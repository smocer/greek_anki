import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';

void main() {
  VocabularyCard card(String greek, String? week) => VocabularyCard(
    id: greek,
    greek: greek,
    prompt: LocalizedText(en: greek, ru: greek),
    meaning: const LocalizedText(en: '', ru: ''),
    pronunciation: const LocalizedText(en: '', ru: ''),
    addedWeek: week,
  );
  final cards = [
    card('Ώρα', '2026-10-12'),
    card('γάτα', null),
    card('Άλφα', '2026-10-05'),
    card('βήτα', '2026-10-12'),
  ];

  test(
    'alphabet order ignores Greek accents and sorts before taking a batch',
    () {
      expect(
        sessionBatch(
          cards,
          limit: 2,
          order: CardOrder.alphabet,
        ).map((c) => c.greek),
        ['Άλφα', 'βήτα'],
      );
    },
  );

  test('time order is newest first, stable within a week, undated last', () {
    expect(
      sessionBatch(cards, order: CardOrder.addedTime).map((c) => c.greek),
      ['Ώρα', 'βήτα', 'Άλφα', 'γάτα'],
    );
  });

  test('random remains the default', () {
    expect(
      sessionBatch(cards, random: Random(42)),
      List.of(cards)..shuffle(Random(42)),
    );
  });

  test('ordered sessions present the batch in order', () {
    final ordered = sessionBatch(cards, order: CardOrder.alphabet);
    final session = StudySession(
      cards: ordered,
      mode: StudyMode.flashcards,
      shuffle: false,
    );
    addTearDown(session.dispose);
    for (final card in ordered) {
      expect(session.current, card);
      session.reveal();
      session.advance(correct: true);
    }
    expect(session.isComplete, isTrue);
  });
}
