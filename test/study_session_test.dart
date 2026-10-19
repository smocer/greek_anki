import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void answer(StudySession session, {required bool correct}) {
  if (session.mode == StudyMode.flashcards) {
    session.reveal();
  } else if (correct) {
    session.checkAnswer(session.current.greek);
    expect(session.typedCorrect, isTrue);
  } else {
    session.skip();
    expect(session.typedCorrect, isFalse);
  }
  session.advance(correct: correct);
}

void complete(StudySession session) {
  for (var turn = 0; !session.isComplete && turn < session.total * 3; turn++) {
    answer(session, correct: true);
  }
  expect(session.isComplete, isTrue);
  expect(session.completed, session.total);
  expect(session.progress, 1);
}

void main() {
  final deck = greekDecks.firstWhere((deck) => deck.id == 'numbers-0-10');

  for (final mode in StudyMode.values) {
    StudySession sessionWith(int count, {int seed = 12}) {
      final session = StudySession(
        cards: deck.cards.take(count).toList(),
        mode: mode,
        random: Random(seed),
      );
      addTearDown(session.dispose);
      return session;
    }

    group(mode.name, () {
      test('only three learning words circulate until one is remembered', () {
        final session = sessionWith(8);
        final firstCycle = <String>[];
        for (var turn = 0; turn < 9; turn++) {
          expect(session.isReview, isFalse);
          if (turn < 3) firstCycle.add(session.currentKey);
          expect(session.currentKey, firstCycle[turn % 3]);
          answer(session, correct: false);
        }
        expect(firstCycle.toSet(), hasLength(3));
        expect(session.completed, 0);
      });

      test('first success adds a new target and a spaced review slot', () {
        final session = sessionWith(8);
        final learned = session.currentKey;
        answer(session, correct: true);
        final targets = <String>{};
        for (var cycle = 0; cycle < 3; cycle++) {
          for (var turn = 0; turn < 3; turn++) {
            expect(session.isReview, isFalse);
            targets.add(session.currentKey);
            answer(session, correct: false);
          }
          expect(targets, hasLength(3));
          expect(targets, isNot(contains(learned)));
          expect(session.isReview, isTrue);
          expect(session.currentKey, learned);
          answer(session, correct: true);
          expect(session.completed, 1);
          expect(session.firstTryCorrect, 1);
        }
        complete(session);
      });

      for (final remaining in [1, 2]) {
        test('$remaining remaining targets stay in a four-word mix', () {
          final session = sessionWith(7);
          final learned = <String>{};
          for (
            var turn = 0;
            session.completed < session.total - remaining && turn < 30;
            turn++
          ) {
            learned.add(session.currentKey);
            answer(session, correct: true);
          }
          expect(session.completed, session.total - remaining);
          final sequence = <String>[];
          var reviews = 0;
          for (var turn = 0; turn < 24; turn++) {
            final key = session.currentKey;
            // Every retry must have three distinct intervening words, even
            // when only one unlearned word is left.
            expect(sequence.reversed.take(3), isNot(contains(key)));
            sequence.add(key);
            final review = session.isReview;
            expect(review, learned.contains(key));
            if (review) reviews++;
            answer(session, correct: review);
            expect(session.completed, session.total - remaining);
            expect(session.isComplete, isFalse);
          }
          expect(reviews, 6 * (4 - remaining));
          complete(session);
        });
      }

      test('forgotten reviews re-enter learning without a fourth target', () {
        final session = sessionWith(8);
        final forgotten = session.currentKey;
        answer(session, correct: true);
        final active = <String>{};
        for (var turn = 0; turn < 3; turn++) {
          active.add(session.currentKey);
          answer(session, correct: false);
        }
        expect(session.isReview, isTrue);
        expect(session.currentKey, forgotten);
        answer(session, correct: false);
        expect(session.completed, 0);
        expect(session.firstTryCorrect, 1);
        for (var turn = 0; turn < 6; turn++) {
          expect(active, contains(session.currentKey));
          expect(session.isReview, isFalse);
          answer(session, correct: false);
        }
        // Free a learning slot. The forgotten review gets it before a new card.
        answer(session, correct: true);
        for (var turn = 0; turn < 2; turn++) {
          answer(session, correct: false);
        }
        expect(session.currentKey, forgotten);
        expect(session.isReview, isFalse);
        complete(session);
        expect(session.firstTryCorrect, 5);
      });

      test('one- and two-card batches work with only available words', () {
        for (final count in [1, 2]) {
          final session = sessionWith(count);
          if (count == 2) answer(session, correct: true);
          final target = session.currentKey;
          for (var attempt = 0; attempt < 3; attempt++) {
            expect(session.currentKey, target);
            answer(session, correct: false);
            if (count == 2) {
              expect(session.currentKey, isNot(target));
              expect(session.isReview, isTrue);
              answer(session, correct: true);
            }
          }
          answer(session, correct: true);
          expect(session.isComplete, isTrue);
          expect(session.isReview, isFalse);
          expect(session.completed, count);
          expect(session.firstTryCorrect, count - 1);
        }
      });

      test('seeded random reviews stay within the supplied batch', () {
        List<String> run(int seed) {
          final session = sessionWith(10, seed: seed);
          final learned = <String>{};
          final reviews = <String>[];
          for (var turn = 0; !session.isComplete && turn < 40; turn++) {
            expect(deck.cards.take(10), contains(session.current));
            if (session.isReview) {
              expect(learned, contains(session.currentKey));
              reviews.add(session.currentKey);
            }
            learned.add(session.currentKey);
            answer(session, correct: true);
          }
          expect(session.isComplete, isTrue);
          expect(learned, hasLength(10));
          expect(session.firstTryCorrect, 10);
          expect(session.repetitions, 0);
          expect(reviews, isNotEmpty);
          return reviews;
        }

        expect(run(27), run(27));
        expect(run(27), isNot(run(28)));
      });

      test(
        'mixed successes and failures keep counts and eventually finish',
        () {
          for (var seed = 0; seed < 30; seed++) {
            final session = sessionWith(8, seed: seed);
            final random = Random(seed);
            final learned = <String>{};
            final recent = <String>[];
            for (var turn = 0; turn < 120 && !session.isComplete; turn++) {
              final key = session.currentKey;
              expect(recent.reversed.take(2), isNot(contains(key)));
              recent.add(key);
              expect(session.isReview, learned.contains(key));
              final correct = random.nextBool();
              if (correct) {
                learned.add(key);
              } else {
                learned.remove(key);
              }
              answer(session, correct: correct);
              expect(session.completed, learned.length);
              expect(session.progress, inInclusiveRange(0, 1));
            }
            complete(session);
          }
        },
      );

      test('review success preserves schedule; forgetting resets it', () async {
        final session = sessionWith(5);
        final store = MemoryProgressStore();
        final now = DateTime.utc(2026, 10, 18);
        final progress = LearningProgress(store, now: () => now);
        addTearDown(progress.dispose);
        final learned = session.current;
        Future<void> saveAnswer(bool correct) async {
          await progress.record(
            deck: deck,
            mode: mode,
            card: session.current,
            correct: correct,
          );
          answer(session, correct: correct);
        }

        await saveAnswer(true);
        final key = '${deck.id}.${mode.name}.${learned.id}';
        final originalSchedule = store.records[key];
        expect(originalSchedule?.level, 1);
        for (var cycle = 0; cycle < 2; cycle++) {
          for (var turn = 0; turn < 3; turn++) {
            await saveAnswer(false);
          }
          expect(session.current, learned);
          expect(session.isReview, isTrue);
          if (cycle == 0) {
            await saveAnswer(true);
            expect(store.records[key], same(originalSchedule));
          } else {
            await saveAnswer(false);
            expect(store.records[key]?.level, 0);
            expect(progress.dueCards(deck, mode), contains(learned));
            expect(session.completed, 0);
          }
        }
      });
    });
  }
}
