import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

Map<String, dynamic> fixture() =>
    jsonDecode(jsonEncode(_fixture())) as Map<String, dynamic>;

Map<String, dynamic> _fixture() => {
  'schemaVersion': 1,
  'cards': {
    'hello': {
      'id': 'hello',
      'prompt': {'en': 'Hello', 'ru': 'Привет'},
      'meaning': {'en': 'Translate', 'ru': 'Переведите'},
      'greek': 'Γεια!',
      'pronunciation': {'en': 'ya', 'ru': 'я'},
      'reviewIdentity': {'deckId': 'greetings', 'cardId': 'hello'},
      'addedWeek': '2026-10-05',
    },
  },
  'decks': [],
  'collections': [
    {
      'section': 'phrases',
      'deck': {
        'id': 'phrases-social',
        'title': {'en': 'Social', 'ru': 'Общение'},
        'subtitle': {'en': 'Greetings', 'ru': 'Приветствия'},
        'cover': 'Γεια!',
        'cards': ['hello'],
      },
      'themes': {
        'hello': ['conversation'],
      },
    },
  ],
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('dictionary is registered as a Flutter asset', () async {
    final source = await rootBundle.loadString(dictionaryAsset);
    expect(GreekDictionary.parse(source).collections, isNotEmpty);
  });
  test(
    'bundled dictionary loads with all card references and themes valid',
    () {
      final parsed = GreekDictionary.parse(
        File(dictionaryAsset).readAsStringSync(),
      );
      expect(parsed.learningDecks, isNotEmpty);
      expect(parsed.decks, isNotEmpty);
      expect(parsed.collections.expand((c) => c.deck.cards), isNotEmpty);
    },
  );

  test('a new JSON-only word appears in search, themes and weekly filters', () {
    final data = fixture();
    data['cards']['goodbye'] = {
      ...data['cards']['hello'] as Map<String, dynamic>,
      'id': 'goodbye',
      'prompt': {'en': 'Goodbye', 'ru': 'До свидания'},
      'greek': 'Αντίο!',
      'reviewIdentity': {'deckId': 'greetings', 'cardId': 'goodbye'},
    };
    data['collections'][0]['deck']['cards'].add('goodbye');
    data['collections'][0]['themes']['goodbye'] = ['conversation'];
    final dictionary = GreekDictionary.parse(jsonEncode(data));
    final result = dictionary.collections.single.filter(
      query: 'αντιο',
      theme: LearningTheme.conversation,
      now: DateTime(2026, 10, 6),
    );
    expect(result.cards.single.id, 'goodbye');
    expect(result.cards.single.addedWeek, '2026-10-05');
  });

  test(
    'changing JSON translation and group keeps existing review history',
    () async {
      final data = fixture();
      data['cards']['hello']['prompt']['en'] = 'Say hello';
      data['collections'][0]['deck']['id'] = 'new-social-group';
      final dictionary = GreekDictionary.parse(jsonEncode(data));
      final store = MemoryProgressStore();
      store.records['greetings.typing.hello'] = ReviewSchedule(
        level: 3,
        dueAt: DateTime.utc(2099),
      );
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(dictionary.learningDecks);
      expect(
        progress.learned(dictionary.learningDecks.single, StudyMode.typing),
        1,
      );
      expect(
        progress.learned(dictionary.learningDecks.single, StudyMode.flashcards),
        0,
      );
    },
  );

  final invalid = <String, void Function(Map<String, dynamic>)>{
    'unsupported schema': (data) => data['schemaVersion'] = 2,
    'missing review identity': (data) =>
        data['cards']['hello'].remove('reviewIdentity'),
    'missing Russian translation': (data) =>
        data['cards']['hello']['prompt'].remove('ru'),
    'misspelled field': (data) => data['cards']['hello']['pronounciation'] = {},
    'unknown reference': (data) =>
        data['collections'][0]['deck']['cards'] = ['missing'],
    'duplicate card id': (data) =>
        data['collections'][0]['deck']['cards'].add('hello'),
    'unknown theme': (data) =>
        data['collections'][0]['themes']['hello'] = ['missing'],
    'unknown theme card': (data) =>
        data['collections'][0]['themes']['missing'] = [],
    'invalid date': (data) =>
        data['cards']['hello']['addedWeek'] = '2026-10-06',
    'invalid token offsets': (data) => data['cards']['hello']['words'] = [
      {
        'surface': 'Γεια',
        'lemma': 'Γεια',
        'start': 0,
        'end': 999,
        'labels': [],
      },
    ],
  };
  for (final entry in invalid.entries) {
    test('rejects ${entry.key}', () {
      final data = fixture();
      entry.value(data);
      expect(
        () => GreekDictionary.parse(jsonEncode(data)),
        throwsFormatException,
      );
    });
  }
}
