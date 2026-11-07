import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/learning_curriculum.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/date_drill.dart';
import 'package:greek_anki/domain/number_drill.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/day_period_picture.dart';
import 'package:greek_anki/presentation/greek_keyboard.dart';
import 'package:greek_anki/presentation/random_drill_screen.dart';
import 'package:greek_anki/presentation/theme.dart';
import 'number_drill_test.dart' show FixedRandom;
import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  void phone(WidgetTester tester) {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  void type(WidgetTester tester, int index, String value) {
    tester
            .widget<TextField>(find.byKey(ValueKey('drill-answer-$index')))
            .controller!
            .text =
        value;
  }

  for (final locale in AppLanguage.values) {
    final strings = AppStrings(locale);
    for (final kind in RandomDrillKind.values) {
      testWidgets(
        'random $kind inputs, feedback, restart and phone layout (${locale.code})',
        (tester) async {
          phone(tester);
          final target = DateTime.utc(2026, 11, 7, 23, 50);
          final minute = target.difference(DateTime.utc(2026)).inMinutes;
          await tester.pumpWidget(
            MaterialApp(
              theme: appTheme,
              locale: Locale(locale.code),
              supportedLocales: const [
                Locale('en'),
                Locale('ru'),
                Locale('zh'),
              ],
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              home: RandomDrillScreen(
                kind: kind,
                numbers: NumberGenerator(random: FixedRandom(3456)),
                dates: DateDrillGenerator(
                  random: FixedRandom(minute ~/ 5),
                  now: () => DateTime(2026),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          final check = find.byKey(const ValueKey('check-random-drill'));
          expect(tester.getRect(check).bottom, lessThanOrEqualTo(700));
          expect(tester.widget<FilledButton>(check).onPressed, isNull);
          if (kind == RandomDrillKind.date) {
            final text = tester
                .widget<Text>(find.byKey(const ValueKey('date-prompt')))
                .data!;
            expect(text, contains('11:50'));
            expect(text, isNot(contains('23:50')));
            expect(text, isNot(contains('2026')));
            expect(
              text,
              contains(switch (locale) {
                AppLanguage.english => 'Nov',
                AppLanguage.russian => 'нояб',
                AppLanguage.chinese => '11月',
              }),
            );
            expect(find.byType(DayPeriodPicture), findsOneWidget);
            await tap(tester, find.byKey(const ValueKey('drill-answer-1')));
            await tap(tester, find.text('α').last);
            expect(
              tester
                  .widget<TextField>(
                    find.byKey(const ValueKey('drill-answer-1')),
                  )
                  .controller!
                  .text,
              'α',
            );
            expect(
              tester
                  .widget<TextField>(
                    find.byKey(const ValueKey('drill-answer-0')),
                  )
                  .controller!
                  .text,
              isEmpty,
            );
            type(tester, 0, 'το Σάββατο επτά Νοεμβρίου');
            type(
              tester,
              1,
              'έντεκα και πενήντα το πρωί',
            ); // correct clock, wrong period
          } else {
            expect(find.text('3456'), findsOneWidget);
            type(tester, 0, 'λάθος');
          }
          await tester.pumpAndSettle();
          await tap(tester, check);
          expect(find.byType(GreekKeyboard), findsNothing);
          expect(
            find.byKey(const ValueKey('drill-feedback-0')),
            findsOneWidget,
          );
          if (kind == RandomDrillKind.date) {
            expect(
              tester
                  .widget<Icon>(find.byIcon(Icons.check_rounded))
                  .semanticLabel,
              strings.exactlyRight,
            );
            expect(find.byIcon(Icons.close_rounded), findsOneWidget);
            expect(find.text('έντεκα και πενήντα το βράδυ'), findsOneWidget);
          } else {
            expect(find.byIcon(Icons.close_rounded), findsOneWidget);
            expect(
              find.text('τρεις χιλιάδες τετρακόσια πενήντα έξι'),
              findsOneWidget,
            );
          }
          await tap(tester, find.byKey(const ValueKey('next-random-drill')));
          expect(find.byKey(const ValueKey('drill-feedback-0')), findsNothing);
          expect(
            tester
                .widget<TextField>(find.byKey(const ValueKey('drill-answer-0')))
                .controller!
                .text,
            isEmpty,
          );
          await tap(tester, find.byTooltip(strings.phoneKeyboard));
          await tester.enterText(
            find.byKey(const ValueKey('drill-answer-0')),
            kind == RandomDrillKind.date
                ? 'Σάββατο επτά Νοεμβρίου'
                : 'τρεις χιλιάδες τετρακόσια πενήντα έξι',
          );
          if (kind == RandomDrillKind.date) {
            await tester.enterText(
              find.byKey(const ValueKey('drill-answer-1')),
              'στις έντεκα και πενήντα το βράδυ',
            );
          }
          await tester.pumpAndSettle();
          await tap(tester, check);
          expect(find.byIcon(Icons.close_rounded), findsNothing);
          expect(
            find.byIcon(Icons.check_rounded),
            findsNWidgets(kind == RandomDrillKind.date ? 2 : 1),
          );
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
  testWidgets(
    'numbers are removed from word categories and both drills exit without saving',
    (tester) async {
      phone(tester);
      expect(
        learningCollections.any((c) => c.deck.id == 'words-numbers'),
        isFalse,
      );
      expect(learningDecks.any((c) => c.id == 'words-numbers'), isFalse);
      final progress = MemoryProgressStore(),
          sessions = MemoryStudySessionStore();
      await tester.pumpWidget(
        GreekAnkiApp(
          store: progress,
          sessionStore: sessions,
          languageStore: MemoryLanguageStore(),
        ),
      );
      await tester.pumpAndSettle();
      for (final kind in RandomDrillKind.values) {
        final button = find.byKey(ValueKey('${kind.name}-drill'));
        await tester.scrollUntilVisible(
          button,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tap(tester, button);
        expect(find.byType(RandomDrillScreen), findsOneWidget);
        type(tester, 0, 'λάθος');
        if (kind == RandomDrillKind.date) type(tester, 1, 'λάθος');
        await tester.pump();
        await tap(tester, find.byKey(const ValueKey('check-random-drill')));
        await tap(tester, find.byType(BackButton));
        expect(find.byType(RandomDrillScreen), findsNothing);
        expect(progress.records, isEmpty);
        expect(sessions.records, isEmpty);
      }
    },
  );
}
