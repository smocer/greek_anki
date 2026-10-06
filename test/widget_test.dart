import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_progress_store.dart';
import 'support/memory_language_store.dart';

void main() {
  final deck = greekDecks.firstWhere((deck) => deck.id == 'numbers-0-10');

  Future<void> openStudy(
    WidgetTester tester,
    StudyMode mode, {
    MemoryProgressStore? store,
    List<VocabularyCard>? cards,
  }) async {
    tester.view.physicalSize = const Size(430, 960);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: StudyScreen(
          deck: deck,
          cards: cards ?? [deck.cards[1]],
          mode: mode,
          progress: LearningProgress(store ?? MemoryProgressStore()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('home exposes both modes and full vocabulary', (tester) async {
    tester.view.physicalSize = const Size(430, 960);
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
    expect(find.text('Flashcards'), findsOneWidget);
    expect(find.text('Hard mode'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('collection-words')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Numbers').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse'));
    await tester.pumpAndSettle();
    expect(find.text('μηδέν'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('δέκα'),
      240,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('δέκα'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('flashcards hide answer, repeat misses, and complete', (
    tester,
  ) async {
    final store = MemoryProgressStore();
    await openStudy(tester, StudyMode.flashcards, store: store);
    expect(find.text('ένα'), findsNothing);
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();
    expect(find.text('ένα'), findsOneWidget);
    await tester.tap(find.text('Again'));
    await tester.pumpAndSettle();
    expect(find.text('0 / 1 remembered'), findsOneWidget);
    expect(find.text('ένα'), findsNothing);
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(find.text('Μπράβο!'), findsOneWidget);
    expect(find.text('0 of 1 on the first try'), findsOneWidget);
    expect(store.records.values.single.level, 1);
  });

  testWidgets('hard mode Greek keys, delete, wrong answer and retry', (
    tester,
  ) async {
    await openStudy(tester, StudyMode.typing);
    expect(find.text('ένα'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Check answer'),
          )
          .onPressed,
      isNull,
    );
    await tester.tap(find.text('δ'));
    await tester.tap(find.text('ε'));
    await tester.tap(find.text('κ'));
    await tester.tap(find.text('α'));
    await tester.pump();
    await tester.tap(find.text('Check answer'));
    await tester.pumpAndSettle();
    expect(find.text('You’ll get this one.'), findsOneWidget);
    expect(find.text('ένα'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('ένα'), findsNothing);
    await tester.tap(find.text('έ'));
    await tester.tap(find.text('ν'));
    await tester.tap(find.text('σ'));
    await tester.tap(find.byIcon(Icons.backspace_outlined));
    await tester.tap(find.text('α'));
    await tester.pump();
    await tester.tap(find.text('Check answer'));
    await tester.pumpAndSettle();
    expect(find.text('Exactly right.'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Μπράβο!'), findsOneWidget);
  });

  testWidgets('skip shows correction and failure to save does not advance', (
    tester,
  ) async {
    final store = MemoryProgressStore()..shouldFail = true;
    await openStudy(tester, StudyMode.typing, store: store);
    await tester.tap(find.text('I don’t know yet'));
    await tester.pumpAndSettle();
    expect(find.text('ένα'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(
      find.text('Could not save this answer. Please try again.'),
      findsOneWidget,
    );
    expect(find.text('0 / 1 remembered'), findsOneWidget);
    store.shouldFail = false;
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Check answer'), findsOneWidget);
  });

  testWidgets('small landscape and large text remain scrollable', (
    tester,
  ) async {
    await openStudy(tester, StudyMode.typing);
    tester.view.physicalSize = const Size(640, 360);
    tester.platformDispatcher.textScaleFactorTestValue = 1.7;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('I don’t know yet'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('I don’t know yet'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('full shuffled deck can be completed in hard mode', (
    tester,
  ) async {
    final cards = List.of(deck.cards)..shuffle(Random(11));
    await openStudy(tester, StudyMode.typing, cards: cards);
    for (var index = 0; index < cards.length; index++) {
      final card = cards.firstWhere(
        (card) => find.text(card.meaning.en).evaluate().isNotEmpty,
      );
      // Switch to native input once to exercise both supported keyboards.
      if (index == 0) {
        await tester.tap(find.text('Use phone keyboard'));
        await tester.pumpAndSettle();
      }
      await tester.enterText(find.byType(TextField), card.greek);
      await tester.pump();
      await tester.tap(find.text('Check answer'));
      await tester.pumpAndSettle();
      expect(find.text('Exactly right.'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
    }
    expect(find.text('11 of 11 on the first try'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
