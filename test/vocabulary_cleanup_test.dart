import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';

void main() {
  test('ordinary nouns do not ask for unnecessary blank sentences', () {
    final nouns = currentDictionary.learningDecks.singleWhere(
      (d) => d.id == 'words-nouns',
    );
    for (final word in ['πιάτο', 'μπουκάλι', 'νερό']) {
      final card = nouns.cards.firstWhere((c) => c.greek == word);
      expect(card.contextExample, isNull, reason: word);
    }
  });
  test('productive diminutives become basic words with old review aliases', () {
    final nouns = currentDictionary.learningDecks.singleWhere(
      (d) => d.id == 'words-nouns',
    );
    const pairs = {
      'σκυλάκι': 'σκύλος',
      'γατάκι': 'γάτα',
      'παιδάκι': 'παιδί',
      'σπιτάκι': 'σπίτι',
      'νεράκι': 'νερό',
      'καφεδάκι': 'καφές',
    };
    for (final pair in pairs.entries) {
      expect(nouns.cards.where((c) => c.greek == pair.key), isEmpty);
      final basic = nouns.cards.firstWhere((c) => c.greek == pair.value);
      expect(basic.reviewAliases, isNotEmpty, reason: pair.value);
    }
    expect(nouns.cards.any((c) => c.greek == 'μπουκάλι'), isTrue);
    expect(nouns.cards.any((c) => c.greek == 'σουβλάκι'), isTrue);
    expect(nouns.cards.any((c) => c.greek == 'πατατάκια'), isTrue);
  });
}
