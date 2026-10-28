import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/data/study_session_store.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/study_session_store.dart';
import 'package:greek_anki/domain/vocabulary.dart';

void main() {
  final verbs = currentDictionary.learningDecks.singleWhere(
    (deck) => deck.id == 'words-verbs',
  );

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

  for (final mode in StudyMode.values) {
    test(
      'resume all verbs after 50 learned and finish the same batch ($mode)',
      () {
        final original = StudySession(
          cards: verbs.cards,
          mode: mode,
          random: Random(1),
        );
        addTearDown(original.dispose);
        answer(original, correct: false);
        for (var turns = 0; original.completed < 50 && turns < 200; turns++) {
          answer(original);
        }
        expect(original.completed, 50);
        final saved = encodeStudySession(original.snapshot);
        // A fresh catalog list and a new RNG simulate leaving/reloading the app.
        final restored = StudySession.restore(
          cards: verbs.cards.reversed.toList(),
          snapshot: decodeStudySession(saved),
          random: Random(2),
        );
        addTearDown(restored.dispose);
        expect(encodeStudySession(restored.snapshot), saved);
        expect(restored.currentKey, original.currentKey);
        expect(restored.completed, 50);
        expect(restored.total, verbs.cards.length);
        expect(restored.repetitions, 1);
        for (var turns = 0; !restored.isComplete && turns < 200; turns++) {
          answer(restored);
        }
        expect(restored.isComplete, isTrue);
        expect(restored.completed, verbs.cards.length);
        expect(restored.firstTryCorrect, verbs.cards.length - 1);
      },
    );

    test('tail review window survives a saved session ($mode)', () {
      final original = StudySession(
        cards: verbs.cards.take(6).toList(),
        mode: mode,
        shuffle: false,
      );
      addTearDown(original.dispose);
      while (original.completed < 5) {
        answer(original);
      }
      final restored = StudySession.restore(
        cards: verbs.cards,
        snapshot: decodeStudySession(encodeStudySession(original.snapshot)),
      );
      addTearDown(restored.dispose);
      expect(restored.snapshot.window, hasLength(4));
      var reviews = 0;
      for (var turn = 0; turn < 4; turn++) {
        final review = restored.isReview;
        if (review) reviews++;
        answer(restored, correct: review);
      }
      expect(reviews, 3);
      expect(restored.completed, 5);
    });
  }

  test('submitted answer and flashcard history restore without recounting', () {
    for (final mode in StudyMode.values) {
      final original = StudySession(
        cards: verbs.cards,
        mode: mode,
        shuffle: false,
      );
      addTearDown(original.dispose);
      answer(original);
      if (mode == StudyMode.typing) {
        original.checkAnswer('λάθος');
      } else {
        original.reveal();
        original.previous();
      }
      final restored = StudySession.restore(
        cards: verbs.cards,
        snapshot: decodeStudySession(encodeStudySession(original.snapshot)),
      );
      addTearDown(restored.dispose);
      expect(restored.phase, CardPhase.answer);
      expect(restored.completed, 1);
      expect(restored.currentKey, original.currentKey);
      if (mode == StudyMode.typing) {
        expect(restored.submittedAnswer, 'λάθος');
        expect(restored.typedCorrect, isFalse);
      } else {
        expect(restored.isReviewing, isTrue);
        restored.next();
        original.next();
        expect(restored.currentKey, original.currentKey);
        expect(restored.phase, CardPhase.answer);
        expect(restored.completed, 1);
      }
    }
  });

  test(
    'session keys isolate modes, filters, limits and order, not shuffle',
    () {
      String key({
        VocabularyDeck? deck,
        StudyMode mode = StudyMode.typing,
        int? limit,
        CardOrder order = CardOrder.random,
      }) => studySessionKey(
        deck: deck ?? verbs,
        mode: mode,
        limit: limit,
        order: order,
      );
      VocabularyDeck withCards(List<VocabularyCard> cards) => VocabularyDeck(
        id: verbs.id,
        title: verbs.title,
        subtitle: verbs.subtitle,
        cover: verbs.cover,
        cards: cards,
      );
      expect(key(deck: withCards(verbs.cards.reversed.toList())), key());
      expect({
        key(),
        key(mode: StudyMode.flashcards),
        key(limit: 15),
        key(order: CardOrder.alphabet),
        key(deck: withCards(verbs.cards.take(10).toList())),
      }, hasLength(5));
    },
  );

  test('invalid saved queues cannot silently lose or duplicate cards', () {
    final session = StudySession(cards: verbs.cards, mode: StudyMode.typing);
    addTearDown(session.dispose);
    final saved = encodeStudySession(session.snapshot);
    for (final change in <void Function(Map<String, dynamic>)>[
      (data) => (data['window'] as List).clear(),
      (data) => (data['pending'] as List).add((data['window'] as List).first),
      (data) => data['firstTryCorrect'] = -1,
      (data) => data['phase'] = 'answer',
      (data) => (data['cards'] as List).add('missing-card'),
    ]) {
      final data = jsonDecode(saved) as Map<String, dynamic>;
      change(data);
      expect(
        () => StudySession.restore(
          cards: verbs.cards,
          snapshot: decodeStudySession(jsonEncode(data)),
        ),
        throwsFormatException,
      );
    }
  });
}
