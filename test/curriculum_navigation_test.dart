import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/presentation/card_explanation.dart';
import 'package:greek_anki/presentation/app_strings.dart';
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
    if (find.text(text).evaluate().isEmpty) {
      await tester.scrollUntilVisible(
        find.text(text),
        150,
        scrollable: find.byType(Scrollable).first,
      );
    }
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'session count supports custom values, validation and all cards',
    (tester) async {
      await openApp(tester);
      final input = find.byKey(const ValueKey('session-count'));
      await tester.ensureVisible(input);
      await tester.enterText(input, '0');
      await tester.pumpAndSettle();
      expect(find.text('Enter a positive number'), findsOneWidget);
      await tester.enterText(input, '3');
      await tapText(tester, 'Flashcards');
      expect(
        tester.widget<StudyScreen>(find.byType(StudyScreen)).cards,
        hasLength(3),
      );
      expect(
        tester.widget<StudyScreen>(find.byType(StudyScreen)).sessionLimit,
        3,
      );
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();
      final all = find.byKey(const ValueKey('session-all'));
      await tester.ensureVisible(all);
      await tester.tap(all);
      await tester.pumpAndSettle();
      final totalText = tester.widget<TextField>(input).controller!.text;
      final order = find.byKey(const ValueKey('session-order'));
      await tester.ensureVisible(order);
      await tester.tap(order);
      await tester.pumpAndSettle();
      await tapText(tester, 'Alphabetical');
      await tapText(tester, 'Flashcards');
      final screen = tester.widget<StudyScreen>(find.byType(StudyScreen));
      expect(screen.cards.length, screen.deck.cards.length);
      expect(screen.sessionLimit, isNull);
      expect(totalText, '${screen.deck.cards.length}');
      expect(screen.cardOrder, CardOrder.alphabet);
    },
  );

  testWidgets(
    'excluded themes preview, apply and persist when reopening filters',
    (tester) async {
      await openApp(tester);
      await tester.tap(find.byKey(const ValueKey('choose-category')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('exclude-themes')));
      await tester.pumpAndSettle();
      for (final name in ['home', 'classroom']) {
        final chip = find.byKey(ValueKey('exclude-$name'));
        await tester.ensureVisible(chip);
        await tester.pumpAndSettle();
        await tester.tap(chip);
        await tester.pumpAndSettle();
      }
      final picker = tester.widget<TopicPicker>(find.byType(TopicPicker));
      final preview = tester.widget<VocabularyPreview>(
        find.byType(VocabularyPreview),
      );
      expect(preview.cards, isNotEmpty);
      for (final card in preview.cards) {
        expect(
          picker.collection.themes[card.id] ?? {},
          isNot(contains(LearningTheme.home)),
        );
        expect(
          picker.collection.themes[card.id] ?? {},
          isNot(contains(LearningTheme.classroom)),
        );
      }
      await tester.tap(find.byKey(const ValueKey('use-category')));
      await tester.pumpAndSettle();
      final filter = find.byKey(const ValueKey('choose-category'));
      await tester.ensureVisible(filter);
      expect(find.textContaining('Exclude themes：'), findsOneWidget);
      await tester.tap(filter);
      await tester.pumpAndSettle();
      for (final name in ['home', 'classroom']) {
        expect(
          tester
              .widget<FilterChip>(find.byKey(ValueKey('exclude-$name')))
              .selected,
          isTrue,
        );
      }
      Future<void> selectTheme(String title) async {
        final theme = find.byKey(const ValueKey('collection-theme'));
        await tester.ensureVisible(theme);
        await tester.tap(theme);
        await tester.pumpAndSettle();
        await tapText(tester, title);
      }

      await selectTheme('Home & everyday life');
      expect(find.byKey(const ValueKey('exclude-themes')), findsNothing);
      final homeCards = tester
          .widget<VocabularyPreview>(find.byType(VocabularyPreview))
          .cards;
      expect(homeCards, isNotEmpty);
      for (final card in homeCards) {
        expect(picker.collection.themes[card.id], contains(LearningTheme.home));
      }
      await selectTheme('All themes');
      expect(find.byKey(const ValueKey('exclude-themes')), findsOneWidget);
      expect(
        tester
            .widget<FilterChip>(find.byKey(const ValueKey('exclude-home')))
            .selected,
        isTrue,
      );
      await selectTheme('Home & everyday life');
      await tester.tap(find.byKey(const ValueKey('use-category')));
      await tester.pumpAndSettle();
      expect(find.textContaining('Exclude themes：'), findsNothing);
    },
  );

  for (final language in AppLanguage.values) {
    testWidgets('verb class topics preview and apply (${language.name})', (
      tester,
    ) async {
      await openApp(tester, language: language);
      final strings = AppStrings(language);
      final verbs = currentDictionary.collections.singleWhere(
        (collection) => collection.deck.id == 'words-verbs',
      );
      await tester.tap(find.byKey(const ValueKey('collection-words')));
      await tester.pumpAndSettle();
      await tapText(tester, strings.text(verbs.deck.title));
      await tapText(tester, strings.filters);
      final dropdown = find.byKey(const ValueKey('collection-theme'));
      for (final theme in [
        LearningTheme.verbA,
        LearningTheme.verbB1,
        LearningTheme.verbB2,
        LearningTheme.verbAB,
      ]) {
        await tester.ensureVisible(dropdown);
        await tester.tap(dropdown);
        await tester.pumpAndSettle();
        await tapText(tester, strings.text(theme.title));
        final preview = tester.widget<VocabularyPreview>(
          find.byType(VocabularyPreview),
        );
        expect(preview.cards, isNotEmpty);
        expect(
          preview.cards.every((card) => verbs.themes[card.id]!.contains(theme)),
          isTrue,
        );
      }
      await tapText(tester, strings.applyFilters);
      await tapText(tester, strings.filters);
      expect(
        tester
            .widget<DropdownButtonFormField<LearningTheme?>>(dropdown)
            .initialValue,
        LearningTheme.verbAB,
      );
      await tapText(tester, strings.applyFilters);
      await tapText(tester, strings.flashcards);
      final screen = tester.widget<StudyScreen>(find.byType(StudyScreen));
      expect(screen.cards, isNotEmpty);
      expect(
        screen.cards.every(
          (card) => verbs.themes[card.id]!.contains(LearningTheme.verbAB),
        ),
        isTrue,
      );
      expect(tester.takeException(), isNull);
    });

    for (final cls in ['B1', 'B2']) {
      testWidgets(
        'conjugation $cls opens and accepts variants (${language.name})',
        (tester) async {
          await openApp(tester, language: language);
          await tapText(
            tester,
            LocalizedText(
              en: 'Grammar',
              ru: 'Грамматика',
              zh: '语法',
            ).resolve(language),
          );
          await tester.tap(find.byKey(const ValueKey('collection-grammar')));
          await tester.pumpAndSettle();
          await tapText(
            tester,
            LocalizedText(
              en: '$cls verb forms',
              ru: 'Глаголы $cls',
              zh: '$cls 动词变位',
            ).resolve(language),
          );
          await tapText(
            tester,
            LocalizedText(
              en: 'Filters',
              ru: 'Фильтры',
              zh: '筛选',
            ).resolve(language),
          );
          await tester.enterText(
            find.byKey(const ValueKey('topic-search')),
            cls == 'B1' ? 'μιλάω' : 'μπορούν',
          );
          await tester.pumpAndSettle();
          expect(
            tester
                .widget<VocabularyPreview>(find.byType(VocabularyPreview))
                .cards,
            hasLength(1),
          );
          await tapText(
            tester,
            LocalizedText(
              en: 'Apply filters',
              ru: 'Применить',
              zh: '应用筛选',
            ).resolve(language),
          );
          await tapText(
            tester,
            LocalizedText(
              en: 'Hard mode',
              ru: 'Сложный режим',
              zh: '默写模式',
            ).resolve(language),
          );
          expect(find.byType(CardExplanation), findsNothing);
          final answer = cls == 'B1' ? 'μιλάω' : 'μπορούν';
          expect(find.text(answer), findsNothing);
          final input = tester.widget<TextField>(
            find.byKey(const ValueKey('greek-answer')),
          );
          input.controller!.text = cls == 'B1' ? 'μιλώ' : 'μπορούνε';
          await tester.pumpAndSettle();
          await tapText(
            tester,
            LocalizedText(
              en: 'Check answer',
              ru: 'Проверить',
              zh: '检查答案',
            ).resolve(language),
          );
          expect(
            find.text(
              LocalizedText(
                en: 'Exactly right.',
                ru: 'Всё верно.',
                zh: '完全正确。',
              ).resolve(language),
            ),
            findsOneWidget,
          );
          expect(find.text(answer), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
      );
    }

    testWidgets(
      'names can be selected and studied separately (${language.name})',
      (tester) async {
        await openApp(tester, language: language);
        await tester.tap(find.byKey(const ValueKey('collection-words')));
        await tester.pumpAndSettle();
        await tapText(
          tester,
          LocalizedText(
            en: 'Names & places',
            ru: 'Имена и названия',
            zh: '人名与地名',
          ).resolve(language),
        );
        await tapText(
          tester,
          LocalizedText(
            en: 'Filters',
            ru: 'Фильтры',
            zh: '筛选',
          ).resolve(language),
        );
        await tester.enterText(
          find.byKey(const ValueKey('topic-search')),
          'Argentina',
        );
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<VocabularyPreview>(find.byType(VocabularyPreview))
              .cards
              .single
              .greek,
          'Αργεντινή',
        );
        await tester.tap(find.byKey(const ValueKey('use-category')));
        await tester.pumpAndSettle();
        await tapText(
          tester,
          LocalizedText(
            en: 'Hard mode',
            ru: 'Сложный режим',
            zh: '默写模式',
          ).resolve(language),
        );
        final input = tester.widget<TextField>(
          find.byKey(const ValueKey('greek-answer')),
        );
        input.controller!.text = 'Αργεντινή';
        await tester.pumpAndSettle();
        await tapText(
          tester,
          LocalizedText(
            en: 'Check answer',
            ru: 'Проверить',
            zh: '检查答案',
          ).resolve(language),
        );
        expect(find.text('η Αργεντινή'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'family filter finds alternate spelling and starts hard mode (${language.name})',
      (tester) async {
        await openApp(tester, language: language);
        await tapText(
          tester,
          LocalizedText(
            en: 'Filters',
            ru: 'Фильтры',
            zh: '筛选',
          ).resolve(language),
        );
        await tester.tap(find.byKey(const ValueKey('collection-theme')));
        await tester.pumpAndSettle();
        await tapText(
          tester,
          LocalizedText(en: 'Family', ru: 'Семья', zh: '家庭').resolve(language),
        );
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
        await tapText(
          tester,
          LocalizedText(
            en: 'Hard mode',
            ru: 'Сложный режим',
            zh: '默写模式',
          ).resolve(language),
        );
        expect(
          find.text(
            LocalizedText(
              en: 'Brother',
              ru: 'Брат',
              zh: '兄弟',
            ).resolve(language),
          ),
          findsOneWidget,
        );
        expect(find.text('ο αδερφός'), findsNothing);
        final input = tester.widget<TextField>(
          find.byKey(const ValueKey('greek-answer')),
        );
        input.controller!.text = 'αδελφός';
        await tester.pumpAndSettle();
        await tapText(
          tester,
          LocalizedText(
            en: 'Check answer',
            ru: 'Проверить',
            zh: '检查答案',
          ).resolve(language),
        );
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
    await tapText(tester, 'Conversation');
    final filtered = tester.widget<VocabularyPreview>(
      find.byType(VocabularyPreview),
    );
    expect(filtered.cards, isNotEmpty);
    expect(
      tester
          .widget<DropdownButtonFormField<LearningTheme?>>(theme)
          .initialValue,
      LearningTheme.conversation,
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
    for (var i = 0; i < 45 && find.text('Μπράβο!').evaluate().isEmpty; i++) {
      await tapText(tester, 'Reveal answer');
      await tapText(tester, 'Got it');
    }
    expect(find.text('15 of 15 on the first try'), findsOneWidget);
    await tapText(tester, 'Next batch');
    for (final prompt in firstBatch) {
      expect(find.text(prompt), findsNothing);
    }
    for (var i = 0; i < 45 && find.text('Μπράβο!').evaluate().isEmpty; i++) {
      // Filler reviews must also come from this round, not the previous batch.
      for (final prompt in firstBatch) {
        expect(find.text(prompt), findsNothing);
      }
      await tapText(tester, 'Reveal answer');
      await tapText(tester, 'Got it');
    }
    expect(find.text('15 of 15 on the first try'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
