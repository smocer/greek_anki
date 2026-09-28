import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void main() {
  final deck = greekDecks.firstWhere((deck) => deck.id == 'numbers-0-10');
  const matcher = GreekAnswer();

  test('0–10 are complete and have unique stable IDs', () {
    expect(
      deck.cards.map((card) => card.prompt.en),
      List.generate(11, (i) => '$i'),
    );
    expect(deck.cards.map((card) => card.id).toSet().length, 11);
  });

  test('accepts Greek case, accent forms, whitespace and variants', () {
    for (final card in deck.cards) {
      expect(matcher.matches(card.greek, card), isTrue);
      expect(matcher.matches('  ${card.greek.toUpperCase()}  ', card), isTrue);
      expect(matcher.matches(GreekText.answerKey(card.greek), card), isTrue);
      for (final alternative in card.alternatives) {
        expect(matcher.matches(alternative, card), isTrue);
      }
    }
    expect(matcher.matches('ε\u0301να', deck.cards[1]), isTrue);
    expect(matcher.matches('δε\u0301κα', deck.cards[10]), isTrue);
  });

  test('rejects Latin lookalikes, numeric prompts, blank and wrong words', () {
    for (final wrong in ['ena', 'eνα', '1', '', '  ', 'εννα', 'δέκα']) {
      expect(matcher.matches(wrong, deck.cards[1]), isFalse);
    }
  });

  test('missed cards return after two others without inflating completion', () {
    final session = StudySession(
      cards: deck.cards,
      mode: StudyMode.flashcards,
      random: Random(4),
    );
    final missed = session.current;
    session.advance(correct: true);
    expect(session.completed, 0); // Answers must first be revealed.
    session.reveal();
    session.advance(correct: false);
    for (var i = 0; i < 2; i++) {
      expect(session.current.id, isNot(missed.id));
      session.reveal();
      session.advance(correct: true);
    }
    expect(session.current.id, missed.id);
    while (!session.isComplete) {
      session.reveal();
      session.advance(correct: true);
    }
    expect(session.completed, 11);
    expect(session.firstTryCorrect, 10);
    expect(session.repetitions, 1);
    expect(session.progress, 1);
  });

  test('review intervals grow and cap; early practice does not promote', () {
    var now = DateTime.utc(2026, 9, 22);
    ReviewSchedule? previous;
    for (final days in [1, 3, 7, 14, 30, 30]) {
      final next = ReviewSchedule.afterAnswer(
        previous: previous,
        correct: true,
        now: now,
      );
      expect(next.dueAt.difference(now).inDays, days);
      expect(
        ReviewSchedule.afterAnswer(
          previous: next,
          correct: true,
          now: now,
        ).dueAt,
        next.dueAt,
      );
      previous = next;
      now = next.dueAt;
    }
    final forgotten = ReviewSchedule.afterAnswer(
      previous: previous,
      correct: false,
      now: now,
    );
    expect(forgotten.level, 0);
    expect(forgotten.isDue(now), isTrue);
    expect(
      ReviewSchedule.afterAnswer(
        previous: forgotten,
        correct: true,
        now: now,
      ).level,
      1,
    );
  });

  test('progress survives reload and stays separate between modes', () async {
    final store = MemoryProgressStore();
    var now = DateTime.utc(2026, 9, 22);
    final first = LearningProgress(store, now: () => now);
    await first.load([deck]);
    await first.record(
      deck: deck,
      mode: StudyMode.flashcards,
      card: deck.cards.first,
      correct: true,
    );
    final reloaded = LearningProgress(store, now: () => now);
    await reloaded.load([deck]);
    expect(reloaded.learned(deck, StudyMode.flashcards), 1);
    expect(reloaded.learned(deck, StudyMode.typing), 0);
    expect(reloaded.dueCards(deck, StudyMode.flashcards).length, 10);
    expect(reloaded.dueCards(deck, StudyMode.typing).length, 11);
    now = now.add(const Duration(days: 1));
    expect(reloaded.dueCards(deck, StudyMode.flashcards).length, 11);
  });

  test('failed persistence leaves in-memory learning unchanged', () async {
    final progress = LearningProgress(MemoryProgressStore()..shouldFail = true);
    await expectLater(
      progress.record(
        deck: deck,
        mode: StudyMode.typing,
        card: deck.cards.first,
        correct: true,
      ),
      throwsStateError,
    );
    expect(progress.learned(deck, StudyMode.typing), 0);
  });
}
