import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/data/study_session_store.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/study_session_store.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  final verbs = currentDictionary.learningDecks.singleWhere(
    (deck) => deck.id == 'words-verbs',
  );
  final smallDeck = VocabularyDeck(
    id: verbs.id,
    title: verbs.title,
    subtitle: verbs.subtitle,
    cover: verbs.cover,
    cards: verbs.cards.take(6).toList(),
  );

  void phone(WidgetTester tester) {
    tester.view.physicalSize = const Size(430, 960);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> tap(WidgetTester tester, Finder target) async {
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  Future<void> openHarness(
    WidgetTester tester,
    StudyMode mode,
    MemoryStudySessionStore sessions,
    MemoryProgressStore reviews,
  ) async {
    final progress = LearningProgress(reviews);
    addTearDown(progress.dispose);
    await progress.load([smallDeck]);
    var opens = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => StudyScreen(
                      deck: smallDeck,
                      cards: opens++ == 0
                          ? smallDeck.cards
                          : smallDeck.cards.reversed.toList(),
                      mode: mode,
                      progress: progress,
                      sessionStore: sessions,
                      sessionLimit: null,
                    ),
                  ),
                ),
                child: const Text('Open study'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tap(tester, find.text('Open study'));
  }

  StudySessionSnapshot saved(MemoryStudySessionStore sessions) =>
      decodeStudySession(sessions.records.values.single);

  Future<void> submit(
    WidgetTester tester,
    StudyMode mode,
    VocabularyDeck deck,
    MemoryStudySessionStore sessions,
  ) async {
    if (mode == StudyMode.flashcards) {
      await tap(tester, find.text('Reveal answer'));
    } else {
      final key = saved(sessions).window.first;
      final card = deck.cards.singleWhere(
        (card) => (card.reviewIdentity?.key(mode) ?? card.id) == key,
      );
      tester
              .widget<TextField>(find.byKey(const ValueKey('greek-answer')))
              .controller!
              .text =
          card.greek;
      await tester.pump();
      await tap(tester, find.text('Check answer'));
    }
  }

  for (final mode in StudyMode.values) {
    testWidgets('exit, reload, finish and restart the saved batch ($mode)', (
      tester,
    ) async {
      phone(tester);
      final sessions = MemoryStudySessionStore();
      final reviews = MemoryProgressStore();
      await openHarness(tester, mode, sessions, reviews);
      final next = mode == StudyMode.typing ? 'Continue' : 'Got it';
      for (var i = 0; i < 3; i++) {
        await submit(tester, mode, smallDeck, sessions);
        await tap(tester, find.text(next));
      }
      expect(find.text('3 / 6 remembered'), findsOneWidget);
      await submit(tester, mode, smallDeck, sessions);
      final checkpoint = sessions.records.values.single;
      // System Back and the in-app close button must both preserve the batch.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Open study'), findsOneWidget);
      await tap(tester, find.text('Open study'));
      expect(sessions.records.values.single, checkpoint);
      expect(find.text('3 / 6 remembered'), findsOneWidget);
      expect(find.text(next), findsOneWidget);
      if (mode == StudyMode.typing) {
        expect(find.text('Exactly right.'), findsOneWidget);
        expect(
          tester
              .widget<TextField>(find.byKey(const ValueKey('greek-answer')))
              .controller!
              .text,
          saved(sessions).submittedAnswer,
        );
      }
      await tap(tester, find.byIcon(Icons.close_rounded));

      // Recreate both storage adapters and the app, as a page reload would.
      await tester.pumpWidget(const SizedBox.shrink());
      final reloadedSessions = MemoryStudySessionStore()
        ..records.addAll(sessions.records);
      final reloadedReviews = MemoryProgressStore()
        ..records.addAll(reviews.records);
      await openHarness(tester, mode, reloadedSessions, reloadedReviews);
      expect(find.text('3 / 6 remembered'), findsOneWidget);
      await tap(tester, find.text(next));
      for (
        var turn = 0;
        find.text('Μπράβο!').evaluate().isEmpty && turn < 20;
        turn++
      ) {
        await submit(tester, mode, smallDeck, reloadedSessions);
        await tap(tester, find.text(next));
      }
      expect(find.text('Μπράβο!'), findsOneWidget);
      expect(find.text('6 of 6 on the first try'), findsOneWidget);
      expect(reloadedSessions.records, isEmpty);
      await tap(tester, find.text('Next batch'));
      expect(find.text('0 / 6 remembered'), findsOneWidget);
      expect(saved(reloadedSessions).cards, hasLength(6));
      expect(saved(reloadedSessions).learned, isEmpty);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'All verbs from home resumes 50 learned even when a fresh batch is offered',
    (tester) async {
      phone(tester);
      final sessions = MemoryStudySessionStore();
      final previous = StudySession(
        cards: verbs.cards,
        mode: StudyMode.typing,
        shuffle: false,
      );
      addTearDown(previous.dispose);
      while (previous.completed < 50) {
        previous.checkAnswer(previous.current.greek);
        previous.advance(correct: true);
      }
      await sessions.write(
        studySessionKey(
          deck: verbs,
          mode: StudyMode.typing,
          limit: null,
          order: CardOrder.random,
        ),
        previous.snapshot,
      );
      await tester.pumpWidget(
        GreekAnkiApp(
          store: MemoryProgressStore(),
          sessionStore: sessions,
          languageStore: MemoryLanguageStore(),
        ),
      );
      await tester.pumpAndSettle();
      await tap(tester, find.byKey(const ValueKey('collection-words')));
      await tap(tester, find.text('Verbs').last);
      await tap(tester, find.byKey(const ValueKey('session-all')));
      await tester.scrollUntilVisible(
        find.text('Hard mode'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tap(tester, find.text('Hard mode'));
      expect(
        find.text('50 / ${verbs.cards.length} remembered'),
        findsOneWidget,
      );
      expect(find.text(previous.current.prompt.en), findsOneWidget);
      await tap(tester, find.byIcon(Icons.close_rounded));
      await tap(tester, find.text('Hard mode'));
      expect(
        find.text('50 / ${verbs.cards.length} remembered'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'failed checkpoint can be retried without recording the answer twice',
    (tester) async {
      phone(tester);
      final sessions = MemoryStudySessionStore();
      final reviews = MemoryProgressStore();
      await openHarness(tester, StudyMode.flashcards, sessions, reviews);
      await tap(tester, find.text('Reveal answer'));
      sessions.shouldFail = true;
      await tap(tester, find.text('Got it'));
      expect(find.text('1 / 6 remembered'), findsOneWidget);
      expect(
        find.text('Could not save progress. Please retry before leaving.'),
        findsOneWidget,
      );
      expect(reviews.records.values.single.level, 1);
      await tap(tester, find.byIcon(Icons.close_rounded));
      expect(find.byType(StudyScreen), findsOneWidget);
      sessions.shouldFail = false;
      await tap(tester, find.byIcon(Icons.close_rounded));
      expect(find.text('Open study'), findsOneWidget);
      await tap(tester, find.text('Open study'));
      expect(find.text('1 / 6 remembered'), findsOneWidget);
      expect(reviews.records.values.single.level, 1);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('a failed restore leaves the saved batch intact for retry', (
    tester,
  ) async {
    phone(tester);
    final sessions = MemoryStudySessionStore();
    final session = StudySession(
      cards: smallDeck.cards,
      mode: StudyMode.flashcards,
      shuffle: false,
    );
    addTearDown(session.dispose);
    session.reveal();
    session.advance(correct: true);
    final key = studySessionKey(
      deck: smallDeck,
      mode: StudyMode.flashcards,
      limit: null,
      order: CardOrder.random,
    );
    await sessions.write(key, session.snapshot);
    final original = sessions.records[key];
    sessions.shouldFail = true;
    await openHarness(
      tester,
      StudyMode.flashcards,
      sessions,
      MemoryProgressStore(),
    );
    expect(
      find.text('Could not restore your session. Please try again.'),
      findsOneWidget,
    );
    expect(sessions.records[key], original);
    sessions.shouldFail = false;
    await tap(tester, find.text('Try again'));
    expect(find.text('1 / 6 remembered'), findsOneWidget);
    expect(sessions.records[key], original);
    expect(tester.takeException(), isNull);
  });
}
