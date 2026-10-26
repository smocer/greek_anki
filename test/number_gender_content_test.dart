import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/greek_answer.dart';

void main() {
  const matcher = GreekAnswer();

  test('number gender forms share the original card and review identity', () {
    final numbers = currentDictionary.learningDecks.singleWhere(
      (deck) => deck.id == 'words-numbers',
    );
    for (final (number, answers) in [
      (1, ['ένα', 'ένας', 'μία', 'μια']),
      (3, ['τρία', 'τρεις']),
      (4, ['τέσσερα', 'τέσσερις']),
    ]) {
      final card = numbers.cards.singleWhere(
        (card) => card.id == 'numbers-0-10.number-$number',
      );
      expect(card.reviewIdentity!.deckId, 'numbers-0-10');
      expect(card.reviewIdentity!.cardId, 'number-$number');
      expect(card.addedWeek, '2026-09-28');
      for (final answer in answers) {
        expect(matcher.matches(answer, card), isTrue, reason: answer);
        expect(
          numbers.cards.where((other) => matcher.matches(answer, other)),
          hasLength(1),
          reason: '$answer should not become another vocabulary card',
        );
      }
      expect(matcher.matches(card.displayedAnswer, card), isFalse);
    }
  });

  test('number agreement drills reject other genders and missing stress', () {
    final grammar = currentDictionary.learningDecks.singleWhere(
      (deck) => deck.id == 'grammar-gender',
    );
    for (final (id, answer, wrongGender, wrongStress) in [
      ('one-man', 'Ένας άντρας.', 'Ένα άντρας.', 'Ενας άντρας.'),
      ('one-woman', 'Μία γυναίκα.', 'Ένα γυναίκα.', 'Μία γυναικα.'),
      ('three-women', 'Τρεις γυναίκες.', 'Τρία γυναίκες.', 'Τρεις γυναικες.'),
      ('three-children', 'Τρία παιδιά.', 'Τρεις παιδιά.', 'Τρια παιδιά.'),
      ('four-men', 'Τέσσερις άντρες.', 'Τέσσερα άντρες.', 'Τεσσερις άντρες.'),
      (
        'four-children',
        'Τέσσερα παιδιά.',
        'Τέσσερις παιδιά.',
        'Τεσσερα παιδιά.',
      ),
    ]) {
      final card = grammar.cards.singleWhere(
        (card) => card.id == 'journeys-$id',
      );
      expect(matcher.matches(answer, card), isTrue, reason: answer);
      expect(matcher.matches(wrongGender, card), isFalse, reason: wrongGender);
      expect(matcher.matches(wrongStress, card), isFalse, reason: wrongStress);
    }
  });
}
