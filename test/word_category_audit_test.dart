import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';
import 'package:greek_anki/domain/vocabulary.dart';

void main() {
  final dictionary = currentDictionary;
  final decks = {for (final d in dictionary.learningDecks) d.id: d};
  test('word categories contain the intended parts of speech', () {
    expect(decks.containsKey('words-descriptions'), isFalse);
    for (final (id, label) in [
      ('words-adjectives', VocabularyLabel.adjective),
      ('words-adverbs', VocabularyLabel.adverb),
      ('words-pronouns', VocabularyLabel.pronoun),
      ('words-prepositions', VocabularyLabel.preposition),
    ]) {
      expect(decks[id]!.cards, isNotEmpty);
      for (final card in decks[id]!.cards) {
        expect(card.labels, contains(label), reason: '$id/${card.id}');
      }
    }
    expect(
      decks.values.expand((d) => d.cards).any((c) => c.greek == 'βρε'),
      isFalse,
    );
  });
  test('homographs have distinct prompts, contexts and review identities', () {
    for (final greek in ['με', 'σε']) {
      final pronoun = decks['words-pronouns']!.cards.singleWhere(
        (c) => c.greek == greek,
      );
      final preposition = decks['words-prepositions']!.cards.singleWhere(
        (c) => c.greek == greek,
      );
      expect(pronoun.prompt.en, isNot(preposition.prompt.en));
      expect(
        pronoun.reviewIdentity!.key(StudyMode.typing),
        isNot(preposition.reviewIdentity!.key(StudyMode.typing)),
      );
      for (final card in [pronoun, preposition]) {
        expect(card.contextExample!.en, contains('___'));
        expect(card.contextExample!.ru, contains('___'));
        expect(card.contextExample!.zh, contains('___'));
      }
    }
    expect(
      decks['words-pronouns']!.cards
          .where((c) => c.greek == 'σου')
          .map((c) => c.senseKey)
          .toSet(),
      {'possessive', 'indirect-object'},
    );
  });
  test('adjectives accept taught genders without accepting missing stress', () {
    const matcher = GreekAnswer();
    final simple = decks['words-adjectives']!.cards.singleWhere(
      (c) => c.greek == 'απλός',
    );
    for (final form in ['απλός', 'απλή', 'απλό']) {
      expect(matcher.matches(form, simple), isTrue);
    }
    for (final form in ['απλος', 'απλά', 'απλώς']) {
      expect(matcher.matches(form, simple), isFalse);
    }
  });
}
