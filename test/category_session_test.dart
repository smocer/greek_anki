import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';

void main() {
  for (final mode in StudyMode.values) {
    test(
      'all word categories complete in ${mode.name} with distinct source identities',
      () {
        final catalog = VocabularyCatalog(greekDecks);
        for (final label in VocabularyLabel.values.where(
          (label) => label != VocabularyLabel.topic,
        )) {
          final cards = catalog.category(label).cards;
          expect(cards, isNotEmpty);
          final session = StudySession(cards: cards, mode: mode);
          final keys = <String>{};
          while (!session.isComplete) {
            expect(keys.add(session.currentKey), isTrue);
            if (mode == StudyMode.flashcards) {
              session.reveal();
            } else {
              session.checkAnswer(session.current.greek);
              expect(session.typedCorrect, isTrue);
            }
            session.advance(correct: true);
          }
          expect(session.completed, cards.length);
          expect(session.firstTryCorrect, cards.length);
          session.dispose();
        }
      },
    );
  }
  test('duplicate original cards are still rejected', () {
    final card = VocabularyCatalog(greekDecks).cards.first;
    expect(
      () => StudySession(cards: [card, card], mode: StudyMode.flashcards),
      throwsArgumentError,
    );
  });
}
