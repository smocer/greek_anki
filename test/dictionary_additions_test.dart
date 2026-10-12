import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'dictionary_test.dart' show fixture;
import 'support/memory_progress_store.dart';

Map<String, dynamic> newWords({String id = 'goodbye'}) => {
  'schemaVersion': 1,
  'addedWeek': '2026-10-12',
  'words': [
    {
      'id': id,
      'collection': 'phrases-social',
      'greek': 'Αντίο!',
      'prompt': {'en': 'Goodbye', 'ru': 'До свидания'},
      'pronunciation': {'en': 'a-DI-o', 'ru': 'а-ДИ-о'},
      'themes': ['conversation'],
    },
  ],
};

class _Bundle extends CachingAssetBundle {
  _Bundle(this.sources);
  final Map<String, String> sources;

  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin') {
      return const StandardMessageCodec().encodeMessage({
        for (final path in sources.keys) path: [],
      })!;
    }
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(sources[key]!)));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'documented noun template accepts its answer with or without the article',
    () {
      final dictionary = GreekDictionary.merge(
        File(dictionaryAsset).readAsStringSync(),
        {
          'example.json': File(
            'docs/new-words.example.json',
          ).readAsStringSync(),
        },
      );
      final card = dictionary.learningDecks
          .singleWhere((deck) => deck.id == 'words-nouns')
          .cards
          .singleWhere((card) => card.id == 'pear-2026-10');
      const matcher = GreekAnswer();
      expect(matcher.matches(card.displayedAnswer, card), isTrue);
      expect(matcher.matches('αχλάδι', card), isTrue);
      for (final answer in ['η αχλάδι', 'το αχλαδι', 'αχλαδι', 'άχλαδι']) {
        expect(matcher.matches(answer, card), isFalse, reason: answer);
      }
    },
  );

  test('noun forms and explicit alternatives retain optional articles', () {
    final base = fixture();
    base['collections'][0]['section'] = 'words';
    base['collections'][0]['deck']['id'] = 'words-nouns';
    final addition = newWords(id: 'cousin');
    final word = addition['words'][0];
    word['collection'] = 'words-nouns';
    word['greek'] = 'ξάδελφος';
    word['answerDisplay'] = 'ο ξάδελφος / η ξαδέλφη';
    word['acceptedAnswers'] = ['ο ξάδερφος'];
    word['forms'] = [
      {
        'greek': 'ξάδελφος',
        'answerDisplay': 'ο ξάδελφος',
        'pronunciation': {'en': 'KSA-dhel-fos', 'ru': 'КСА-дэл-фос'},
      },
      {
        'greek': 'ξαδέλφη',
        'answerDisplay': 'η ξαδέλφη',
        'pronunciation': {'en': 'ksa-DHEL-fi', 'ru': 'кса-ДЭЛ-фи'},
      },
    ];
    final card = GreekDictionary.merge(jsonEncode(base), {
      'nouns.json': jsonEncode(addition),
    }).learningDecks.single.cards.last;
    const matcher = GreekAnswer();
    for (final answer in [
      'ξάδελφος',
      'ο ξάδελφος',
      'ξαδέλφη',
      'η ξαδέλφη',
      'ξάδερφος',
      'ο ξάδερφος',
    ]) {
      expect(matcher.matches(answer, card), isTrue, reason: answer);
    }
    expect(matcher.matches('η ξάδελφος', card), isFalse);
    expect(matcher.matches(card.displayedAnswer, card), isFalse);
  });

  test('noun article adaptation does not relax grammar or phrase answers', () {
    for (final section in ['grammar', 'phrases']) {
      final base = fixture();
      base['collections'][0]['section'] = section;
      final addition = newWords();
      addition['words'][0]['greek'] = 'το αχλάδι';
      addition['words'][0]['labels'] = ['noun'];
      final card = GreekDictionary.merge(jsonEncode(base), {
        'exercise.json': jsonEncode(addition),
      }).learningDecks.single.cards.last;
      const matcher = GreekAnswer();
      expect(matcher.matches('το αχλάδι', card), isTrue);
      expect(matcher.matches('αχλάδι', card), isFalse, reason: section);
    }
  });

  test('all checked-in addition files are bundled and merged', () async {
    final expected = Directory(dictionaryAdditionsDirectory)
        .listSync()
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => path.endsWith('.json'))
        .toSet();
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final actual = manifest
        .listAssets()
        .where(
          (path) =>
              path.startsWith(dictionaryAdditionsDirectory) &&
              path.endsWith('.json'),
        )
        .toSet();
    expect(actual, expected);
    final dictionary = await readGreekDictionary(rootBundle);
    expect(
      dictionary.learningDecks.map((deck) => deck.cards.length),
      currentDictionary.learningDecks.map((deck) => deck.cards.length),
    );
  });
  test(
    'one new file is discovered and merged without editing the base or a list',
    () async {
      final base = jsonEncode(fixture());
      final dictionary = await readGreekDictionary(
        _Bundle({
          dictionaryAsset: base,
          '${dictionaryAdditionsDirectory}2026-10-12.json': jsonEncode(
            newWords(),
          ),
          '${dictionaryAdditionsDirectory}notes.txt': 'ignored',
        }),
      );
      final collection = dictionary.collections.single;
      expect(collection.deck.cards.map((c) => c.id), ['hello', 'goodbye']);
      final result = collection.filter(
        query: 'αντιο',
        theme: LearningTheme.conversation,
        now: DateTime(2026, 10, 12),
      );
      expect(result.cards.single.addedWeek, '2026-10-12');
      expect(result.cards.single.reviewIdentity!.cardId, 'goodbye');
      expect(base, jsonEncode(fixture()));
    },
  );

  test(
    'file order is deterministic and renaming a file preserves review keys',
    () {
      final base = jsonEncode(fixture());
      final a = jsonEncode(newWords(id: 'a'));
      final b = jsonEncode(newWords(id: 'b'));
      final first = GreekDictionary.merge(base, {'b.json': b, 'a.json': a});
      final second = GreekDictionary.merge(base, {'a.json': a, 'b.json': b});
      expect(first.learningDecks.single.cards.map((c) => c.id), [
        'hello',
        'a',
        'b',
      ]);
      expect(second.learningDecks.single.cards.map((c) => c.id), [
        'hello',
        'a',
        'b',
      ]);
      final renamed = GreekDictionary.merge(base, {'renamed.json': a});
      expect(
        renamed.learningDecks.single.cards.last.reviewIdentity!.key(
          StudyMode.typing,
        ),
        first.learningDecks.single.cards[1].reviewIdentity!.key(
          StudyMode.typing,
        ),
      );
    },
  );

  test('old reviews remain learned and new words start due', () async {
    final dictionary = GreekDictionary.merge(jsonEncode(fixture()), {
      'new.json': jsonEncode(newWords()),
    });
    final store = MemoryProgressStore();
    store.records['greetings.typing.hello'] = ReviewSchedule(
      level: 3,
      dueAt: DateTime.utc(2099),
    );
    final progress = LearningProgress(store);
    addTearDown(progress.dispose);
    await progress.load(dictionary.learningDecks);
    final deck = dictionary.learningDecks.single;
    expect(progress.learned(deck, StudyMode.typing), 1);
    expect(progress.dueCards(deck, StudyMode.typing).single.id, 'goodbye');
  });

  test('duplicate IDs across files fail rather than replacing a word', () {
    final addition = jsonEncode(newWords());
    expect(
      () => GreekDictionary.merge(jsonEncode(fixture()), {
        'a.json': addition,
        'b.json': addition,
      }),
      throwsFormatException,
    );
  });

  final invalid = <String, void Function(Map<String, dynamic>)>{
    'unknown collection': (data) => data['words'][0]['collection'] = 'missing',
    'conflicting review key': (data) => data['words'][0]['reviewIdentity'] = {
      'deckId': 'greetings',
      'cardId': 'hello',
    },
    'conflicting display id': (data) => data['words'][0]['id'] = 'hello',
    'unknown theme': (data) => data['words'][0]['themes'] = ['missing'],
    'invalid week': (data) => data['addedWeek'] = '2026-10-13',
    'missing week': (data) => data.remove('addedWeek'),
    'missing translation': (data) => data['words'][0]['prompt'].remove('ru'),
    'unknown field': (data) => data['words'][0]['typo'] = true,
    'unsupported schema': (data) => data['schemaVersion'] = 2,
  };
  for (final entry in invalid.entries) {
    test('addition rejects ${entry.key}', () {
      final data = jsonDecode(jsonEncode(newWords())) as Map<String, dynamic>;
      entry.value(data);
      expect(
        () => GreekDictionary.merge(jsonEncode(fixture()), {
          'new.json': jsonEncode(data),
        }),
        throwsFormatException,
      );
    });
  }
}
