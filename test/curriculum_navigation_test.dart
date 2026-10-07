import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/presentation/card_explanation.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/topic_picker.dart';
import 'package:greek_anki/presentation/vocabulary_preview.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

void main() {
  Future<void> openApp(
    WidgetTester tester, {
    AppLanguage language = AppLanguage.english,
  }) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      GreekAnkiApp(
        store: MemoryProgressStore(),
        languageStore: MemoryLanguageStore(language: language),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    final target = find.text(text).last;
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  for (final language in AppLanguage.values) {
    testWidgets(
      'family filter finds alternate spelling and starts hard mode (${language.name})',
      (tester) async {
        final russian = language == AppLanguage.russian;
        await openApp(tester, language: language);
        await tapText(tester, russian ? 'Фильтры' : 'Filters');
        await tester.tap(find.byKey(const ValueKey('collection-theme')));
        await tester.pumpAndSettle();
        await tapText(tester, russian ? 'Семья' : 'Family');
        await tester.enterText(
          find.byKey(const ValueKey('topic-search')),
          'αδελφός',
        );
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<VocabularyPreview>(find.byType(VocabularyPreview))
              .cards
              .map((card) => card.greek),
          contains('αδερφός'),
        );
        // The substring also matches ξάδελφος, so narrow the round to brother.
        await tester.enterText(
          find.byKey(const ValueKey('topic-search')),
          'Brother αδελφός',
        );
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<VocabularyPreview>(find.byType(VocabularyPreview))
              .cards
              .single
              .greek,
          'αδερφός',
        );
        await tester.tap(find.byKey(const ValueKey('use-category')));
        await tester.pumpAndSettle();
        await tapText(tester, russian ? 'Сложный режим' : 'Hard mode');
        expect(find.text(russian ? 'Брат' : 'Brother'), findsOneWidget);
        expect(find.text('ο αδερφός'), findsNothing);
        final input = tester.widget<TextField>(
          find.byKey(const ValueKey('greek-answer')),
        );
        input.controller!.text = 'αδελφός';
        await tester.pumpAndSettle();
        await tapText(tester, russian ? 'Проверить' : 'Check answer');
        expect(find.text('ο αδερφός'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('grammar hard mode asks for the full translated sentence', (
    tester,
  ) async {
    await openApp(tester);
    await tapText(tester, 'Grammar');
    await tester.tap(find.byKey(const ValueKey('collection-grammar')));
    await tester.pumpAndSettle();
    await tapText(tester, 'Possession');
    await tapText(tester, 'Filters');
    await tester.enterText(
      find.byKey(const ValueKey('topic-search')),
      'This is her bag',
    );
    await tester.pumpAndSettle();
    await tapText(tester, 'Apply filters');
    await tapText(tester, 'Hard mode');
    expect(find.text('This is her bag.'), findsOneWidget);
    expect(find.text('Αυτή είναι η τσάντα της.'), findsNothing);
    expect(find.byType(CardExplanation), findsNothing);
    final input = tester.widget<TextField>(
      find.byKey(const ValueKey('greek-answer')),
    );
    input.controller!.text = 'Αυτή είναι η τσάντα της';
    await tester.pumpAndSettle();
    await tapText(tester, 'Check answer');
    expect(find.text('Exactly right.'), findsOneWidget);
    expect(find.text('Αυτή είναι η τσάντα της.'), findsOneWidget);
    expect(find.byType(CardExplanation), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a theme can be cleared and fifteen-card rounds continue', (
    tester,
  ) async {
    await openApp(tester);
    await tapText(tester, 'Filters');
    final theme = find.byKey(const ValueKey('collection-theme'));
    await tester.tap(theme);
    await tester.pumpAndSettle();
    await tapText(tester, 'Phone');
    final filtered = tester.widget<VocabularyPreview>(
      find.byType(VocabularyPreview),
    );
    expect(filtered.cards.length, lessThan(15));
    expect(
      tester
          .widget<DropdownButtonFormField<LearningTheme?>>(theme)
          .initialValue,
      LearningTheme.phone,
    );
    await tester.tap(theme);
    await tester.pumpAndSettle();
    await tapText(tester, 'All themes');
    expect(
      tester
          .widget<VocabularyPreview>(find.byType(VocabularyPreview))
          .cards
          .length,
      greaterThan(100),
    );
    await tapText(tester, 'Apply filters');
    expect(find.byType(TopicPicker), findsNothing);
    await tapText(tester, 'Flashcards');
    final screen = tester.widget<StudyScreen>(find.byType(StudyScreen));
    expect(screen.cards.length, 15);
    final firstBatch = screen.cards.map((c) => c.prompt.en).toSet();
    for (var i = 0; i < 15; i++) {
      await tapText(tester, 'Reveal answer');
      await tapText(tester, 'Got it');
    }
    expect(find.text('15 of 15 on the first try'), findsOneWidget);
    await tapText(tester, 'Next batch');
    for (final prompt in firstBatch) {
      expect(find.text(prompt), findsNothing);
    }
    for (var i = 0; i < 15; i++) {
      await tapText(tester, 'Reveal answer');
      await tapText(tester, 'Got it');
    }
    expect(find.text('15 of 15 on the first try'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
