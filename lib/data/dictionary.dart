import 'dart:convert';

import 'package:flutter/services.dart';

import '../domain/app_language.dart';
import '../domain/curriculum.dart';
import '../domain/vocabulary.dart';
import '../domain/vocabulary_category.dart';
import 'word_consolidation.dart';

const dictionaryAsset = 'assets/dictionary/greek.json';
const dictionaryAdditionsDirectory = 'assets/dictionary/additions/';

/// A dictionary is published atomically: invalid data never replaces a catalog.
class GreekDictionary {
  GreekDictionary._(this.decks, this.collections);

  final List<VocabularyDeck> decks;
  final List<LearningCollection> collections;
  late final List<VocabularyDeck> learningDecks = List.unmodifiable(
    collections.map((collection) => collection.deck),
  );

  /// Increment files only append cards. Conflicts fail instead of hiding data.
  factory GreekDictionary.merge(String base, Map<String, String> additions) {
    final reader = _DictionaryReader();
    final original = GreekDictionary.parse(base);
    final root = reader.object(jsonDecode(base), 'dictionary');
    final cards = reader.object(root['cards'], 'cards');
    final collections = {
      for (final value in reader.list(root['collections'], 'collections'))
        (value['deck']['id'] as String): value as Map<String, dynamic>,
    };
    final identities = <String>{
      for (final deck in [...original.decks, ...original.learningDecks])
        for (final card in deck.cards)
          (card.reviewIdentity ??
                  ReviewIdentity(deckId: deck.id, cardId: card.id))
              .key(StudyMode.flashcards),
      for (final deck in [...original.decks, ...original.learningDecks])
        for (final card in deck.cards)
          for (final alias in card.reviewAliases)
            alias.key(StudyMode.flashcards),
    };
    for (final filename in additions.keys.toList()..sort()) {
      final data = reader.object(jsonDecode(additions[filename]!), filename, {
        'schemaVersion',
        'addedWeek',
        'words',
      });
      if (data['schemaVersion'] is! int || data['schemaVersion'] != 1) {
        reader.fail(filename, 'unsupported schemaVersion');
      }
      final addedWeek = reader.week(data['addedWeek'], '$filename.addedWeek');
      final words = reader.list(data['words'], '$filename.words');
      if (words.isEmpty) reader.fail(filename, 'no words');
      for (final value in words) {
        final word = Map<String, dynamic>.from(reader.object(value, filename));
        final target = reader.string(
          word.remove('collection'),
          '$filename.collection',
        );
        final collection = collections[target];
        if (collection == null) {
          reader.fail(filename, 'unknown collection $target');
        }
        final themes = word.remove('themes') ?? [];
        final id = reader.string(word['id'], '$filename.id');
        word['meaning'] ??= {
          'en': 'Translate into Greek.',
          'ru': 'Переведите на греческий.',
        };
        word['reviewIdentity'] ??= {'deckId': target, 'cardId': id};
        if (addedWeek != null) word['addedWeek'] ??= addedWeek;
        final card = reader.card(word, '$filename.$id');
        if (target == 'words-nouns' || target == 'words-names') {
          word['acceptedAnswers'] = _nounAcceptedAnswers(card);
        }
        if (card.addedWeek == null) {
          reader.fail(filename, 'missing addedWeek for $id');
        }
        final identity = card.reviewIdentity!;
        if (!identities.add(identity.key(StudyMode.flashcards))) {
          reader.fail(
            filename,
            'duplicate review identity ${identity.deckId}/${identity.cardId}',
          );
        }
        final key = 'additions/$id';
        if (cards.containsKey(key)) {
          reader.fail(filename, 'duplicate word id $id');
        }
        cards[key] = word;
        (collection['deck']['cards'] as List).add(key);
        collection['themes'] ??= <String, dynamic>{};
        (collection['themes'] as Map<String, dynamic>)[id] = themes;
      }
    }
    consolidateWordData(root);
    // Includes duplicate display IDs, unsupported themes and dates.
    return GreekDictionary.parse(jsonEncode(root));
  }

  factory GreekDictionary.parse(String source) {
    final reader = _DictionaryReader();
    final root = reader.object(jsonDecode(source), r'$', {
      'schemaVersion',
      'cards',
      'decks',
      'collections',
    });
    if (root['schemaVersion'] is! int || root['schemaVersion'] != 1) {
      throw const FormatException('Unsupported dictionary schemaVersion');
    }
    final entries = reader.object(root['cards'], 'cards');
    if (entries.isEmpty) throw const FormatException('Dictionary has no cards');
    final cards = <String, VocabularyCard>{};
    for (final entry in entries.entries) {
      reader.string(entry.key, 'card key');
      cards[entry.key] = reader.card(entry.value, 'cards.${entry.key}');
    }
    final decks = <VocabularyDeck>[];
    final deckIds = <String>{};
    for (final value in reader.list(root['decks'], 'decks')) {
      final deck = reader.deck(value, 'decks', cards);
      reader.unique(deck.id, deckIds, 'deck');
      decks.add(deck);
    }
    final collections = <LearningCollection>[];
    final collectionIds = <String>{};
    for (final value in reader.list(root['collections'], 'collections')) {
      final data = reader.object(value, 'collection', {
        'section',
        'deck',
        'themes',
      });
      final section = reader.enumValue(
        data['section'],
        LearningSection.values,
        'section',
      );
      final deck = reader.deck(data['deck'], 'collection.deck', cards);
      reader.unique(deck.id, collectionIds, 'collection');
      for (final card in deck.cards) {
        if (card.reviewIdentity == null) {
          throw FormatException(
            'Missing reviewIdentity: ${deck.id}/${card.id}',
          );
        }
      }
      final ids = deck.cards.map((card) => card.id).toSet();
      final themes = <String, Set<LearningTheme>>{};
      for (final entry
          in reader.object(data['themes'] ?? {}, 'themes').entries) {
        if (!ids.contains(entry.key)) {
          throw FormatException('Unknown theme card: ${deck.id}/${entry.key}');
        }
        themes[entry.key] = Set.unmodifiable([
          for (final theme in reader.list(entry.value, 'themes.${entry.key}'))
            reader.enumValue(theme, LearningTheme.values, 'theme'),
        ]);
      }
      collections.add(
        LearningCollection(
          section: section,
          deck: deck,
          themes: Map.unmodifiable(themes),
        ),
      );
    }
    if (collections.isEmpty) {
      throw const FormatException('Dictionary has no learning collections');
    }
    return GreekDictionary._(
      List.unmodifiable(decks),
      List.unmodifiable(collections),
    );
  }
}

List<String> _nounAcceptedAnswers(VocabularyCard card) {
  final answers = {
    card.greek,
    ...card.alternatives,
    ...card.acceptedAnswers,
    // Grouped displays join forms with a slash; each form is a valid answer.
    if (card.forms.isEmpty) card.displayedAnswer,
    for (final form in card.forms) ...[form.greek, form.answerDisplay],
  };
  final article = RegExp(r'^(ο|η|το|οι|τα)\s+', caseSensitive: false);
  return {
    ...answers,
    for (final answer in answers) answer.trim().replaceFirst(article, ''),
  }.toList();
}

GreekDictionary? _dictionary;
Future<void>? _loading;

GreekDictionary get currentDictionary =>
    _dictionary ??
    (throw StateError('Call loadGreekDictionary before reading the catalog'));

Future<void> loadGreekDictionary({AssetBundle? bundle}) {
  if (_dictionary != null) return Future.value();
  return _loading ??= _load(bundle ?? rootBundle);
}

Future<void> _load(AssetBundle bundle) async {
  try {
    _dictionary = await readGreekDictionary(bundle);
  } finally {
    // A failed asset load can be retried from the existing app error screen.
    _loading = null;
  }
}

/// Flutter discovers new files from the generated asset manifest automatically.
Future<GreekDictionary> readGreekDictionary(AssetBundle bundle) async {
  final manifest = await AssetManifest.loadFromAssetBundle(bundle);
  final paths =
      manifest
          .listAssets()
          .where(
            (path) =>
                path.startsWith(dictionaryAdditionsDirectory) &&
                path.endsWith('.json'),
          )
          .toList()
        ..sort();
  final additions = <String, String>{};
  for (final path in paths) {
    additions[path] = await bundle.loadString(path, cache: false);
  }
  return GreekDictionary.merge(
    await bundle.loadString(dictionaryAsset, cache: false),
    additions,
  );
}

class _DictionaryReader {
  Map<String, dynamic> object(
    Object? value,
    String path, [
    Set<String>? fields,
  ]) {
    if (value is! Map<String, dynamic>) fail(path, 'expected an object');
    if (fields != null) {
      for (final key in value.keys) {
        if (!fields.contains(key)) fail('$path.$key', 'unknown field');
      }
    }
    return value;
  }

  List<dynamic> list(Object? value, String path) {
    if (value is! List) fail(path, 'expected an array');
    return value;
  }

  String string(Object? value, String path, {bool allowEmpty = false}) {
    if (value is! String || (!allowEmpty && value.trim().isEmpty)) {
      fail(path, 'expected ${allowEmpty ? 'a string' : 'a nonempty string'}');
    }
    return value;
  }

  LocalizedText text(Object? value, String path) {
    final data = object(value, path, {'en', 'ru'});
    return LocalizedText(
      en: string(data['en'], '$path.en'),
      ru: string(data['ru'], '$path.ru'),
    );
  }

  T enumValue<T extends Enum>(Object? value, List<T> values, String path) {
    for (final option in values) {
      if (option.name == value) return option;
    }
    fail(path, 'unsupported value $value');
  }

  List<String> strings(Object? value, String path) => List.unmodifiable([
    for (final item in list(value ?? [], path)) string(item, path),
  ]);

  List<VocabularyLabel> labels(Object? value, String path) =>
      List.unmodifiable([
        for (final item in list(value ?? [], path))
          enumValue(item, VocabularyLabel.values, path),
      ]);

  String? week(Object? value, String path) {
    if (value == null) return null;
    final stamp = string(value, path);
    final date = DateTime.tryParse(stamp);
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(stamp) ||
        date == null ||
        date.weekday != DateTime.monday ||
        date.toIso8601String().substring(0, 10) != stamp) {
      fail(path, 'expected an ISO Monday date (YYYY-MM-DD)');
    }
    return stamp;
  }

  VocabularyCard card(Object? value, String path) {
    final data = object(value, path, {
      'id',
      'prompt',
      'meaning',
      'greek',
      'pronunciation',
      'explanation',
      'alternatives',
      'acceptedAnswers',
      'reviewIdentity',
      'labels',
      'addedWeek',
      'words',
      'answerDisplay',
      'aliases',
      'reviewAliases',
      'senses',
      'wordGroup',
      'forms',
    });
    ReviewIdentity? identity;
    if (data['reviewIdentity'] != null) {
      final origin = object(data['reviewIdentity'], '$path.reviewIdentity', {
        'deckId',
        'cardId',
      });
      identity = ReviewIdentity(
        deckId: string(origin['deckId'], '$path.reviewIdentity.deckId'),
        cardId: string(origin['cardId'], '$path.reviewIdentity.cardId'),
      );
    }
    final greek = string(data['greek'], '$path.greek');
    return VocabularyCard(
      id: string(data['id'], '$path.id'),
      prompt: text(data['prompt'], '$path.prompt'),
      meaning: text(data['meaning'], '$path.meaning'),
      greek: greek,
      pronunciation: text(data['pronunciation'], '$path.pronunciation'),
      explanation: data['explanation'] == null
          ? null
          : text(data['explanation'], '$path.explanation'),
      alternatives: strings(data['alternatives'], '$path.alternatives'),
      acceptedAnswers: strings(
        data['acceptedAnswers'],
        '$path.acceptedAnswers',
      ),
      reviewIdentity: identity,
      wordGroup: data['wordGroup'] == null
          ? null
          : string(data['wordGroup'], '$path.wordGroup'),
      forms: List.unmodifiable([
        for (final value in list(data['forms'] ?? [], '$path.forms'))
          (() {
            final form = object(value, '$path.forms', {
              'greek',
              'answerDisplay',
              'pronunciation',
            });
            final greek = string(form['greek'], '$path.forms.greek');
            return VocabularyForm(
              greek: greek,
              answerDisplay: string(
                form['answerDisplay'] ?? greek,
                '$path.forms.answerDisplay',
              ),
              pronunciation: text(
                form['pronunciation'],
                '$path.forms.pronunciation',
              ),
            );
          })(),
      ]),
      aliases: strings(data['aliases'], '$path.aliases'),
      reviewAliases: List.unmodifiable([
        for (final value in list(
          data['reviewAliases'] ?? [],
          '$path.reviewAliases',
        ))
          (() {
            final alias = object(value, '$path.reviewAliases', {
              'deckId',
              'cardId',
            });
            return ReviewIdentity(
              deckId: string(alias['deckId'], '$path.reviewAliases.deckId'),
              cardId: string(alias['cardId'], '$path.reviewAliases.cardId'),
            );
          })(),
      ]),
      senses: List.unmodifiable([
        for (final value in list(data['senses'] ?? [], '$path.senses'))
          text(value, '$path.senses'),
      ]),
      labels: labels(data['labels'], '$path.labels'),
      addedWeek: week(data['addedWeek'], '$path.addedWeek'),
      answerDisplay: data['answerDisplay'] == null
          ? null
          : string(data['answerDisplay'], '$path.answerDisplay'),
      words: List.unmodifiable([
        for (final word in list(data['words'] ?? [], '$path.words'))
          token(word, '$path.words', greek.length),
      ]),
    );
  }

  VocabularyToken token(Object? value, String path, int length) {
    final data = object(value, path, {
      'surface',
      'lemma',
      'start',
      'end',
      'labels',
      'tag',
      'addedWeek',
    });
    final start = data['start'], end = data['end'];
    if (start is! int ||
        end is! int ||
        start < 0 ||
        end <= start ||
        end > length) {
      fail(path, 'invalid token offsets');
    }
    return VocabularyToken(
      surface: string(data['surface'], '$path.surface'),
      lemma: string(data['lemma'], '$path.lemma'),
      start: start,
      end: end,
      labels: labels(data['labels'], '$path.labels'),
      tag: string(data['tag'] ?? '', '$path.tag', allowEmpty: true),
      addedWeek: week(data['addedWeek'], '$path.addedWeek'),
    );
  }

  VocabularyDeck deck(
    Object? value,
    String path,
    Map<String, VocabularyCard> cards,
  ) {
    final data = object(value, path, {
      'id',
      'title',
      'subtitle',
      'cover',
      'note',
      'cards',
    });
    final selected = <VocabularyCard>[];
    final ids = <String>{};
    for (final reference in strings(data['cards'], '$path.cards')) {
      final card = cards[reference];
      if (card == null) fail('$path.cards', 'unknown card $reference');
      unique(card.id, ids, '$path card');
      selected.add(card);
    }
    if (selected.isEmpty) fail(path, 'deck has no cards');
    return VocabularyDeck(
      id: string(data['id'], '$path.id'),
      title: text(data['title'], '$path.title'),
      subtitle: text(data['subtitle'], '$path.subtitle'),
      cover: string(data['cover'], '$path.cover'),
      note: data['note'] == null ? null : text(data['note'], '$path.note'),
      cards: List.unmodifiable(selected),
    );
  }

  void unique(String id, Set<String> ids, String path) {
    if (!ids.add(id)) fail(path, 'duplicate id $id');
  }

  Never fail(String path, String message) =>
      throw FormatException('$path: $message');
}
