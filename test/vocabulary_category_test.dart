import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/presentation/theme.dart';
import 'package:greek_anki/presentation/home_screen.dart';
import 'package:greek_anki/presentation/topic_picker.dart';
import 'package:greek_anki/presentation/vocabulary_preview.dart';
import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

VocabularyCard sample(String id, String? week) => VocabularyCard(
  id: id,
  greek: id,
  prompt: const LocalizedText(en: 'Sample', ru: 'Пример'),
  meaning: const LocalizedText(en: 'Word', ru: 'Слово'),
  pronunciation: const LocalizedText(en: 'sample', ru: 'пример'),
  addedWeek: week,
  labels: const [VocabularyLabel.noun],
);

void main() {
  testWidgets('week selection filters preview and applied practice cards', (
    tester,
  ) async {
    final now = DateTime.now();
    final current = weekStamp(now);
    final previous = weekStamp(now.subtract(const Duration(days: 7)));
    final older = weekStamp(now.subtract(const Duration(days: 14)));
    final deck = VocabularyDeck(
      id: 'period-test',
      title: const LocalizedText(en: 'Test', ru: 'Test'),
      subtitle: const LocalizedText(en: 'Test', ru: 'Test'),
      cover: 'Test',
      cards: [
        sample('current', current),
        sample('previous', previous),
        sample('older', older),
      ],
    );
    VocabularyDeck? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                selected = await showModalBottomSheet<VocabularyDeck>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) =>
                      TopicPicker(decks: [deck], selectedId: deck.id),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    Future<void> select(String title) async {
      await tester.ensureVisible(find.byKey(const ValueKey('category-period')));
      await tester.tap(find.byKey(const ValueKey('category-period')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(title).last);
      await tester.pumpAndSettle();
    }

    await select('This week');
    expect(
      tester
          .widget<VocabularyPreview>(find.byType(VocabularyPreview))
          .cards
          .map((card) => card.id),
      ['current'],
    );
    await select('Earlier');
    expect(
      tester
          .widget<VocabularyPreview>(find.byType(VocabularyPreview))
          .cards
          .map((card) => card.id),
      ['older'],
    );
    await select('All words');
    expect(
      tester
          .widget<VocabularyPreview>(find.byType(VocabularyPreview))
          .cards
          .length,
      3,
    );
    await select('Last week');
    await tester.tap(find.byKey(const ValueKey('use-category')));
    await tester.pumpAndSettle();
    expect(selected!.cards.single.id, 'previous');
    expect(selected!.period, VocabularyPeriod.lastWeek);
    expect(tester.takeException(), isNull);
  });
  test('period filters use calendar weeks including month boundaries', () {
    final now = DateTime(2026, 10, 1);
    expect(VocabularyPeriod.thisWeek.includes('2026-09-28', now), isTrue);
    expect(VocabularyPeriod.thisWeek.includes('2026-09-21', now), isFalse);
    expect(VocabularyPeriod.lastWeek.includes('2026-09-21', now), isTrue);
    expect(VocabularyPeriod.lastWeek.includes('2026-09-14', now), isFalse);
    expect(VocabularyPeriod.earlier.includes('2026-09-14', now), isTrue);
    expect(VocabularyPeriod.earlier.includes('2026-09-21', now), isFalse);
    expect(VocabularyPeriod.earlier.includes(null, now), isTrue);
    expect(VocabularyPeriod.all.includes(null, now), isTrue);
    expect(
      VocabularyPeriod.lastWeek.includes('2026-12-28', DateTime(2027, 1, 4)),
      isTrue,
    );
  });
  test(
    'sentence words have exact offsets, contextual labels and original sources',
    () {
      final catalog = VocabularyCatalog(greekDecks);
      for (final card in catalog.cards) {
        expect(card.words, isNotEmpty, reason: card.greek);
        for (final word in card.words) {
          expect(card.greek.substring(word.start, word.end), word.surface);
          expect(word.addedWeek, isNotNull);
        }
      }
      final exercise = catalog.cards.firstWhere(
        (card) => card.greek == 'Κάνω την άσκηση.',
      );
      expect(exercise.words.map((word) => word.labels), [
        [VocabularyLabel.verb],
        [VocabularyLabel.article],
        [VocabularyLabel.noun],
      ]);
      final nouns = catalog.words(VocabularyLabel.noun);
      expect(nouns.any((entry) => entry.word.surface == 'άσκηση'), isTrue);
      expect(
        nouns.any((entry) => entry.word.surface == exercise.greek),
        isFalse,
      );
      expect(
        catalog
            .category(VocabularyLabel.noun)
            .cards
            .any((card) => card.greek == exercise.greek),
        isTrue,
      );
      final goodbye = catalog.cards.firstWhere(
        (card) => card.greek == 'Τα λέμε!',
      );
      expect(goodbye.words.map((word) => word.labels), [
        [VocabularyLabel.pronoun],
        [VocabularyLabel.verb],
      ]);
      final me = catalog.cards
          .expand((card) => card.words)
          .where((word) => word.surface.toLowerCase() == 'με');
      expect(
        me.any((word) => word.labels.contains(VocabularyLabel.pronoun)),
        isTrue,
      );
      expect(
        me.any((word) => word.labels.contains(VocabularyLabel.preposition)),
        isTrue,
      );
      expect(nouns.map((entry) => entry.id).toSet().length, nouns.length);
      expect(
        sourceCardsFor(nouns).every((card) => card.reviewIdentity != null),
        isTrue,
      );
    },
  );
  test(
    'weekly timestamps cross months and years and keep Sunday with Monday',
    () {
      expect(weekStamp(DateTime(2026, 9, 28)), '2026-09-28');
      expect(weekStamp(DateTime(2026, 10, 4, 23, 59)), '2026-09-28');
      expect(weekStamp(DateTime(2026, 10, 5)), '2026-10-05');
      expect(weekStamp(DateTime(2027, 1, 1)), '2026-12-28');
    },
  );

  test(
    'newest first keeps within-week order; colours stay global when filtered',
    () {
      final cards = [
        sample('old', '2026-09-14'),
        sample('new-a', '2026-09-28'),
        sample('unknown', null),
        sample('previous', '2026-09-21'),
        sample('new-b', '2026-09-28'),
      ];
      expect(newestFirst(cards).map((card) => card.id), [
        'new-a',
        'new-b',
        'previous',
        'old',
        'unknown',
      ]);
      final weeks = additionWeeks(cards);
      expect(additionColor('2026-09-28', weeks), const Color(0xFF237A42));
      expect(additionColor('2026-09-21', weeks), const Color(0xFF8A6500));
      expect(additionColor('2026-09-14', weeks), Colors.black87);
      expect(additionColor(null, weeks), Colors.black87);
    },
  );

  test(
    'all existing cards have fixed Monday stamps and classifications are contextual',
    () {
      for (final deck in greekDecks) {
        for (final card in deck.cards) {
          expect(
            card.addedWeek,
            isNotNull,
            reason: '${deck.id}.${card.id}: run metadata sync',
          );
          expect(weekStamp(DateTime.parse(card.addedWeek!)), card.addedWeek);
        }
      }
      final catalog = VocabularyCatalog(greekDecks);
      expect(catalog.cards.length, 497);
      expect(
        catalog
            .category(VocabularyLabel.noun)
            .cards
            .any((card) => card.greek == 'το βιβλίο'),
        isTrue,
      );
      expect(
        catalog
            .category(VocabularyLabel.noun)
            .cards
            .any((card) => card.greek == 'Τα λέμε!'),
        isFalse,
      );
      expect(
        catalog
            .category(VocabularyLabel.verb)
            .cards
            .any((card) => card.greek == 'γράφω'),
        isTrue,
      );
      expect(
        catalog
            .category(VocabularyLabel.conjunction)
            .cards
            .any((card) => card.greek == 'ή'),
        isTrue,
      );
      expect(
        catalog
            .category(VocabularyLabel.article)
            .cards
            .any((card) => card.greek == 'η'),
        isTrue,
      );
    },
  );

  test(
    'category reviews reuse the original progress rather than a new category key',
    () async {
      final store = MemoryProgressStore();
      store.records['write-present.typing.i'] = ReviewSchedule(
        level: 2,
        dueAt: DateTime.utc(2099),
      );
      final progress = LearningProgress(store);
      await progress.load(greekDecks);
      final verbs = VocabularyCatalog(
        greekDecks,
      ).category(VocabularyLabel.verb);
      expect(progress.learned(verbs, StudyMode.typing), 1);
      final card = verbs.cards.singleWhere((card) => card.greek == 'γράφω');
      await progress.record(
        deck: verbs,
        mode: StudyMode.typing,
        card: card,
        correct: false,
      );
      expect(store.records['write-present.typing.i']!.level, 0);
      expect(
        store.records.keys.any((key) => key.startsWith('category-')),
        isFalse,
      );
    },
  );

  testWidgets(
    'choose label previews noun results and applies the searched cards to practice',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
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
      await tester.ensureVisible(find.byKey(const ValueKey('choose-category')));
      await tester.tap(find.byKey(const ValueKey('choose-category')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('category-label')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Noun').last);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('category-topic')), findsNothing);
      await tester.enterText(
        find.byKey(const ValueKey('topic-search')),
        'βιβλιο',
      );
      await tester.pumpAndSettle();
      final preview = tester.widget<VocabularyPreview>(
        find.byType(VocabularyPreview),
      );
      expect(preview.cards, isNotEmpty);
      expect(preview.words, isNotEmpty);
      expect(
        preview.words!.every(
          (entry) => entry.word.labels.contains(VocabularyLabel.noun),
        ),
        isTrue,
      );
      expect(
        preview.cards.every(
          (card) => card.labels.contains(VocabularyLabel.noun),
        ),
        isTrue,
      );
      await tester.tap(find.byKey(const ValueKey('use-category')));
      await tester.pumpAndSettle();
      expect(find.byType(TopicPicker), findsNothing);
      final home = tester.state(find.byType(HomeScreen));
      expect(home.mounted, isTrue);
      expect(find.text('Noun'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'category controls remain scrollable on a narrow phone with keyboard',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      tester.view.viewInsets = const FakeViewPadding(bottom: 220);
      addTearDown(tester.view.resetViewInsets);
      await tester.pumpWidget(
        MaterialApp(
          theme: appTheme,
          home: Scaffold(
            body: Builder(
              builder: (context) => FilledButton(
                onPressed: () => showModalBottomSheet<VocabularyDeck>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (_) => TopicPicker(
                    decks: greekDecks,
                    selectedId: greekDecks.first.id,
                  ),
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('category-label')), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
