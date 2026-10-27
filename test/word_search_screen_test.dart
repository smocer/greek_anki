import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/vocabulary_card_details.dart';
import 'package:greek_anki/presentation/word_search_screen.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

void main() {
  for (final language in AppLanguage.values) {
    testWidgets('global lookup from Reference works on a phone ($language)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final store = MemoryProgressStore();
      final strings = AppStrings(language);
      await tester.pumpWidget(
        GreekAnkiApp(
          store: store,
          languageStore: MemoryLanguageStore(language: language),
        ),
      );
      await tester.pumpAndSettle();
      final collection = find.byKey(const ValueKey('collection-words'));
      await tester.tap(find.text(strings.reference));
      await tester.pumpAndSettle();
      await tester.tap(find.text(strings.wordSearch));
      await tester.pumpAndSettle();
      expect(find.byType(WordSearchScreen), findsOneWidget);
      expect(find.byType(VocabularyCardDetails), findsNothing);

      final input = find.byKey(const ValueKey('word-search-query'));
      await tester.enterText(input, 'επικ');
      tester.view.viewInsets = const FakeViewPadding(bottom: 250);
      await tester.pumpAndSettle();
      expect(find.text(strings.searchResultCount(1)), findsOneWidget);
      final entry = find.byType(VocabularyCardDetails);
      await tester.scrollUntilVisible(
        entry,
        100,
        scrollable: find
            .descendant(
              of: find.byType(CustomScrollView),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.pumpAndSettle();
      final card = tester.widget<VocabularyCardDetails>(entry).card;
      expect(card.greek, 'επικίνδυνος');
      expect(find.text(strings.text(card.prompt)), findsOneWidget);
      expect(find.text(card.displayedAnswer), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Returning to the query and replacing it also resets the results scroll.
      await tester.scrollUntilVisible(
        input,
        -100,
        scrollable: find
            .descendant(
              of: find.byType(CustomScrollView),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.enterText(input, 'αβγδεζηθικλ');
      await tester.pumpAndSettle();
      expect(find.text(strings.noSearchResults), findsOneWidget);
      expect(find.byType(VocabularyCardDetails), findsNothing);
      await tester.tap(find.byTooltip(strings.clearSearch));
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(input).controller!.text, isEmpty);
      expect(find.text(strings.noSearchResults), findsNothing);

      tester.view.viewInsets = const FakeViewPadding();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(WordSearchScreen), findsNothing);
      await tester.scrollUntilVisible(
        collection,
        100,
        scrollable: find.byType(Scrollable).first,
      );
      expect(
        tester.widget<DropdownButtonFormField<String>>(collection).initialValue,
        'words-nouns',
      );
      expect(store.records, isEmpty);
      expect(tester.takeException(), isNull);
    });
  }
}
