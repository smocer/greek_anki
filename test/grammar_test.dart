import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/greek_grammar.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/presentation/grammar_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

void main() {
  test('merged grammar keeps forms together with English table labels', () {
    expect(greekGrammar.map((topic) => topic.id), [
      'be',
      'verbs',
      'passive',
      'nouns',
      'possession',
      'prepositions',
    ]);
    final verbs = greekGrammar
        .firstWhere((topic) => topic.id == 'verbs')
        .tables
        .single;
    expect(verbs.rows.first, [
      'I',
      'γράφω',
      'έγραψα',
      'θα γράψω',
      'αγαπώ',
      'μπορώ',
    ]);
    final nouns = greekGrammar
        .firstWhere((topic) => topic.id == 'nouns')
        .tables
        .first;
    expect(nouns.rows.first, ['ο φίλος', 'ο φίλος', 'οι φίλοι']);
    expect(nouns.rows.length, 8);
    final caseTables = greekGrammar
        .firstWhere((topic) => topic.id == 'nouns')
        .tables
        .take(4)
        .toList();
    expect(caseTables.map((table) => table.title.en), [
      'Nominative',
      'Genitive',
      'Accusative',
      'Vocative',
    ]);
    expect(caseTables[1].rows.first, ['ο φίλος', 'του φίλου', 'των φίλων']);
    expect(caseTables[2].rows.first, ['ο φίλος', 'τον φίλο', 'τους φίλους']);
    expect(caseTables[3].rows.first, ['ο φίλος', 'φίλε', 'φίλοι']);
    final greekLetters = RegExp(r'[\u0370-\u03ff]');
    for (final topic in greekGrammar) {
      for (final table in topic.tables) {
        expect(greekLetters.hasMatch(table.title.en), isFalse);
        for (final header in table.headers) {
          expect(greekLetters.hasMatch(header.en), isFalse);
        }
      }
    }
  });
  testWidgets('home grammar button sits beside alphabet and opens be table', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      GreekAnkiApp(
        store: MemoryProgressStore(),
        languageStore: MemoryLanguageStore(),
      ),
    );
    await tester.pumpAndSettle();
    final alphabet = tester.getRect(
      find.widgetWithText(OutlinedButton, 'Alphabets'),
    );
    final grammar = tester.getRect(
      find.widgetWithText(OutlinedButton, 'Grammar'),
    );
    expect(grammar.left, alphabet.left);
    expect(grammar.top, greaterThan(alphabet.bottom));
    final headline = tester.getRect(find.text('Greek,\nby heart.'));
    expect(alphabet.left, greaterThan(headline.right));
    await tester.tap(find.text('Grammar'));
    await tester.pumpAndSettle();
    expect(find.byType(GrammarScreen), findsOneWidget);
    await tester.tap(find.text('Be · είμαι'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(ValueKey(greekGrammar.first.tables.first)),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('ήμασταν'), findsOneWidget);
    final tableOrigin = tester.getTopLeft(find.byType(DataTable));
    await tester.dragFrom(
      tableOrigin + const Offset(100, 30),
      const Offset(-500, 0),
    );
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.byType(DataTable)).dx,
      lessThan(tableOrigin.dx),
    );
    expect(find.text('θα είμαστε'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(GrammarScreen), findsOneWidget);
  });

  for (final language in AppLanguage.values) {
    testWidgets(
      'every grammar topic renders tables on a narrow screen (${language.code})',
      (tester) async {
        tester.view.physicalSize = const Size(320, 900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        for (final topic in greekGrammar) {
          await tester.pumpWidget(
            MaterialApp(
              key: ValueKey(topic.id),
              locale: Locale(language.code),
              supportedLocales: const [Locale('en'), Locale('ru')],
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              theme: appTheme,
              home: GrammarTopicScreen(topic: topic),
            ),
          );
          await tester.pumpAndSettle();
          await tester.scrollUntilVisible(
            find.byKey(ValueKey(topic.tables.first)),
            200,
            scrollable: find.byType(Scrollable).first,
          );
          expect(find.byType(DataTable), findsWidgets);
          expect(tester.takeException(), isNull, reason: topic.id);
        }
      },
    );
  }
}
