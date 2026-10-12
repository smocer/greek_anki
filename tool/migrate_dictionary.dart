import 'dart:convert';
import 'dart:io';

import 'legacy_data/greek_decks.dart';
import 'legacy_data/learning_curriculum.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/vocabulary.dart';

Map<String, String> text(LocalizedText value) => {
  'en': value.en,
  'ru': value.ru,
};

Map<String, Object?> card(VocabularyCard c) => {
  'id': c.id,
  'prompt': text(c.prompt),
  'meaning': text(c.meaning),
  'greek': c.greek,
  'pronunciation': text(c.pronunciation),
  if (c.explanation != null) 'explanation': text(c.explanation!),
  if (c.alternatives.isNotEmpty) 'alternatives': c.alternatives,
  if (c.acceptedAnswers.isNotEmpty) 'acceptedAnswers': c.acceptedAnswers,
  if (c.reviewIdentity != null)
    'reviewIdentity': {
      'deckId': c.reviewIdentity!.deckId,
      'cardId': c.reviewIdentity!.cardId,
    },
  if (c.labels.isNotEmpty) 'labels': c.labels.map((l) => l.name).toList(),
  if (c.addedWeek != null) 'addedWeek': c.addedWeek,
  if (c.answerDisplay != null) 'answerDisplay': c.answerDisplay,
  if (c.words.isNotEmpty)
    'words': [
      for (final w in c.words)
        {
          'surface': w.surface,
          'lemma': w.lemma,
          'start': w.start,
          'end': w.end,
          'labels': w.labels.map((l) => l.name).toList(),
          if (w.tag.isNotEmpty) 'tag': w.tag,
          if (w.addedWeek != null) 'addedWeek': w.addedWeek,
        },
    ],
};

void main() {
  final cards = <String, Object?>{};
  final matching = <String, String>{};
  Map<String, Object?> deck(VocabularyDeck d) => {
    'id': d.id,
    'title': text(d.title),
    'subtitle': text(d.subtitle),
    'cover': d.cover,
    if (d.note != null) 'note': text(d.note!),
    'cards': [
      for (final c in d.cards)
        (() {
          final value = card(c);
          final serialized = jsonEncode(value);
          if (matching.containsKey(serialized)) return matching[serialized]!;
          final key = '${d.id}/${c.id}';
          cards[key] = value;
          matching[serialized] = key;
          return key;
        })(),
    ],
  };
  final decks = greekDecks.map(deck).toList();
  final collections = [
    for (final c in learningCollections)
      {
        'section': c.section.name,
        'deck': deck(c.deck),
        'themes': {
          for (final e in c.themes.entries)
            e.key: e.value.map((t) => t.name).toList(),
        },
      },
  ];
  final output = File('assets/dictionary/greek.json');
  if (output.existsSync()) {
    throw StateError(
      'Dictionary already exists. This exporter is only for '
      'the initial migration; edit the JSON dictionary for updates.',
    );
  }
  output.parent.createSync(recursive: true);
  output.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert({'schemaVersion': 1, 'cards': cards, 'decks': decks, 'collections': collections})}\n',
  );
  stdout.writeln(
    'Exported ${cards.length} cards, ${decks.length} source decks, '
    '${collections.length} learning collections.',
  );
}
