import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';

import 'support/memory_progress_store.dart';

void main() {
  LearningCollection collection(String id) =>
      currentDictionary.collections.singleWhere((c) => c.deck.id == id);
  VocabularyDeck deck(String id) => collection(id).deck;
  bool languageOrNationality(VocabularyCard card) =>
      card.wordGroup?.startsWith('nationality-') == true ||
      (card.id.endsWith('-language') && card.id != 'languages-language');
  const matcher = GreekAnswer();

  test('hundreds extend Numbers without duplicating 100 or 101', () {
    final numbers = deck('words-numbers').cards;
    final fresh = numbers.where((c) => c.id.startsWith('hundreds-number-'));
    expect(fresh, hasLength(13));
    expect(numbers.map((c) => c.prompt.en).toSet(), hasLength(numbers.length));
    expect(
      fresh.map((c) => int.parse(c.prompt.en)),
      containsAll([
        102,
        103,
        110,
        199,
        for (var n = 200; n <= 1000; n += 100) n,
      ]),
    );
    for (final (number, key) in [
      ('100', 'numbers-tens.typing.number-100'),
      ('101', 'numbers-compound.typing.number-101'),
    ]) {
      final card = numbers.singleWhere((c) => c.prompt.en == number);
      expect(card.reviewIdentity!.key(StudyMode.typing), key);
      expect(card.addedWeek, '2026-09-28');
    }
    final recent = collection(
      'words-numbers',
    ).filter(period: VocabularyPeriod.thisWeek, now: DateTime(2026, 10, 18));
    expect(recent.cards, containsAll(fresh));
    expect(recent.cards.any((c) => c.prompt.en == '100'), isFalse);
  });

  test('number variants retain stress and the correct hundred stem', () {
    VocabularyCard number(String value) =>
        deck('words-numbers').cards.singleWhere((c) => c.prompt.en == value);
    for (final (value, accepted, rejected) in [
      ('199', 'εκατόν ενενήντα εννέα', 'εκατόν ενενήντα εννια'),
      ('700', 'επτακόσια', 'επτακοσια'),
      ('800', 'οκτακόσια', 'οχτωκόσια'),
      ('1000', 'χίλια', 'χιλιά'),
    ]) {
      final card = number(value);
      expect(matcher.matches(card.greek, card), isTrue);
      expect(matcher.matches(accepted, card), isTrue);
      expect(matcher.matches(rejected, card), isFalse);
      expect(matcher.matches(value, card), isFalse);
    }
  });

  test(
    'all language and nationality cards live in Names, with forms intact',
    () {
      final names = deck('words-names').cards;
      final nouns = deck('words-nouns').cards;
      final moved = names.where(languageOrNationality).toList();
      expect(moved, hasLength(33));
      expect(nouns.where(languageOrNationality), isEmpty);
      expect(nouns.any((c) => c.greek == 'γλώσσα'), isTrue);
      expect(names.any((c) => c.greek == 'γλώσσα'), isFalse);
      for (final card in moved) {
        expect(card.reviewIdentity!.deckId, 'words-nouns');
        expect(card.reviewIdentity!.cardId, card.id);
        expect(card.addedWeek, '2026-10-12');
        expect(matcher.matches(card.greek, card), isTrue);
        for (final form in card.forms) {
          expect(matcher.matches(form.greek, card), isTrue);
          expect(matcher.matches(form.answerDisplay, card), isTrue);
        }
      }
      final namesCollection = collection('words-names');
      expect(
        namesCollection
            .filter(
              theme: LearningTheme.properNouns,
              query: 'греческий язык',
              now: DateTime(2026, 10, 18),
            )
            .cards
            .single
            .greek,
        'ελληνικά',
      );
      expect(
        namesCollection
            .filter(
              theme: LearningTheme.properNouns,
              query: 'Πολωνέζα',
              now: DateTime(2026, 10, 18),
            )
            .cards
            .single
            .wordGroup,
        'nationality-polish',
      );
    },
  );

  test(
    'moved names load and update their original schedules in both modes',
    () async {
      final names = deck('words-names');
      final moved = names.cards.where(languageOrNationality).toList();
      final store = MemoryProgressStore();
      final record = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
      for (final mode in StudyMode.values) {
        for (final card in moved) {
          store.records['words-nouns.${mode.name}.${card.id}'] = record;
        }
      }
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(currentDictionary.learningDecks);
      for (final mode in StudyMode.values) {
        expect(progress.learned(names, mode), 33);
        expect(progress.learned(deck('words-nouns'), mode), 0);
        expect(
          progress.dueCards(names, mode).where(languageOrNationality),
          isEmpty,
        );
        final card = moved.first;
        await progress.record(
          deck: names,
          mode: mode,
          card: card,
          correct: false,
        );
        expect(store.records['words-nouns.${mode.name}.${card.id}']!.level, 0);
        expect(progress.learned(names, mode), 32);
      }
      expect(
        store.records.keys.any((k) => k.startsWith('words-names.')),
        isFalse,
      );
    },
  );
}
