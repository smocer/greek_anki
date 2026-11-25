import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/learning_curriculum.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/grammar_drill.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/grammar_drill_screen.dart';
import 'package:greek_anki/presentation/greek_keyboard.dart';
import 'package:greek_anki/presentation/theme.dart';
import 'grammar_drill_test.dart' show generator;
import 'number_drill_test.dart' show FixedRandom;
import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  final answer = find.byKey(const ValueKey('grammar-drill-answer'));
  final check = find.byKey(const ValueKey('check-grammar-drill'));
  final next = find.byKey(const ValueKey('next-grammar-drill'));

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  void layout(WidgetTester tester, Finder action, Size size, double inset) {
    expect(tester.takeException(), isNull);
    final rect = tester.getRect(action);
    expect(rect.left, greaterThanOrEqualTo(0));
    expect(rect.right, lessThanOrEqualTo(size.width));
    expect(rect.bottom, lessThanOrEqualTo(size.height - inset));
    expect(action.hitTestable(), findsOneWidget);
    for (final richText in find.byType(RichText).evaluate()) {
      final paragraph = richText.renderObject! as RenderParagraph;
      expect(
        paragraph.didExceedMaxLines,
        isFalse,
        reason: paragraph.text.toPlainText(),
      );
    }
  }

  for (final language in AppLanguage.values) {
    for (final kind in GrammarDrillKind.values) {
      for (final size in [
        const Size(320, 568),
        const Size(390, 700),
        const Size(568, 320),
      ]) {
        for (final scale in [1.0, 2.0]) {
          testWidgets(
            '$kind ${language.code} $size ${scale}x question/feedback/keyboard',
            (tester) async {
              tester.view.physicalSize = size;
              tester.view.devicePixelRatio = 1;
              addTearDown(tester.view.resetPhysicalSize);
              addTearDown(tester.view.resetDevicePixelRatio);
              addTearDown(tester.view.resetViewInsets);
              final pool = generator(kind).questions;
              // Exercise the longest real prompt and a second distinct pattern.
              final first = pool.reduce(
                (a, b) => a.prompt.length > b.prompt.length ? a : b,
              );
              final second = pool.firstWhere((q) => q.pattern != first.pattern);
              await tester.pumpWidget(
                MaterialApp(
                  theme: appTheme,
                  locale: Locale(language.code),
                  supportedLocales: const [
                    Locale('en'),
                    Locale('ru'),
                    Locale('zh'),
                  ],
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                  builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.linear(scale)),
                    child: child!,
                  ),
                  home: GrammarDrillScreen(
                    kind: kind,
                    collections: learningCollections,
                    generator: GrammarDrillGenerator([
                      first,
                      second,
                    ], random: FixedRandom(0)),
                  ),
                ),
              );
              await tester.pumpAndSettle();
              layout(tester, check, size, 0);
              await tap(tester, find.byTooltip(AppStrings(language).drillHelp));
              expect(tester.takeException(), isNull);
              for (final richText in find.byType(RichText).evaluate()) {
                expect(
                  (richText.renderObject! as RenderParagraph).didExceedMaxLines,
                  isFalse,
                );
              }
              await tap(tester, find.text(AppStrings(language).close));
              expect(tester.widget<FilledButton>(check).onPressed, isNull);
              tester.widget<TextField>(answer).controller!.text =
                  'λάθος απάντηση';
              await tester.pump();
              await tap(tester, check);
              layout(tester, next, size, 0);
              expect(find.byType(GreekKeyboard), findsNothing);
              expect(find.byIcon(Icons.close_rounded), findsOneWidget);
              await tap(tester, next);
              expect(
                tester.widget<TextField>(answer).controller!.text,
                isEmpty,
              );
              await tap(
                tester,
                find.byTooltip(AppStrings(language).phoneKeyboard),
              );
              final inset = size.height < 400 ? 120.0 : 260.0;
              tester.view.viewInsets = FakeViewPadding(bottom: inset);
              await tester.pumpAndSettle();
              layout(tester, check, size, inset);
              await tester.ensureVisible(answer);
              await tester.enterText(answer, second.answers.first);
              await tester.testTextInput.receiveAction(TextInputAction.done);
              await tester.pumpAndSettle();
              layout(tester, next, size, inset);
              expect(find.byIcon(Icons.check_rounded), findsOneWidget);
              await tap(tester, next);
              layout(tester, check, size, inset);
            },
          );
        }
      }
    }
  }

  testWidgets(
    'standalone buttons follow date drill, work independently, exit without progress',
    (tester) async {
      tester.view.physicalSize = const Size(390, 700);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final progress = MemoryProgressStore();
      final sessions = MemoryStudySessionStore();
      await tester.pumpWidget(
        GreekAnkiApp(
          store: progress,
          sessionStore: sessions,
          languageStore: MemoryLanguageStore(),
        ),
      );
      await tester.pumpAndSettle();
      final date = find.byKey(const ValueKey('date-drill'));
      for (final kind in GrammarDrillKind.values) {
        final button = find.byKey(ValueKey('${kind.name}-drill'));
        await tester.scrollUntilVisible(
          button,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        expect(
          tester.getTopLeft(button).dy,
          greaterThan(tester.getTopLeft(date).dy),
        );
        await tap(tester, button);
        expect(find.byType(GrammarDrillScreen), findsOneWidget);
        tester.widget<TextField>(answer).controller!.text = 'λάθος απάντηση';
        await tester.pump();
        await tap(tester, check);
        await tap(tester, find.byType(BackButton));
        expect(find.byType(GrammarDrillScreen), findsNothing);
        expect(progress.records, isEmpty);
        expect(sessions.records, isEmpty);
      }
    },
  );
}
