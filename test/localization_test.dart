import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

void main() {
  final deck = greekDecks.firstWhere((deck) => deck.id == 'numbers-0-10');
  final seven = deck.cards[7];

  void phoneSize(WidgetTester tester, {Size size = const Size(430, 960)}) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> openRussianStudy(WidgetTester tester, StudyMode mode) async {
    phoneSize(tester);
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        locale: const Locale('ru'),
        supportedLocales: const [Locale('en'), Locale('ru')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: StudyScreen(
          deck: deck,
          cards: [seven],
          mode: mode,
          progress: LearningProgress(MemoryProgressStore()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  test('seven prefers efta with epta as an accepted alternative', () {
    expect(seven.id, 'number-7');
    expect(seven.greek, 'εφτά');
    expect(seven.alternatives, ['επτά']);
    expect(seven.pronunciation.en, 'ef-TA');
    expect(seven.pronunciation.ru, 'эф-ТА');
    for (final answer in ['εφτά', 'επτά', 'ΕΦΤΆ', 'ΕΠΤΆ']) {
      expect(const GreekAnswer().matches(answer, seven), isTrue);
    }
    for (final answer in [
      'εφτα',
      'επτα',
      'ΕΦΤΑ',
      'ΕΠΤΑ',
      'έπτα',
      'efta',
      'epta',
      'эфта',
      'семь',
    ]) {
      expect(const GreekAnswer().matches(answer, seven), isFalse);
    }
  });

  test(
    'Russian vocabulary and count grammar are present throughout the deck',
    () {
      for (final card in deck.cards) {
        expect(card.meaning.ru, matches(RegExp('[а-яё]')));
        expect(card.pronunciation.ru, matches(RegExp('[А-ЯЁа-яё]')));
        expect(card.prompt.resolve(AppLanguage.russian), card.prompt.en);
      }
      const strings = AppStrings(AppLanguage.russian);
      expect(strings.cardCount(1), '1 карточка');
      expect(strings.cardCount(2), '2 карточки');
      expect(strings.cardCount(11), '11 карточек');
      expect(strings.cardCount(21), '21 карточка');
      expect(strings.cardCount(112), '112 карточек');
    },
  );

  testWidgets('language switch persists across restart and keeps progress', (
    tester,
  ) async {
    phoneSize(tester);
    final language = MemoryLanguageStore();
    final store = MemoryProgressStore();
    final progress = LearningProgress(store);
    await progress.record(
      deck: deck,
      mode: StudyMode.flashcards,
      card: seven,
      correct: true,
    );
    final records = Map.of(store.records);
    await tester.pumpWidget(
      GreekAnkiApp(store: store, languageStore: language),
    );
    await tester.pumpAndSettle();
    expect(find.text('Greek,\nby heart.'), findsOneWidget);
    await tester.tap(find.text('Русский'));
    await tester.pumpAndSettle();
    expect(find.text('Греческий\nнаизусть.'), findsOneWidget);
    expect(find.text('Карточки'), findsOneWidget);
    expect(find.text('Повторить: 10 · Выучено: 1/11'), findsOneWidget);
    expect(language.language, AppLanguage.russian);
    expect(store.records, records);

    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      GreekAnkiApp(store: store, languageStore: language),
    );
    await tester.pumpAndSettle();
    expect(find.text('Греческий\nнаизусть.'), findsOneWidget);
    await tester.tap(find.text('Все слова'));
    await tester.pumpAndSettle();
    expect(find.text('ми-ДЭН'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('эф-ТА'),
      220,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('εφτά'), findsOneWidget);
    expect(find.text('Также верно: επτά'), findsOneWidget);
    Navigator.of(tester.element(find.text('эф-ТА'))).pop();
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Flashcards'), findsOneWidget);
    expect(language.language, AppLanguage.english);
    expect(store.records, records);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Russian flashcards reveal Cyrillic pronunciation and epta alternative',
    (tester) async {
      await openRussianStudy(tester, StudyMode.flashcards);
      expect(find.text('семь'), findsOneWidget);
      expect(find.text('РУССКИЙ → ГРЕЧЕСКИЙ'), findsOneWidget);
      await tester.tap(find.text('Показать ответ'));
      await tester.pumpAndSettle();
      expect(find.text('εφτά'), findsOneWidget);
      expect(find.text('эф-ТА'), findsOneWidget);
      expect(find.text('Также верно: επτά'), findsOneWidget);
      await tester.tap(find.text('Помню'));
      await tester.pumpAndSettle();
      expect(find.text('Выучено карточек: 1'), findsOneWidget);
      expect(find.text('1 из 1 с первой попытки'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Russian hard mode accepts secondary Greek spelling', (
    tester,
  ) async {
    await openRussianStudy(tester, StudyMode.typing);
    expect(find.text('семь'), findsOneWidget);
    expect(find.text('пробел'), findsOneWidget);
    expect(find.text('эф-ТА'), findsNothing);
    await tester.tap(find.text('ε'));
    await tester.tap(find.text('π'));
    await tester.tap(find.text('τ'));
    await tester.tap(find.text('ά'));
    await tester.pump();
    await tester.tap(find.text('Проверить'));
    await tester.pumpAndSettle();
    expect(find.text('Всё верно.'), findsOneWidget);
    expect(find.text('εφτά'), findsOneWidget);
    expect(find.text('эф-ТА'), findsOneWidget);
    await tester.tap(find.text('Дальше'));
    await tester.pumpAndSettle();
    expect(find.text('Выучено карточек: 1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('failed language save leaves the chosen language unchanged', (
    tester,
  ) async {
    phoneSize(tester);
    final language = MemoryLanguageStore()..shouldFail = true;
    await tester.pumpWidget(
      GreekAnkiApp(store: MemoryProgressStore(), languageStore: language),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Русский'));
    await tester.pumpAndSettle();
    expect(
      find.text('Could not save the language. Please try again.'),
      findsOneWidget,
    );
    expect(find.text('Greek,\nby heart.'), findsOneWidget);
    expect(language.language, AppLanguage.english);
    language.shouldFail = false;
    await tester.tap(find.text('Русский'));
    await tester.pumpAndSettle();
    expect(find.text('Греческий\nнаизусть.'), findsOneWidget);
  });

  testWidgets('Russian main menu remains usable on a narrow screen', (
    tester,
  ) async {
    phoneSize(tester, size: const Size(320, 740));
    await tester.pumpWidget(
      GreekAnkiApp(
        store: MemoryProgressStore(),
        languageStore: MemoryLanguageStore(language: AppLanguage.russian),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Сложный режим'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Сложный режим'));
    await tester.pumpAndSettle();
    expect(find.byType(StudyScreen), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Пока не знаю'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Пока не знаю'));
    await tester.pumpAndSettle();
    expect(find.text('Скоро запомните.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
