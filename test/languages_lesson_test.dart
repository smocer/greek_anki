import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void main() {
  VocabularyDeck deck(String id) =>
      currentDictionary.learningDecks.singleWhere((deck) => deck.id == id);
  VocabularyCard card(String deckId, String id) =>
      deck(deckId).cards.singleWhere((card) => card.id == id);
  const matcher = GreekAnswer();

  test(
    'proper nouns include languages and nationalities with prior review history',
    () async {
      final names = deck('words-names');
      final moved = names.cards.where(
        (c) =>
            c.id.startsWith('languages-nationality-') ||
            c.prompt.en.contains('(language)'),
      );
      expect(names.title.zh, '专有名词');
      expect(moved, hasLength(33));
      expect(names.cards.any((c) => c.greek == 'Γερμανία'), isTrue);
      expect(moved.any((c) => c.greek == 'γερμανικά'), isTrue);
      expect(moved.any((c) => c.greek == 'Γερμανός'), isTrue);
      final proper = currentDictionary.collections.singleWhere(
        (c) => c.deck.id == 'words-names',
      );
      for (final entry in names.cards) {
        expect(proper.themes[entry.id], {LearningTheme.properNouns});
      }
      expect(
        proper
            .filter(theme: LearningTheme.places, now: DateTime(2026, 10, 17))
            .cards,
        isEmpty,
      );
      final store = MemoryProgressStore();
      final record = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
      for (final entry in moved) {
        expect(entry.reviewIdentity!.deckId, 'words-nouns');
        expect(deck('words-nouns').cards.any((c) => c.id == entry.id), isFalse);
        for (final mode in StudyMode.values) {
          store.records[entry.reviewIdentity!.key(mode)] = record;
        }
      }
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(currentDictionary.learningDecks);
      for (final mode in StudyMode.values) {
        expect(progress.learned(names, mode), 33);
        expect(progress.dueCards(names, mode).any(moved.contains), isFalse);
      }
    },
  );

  test('B1 and B2 drill every person without accepting another person', () {
    for (final (deckId, verb, forms) in [
      (
        'grammar-verbs-b1',
        'b1-speak',
        ['μιλάω', 'μιλάς', 'μιλάει', 'μιλάμε', 'μιλάτε', 'μιλάνε'],
      ),
      (
        'grammar-verbs-b1',
        'b1-love',
        ['αγαπάω', 'αγαπάς', 'αγαπάει', 'αγαπάμε', 'αγαπάτε', 'αγαπάνε'],
      ),
      (
        'grammar-verbs-b2',
        'b2-can',
        ['μπορώ', 'μπορείς', 'μπορεί', 'μπορούμε', 'μπορείτε', 'μπορούν'],
      ),
    ]) {
      const persons = ['i', 'you', 'he', 'we', 'you-plural', 'they'];
      for (var index = 0; index < persons.length; index++) {
        final entry = card(deckId, '$verb-${persons[index]}');
        expect(matcher.matches(forms[index], entry), isTrue);
        expect(matcher.matches(forms[(index + 1) % 6], entry), isFalse);
      }
    }
    final speak = card('grammar-verbs-b1', 'b1-speak-i');
    for (final answer in ['μιλώ', 'εγώ μιλώ', 'εγώ μιλάω']) {
      expect(matcher.matches(answer, speak), isTrue);
    }
    for (final answer in ['μιλαω', 'μιλω', 'μίλαω', 'εσύ μιλάς']) {
      expect(matcher.matches(answer, speak), isFalse);
    }
    final plural = card('grammar-verbs-b1', 'b1-speak-they');
    for (final answer in ['μιλούν', 'μιλούνε', 'αυτές μιλάνε']) {
      expect(matcher.matches(answer, plural), isTrue);
    }
    expect(
      matcher.matches('μπορούνε', card('grammar-verbs-b2', 'b2-can-they')),
      isTrue,
    );
    expect(
      matcher.matches('μποράς', card('grammar-verbs-b2', 'b2-can-you')),
      isFalse,
    );
  });

  test(
    'nationalities allow gender variants; grammar keeps the requested gender',
    () {
      final polish = card('words-names', 'languages-nationality-polish');
      for (final answer in ['Πολωνός', 'Πολωνή', 'η Πολωνέζα']) {
        expect(matcher.matches(answer, polish), isTrue);
      }
      for (final answer in ['η Πολωνός', 'πολωνικά', 'Πολωνη']) {
        expect(matcher.matches(answer, polish), isFalse);
      }
      final female = card('grammar-gender', 'languages-nationality-female');
      expect(matcher.matches('Είμαι Ελληνίδα.', female), isTrue);
      expect(matcher.matches('Είμαι Έλληνας.', female), isFalse);
      final russian = card('words-names', 'languages-russian-language');
      expect(matcher.matches('τα ρώσικα', russian), isTrue);
      expect(matcher.matches('η ρωσικά', russian), isFalse);
      final country = card('words-names', 'languages-poland');
      expect(matcher.matches('η Πολωνία', country), isTrue);
      expect(deck('words-nouns').cards.any((c) => c.id == country.id), isFalse);
    },
  );

  test(
    'new practice preserves old schedules and stays separate from word learning',
    () async {
      final store = MemoryProgressStore();
      final record = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
      final word = card('words-verbs', 'languages-speak');
      final oldDrill = deck('grammar-verbs').cards.first;
      for (final mode in StudyMode.values) {
        store.records[word.reviewIdentity!.key(mode)] = record;
        store.records[oldDrill.reviewIdentity!.key(mode)] = record;
      }
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(currentDictionary.learningDecks);
      for (final mode in StudyMode.values) {
        expect(progress.learned(deck('words-verbs'), mode), 1);
        expect(progress.learned(deck('grammar-verbs'), mode), 1);
        expect(progress.learned(deck('grammar-verbs-b1'), mode), 0);
        expect(progress.learned(deck('grammar-verbs-b2'), mode), 0);
      }
      await progress.record(
        deck: deck('grammar-verbs-b1'),
        mode: StudyMode.typing,
        card: card('grammar-verbs-b1', 'b1-speak-i'),
        correct: false,
      );
      expect(
        store.records[word.reviewIdentity!.key(StudyMode.typing)],
        same(record),
      );
      expect(
        store.records[oldDrill.reviewIdentity!.key(StudyMode.typing)],
        same(record),
      );
    },
  );

  test('mobile app developer is absent from every learning collection', () {
    for (final entry in currentDictionary.learningDecks.expand(
      (d) => d.cards,
    )) {
      expect(entry.wordGroup, isNot('mobile-app-developer'));
      expect(entry.id, isNot('work-life-mobile-app-developer'));
    }
  });
}
