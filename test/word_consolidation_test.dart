import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/data/word_consolidation.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'dictionary_test.dart' show fixture;
import 'support/memory_progress_store.dart';

Map<String, dynamic> duplicateWords() {
  final data = fixture();
  final first = data['cards']['hello'];
  first['greek'] = 'με';
  first['prompt'] = {'en': 'Me', 'ru': 'Меня'};
  first['labels'] = ['pronoun'];
  first['explanation'] = {
    'en': 'Object pronoun.',
    'ru': 'Объектное местоимение.',
  };
  final second = jsonDecode(jsonEncode(first));
  second['id'] = 'with';
  second['prompt'] = {'en': 'With', 'ru': 'С'};
  second['labels'] = ['preposition'];
  second['reviewIdentity'] = {'deckId': 'old-connectors', 'cardId': 'with'};
  second['explanation'] = {'en': 'A preposition.', 'ru': 'Предлог.'};
  data['cards']['with'] = second;
  final group = data['collections'][0];
  group['section'] = 'words';
  group['deck']['id'] = 'words-pronouns';
  final connectors = jsonDecode(jsonEncode(group));
  connectors['deck']['id'] = 'words-connectors';
  connectors['deck']['cards'] = ['with'];
  connectors['themes'] = {
    'with': ['home'],
  };
  data['collections'].add(connectors);
  return data;
}

void main() {
  test(
    'one definition preserves both senses, labels, themes and review aliases',
    () {
      final data = duplicateWords();
      expect(consolidateWordData(data), 1);
      final dictionary = GreekDictionary.parse(jsonEncode(data));
      final first = dictionary.collections.first.deck.cards.single;
      final second = dictionary.collections.last.deck.cards.single;
      expect(identical(first, second), isTrue);
      expect(data['cards'].length, 1);
      expect(first.prompt.en, 'Me / With');
      expect(first.senses.map((sense) => sense.ru), ['Меня', 'С']);
      expect(first.labels.map((label) => label.name), [
        'pronoun',
        'preposition',
      ]);
      expect(first.explanation!.en, contains('Object pronoun.'));
      expect(first.explanation!.en, contains('A preposition.'));
      expect(first.aliases, ['with']);
      expect(first.reviewAliases.single.cardId, 'with');
      expect(
        dictionary.collections.first.availableThemes.map((theme) => theme.name),
        containsAll(['conversation', 'home']),
      );
      final once = jsonEncode(data);
      expect(consolidateWordData(data), 0);
      expect(jsonEncode(data), once);
    },
  );

  test(
    'grammar exercises remain unchanged even when they reference the same definition',
    () {
      final data = duplicateWords();
      final grammar = jsonDecode(jsonEncode(data['collections'][0]));
      grammar['section'] = 'grammar';
      grammar['deck']['id'] = 'grammar-pronouns';
      data['collections'].add(grammar);
      consolidateWordData(data);
      final dictionary = GreekDictionary.parse(jsonEncode(data));
      expect(dictionary.collections.last.deck.cards.single.prompt.en, 'Me');
      expect(
        dictionary.collections.first.deck.cards.single.prompt.en,
        'Me / With',
      );
    },
  );

  test('stress stays significant when identifying duplicate words', () {
    final data = duplicateWords();
    data['cards']['hello']['greek'] = 'που';
    data['cards']['with']['greek'] = 'πού';
    expect(consolidateWordData(data), 0);
  });

  test('a new file adds a sense to an existing word automatically', () {
    final data = duplicateWords();
    data['cards'].remove('with');
    data['collections'].removeLast();
    final dictionary = GreekDictionary.merge(jsonEncode(data), {
      'new.json': jsonEncode({
        'schemaVersion': 1,
        'addedWeek': '2026-10-12',
        'words': [
          {
            'id': 'with',
            'collection': 'words-pronouns',
            'greek': 'με',
            'prompt': {'en': 'With', 'ru': 'С'},
            'pronunciation': {'en': 'me', 'ru': 'мэ'},
            'labels': ['preposition'],
          },
        ],
      }),
    });
    final word = dictionary.learningDecks.single.cards.single;
    expect(word.senses, hasLength(2));
    expect(word.labels.map((l) => l.name), ['pronoun', 'preposition']);
  });

  test(
    'an old merged-away review loads and later canonical reviews take priority',
    () async {
      final data = duplicateWords();
      consolidateWordData(data);
      final dictionary = GreekDictionary.parse(jsonEncode(data));
      final store = MemoryProgressStore();
      store.records['old-connectors.typing.with'] = ReviewSchedule(
        level: 3,
        dueAt: DateTime.utc(2099),
      );
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(dictionary.learningDecks);
      final deck = dictionary.learningDecks.first;
      expect(progress.learned(deck, StudyMode.typing), 1);
      expect(progress.learned(deck, StudyMode.flashcards), 0);
      await progress.record(
        deck: deck,
        mode: StudyMode.typing,
        card: deck.cards.single,
        correct: false,
      );
      await progress.load(dictionary.learningDecks);
      expect(progress.learned(deck, StudyMode.typing), 0);
      expect(store.records['old-connectors.typing.with']!.level, 3);
    },
  );
}
