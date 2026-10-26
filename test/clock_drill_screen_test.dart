import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/domain/clock_drill.dart';
import 'package:greek_anki/presentation/analog_clock.dart';
import 'package:greek_anki/presentation/clock_drill_screen.dart';
import 'package:greek_anki/presentation/greek_keyboard.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

void main() {
  const fieldKey = ValueKey('clock-answer');
  const checkKey = ValueKey('check-clock');
  const nextKey = ValueKey('next-clock');
  const feedbackKey = ValueKey('clock-feedback');

  void size(WidgetTester tester, Size value) {
    tester.view.physicalSize = value;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('home opens an endless drill without changing saved progress', (
    tester,
  ) async {
    size(tester, const Size(430, 960));
    final store = MemoryProgressStore();
    await tester.pumpWidget(
      GreekAnkiApp(store: store, languageStore: MemoryLanguageStore()),
    );
    await tester.pumpAndSettle();
    final saved = Map.of(store.records);
    final launch = find.byKey(const ValueKey('clock-drill'));
    await tester.scrollUntilVisible(
      launch,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tapVisible(tester, launch);

    var time = tester.widget<AnalogClock>(find.byType(AnalogClock)).time;
    expect(find.text(time.digital), findsNothing);
    expect(find.byKey(feedbackKey), findsNothing);
    expect(tester.widget<FilledButton>(find.byKey(checkKey)).onPressed, isNull);
    expect(find.byType(GreekKeyboard), findsOneWidget);
    await tapVisible(tester, find.text('μ'));
    expect(
      tester.widget<TextField>(find.byKey(fieldKey)).controller!.text,
      'μ',
    );

    await tapVisible(tester, find.byTooltip('Use phone keyboard'));
    expect(tester.widget<TextField>(find.byKey(fieldKey)).readOnly, isFalse);
    expect(
      tester.widget<TextField>(find.byKey(fieldKey)).focusNode!.hasFocus,
      isTrue,
    );
    await tester.enterText(
      find.byKey(fieldKey),
      const GreekClockAnswer().display(time),
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('Exactly right.'), findsOneWidget);
    expect(find.text(time.digital), findsOneWidget);
    expect(tester.widget<TextField>(find.byKey(fieldKey)).readOnly, isTrue);
    expect(
      tester.widget<AnalogClock>(find.byType(AnalogClock)).time.slot,
      time.slot,
    );

    for (var round = 0; round < 8; round++) {
      final previous = time.slot;
      await tapVisible(tester, find.byKey(nextKey));
      time = tester.widget<AnalogClock>(find.byType(AnalogClock)).time;
      expect(time.slot, isNot(previous));
      expect(time.minute % 5, 0);
      expect(find.byKey(feedbackKey), findsNothing);
      expect(tester.widget<TextField>(find.byKey(fieldKey)).readOnly, isFalse);
      expect(
        tester.widget<TextField>(find.byKey(fieldKey)).focusNode!.hasFocus,
        isTrue,
      );
      expect(
        tester.widget<TextField>(find.byKey(fieldKey)).controller!.text,
        isEmpty,
      );
      await tester.enterText(find.byKey(fieldKey), 'λάθος');
      await tapVisible(tester, find.byKey(checkKey));
      expect(find.text('Incorrect answer'), findsOneWidget);
      expect(find.text(const GreekClockAnswer().display(time)), findsOneWidget);
    }
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(ClockDrillScreen), findsNothing);
    expect(store.records, saved);
  });

  for (final (locale, screenSize) in [
    ('en', const Size(320, 640)),
    ('ru', const Size(568, 320)),
    ('zh', const Size(390, 844)),
  ]) {
    testWidgets('clock input and feedback fit $locale at $screenSize', (
      tester,
    ) async {
      size(tester, screenSize);
      await tester.pumpWidget(
        MaterialApp(
          theme: appTheme,
          locale: Locale(locale),
          supportedLocales: const [Locale('en'), Locale('ru'), Locale('zh')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: ClockDrillScreen(
            generator: ClockTimeGenerator(random: Random(20)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tapVisible(tester, find.text('α'));
      await tapVisible(tester, find.byKey(checkKey));
      expect(find.byKey(feedbackKey), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tapVisible(tester, find.byKey(nextKey));
      expect(find.byKey(feedbackKey), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
