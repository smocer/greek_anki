import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/greek_alphabet.dart';
import 'package:greek_anki/data/greek_letter_pairs.dart';
import 'package:greek_anki/presentation/alphabet_screen.dart';
import 'package:greek_anki/presentation/theme.dart';
import 'package:greek_anki/presentation/letter_pairs_screen.dart';
import 'package:greek_anki/presentation/pronunciation_button.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('alphabet references replacement letter-name recordings', () {
    for (final letter in greekAlphabet) {
      expect(letter.audioAsset, startsWith('audio/greek/native-name-'));
      expect(letter.audioAsset, endsWith('.mp3'));
    }
  });

  test('every letter and pair example has a bundled audio clip', () async {
    final assets = [
      for (final letter in greekAlphabet) letter.audioAsset,
      for (final pair in greekLetterPairs)
        for (final example in pair.examples) example.audioAsset,
    ];
    expect(assets.toSet().length, 40);
    for (final asset in assets) {
      final bytes = await rootBundle.load('assets/$asset');
      expect(bytes.lengthInBytes, greaterThan(1000), reason: asset);
      if (asset.endsWith('.wav')) {
        expect(
          String.fromCharCodes(bytes.buffer.asUint8List(0, 4)),
          'RIFF',
          reason: asset,
        );
        expect(
          String.fromCharCodes(bytes.buffer.asUint8List(8, 4)),
          'WAVE',
          reason: asset,
        );
      } else {
        expect(bytes.getUint8(0), 0xff, reason: asset);
        expect(bytes.getUint8(1) & 0xe0, 0xe0, reason: asset);
      }
    }
  });

  testWidgets('top right opens letter pairs with playable examples', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(theme: appTheme, home: const AlphabetScreen()),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('24 letters · Tap a letter to learn how to write it.'),
      findsNothing,
    );
    await tester.tap(find.text('Letter pairs'));
    await tester.pumpAndSettle();
    expect(find.byType(LetterPairsScreen), findsOneWidget);
    expect(find.text('αι'), findsOneWidget);
    expect(find.byType(PronunciationButton), findsWidgets);
    await tester.scrollUntilVisible(find.text('αυ'), 250);
    expect(find.text('αυ'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('strokes move slowly and pause without advancing', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: LetterWritingScreen(letter: greekAlphabet.first),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    StrokePainter painter() => tester
        .widgetList<CustomPaint>(find.byType(CustomPaint))
        .map((widget) => widget.painter)
        .whereType<StrokePainter>()
        .single;
    expect(painter().progress, inExclusiveRange(0.0, .5));
    await tester.ensureVisible(find.text('Pause'));
    await tester.tap(find.text('Pause'));
    await tester.pump();
    final paused = painter().progress;
    await tester.pump(const Duration(seconds: 3));
    expect(painter().progress, paused);
    expect(painter().stroke, 0);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Stroke 2 / 2'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  test('all 24 letters and final sigma have drawable teaching strokes', () {
    expect(greekAlphabet.length, 24);
    expect(greekAlphabet.map((letter) => letter.lower).toSet().length, 24);
    for (final strokes in [
      for (final letter in greekAlphabet) ...[
        letter.upperStrokes,
        letter.lowerStrokes,
      ],
      finalSigmaStrokes,
    ]) {
      expect(strokes, isNotEmpty);
      for (final source in strokes) {
        final metrics = parseTeachingStroke(source).computeMetrics().toList();
        expect(metrics.length, 1, reason: source);
        expect(metrics.single.length, greaterThan(0), reason: source);
      }
    }
  });

  testWidgets(
    'home opens alphabet, animates and switches case on small screen',
    (tester) async {
      tester.view.physicalSize = const Size(360, 800);
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
      await tester.tap(find.text('Reference'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alphabets'));
      await tester.pumpAndSettle();
      expect(find.byType(AlphabetScreen), findsOneWidget);
      await tester.tap(find.text('άλφα'));
      await tester.pumpAndSettle();
      expect(find.text('Stroke 2 / 2'), findsOneWidget);
      await tester.tap(find.text('Uppercase'));
      await tester.pumpAndSettle();
      expect(find.text('Stroke 2 / 2'), findsOneWidget);
      await tester.tap(find.text('Replay'));
      await tester.pump();
      expect(find.text('Stroke 1 / 2'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(AlphabetScreen), findsOneWidget);
    },
  );

  testWidgets('sigma includes a working final form in Russian', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ru'),
        supportedLocales: const [Locale('en'), Locale('ru')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: appTheme,
        home: LetterWritingScreen(
          letter: greekAlphabet.firstWhere((letter) => letter.lower == 'σ'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Конечная ς'));
    await tester.pumpAndSettle();
    expect(find.text('Штрих 1 / 1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
