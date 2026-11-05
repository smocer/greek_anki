import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/greek_answer.dart';

void main() {
  test('reviewed gender pairs occupy one card and accept both forms', () {
    final cards = currentDictionary.collections
        .where((c) => c.section.name == 'words')
        .expand((c) => c.deck.cards)
        .where((c) => c.wordGroup != null)
        .toList();
    expect(cards, isNotEmpty);
    // All 22 previously combined pairs still retain their saved review aliases.
    expect(
      cards.where((c) => c.reviewAliases.isNotEmpty).length,
      greaterThanOrEqualTo(22),
    );
    const matcher = GreekAnswer();
    for (final group in cards.map((c) => c.wordGroup).toSet()) {
      final matches = cards.where((c) => c.wordGroup == group).toList();
      expect(matches.length, 1, reason: group);
      final card = matches.single;
      expect(card.forms.length, greaterThanOrEqualTo(2), reason: group);
      for (final form in card.forms) {
        expect(matcher.matches(form.greek, card), isTrue, reason: form.greek);
        expect(
          matcher.matches(form.answerDisplay, card),
          isTrue,
          reason: form.answerDisplay,
        );
        expect(card.answerDisplay, contains(form.answerDisplay));
        expect(form.pronunciation.en, isNotEmpty);
      }
    }
  });

  test('different kinship meanings remain separate', () {
    final cards = currentDictionary.collections.expand((c) => c.deck.cards);
    final father = cards.firstWhere((c) => c.greek == 'πατέρας');
    final mother = cards.firstWhere((c) => c.greek == 'μητέρα');
    const matcher = GreekAnswer();
    expect(matcher.matches('μητέρα', father), isFalse);
    expect(matcher.matches('πατέρας', mother), isFalse);
  });

  test('breakfast does not accept the morning adjective gender forms', () {
    final nouns = currentDictionary.collections.singleWhere(
      (collection) => collection.deck.id == 'words-nouns',
    );
    final breakfast = nouns.deck.cards.singleWhere(
      (card) => card.greek == 'το πρωινό',
    );
    const matcher = GreekAnswer();
    for (final answer in ['πρωινό', 'το πρωινό']) {
      expect(matcher.matches(answer, breakfast), isTrue);
    }
    for (final answer in ['πρωινός', 'πρωινή', 'ο πρωινό', 'πρωινο']) {
      expect(matcher.matches(answer, breakfast), isFalse, reason: answer);
    }
    final descriptions = currentDictionary.collections.singleWhere(
      (collection) => collection.deck.id == 'words-descriptions',
    );
    final morning = descriptions.deck.cards.singleWhere(
      (card) => card.wordGroup == 'morning',
    );
    expect(matcher.matches('πρωινός', morning), isTrue);
    expect(matcher.matches('πρωινή', morning), isTrue);
  });
}
