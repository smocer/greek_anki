import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_frequency_data.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/word_frequency.dart';

void main() {
  VocabularyCard card(String greek, [String? week]) => VocabularyCard(
    id: greek,
    greek: greek,
    prompt: LocalizedText(en: greek, ru: greek),
    meaning: const LocalizedText(en: '', ru: ''),
    pronunciation: const LocalizedText(en: '', ru: ''),
    addedWeek: week,
  );
  final cards = [
    card('ώρα', '2026-10-12'),
    card('γάτα'),
    card('καφές', '2026-10-05'),
    card('νερό', '2026-10-12'),
  ];

  test('frequency sorts most common first before limiting, unlisted last', () {
    final rare = card('αραχνοφοβία');
    final common = card('μαμά');
    expect(WordFrequency.score(common), greaterThan(0));
    expect(WordFrequency.score(common), greaterThan(WordFrequency.score(rare)));
    expect(sessionBatch([rare, common], limit: 1, order: CardOrder.frequency), [
      common,
    ]);
    expect(
      sessionBatch([
        card('αβγδεζηθικλ'),
        ...cards,
      ], order: CardOrder.frequency).last.greek,
      'αβγδεζηθικλ',
    );
    expect(
      WordFrequency.score(card('το νερό')),
      WordFrequency.score(card('νερό')),
    );
  });

  test('ties retain input order and case does not change frequency', () {
    final tied = [card('ΑΒΓΔΕΖΗ'), card('ΑΒΓΔΕΖΗΘ')];
    expect(sessionBatch(tied, order: CardOrder.frequency), tied);
    expect(
      WordFrequency.score(card('ΜΑΜΆ')),
      WordFrequency.score(card('μαμά')),
    );
  });

  test('time order is newest first, stable within a week, undated last', () {
    expect(
      sessionBatch(cards, order: CardOrder.addedTime).map((c) => c.greek),
      ['ώρα', 'νερό', 'καφές', 'γάτα'],
    );
  });
  test('random remains default and alphabet is no longer offered', () {
    expect(CardOrder.values.map((o) => o.name), [
      'random',
      'frequency',
      'addedTime',
    ]);
    expect(
      sessionBatch(cards, random: Random(42)),
      List.of(cards)..shuffle(Random(42)),
    );
  });
  test('ordered session presents batch in order', () {
    final ordered = sessionBatch(cards, order: CardOrder.frequency);
    final session = StudySession(
      cards: ordered,
      mode: StudyMode.flashcards,
      shuffle: false,
    );
    addTearDown(session.dispose);
    for (final c in ordered) {
      expect(session.current, c);
      session.reveal();
      session.advance(correct: true);
    }
    expect(session.isComplete, isTrue);
  });
  test(
    'every vocabulary spelling is represented in the frequency snapshot',
    () {
      for (final collection in currentDictionary.collections) {
        for (final c in collection.deck.cards) {
          for (final spelling in [
            c.greek,
            ...c.alternatives,
            for (final f in c.forms) f.greek,
          ]) {
            for (final word in WordFrequency.tokens(spelling)) {
              expect(
                greekFrequencyCounts.containsKey(word),
                isTrue,
                reason:
                    '${c.id}: $spelling — run tool/generate_greek_frequency.py',
              );
            }
          }
        }
      }
    },
  );
}
