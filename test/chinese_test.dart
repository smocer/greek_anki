import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

GreekDictionary catalog() =>
    GreekDictionary.merge(File(dictionaryAsset).readAsStringSync(), {
      for (final file
          in Directory(dictionaryAdditionsDirectory)
              .listSync()
              .whereType<File>()
              .where((file) => file.path.endsWith('.json')))
        file.path: file.readAsStringSync(),
    });

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('all bundled cards have Chinese prompts and instructions', () {
    for (final deck in catalog().learningDecks) {
      expect(deck.title.zh, isNotEmpty, reason: deck.id);
      for (final card in deck.cards) {
        expect(card.prompt.zh, isNotEmpty, reason: '${deck.id}/${card.id}');
        expect(card.meaning.zh, isNotEmpty, reason: '${deck.id}/${card.id}');
        for (final sense in card.senses) {
          expect(sense.zh, isNotEmpty, reason: card.id);
        }
      }
    }
  });

  test('October import reuses existing words and keeps distinct forms', () {
    final dictionary = catalog();
    final cards = [for (final deck in dictionary.learningDecks) ...deck.cards];
    Iterable<VocabularyCard> find(String greek) => cards.where(
      (card) => GreekText.answerKey(card.greek) == GreekText.answerKey(greek),
    );
    final source = jsonDecode(File('10.16.2026new.json').readAsStringSync());
    final imported = jsonDecode(
      File(
        'assets/dictionary/additions/2026-10-16-import.json',
      ).readAsStringSync(),
    );
    expect(source['词条'], hasLength(68));
    expect(imported['words'], hasLength(29));
    String bare(String text) =>
        GreekText.answerKey(text).replaceFirst(RegExp(r'^(ο|η|το|οι|τα) '), '');
    for (final entry in source['词条']) {
      final key = bare(entry['希腊语']);
      expect(
        cards.any(
          (card) => [
            card.greek,
            ...card.alternatives,
            for (final form in card.forms) form.greek,
          ].any((form) => bare(form) == key),
        ),
        isTrue,
        reason: entry['希腊语'],
      );
    }
    expect(find('πότε;').map((c) => c.id).toSet(), hasLength(1));
    expect(find('ποτέ').single.prompt.zh, contains('从来'));
    expect(find('ζητάει').single.id, 'oct16-requests');
    expect(find('ζητάω').single.id, 'languages-request');
    expect(find('πάρε').single.id, 'oct16-take-imperative');
    expect(find('παίρνω').single.id, 'oct16-take');
    expect(find('εταιρεία').single.id, 'languages-company');
    expect(find('εταιρεία').single.prompt.zh, '公司');
    expect(find('ξενοδοχείο').single.prompt.zh, '酒店');
    expect(find('βράχηκα.').single.id, 'languages-got-wet');
    final airplane = find('αεροπλάνο').single;
    expect(airplane.addedWeek, '2026-10-12');
    for (final answer in ['αεροπλάνο', 'το αεροπλάνο']) {
      expect(const GreekAnswer().matches(answer, airplane), isTrue);
    }
    final nouns = dictionary.collections.singleWhere(
      (c) => c.deck.id == 'words-nouns',
    );
    expect(
      nouns.filter(query: '飞机', now: DateTime(2026, 10, 16)).cards,
      contains(airplane),
    );
  });

  test('Chinese locale codes and legacy fallback are supported', () {
    expect(AppLanguage.fromCode('zh'), AppLanguage.chinese);
    expect(AppLanguage.fromCode('zh-CN'), AppLanguage.chinese);
    expect(AppLanguage.fromCode('ru'), AppLanguage.russian);
    expect(
      const LocalizedText(
        en: 'legacy',
        ru: 'старое',
      ).resolve(AppLanguage.chinese),
      'legacy',
    );
  });

  testWidgets('Chinese switch persists after restarting the app', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final language = MemoryLanguageStore();
    final progress = MemoryProgressStore();
    await tester.pumpWidget(
      GreekAnkiApp(store: progress, languageStore: language),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('中文'));
    await tester.pumpAndSettle();
    expect(find.text('词卡'), findsOneWidget);
    expect(language.language, AppLanguage.chinese);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      GreekAnkiApp(store: progress, languageStore: language),
    );
    await tester.pumpAndSettle();
    expect(find.text('词卡'), findsOneWidget);
    expect(find.text('默写模式'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
