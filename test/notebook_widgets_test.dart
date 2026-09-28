import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/card_explanation.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';
import 'package:greek_anki/presentation/topic_picker.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

void main() {
  void phone(WidgetTester tester, {double width = 430}) {
    tester.view.physicalSize = Size(width, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> tapVisible(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text));
    await tester.pumpAndSettle();
    await tester.tap(find.text(text));
    await tester.pumpAndSettle();
  }

  testWidgets('topic search, selection, language switch and reference browse', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(
      GreekAnkiApp(
        store: MemoryProgressStore(),
        languageStore: MemoryLanguageStore(language: AppLanguage.russian),
      ),
    );
    await tester.pumpAndSettle();
    await tapVisible(tester, 'Выбрать тему · ${greekDecks.length}');
    expect(find.byType(TopicPicker), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('topic-search')),
      'несуществующая тема',
    );
    await tester.pumpAndSettle();
    expect(find.text('Подходящих тем нет'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('topic-search')),
      'откуда',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Откуда вы?'));
    await tester.pumpAndSettle();
    expect(find.byType(TopicPicker), findsNothing);
    expect(find.text('Откуда вы?'), findsOneWidget);
    await tapVisible(tester, 'Все слова');
    await tester.scrollUntilVisible(
      find.text('από τη Ρωσία'),
      240,
      scrollable: find.byType(Scrollable).last,
    );
    final origin = greekDecks.firstWhere((d) => d.id == 'origin');
    final card = origin.cards.firstWhere((c) => c.id == 'from-russia');
    expect(find.text(card.explanation!.ru), findsOneWidget);
    Navigator.of(tester.element(find.text('από τη Ρωσία'))).pop();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('English'),
      -240,
      scrollable: find.byType(Scrollable).first,
    );
    await tapVisible(tester, 'English');
    expect(find.text('Where are you from?'), findsOneWidget);
    await tapVisible(tester, 'Hard mode');
    expect(find.byType(StudyScreen), findsOneWidget);
    expect(find.text('Where are you from?'), findsOneWidget);
    expect(find.byType(CardExplanation), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'long Russian phrases hide grammar until reveal and remain scrollable',
    (tester) async {
      phone(tester, width: 320);
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final deck = greekDecks.firstWhere((d) => d.id == 'classroom-phrases');
      final card = deck.cards.firstWhere((c) => c.id == 'say-greek');
      for (final mode in StudyMode.values) {
        await tester.pumpWidget(
          MaterialApp(
            theme: appTheme,
            locale: const Locale('ru'),
            supportedLocales: const [Locale('en'), Locale('ru')],
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            home: StudyScreen(
              key: ValueKey(mode),
              deck: deck,
              cards: [card],
              mode: mode,
              progress: LearningProgress(MemoryProgressStore()),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text(card.greek), findsNothing);
        expect(find.text(card.explanation!.ru), findsNothing);
        await tapVisible(
          tester,
          mode == StudyMode.flashcards ? 'Показать ответ' : 'Пока не знаю',
        );
        expect(find.text(card.greek), findsOneWidget);
        expect(find.text(card.explanation!.ru), findsOneWidget);
        await tapVisible(
          tester,
          mode == StudyMode.flashcards ? 'Помню' : 'Дальше',
        );
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets('full Greek phrase typed without punctuation is accepted', (
    tester,
  ) async {
    phone(tester);
    final deck = greekDecks.firstWhere((d) => d.id == 'origin');
    final card = deck.cards.firstWhere((c) => c.id == 'i-from-cyprus');
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: StudyScreen(
          deck: deck,
          cards: [card],
          mode: StudyMode.typing,
          progress: LearningProgress(MemoryProgressStore()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tapVisible(tester, 'Use phone keyboard');
    await tester.enterText(
      find.byKey(const ValueKey('greek-answer')),
      'είμαι από την Κύπρο',
    );
    await tapVisible(tester, 'Check answer');
    expect(find.text('Exactly right.'), findsOneWidget);
    expect(find.text(card.explanation!.en), findsOneWidget);
    await tapVisible(tester, 'Continue');
    expect(find.text('1 of 1 on the first try'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'new lesson sentences work in both modes on a small Russian screen',
    (tester) async {
      phone(tester, width: 320);
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      for (final (deckId, cardId) in [
        ('everyday-places', 'study-present.kostas-university'),
        ('phone-conversations', 'have-present.not-phone-yet'),
      ]) {
        final deck = greekDecks.firstWhere((d) => d.id == deckId);
        final card = deck.cards.firstWhere((c) => c.id == cardId);
        for (final mode in StudyMode.values) {
          await tester.pumpWidget(
            MaterialApp(
              theme: appTheme,
              locale: const Locale('ru'),
              supportedLocales: const [Locale('en'), Locale('ru')],
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              home: StudyScreen(
                key: ValueKey('$deckId-$mode'),
                deck: deck,
                cards: [card],
                mode: mode,
                progress: LearningProgress(MemoryProgressStore()),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text(card.explanation!.ru), findsNothing);
          if (mode == StudyMode.typing) {
            // Enter through the same controller used by the built-in Greek keys.
            final input = tester.widget<TextField>(
              find.byKey(const ValueKey('greek-answer')),
            );
            input.controller!.text = card.greek;
            await tester.pumpAndSettle();
            await tapVisible(tester, 'Проверить');
            expect(find.text('Всё верно.'), findsOneWidget);
          } else {
            await tapVisible(tester, 'Показать ответ');
          }
          expect(
            find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == card.greek,
            ),
            findsOneWidget,
          );
          expect(find.text(card.explanation!.ru), findsOneWidget);
          await tapVisible(
            tester,
            mode == StudyMode.typing ? 'Дальше' : 'Помню',
          );
          expect(tester.takeException(), isNull);
        }
      }
    },
  );
}
