import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/alphabet_screen.dart';
import 'package:greek_anki/presentation/analog_clock.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/clock_drill_screen.dart';
import 'package:greek_anki/presentation/grammar_screen.dart';
import 'package:greek_anki/presentation/greek_keyboard.dart';
import 'package:greek_anki/presentation/labeled_field.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  void viewport(WidgetTester tester, Size size) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
  }

  Widget localized(Widget child, String locale, {double scale = 1}) =>
      MaterialApp(
        theme: appTheme,
        locale: Locale(locale),
        supportedLocales: const [Locale('en'), Locale('ru'), Locale('zh')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: child,
      );

  void visible(WidgetTester tester, Finder finder, {double inset = 0}) {
    final rect = tester.getRect(finder);
    final size = tester.view.physicalSize / tester.view.devicePixelRatio;
    expect(rect.left, greaterThanOrEqualTo(0));
    expect(rect.right, lessThanOrEqualTo(size.width));
    expect(rect.top, greaterThanOrEqualTo(kToolbarHeight));
    expect(rect.bottom, lessThanOrEqualTo(size.height - inset));
    expect(finder.hitTestable(), findsOneWidget);
  }

  for (final language in AppLanguage.values) {
    final locale = language.code;
    final strings = AppStrings(language);
    for (final size in [const Size(320, 640), const Size(390, 700)]) {
      testWidgets(
        'clock fits phone viewport $size in $locale without scrolling',
        (tester) async {
          viewport(tester, size);
          await tester.pumpWidget(localized(const ClockDrillScreen(), locale));
          await tester.pumpAndSettle();
          visible(tester, find.byType(AnalogClock));
          visible(tester, find.byKey(const ValueKey('clock-answer')));
          visible(tester, find.byType(GreekKeyboard));
          visible(tester, find.byKey(const ValueKey('check-clock')));
          expect(
            tester.getRect(find.byType(GreekKeyboard)).bottom,
            lessThan(
              tester.getRect(find.byKey(const ValueKey('check-clock'))).top,
            ),
          );
          await tester.tap(find.text('α'));
          await tester.pump();
          await tester.tap(find.byKey(const ValueKey('check-clock')));
          await tester.pumpAndSettle();
          visible(tester, find.byKey(const ValueKey('next-clock')));
          await tester.tap(find.byKey(const ValueKey('next-clock')));
          await tester.pumpAndSettle();
          visible(tester, find.byKey(const ValueKey('check-clock')));
          expect(tester.takeException(), isNull);
        },
      );
    }

    testWidgets(
      'clock action stays visible with large text, landscape and device keyboard ($locale)',
      (tester) async {
        viewport(tester, const Size(568, 320));
        await tester.pumpWidget(
          localized(const ClockDrillScreen(), locale, scale: 1.5),
        );
        await tester.pumpAndSettle();
        visible(tester, find.byKey(const ValueKey('check-clock')));
        final toggle = find.byTooltip(strings.phoneKeyboard);
        await tester.ensureVisible(toggle);
        await tester.pumpAndSettle();
        await tester.tap(toggle);
        await tester.pumpAndSettle();
        tester.view.physicalSize = const Size(390, 700);
        tester.view.viewInsets = const FakeViewPadding(bottom: 300);
        await tester.pumpAndSettle();
        visible(tester, find.byKey(const ValueKey('check-clock')), inset: 300);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'home labels wrap outside fields and controls use phone width ($locale)',
      (tester) async {
        viewport(tester, const Size(320, 640));
        tester.platformDispatcher.textScaleFactorTestValue = 1.3;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await tester.pumpWidget(
          GreekAnkiApp(
            sessionStore: MemoryStudySessionStore(),
            store: MemoryProgressStore(),
            languageStore: MemoryLanguageStore(language: language),
          ),
        );
        await tester.pumpAndSettle();
        for (final (key, label) in [
          ('collection-words', strings.practiceGroup),
          ('session-count', strings.sessionCount),
          ('session-order', strings.cardOrder),
        ]) {
          final control = find.byKey(ValueKey(key));
          await tester.scrollUntilVisible(
            control,
            120,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.ensureVisible(control);
          await tester.pumpAndSettle();
          final field = find
              .ancestor(of: control, matching: find.byType(LabeledField))
              .first;
          final caption = find.descendant(
            of: field,
            matching: find.text(label),
          );
          final paragraph = tester.renderObject<RenderParagraph>(caption);
          expect(paragraph.didExceedMaxLines, isFalse);
          expect(
            tester.getRect(caption).bottom,
            lessThan(tester.getRect(control).top),
          );
          expect(tester.getSize(field).width, greaterThanOrEqualTo(240));
        }
        await tester.enterText(
          find.byKey(const ValueKey('session-count')),
          '0',
        );
        await tester.pumpAndSettle();
        expect(find.text(strings.invalidSessionCount), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('hard mode and flashcard actions remain reachable ($locale)', (
      tester,
    ) async {
      viewport(tester, const Size(320, 568));
      final deck = greekDecks.firstWhere((d) => d.id == 'numbers-0-10');
      final progress = LearningProgress(MemoryProgressStore());
      addTearDown(progress.dispose);
      for (final mode in StudyMode.values) {
        await tester.pumpWidget(
          localized(
            StudyScreen(
              sessionStore: MemoryStudySessionStore(),
              key: ValueKey(mode),
              deck: deck,
              cards: deck.cards,
              mode: mode,
              progress: progress,
            ),
            locale,
          ),
        );
        await tester.pumpAndSettle();
        if (mode == StudyMode.typing) {
          visible(tester, find.byKey(const ValueKey('check-typing')));
          await tester.tap(find.text(strings.dontKnow));
          await tester.pumpAndSettle();
          visible(tester, find.text(strings.continueLabel));
        } else {
          visible(tester, find.text(strings.revealAnswer));
          await tester.tap(find.text(strings.revealAnswer));
          await tester.pumpAndSettle();
          visible(tester, find.text(strings.again));
          visible(tester, find.text(strings.gotIt));
        }
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets(
      'reference screens fit narrow screens with larger text ($locale)',
      (tester) async {
        viewport(tester, const Size(320, 640));
        for (final screen in [const AlphabetScreen(), const GrammarScreen()]) {
          await tester.pumpWidget(localized(screen, locale, scale: 1.3));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
      },
    );
  }
}
