import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';

import 'support/memory_progress_store.dart';

void main() {
  VocabularyDeck deck(String id) => greekDecks.firstWhere((d) => d.id == id);

  test(
    'noun collection reuses existing reviews and keeps new practice due',
    () async {
      final nouns = deck('everyday-nouns');
      final reused = nouns.cards.where((card) => card.reviewIdentity != null);
      expect(nouns.cards, hasLength(72));
      expect(reused, hasLength(32));
      final store = MemoryProgressStore();
      for (final card in reused) {
        final identity = card.reviewIdentity!;
        final original = deck(
          identity.deckId,
        ).cards.firstWhere((card) => card.id == identity.cardId);
        expect(card.greek, original.greek);
        expect(card.addedWeek, original.addedWeek);
        expect(card.words, original.words);
        store.records[identity.key(StudyMode.typing)] = ReviewSchedule(
          level: 2,
          dueAt: DateTime.utc(2099),
        );
      }
      final progress = LearningProgress(store);
      await progress.load(greekDecks);
      expect(progress.learned(nouns, StudyMode.typing), 32);
      expect(progress.dueCards(nouns, StudyMode.typing), hasLength(40));
      expect(progress.learned(nouns, StudyMode.flashcards), 0);
      await progress.record(
        deck: nouns,
        mode: StudyMode.typing,
        card: nouns.cards.firstWhere((c) => c.id == 'classroom-objects.book'),
        correct: false,
      );
      expect(store.records['classroom-objects.typing.book']!.level, 0);
      expect(progress.learned(deck('classroom-objects'), StudyMode.typing), 3);
      expect(
        store.records.keys.any((key) => key.startsWith('everyday-nouns.')),
        isFalse,
      );
      final catalog = VocabularyCatalog(greekDecks);
      for (final card in nouns.cards.where(
        (card) => card.reviewIdentity == null,
      )) {
        expect(card.addedWeek, '2026-09-28');
        expect(card.words.map((word) => word.labels), [
          [VocabularyLabel.article],
          [VocabularyLabel.noun],
        ], reason: card.greek);
        expect(
          catalog
              .words(VocabularyLabel.noun)
              .any(
                (entry) => entry.sources.any(
                  (source) =>
                      source.reviewIdentity?.deckId == nouns.id &&
                      source.reviewIdentity?.cardId == card.id,
                ),
              ),
          isTrue,
          reason: card.greek,
        );
      }
    },
  );

  test('new noun answers distinguish gender, case and stress', () {
    const matcher = GreekAnswer();
    final nouns = deck('everyday-nouns');
    for (final (id, incorrect) in [
      ('teacher-male', 'το δάσκαλος'),
      ('girl', 'η κορίτσι'),
      ('boy', 'ο αγόρι'),
      ('pupil-accusative', 'τον μαθητής'),
      ('pupil-genitive', 'τον μαθητή'),
      ('bag-accusative', 'η τσάντα'),
      ('bag-genitive', 'της τσάντα'),
      ('problem-genitive', 'του πρόβληματος'),
      ('problems', 'τα πρόβληματα'),
      ('map', 'ο χαρτί'),
      ('taxi', 'το τάξι'),
    ]) {
      final card = nouns.cards.firstWhere((card) => card.id == id);
      expect(matcher.matches(card.greek, card), isTrue);
      expect(matcher.matches(incorrect, card), isFalse, reason: id);
    }
  });
}
