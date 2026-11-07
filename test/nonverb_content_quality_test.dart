import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/data/greek_grammar.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/greek_answer.dart';

bool auditedCategory(String id) =>
    id.startsWith('words-') && !['words-verbs', 'words-numbers'].contains(id);

void checkLocalizedLeaves(dynamic value, String path) {
  if (value is Map) {
    if (value.containsKey('en')) {
      for (final locale in ['en', 'ru', 'zh']) {
        expect(value[locale], isA<String>(), reason: '$path/$locale');
        expect(
          (value[locale] as String).trim(),
          isNotEmpty,
          reason: '$path/$locale',
        );
      }
    }
    for (final entry in value.entries) {
      checkLocalizedLeaves(entry.value, '$path/${entry.key}');
    }
  } else if (value is List) {
    for (var i = 0; i < value.length; i++) {
      checkLocalizedLeaves(value[i], '$path/$i');
    }
  }
}

void main() {
  test('all nonverb source text has explicit translations before merging', () {
    final base = jsonDecode(File(dictionaryAsset).readAsStringSync());
    for (final collection in base['collections']) {
      if (!auditedCategory(collection['deck']['id'])) continue;
      for (final key in collection['deck']['cards']) {
        checkLocalizedLeaves(base['cards'][key], key);
      }
    }
    for (final file in Directory(
      dictionaryAdditionsDirectory,
    ).listSync().whereType<File>().where((f) => f.path.endsWith('.json'))) {
      final data = jsonDecode(file.readAsStringSync());
      for (final word in data['words']) {
        if (auditedCategory(word['collection'])) {
          checkLocalizedLeaves(word, '${file.path}/${word['id']}');
        }
      }
    }
  });

  test(
    'short words have localized blanks without the answer in the example',
    () {
      final greekWord = RegExp(r'[\u0370-\u03ff\u1f00-\u1fff]+');
      for (final deck in currentDictionary.learningDecks) {
        if (!auditedCategory(deck.id)) continue;
        for (final card in deck.cards) {
          if ([
            'words-pronouns',
            'words-prepositions',
            'words-adverbs',
            'words-connectors',
          ].contains(deck.id)) {
            expect(card.contextExample, isNotNull, reason: card.id);
            expect(card.explanation, isNotNull, reason: card.id);
          }
          if (card.contextExample == null) continue;
          for (final locale in AppLanguage.values) {
            final example = card.contextExample!.resolve(locale);
            expect(
              '___'.allMatches(example).length,
              1,
              reason: '${card.id}/${locale.code}',
            );
            final words = greekWord
                .allMatches(example)
                .map((match) => match[0]!.toLowerCase());
            if (greekWord.stringMatch(card.greek) == card.greek) {
              expect(
                words,
                isNot(contains(card.greek.toLowerCase())),
                reason: '${card.id}/${locale.code}: answer revealed',
              );
            }
          }
        }
      }
    },
  );

  test('every listed adjective form is accepted in strict practice', () {
    const matcher = GreekAnswer();
    final adjectives = currentDictionary.learningDecks.singleWhere(
      (deck) => deck.id == 'words-adjectives',
    );
    for (final card in adjectives.cards) {
      for (final form in card.forms) {
        expect(
          matcher.matches(form.greek, card),
          isTrue,
          reason: '${card.id}: ${form.greek}',
        );
      }
    }
  });

  test('grammar reference copy never silently falls back to English', () {
    for (final topic in greekGrammar) {
      final text = [
        topic.title,
        topic.summary,
        ...topic.notes,
        for (final table in topic.tables) ...[
          table.title,
          ...table.headers,
          ...?table.rowLabels,
        ],
      ];
      for (final value in text) {
        expect(value.zh, isNotNull, reason: '${topic.id}: ${value.en}');
        expect(value.zh!.trim(), isNotEmpty, reason: topic.id);
      }
    }
  });
}
