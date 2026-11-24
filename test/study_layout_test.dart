import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/greek_keyboard.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';
import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  Widget app(Widget screen, AppLanguage language, double scale) => MaterialApp(
    theme: appTheme,
    locale: Locale(language.code),
    supportedLocales: const [Locale('en'), Locale('ru'), Locale('zh')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(scale)),
      child: child!,
    ),
    home: screen,
  );

  void actionVisible(WidgetTester tester, Finder action, double bottom) {
    final rect = tester.getRect(action);
    expect(rect.left, greaterThanOrEqualTo(0));
    expect(rect.right, lessThanOrEqualTo(tester.view.physicalSize.width));
    expect(rect.top, greaterThanOrEqualTo(0));
    expect(rect.bottom, lessThanOrEqualTo(bottom));
    expect(action.hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  }

  for (final language in AppLanguage.values) {
    final strings = AppStrings(language);
    for (final size in [
      const Size(320, 568),
      const Size(390, 700),
      const Size(568, 320),
    ]) {
      for (final scale in [1.0, 2.0]) {
        testWidgets('study layouts remain usable $language $size at $scale', (
          tester,
        ) async {
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = size;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetViewInsets);
          final deck = currentDictionary.learningDecks.singleWhere(
            (d) => d.id == 'words-prepositions',
          );
          final progress = LearningProgress(MemoryProgressStore());
          addTearDown(progress.dispose);
          for (final mode in StudyMode.values) {
            await tester.pumpWidget(
              app(
                StudyScreen(
                  key: ValueKey(mode),
                  deck: deck,
                  cards: [deck.cards.first],
                  mode: mode,
                  progress: progress,
                  sessionStore: MemoryStudySessionStore(),
                ),
                language,
                scale,
              ),
            );
            await tester.pumpAndSettle();
            final questionAction = mode == StudyMode.typing
                ? find.byKey(const ValueKey('check-typing'))
                : find.text(strings.revealAnswer);
            actionVisible(tester, questionAction, size.height);
            await tester.tap(find.byTooltip(strings.sessionProgressHelp));
            await tester.pumpAndSettle();
            expect(
              find.text(strings.sessionProgressExplanation),
              findsOneWidget,
            );
            expect(tester.takeException(), isNull);
            await tester.tap(
              find.byType(AlertDialog).evaluate().isNotEmpty
                  ? find
                        .descendant(
                          of: find.byType(AlertDialog),
                          matching: find.byType(TextButton),
                        )
                        .last
                  : find.text('Close'),
            );
            await tester.pumpAndSettle();
            if (mode == StudyMode.typing) {
              final toggle = find.byTooltip(strings.phoneKeyboard);
              await tester.ensureVisible(toggle);
              await tester.pumpAndSettle();
              await tester.tap(toggle);
              await tester.pumpAndSettle();
              final inset = size.height > 400 ? 250.0 : 100.0;
              tester.view.viewInsets = FakeViewPadding(bottom: inset);
              await tester.pumpAndSettle();
              actionVisible(tester, questionAction, size.height - inset);
              await tester.enterText(
                find.byKey(const ValueKey('greek-answer')),
                'λάθος',
              );
              await tester.pumpAndSettle();
              await tester.tap(questionAction);
              await tester.pumpAndSettle();
              tester.view.viewInsets = const FakeViewPadding();
              await tester.pumpAndSettle();
              actionVisible(
                tester,
                find.text(strings.continueLabel),
                size.height,
              );
            } else {
              await tester.tap(questionAction);
              await tester.pumpAndSettle();
              actionVisible(tester, find.text(strings.again), size.height);
              actionVisible(tester, find.text(strings.gotIt), size.height);
            }
            // Three misses expose deferral; finishing this one-card session
            // also exercises the scrollable completion layout.
            for (var attempt = 0; attempt < 3; attempt++) {
              if (attempt > 0) {
                await tester.tap(
                  mode == StudyMode.typing
                      ? find.text(strings.dontKnow)
                      : find.text(strings.revealAnswer),
                );
                await tester.pumpAndSettle();
              }
              await tester.tap(
                find.text(
                  mode == StudyMode.typing
                      ? strings.continueLabel
                      : strings.again,
                ),
              );
              await tester.pumpAndSettle();
              expect(tester.takeException(), isNull);
            }
            final defer = find.byKey(const ValueKey('defer-card'));
            await tester.ensureVisible(defer);
            await tester.pumpAndSettle();
            await tester.tap(defer);
            await tester.pumpAndSettle();
            expect(find.text(strings.sessionComplete), findsOneWidget);
            final done = find.text(strings.backToMyDeck);
            await tester.ensureVisible(done);
            await tester.pumpAndSettle();
            actionVisible(tester, done, size.height);
          }
        });
      }
    }
    testWidgets(
      'ordinary writing card fits 390x700 without scrolling $language',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(390, 700);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final deck = currentDictionary.learningDecks.singleWhere(
          (d) => d.id == 'words-nouns',
        );
        final card = deck.cards.firstWhere((c) => c.greek == 'πιάτο');
        final progress = LearningProgress(MemoryProgressStore());
        addTearDown(progress.dispose);
        await tester.pumpWidget(
          app(
            StudyScreen(
              deck: deck,
              cards: [card],
              mode: StudyMode.typing,
              progress: progress,
              sessionStore: MemoryStudySessionStore(),
            ),
            language,
            1,
          ),
        );
        await tester.pumpAndSettle();
        final keyboard = tester.getRect(find.byType(GreekKeyboard));
        final action = tester.getRect(
          find.byKey(const ValueKey('check-typing')),
        );
        expect(keyboard.bottom, lessThanOrEqualTo(action.top));
        expect(find.byType(GreekKeyboard).hitTestable(), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
