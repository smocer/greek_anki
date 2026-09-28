import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/greek_keyboard.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_progress_store.dart';

void main() {
  void phone(WidgetTester tester) {
    tester.view.physicalSize = const Size(430, 960);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> tap(WidgetTester tester, Finder target) async {
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'all stressed vowels support typing, caret insertion, selection and deletion',
    (tester) async {
      phone(tester);
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          theme: appTheme,
          home: Scaffold(
            body: Center(child: GreekKeyboard(controller: controller)),
          ),
        ),
      );
      for (final letter in 'άέήίόύώ'.split('')) {
        await tap(tester, find.text(letter));
      }
      expect(controller.text, 'άέήίόύώ');
      await tap(tester, find.byIcon(Icons.backspace_outlined));
      expect(controller.text, 'άέήίόύ');

      controller.value = const TextEditingValue(
        text: 'επτα',
        selection: TextSelection(baseOffset: 3, extentOffset: 4),
      );
      await tap(tester, find.text('ά'));
      expect(controller.text, 'επτά');
      expect(controller.selection.baseOffset, 4);
      await tap(tester, find.byIcon(Icons.backspace_outlined));
      expect(controller.text, 'επτ');

      controller.value = const TextEditingValue(
        text: 'οχτ',
        selection: TextSelection.collapsed(offset: 3),
      );
      await tap(tester, find.text('ώ'));
      expect(controller.text, 'οχτώ');
      // Backspace must also remove a decomposed vowel and its accent as one unit.
      controller.value = const TextEditingValue(
        text: 'ε\u0301',
        selection: TextSelection.collapsed(offset: 2),
      );
      await tap(tester, find.byIcon(Icons.backspace_outlined));
      expect(controller.text, isEmpty);
    },
  );

  for (final language in ['en', 'ru']) {
    testWidgets(
      'hard mode accepts valid variants but requires correct stress from Greek keys ($language)',
      (tester) async {
        phone(tester);
        final deck = greekDecks.firstWhere((d) => d.id == 'numbers-0-10');
        final cases = {
          'number-7': {
            'εφτά': true,
            'επτά': true,
            'εφτα': false,
            'επτα': false,
            'έφτα': false,
            'έπτα': false,
          },
          'number-8': {
            'οκτώ': true,
            'οχτώ': true,
            'οκτω': false,
            'οχτω': false,
            'όκτω': false,
            'όχτω': false,
          },
        };
        for (final entry in cases.entries) {
          final card = deck.cards.firstWhere((c) => c.id == entry.key);
          for (final answer in entry.value.entries) {
            final input = answer.key;
            final correct = answer.value;
            final store = MemoryProgressStore();
            await tester.pumpWidget(
              MaterialApp(
                theme: appTheme,
                locale: Locale(language),
                supportedLocales: const [Locale('en'), Locale('ru')],
                localizationsDelegates: GlobalMaterialLocalizations.delegates,
                home: StudyScreen(
                  key: ValueKey('$language-$input'),
                  deck: deck,
                  cards: [card],
                  mode: StudyMode.typing,
                  progress: LearningProgress(store),
                ),
              ),
            );
            await tester.pumpAndSettle();
            for (final letter in input.split('')) {
              await tap(
                tester,
                find.descendant(
                  of: find.byType(GreekKeyboard),
                  matching: find.text(letter),
                ),
              );
            }
            expect(
              tester
                  .widget<TextField>(find.byKey(const ValueKey('greek-answer')))
                  .controller!
                  .text,
              input,
            );
            await tap(
              tester,
              find.text(language == 'ru' ? 'Проверить' : 'Check answer'),
            );
            expect(
              find.text(
                correct
                    ? (language == 'ru' ? 'Всё верно.' : 'Exactly right.')
                    : (language == 'ru'
                          ? 'Скоро запомните.'
                          : 'You’ll get this one.'),
              ),
              findsOneWidget,
              reason: input,
            );
            await tap(
              tester,
              find.text(language == 'ru' ? 'Дальше' : 'Continue'),
            );
            expect(
              find.text(
                correct
                    ? (language == 'ru'
                          ? '1 из 1 с первой попытки'
                          : '1 of 1 on the first try')
                    : (language == 'ru' ? '0 / 1 выучено' : '0 / 1 remembered'),
              ),
              findsOneWidget,
              reason: input,
            );
            expect(
              store.records.values.single.level,
              correct ? 1 : 0,
              reason: input,
            );
            expect(tester.takeException(), isNull);
          }
        }
      },
    );
  }
}
