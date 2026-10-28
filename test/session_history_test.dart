import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

class _CountingStore extends MemoryProgressStore {
  int writes = 0;
  @override
  Future<void> write(String key, ReviewSchedule schedule) async {
    writes++;
    await super.write(key, schedule);
  }
}

void main() {
  final source = greekDecks.firstWhere((deck) => deck.id == 'numbers-0-10');
  final cards = source.cards.skip(1).take(3).toList();

  test('history leaves the moving review window and progress unchanged', () {
    final ordered = source.cards.take(7).toList();
    final session = StudySession(
      cards: ordered,
      mode: StudyMode.flashcards,
      shuffle: false,
    );
    addTearDown(session.dispose);
    final firstSeen = <String>[];
    var reviewed = false;
    for (var turn = 0; !session.isComplete && turn < 30; turn++) {
      final current = session.current;
      final wasReview = session.isReview;
      if (wasReview) {
        reviewed = true;
        final completed = session.completed;
        session.previous();
        expect(session.isReviewing, isTrue);
        expect(session.isReview, isFalse);
        session.advance(correct: false);
        expect(session.completed, completed);
        expect(session.repetitions, 0);
        session.next();
        expect(session.current, current);
        expect(session.isReview, isTrue);
        expect(session.phase, CardPhase.question);
      } else {
        firstSeen.add(current.id);
      }
      session.reveal();
      session.advance(correct: true);
    }
    expect(reviewed, isTrue);
    expect(firstSeen, ordered.map((card) => card.id));
    expect(session.isComplete, isTrue);
    session.previous();
    expect(session.isComplete, isFalse);
    expect(session.phase, CardPhase.answer);
    session.next();
    expect(session.isComplete, isTrue);
    expect(session.completed, ordered.length);
    expect(session.firstTryCorrect, ordered.length);
  });

  test('history preserves the pending card, answer state and repeat queue', () {
    final session = StudySession(
      cards: cards,
      mode: StudyMode.flashcards,
      shuffle: false,
    );
    addTearDown(session.dispose);
    expect(session.canGoPrevious, isFalse);
    session.previous();
    expect(session.current, cards[0]);
    session.reveal();
    session.advance(correct: false);
    session.reveal();
    expect(session.current, cards[1]);
    session.previous();
    expect(session.current, cards[0]);
    expect(session.phase, CardPhase.answer);
    session.advance(correct: true);
    expect(session.completed, 0);
    expect(session.repetitions, 1);
    session.next();
    expect(session.current, cards[1]);
    expect(session.phase, CardPhase.answer);
    session.advance(correct: true);
    session.reveal();
    session.advance(correct: true);
    expect(session.current, cards[0]);
    expect(session.phase, CardPhase.question);
  });

  test(
    'history supports multiple steps and return to completion without recounting',
    () {
      final session = StudySession(
        cards: cards,
        mode: StudyMode.flashcards,
        shuffle: false,
      );
      addTearDown(session.dispose);
      for (final _ in cards) {
        session.reveal();
        session.advance(correct: true);
      }
      expect(session.isComplete, isTrue);
      for (final card in cards.reversed) {
        session.previous();
        expect(session.current, card);
      }
      expect(session.canGoPrevious, isFalse);
      session.previous();
      expect(session.current, cards.first);
      for (var i = 0; i < cards.length; i++) {
        session.next();
      }
      expect(session.isComplete, isTrue);
      expect(session.completed, cards.length);
      expect(session.firstTryCorrect, cards.length);
      expect(session.repetitions, 0);
    },
  );

  testWidgets(
    'previous and next never save duplicate reviews and history resets for a new round',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final store = _CountingStore();
      final deck = VocabularyDeck(
        id: source.id,
        title: source.title,
        subtitle: source.subtitle,
        cover: source.cover,
        cards: cards.take(2).toList(),
      );
      await tester.pumpWidget(
        MaterialApp(
          theme: appTheme,
          home: StudyScreen(
            sessionStore: MemoryStudySessionStore(),
            deck: deck,
            cards: deck.cards,
            mode: StudyMode.flashcards,
            progress: LearningProgress(store),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final previous = find.byKey(const ValueKey('previous-card'));
      expect(tester.widget<IconButton>(previous).onPressed, isNull);

      Future<void> tap(Finder finder) async {
        await tester.ensureVisible(finder);
        await tester.pumpAndSettle();
        await tester.tap(finder);
        await tester.pumpAndSettle();
      }

      await tap(find.text('Reveal answer'));
      await tap(find.text('Got it'));
      expect(store.writes, 1);
      await tap(previous);
      expect(find.text(cards.first.greek), findsOneWidget);
      expect(find.text('Got it'), findsNothing);
      expect(find.text('Again'), findsNothing);
      await tap(find.byKey(const ValueKey('next-card')));
      expect(find.text(cards[1].greek), findsNothing);
      expect(store.writes, 1);
      await tap(find.text('Reveal answer'));
      await tap(find.text('Got it'));
      expect(store.writes, 2);
      expect(find.text('Μπράβο!'), findsOneWidget);
      await tap(previous);
      expect(find.text(cards[1].greek), findsOneWidget);
      await tap(find.byKey(const ValueKey('next-card')));
      expect(find.text('Μπράβο!'), findsOneWidget);
      expect(store.writes, 2);
      await tap(find.text('Next batch'));
      expect(tester.widget<IconButton>(previous).onPressed, isNull);
    },
  );
}
