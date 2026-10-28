import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/data/dictionary_audio.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/presentation/pronunciation_button.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  VocabularyCard word(String id) => currentDictionary.learningDecks
      .expand((deck) => deck.cards)
      .firstWhere((card) => card.id == id);

  Future<void> open(
    WidgetTester tester,
    VocabularyCard card, {
    StudyMode mode = StudyMode.flashcards,
  }) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final deck = VocabularyDeck(
      id: 'combined-nouns',
      title: currentDictionary.learningDecks.first.title,
      subtitle: currentDictionary.learningDecks.first.subtitle,
      cover: '',
      cards: [card],
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: StudyScreen(
          sessionStore: MemoryStudySessionStore(),
          deck: deck,
          cards: [card],
          mode: mode,
          progress: LearningProgress(MemoryProgressStore()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  test(
    'moved proper nouns use their audio collection, not review identity',
    () {
      final card = word('languages-nationality-german');
      expect(card.reviewIdentity!.deckId, 'words-nouns');
      final clips = dictionaryAudioFor(card);
      expect(
        clips.map((clip) => clip.text),
        containsAll(['Γερμανός', 'Γερμανίδα']),
      );
      expect(
        clips.every(
          (clip) => clip.asset.startsWith('audio/greek/words-names/'),
        ),
        isTrue,
      );
    },
  );

  testWidgets(
    'word audio appears only after flipping and passes MP3 bytes to playback',
    (tester) async {
      final calls = <MethodCall>[];
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers.global'),
        (_) async => null,
      );
      messenger.setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers.global/events'),
        (_) async => null,
      );
      messenger.setMockMethodCallHandler(
        const MethodChannel('xyz.luan/audioplayers'),
        (call) async {
          calls.add(call);
          final id = call.arguments['playerId'] as String;
          if (call.method == 'create') {
            messenger.setMockMethodCallHandler(
              MethodChannel('xyz.luan/audioplayers/events/$id'),
              (_) async => null,
            );
          }
          if (call.method == 'setSourceBytes') {
            await messenger.handlePlatformMessage(
              'xyz.luan/audioplayers/events/$id',
              const StandardMethodCodec().encodeSuccessEnvelope({
                'event': 'audio.onPrepared',
                'value': true,
              }),
              (_) {},
            );
          }
          return null;
        },
      );
      final card = word('countries.germany');
      await open(tester, card);
      expect(find.byType(PronunciationButton), findsNothing);
      await tester.tap(find.text('Reveal answer'));
      await tester.pumpAndSettle();
      final button = find.byType(PronunciationButton);
      expect(button, findsOneWidget);
      expect(
        tester.widget<PronunciationButton>(button).asset,
        'audio/greek/words-names/countries.germany.mp3',
      );
      await tester.ensureVisible(button);
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        await tester.tap(find.text('Play audio'));
        for (var i = 0; i < 100 && pronunciationPlayback.loading; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 10));
        }
      });
      await tester.pump();
      final bytesCall = calls.singleWhere(
        (call) => call.method == 'setSourceBytes',
      );
      expect((bytesCall.arguments['bytes'] as List).length, greaterThan(1000));
      expect(bytesCall.arguments['mimeType'], 'audio/mpeg');
      expect(calls.any((call) => call.method == 'resume'), isTrue);
      await tester.runAsync(() async {
        await tester.pumpWidget(const SizedBox());
        await Future<void>.delayed(const Duration(milliseconds: 50));
      });
      await tester.pumpAndSettle();
      expect(pronunciationPlayback.currentAsset, isNull);
    },
  );

  testWidgets('each gender form has its own playback button', (tester) async {
    await open(tester, word('languages-nationality-german'));
    await tester.tap(find.text('Reveal answer'));
    await tester.pumpAndSettle();
    final buttons = tester.widgetList<PronunciationButton>(
      find.byType(PronunciationButton),
    );
    expect(
      buttons.map((button) => button.label),
      containsAll(['Γερμανός', 'Γερμανίδα']),
    );
    expect(
      buttons.map((button) => button.asset).toSet().length,
      buttons.length,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('typing feedback also offers word audio after checking', (
    tester,
  ) async {
    final card = word('countries.germany');
    await open(tester, card, mode: StudyMode.typing);
    expect(find.byType(PronunciationButton), findsNothing);
    await tester.tap(find.byTooltip('Use phone keyboard'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('greek-answer')),
      card.greek,
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Check answer'));
    await tester.tap(find.text('Check answer'));
    await tester.pumpAndSettle();
    expect(find.byType(PronunciationButton), findsOneWidget);
  });
}
