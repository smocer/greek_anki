import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/decks/verb_topics.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void main() {
  VocabularyDeck deck(String id) => greekDecks.firstWhere((d) => d.id == id);

  test('number groups merge without gaps or duplicates at twenty', () {
    final numbers = deck('numbers-11-100');
    expect(numbers.cards.map((c) => c.prompt.en), [
      for (var i = 11; i <= 20; i++) '$i',
      for (var i = 30; i <= 100; i += 10) '$i',
    ]);
    expect(greekDecks.map((d) => d.id), isNot(contains('numbers-11-20')));
    expect(greekDecks.map((d) => d.id), isNot(contains('numbers-tens')));
  });

  test('everyday verbs use one I-form card and a three-verb grammar drill', () {
    final basics = deck('basic-verbs');
    expect(basics.cards.map((c) => c.greek), [
      'κάνω',
      'πίνω',
      'αρχίζω',
      'μένω',
      'θέλω',
      'περιμένω',
      'έχω',
      'διαβάζω',
      'γράφω',
      'ανοίγω',
      'κλείνω',
      'μαθαίνω',
      'σπουδάζω',
      'ξέρω',
      'καταλαβαίνω',
      'τελειώνω',
      'δουλεύω',
      'πληρώνω',
      'αγοράζω',
    ]);
    expect(basics.cards.every((c) => c.reviewIdentity!.cardId == 'i'), isTrue);
    final drill = deck('present-conjugation');
    expect(drill.cards.length, 18);
    expect(drill.cards.map((c) => c.reviewIdentity!.deckId).toSet(), {
      'live-present',
      'read-present',
      'understand-present',
    });
    for (final source in everydayVerbSources) {
      expect(greekDecks.map((d) => d.id), isNot(contains(source.id)));
    }
    for (final id in ['be-present', 'called-present', 'sing-present']) {
      expect(deck(id).cards.length, greaterThanOrEqualTo(6));
    }
  });

  test(
    'sentence examples retain their answers and identities in other topics',
    () {
      final phrases = greekDecks
          .where((d) => !['basic-verbs', 'present-conjugation'].contains(d.id))
          .expand((d) => d.cards)
          .toList();
      for (final source in everydayVerbSources) {
        for (final original in source.cards.skip(6)) {
          final moved = phrases.singleWhere(
            (c) =>
                c.reviewIdentity?.deckId == source.id &&
                c.reviewIdentity?.cardId == original.id,
          );
          expect(moved.greek, original.greek);
          expect(moved.alternatives, original.alternatives);
          expect(moved.acceptedAnswers, original.acceptedAnswers);
          expect(moved.explanation, original.explanation);
        }
      }
    },
  );

  test(
    'old reviews load and save in new topics without resetting or copying',
    () async {
      final previous = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
      final store = MemoryProgressStore();
      for (final key in [
        'numbers-11-20.typing.number-11',
        'numbers-tens.typing.number-100',
        'learn-present.typing.i',
        'live-present.typing.i',
        'live-present.flashcards.i',
        'read-present.typing.you',
        'have-present.typing.not-phone-yet',
        'want-present.typing.you',
      ]) {
        store.records[key] = previous;
      }
      final progress = LearningProgress(store);
      await progress.load(greekDecks);
      expect(progress.learned(deck('numbers-11-100'), StudyMode.typing), 2);
      expect(
        progress.dueCards(deck('numbers-11-100'), StudyMode.typing).length,
        16,
      );
      expect(progress.learned(deck('numbers-11-100'), StudyMode.flashcards), 0);
      expect(progress.learned(deck('basic-verbs'), StudyMode.typing), 2);
      expect(
        progress.learned(deck('present-conjugation'), StudyMode.typing),
        2,
      );
      expect(
        progress.learned(deck('phone-conversations'), StudyMode.typing),
        1,
      );

      // The same first-person card appears in vocabulary and the drill. They
      // share its history, while flashcards and typing still stay independent.
      await progress.record(
        deck: deck('present-conjugation'),
        mode: StudyMode.typing,
        card: deck(
          'present-conjugation',
        ).cards.firstWhere((c) => c.id == 'live-present.i'),
        correct: false,
      );
      expect(progress.learned(deck('basic-verbs'), StudyMode.typing), 1);
      expect(
        progress.learned(deck('present-conjugation'), StudyMode.typing),
        1,
      );
      expect(progress.learned(deck('basic-verbs'), StudyMode.flashcards), 1);
      expect(store.records['live-present.typing.i']!.level, 0);
      expect(
        store.records.keys.any((key) => key.startsWith('present-conjugation.')),
        isFalse,
      );
      expect(store.records['want-present.typing.you'], same(previous));

      await progress.record(
        deck: deck('numbers-11-100'),
        mode: StudyMode.typing,
        card: deck('numbers-11-100').cards.last,
        correct: false,
      );
      expect(store.records['numbers-tens.typing.number-100']!.level, 0);
      final reloaded = LearningProgress(store);
      await reloaded.load(greekDecks);
      expect(reloaded.learned(deck('numbers-11-100'), StudyMode.typing), 1);
      expect(reloaded.learned(deck('basic-verbs'), StudyMode.typing), 1);
      expect(
        reloaded.learned(deck('present-conjugation'), StudyMode.typing),
        1,
      );
    },
  );
}
