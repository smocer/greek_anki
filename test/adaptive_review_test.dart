import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/data/study_session_store.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/recall_attempt.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/review_selection.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';

void answer(StudySession session, {bool correct = true}) {
  if (session.mode == StudyMode.flashcards) {
    session.reveal();
  } else if (correct) {
    session.checkAnswer(session.current.greek);
  } else {
    session.skip();
  }
  session.advance(correct: correct);
}

void main() {
  final cards = currentDictionary.learningDecks
      .singleWhere((d) => d.id == 'words-verbs')
      .cards;
  final now = DateTime.utc(2026, 11, 3);
  RecallAttempt attempt(int n, bool correct, {bool independent = true}) =>
      RecallAttempt(
        id: '$n',
        at: now.add(Duration(minutes: n)),
        outcome: correct ? RecallOutcome.correct : RecallOutcome.incorrect,
        independent: independent,
      );

  test('recent errors decay; rapid corrections cannot erase a failure', () {
    final history = [
      attempt(0, false),
      for (var i = 1; i <= 20; i++) attempt(i, true, independent: false),
    ];
    expect(recallWeakness(history), 1);
    history.add(attempt(21, true));
    expect(recallWeakness(history), inExclusiveRange(0, 1));
    history.add(attempt(22, true));
    expect(recallWeakness(history), 0);
    expect(
      recallWeakness([
        RecallAttempt(
          id: 'accent',
          at: now,
          outcome: RecallOutcome.accentError,
          independent: true,
        ),
      ]),
      0.35,
    );
  });

  test(
    '80/20 selection favours weak words without starving coverage or looping a leech',
    () {
      final last = <String, int>{};
      final counts = <String, int>{};
      final random = Random(7);
      final sequence = <String>[];
      for (var pick = 0; pick < 300; pick++) {
        final turn = pick * 4;
        final key = const ReviewSelection().choose(
          [
            for (var i = 0; i < 80; i++)
              ReviewCandidate(
                key: '$i',
                weakness: i == 0
                    ? 1
                    : i < 10
                    ? 0.5
                    : 0,
                lastTurn: last['$i'],
                presentations: counts['$i'] ?? 0,
                lastReviewAt: null,
                confirmations: 0,
              ),
          ],
          turn: turn,
          pick: pick,
          random: random,
          minimumGap: 8,
        );
        if (last[key] != null) {
          expect(turn - last[key]! - 1, greaterThanOrEqualTo(8));
        }
        sequence.add(key);
        last[key] = turn;
        counts.update(key, (n) => n + 1, ifAbsent: () => 1);
      }
      final weakReviews = sequence.where((key) => int.parse(key) < 10).length;
      expect(weakReviews, greaterThan(220));
      expect(
        counts.keys.where((key) => int.parse(key) >= 10).length,
        greaterThan(45),
      );
      expect(counts['0'], lessThan(60));
      expect(counts.keys.where((key) => int.parse(key) < 10), hasLength(10));
    },
  );

  for (final mode in StudyMode.values) {
    for (final style in SessionStyle.values) {
      test(
        'last-word lapse needs two delayed confirmations ($style, $mode)',
        () {
          final session = StudySession(
            cards: cards.take(20).toList(),
            mode: mode,
            style: style,
            shuffle: false,
            random: Random(8),
          );
          addTearDown(session.dispose);
          final target = cards[19].reviewIdentity!.key(mode);
          var failed = false;
          var confirmations = 0;
          var previousTurn = -1;
          for (var turn = 0; !session.isComplete && turn < 250; turn++) {
            if (session.currentKey == target) {
              if (!failed) {
                answer(session, correct: false);
                failed = true;
                previousTurn = turn;
                expect(session.isComplete, isFalse);
                continue;
              }
              if (turn - previousTurn - 1 >= 8) confirmations++;
              previousTurn = turn;
            }
            answer(session);
            if (failed && confirmations < 2) {
              expect(session.isComplete, isFalse);
            }
          }
          expect(failed, isTrue);
          expect(confirmations, greaterThanOrEqualTo(2));
          expect(session.isComplete, isTrue);
          expect(session.firstTryCorrect, 19);
        },
      );

      test(
        'adaptive queues restore pending confirmations and feedback ($style, $mode)',
        () {
          final first = StudySession(
            cards: cards,
            mode: mode,
            style: style,
            random: Random(2),
            shuffle: false,
          );
          addTearDown(first.dispose);
          for (var turn = 0; turn < 60; turn++) {
            answer(first, correct: turn % 7 != 0);
          }
          if (mode == StudyMode.typing) {
            first.checkAnswer('λάθος');
          } else {
            first.reveal();
          }
          final encoded = encodeStudySession(first.snapshot);
          final restored = StudySession.restore(
            cards: cards,
            snapshot: decodeStudySession(encoded),
            random: Random(3),
          );
          addTearDown(restored.dispose);
          expect(encodeStudySession(restored.snapshot), encoded);
          expect(restored.awaitingConfirmation, greaterThan(0));
          expect(restored.currentKey, first.currentKey);
          restored.advance(correct: mode == StudyMode.flashcards);
          for (var turn = 0; !restored.isComplete && turn < 1500; turn++) {
            answer(restored);
          }
          expect(restored.isComplete, isTrue);
          expect(restored.completed, cards.length);
        },
      );
    }

    test('review all covers each easy word exactly once ($mode)', () {
      final session = StudySession(
        cards: cards,
        mode: mode,
        style: SessionStyle.reviewAll,
        shuffle: false,
      );
      addTearDown(session.dispose);
      final visited = <String>{};
      for (
        var turn = 0;
        !session.isComplete && turn < cards.length + 1;
        turn++
      ) {
        expect(visited.add(session.currentKey), isTrue);
        answer(session);
      }
      expect(visited, hasLength(cards.length));
      expect(session.isComplete, isTrue);
    });
  }

  test('known difficult words require confirmation, easy words do not', () {
    final weak = ReviewSchedule(
      level: 1,
      dueAt: now,
      attempts: [attempt(0, false)],
    );
    final session = StudySession(
      cards: cards.take(12).toList(),
      mode: StudyMode.typing,
      style: SessionStyle.reviewAll,
      shuffle: false,
      scheduleFor: (card) => card == cards.first ? weak : null,
    );
    addTearDown(session.dispose);
    answer(session);
    expect(session.completed, 0);
    expect(session.awaitingConfirmation, 1);
    answer(session);
    expect(session.completed, 1);
  });

  test('accent-only mistakes remain wrong and have a distinct outcome', () {
    final card = cards.firstWhere(
      (c) => GreekText.searchKey(c.greek) != GreekText.answerKey(c.greek),
    );
    final session = StudySession(cards: [card], mode: StudyMode.typing);
    addTearDown(session.dispose);
    session.checkAnswer(GreekText.searchKey(card.greek));
    expect(session.typedCorrect, isFalse);
    expect(
      session.attemptFor(correct: false).outcome,
      RecallOutcome.accentError,
    );
  });

  test(
    'a quick restart is practice, but recall after time away is independent',
    () {
      var clock = now;
      final previous = ReviewSchedule(
        level: 0,
        dueAt: now,
        attempts: [attempt(0, false)],
      );
      final session = StudySession(
        cards: cards.take(12).toList(),
        mode: StudyMode.typing,
        shuffle: false,
        now: () => clock,
        scheduleFor: (_) => previous,
      );
      addTearDown(session.dispose);
      session.checkAnswer(session.current.greek);
      expect(session.attemptFor(correct: true).independent, isFalse);
      session.advance(correct: true);
      final saved = decodeStudySession(encodeStudySession(session.snapshot));
      clock = clock.add(const Duration(days: 1));
      final resumed = StudySession.restore(
        cards: cards,
        snapshot: saved,
        now: () => clock,
        scheduleFor: (_) => previous,
      );
      addTearDown(resumed.dispose);
      resumed.checkAnswer(resumed.current.greek);
      expect(resumed.attemptFor(correct: true).independent, isTrue);
    },
  );

  for (final style in SessionStyle.values) {
    test('deferral shrinks the gap when only one word remains ($style)', () {
      final session = StudySession(
        cards: cards.take(4).toList(),
        mode: StudyMode.typing,
        style: style,
        shuffle: false,
      );
      addTearDown(session.dispose);
      final target = session.currentKey;
      for (var turn = 0; !session.isComplete && turn < 200; turn++) {
        if (session.currentKey != target && session.canDefer) {
          session.deferCurrent();
        } else {
          answer(session, correct: session.deferredCount == 3);
        }
      }
      expect(session.isComplete, isTrue);
      expect(session.completed, 1);
      expect(session.deferredCount, 3);
    });
  }

  test('leech can be deferred, remains unlearned, and survives reload', () {
    var session = StudySession(
      cards: cards.take(4).toList(),
      mode: StudyMode.typing,
      style: SessionStyle.reviewAll,
      shuffle: false,
    );
    final target = session.currentKey;
    for (var turn = 0; !session.canDefer && turn < 100; turn++) {
      answer(session, correct: session.currentKey != target);
    }
    expect(session.canDefer, isTrue);
    session.deferCurrent();
    final snapshot = decodeStudySession(encodeStudySession(session.snapshot));
    session.dispose();
    session = StudySession.restore(cards: cards, snapshot: snapshot);
    addTearDown(session.dispose);
    for (var turn = 0; !session.isComplete && turn < 30; turn++) {
      answer(session);
    }
    expect(session.isComplete, isTrue);
    expect(session.completed, 3);
    expect(session.deferredCount, 1);
  });

  test('version-one bookmarks retain learned words and queue order', () {
    final first = StudySession(
      cards: cards,
      mode: StudyMode.typing,
      shuffle: false,
    );
    addTearDown(first.dispose);
    for (var i = 0; i < 20; i++) {
      answer(first);
    }
    final old =
        jsonDecode(encodeStudySession(first.snapshot)) as Map<String, dynamic>;
    for (final key in [
      'style',
      'sessionId',
      'turn',
      'reviewPicks',
      'evidence',
      'deferred',
      'answeredAt',
    ]) {
      old.remove(key);
    }
    final restored = StudySession.restore(
      cards: cards,
      snapshot: decodeStudySession(jsonEncode(old)),
    );
    addTearDown(restored.dispose);
    expect(restored.completed, first.completed);
    expect(restored.currentKey, first.currentKey);
    expect(restored.snapshot.window, first.snapshot.window);
  });
}
