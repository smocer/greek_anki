import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/learning_curriculum.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_answer.dart';

void main() {
  test('notebook tense practice is isolated from present-tense vocabulary', () {
    final collection = learningCollections.singleWhere(
      (c) => c.deck.id == 'grammar-past-future',
    );
    expect(collection.section, LearningSection.grammar);
    final forms = collection.deck.cards.map((c) => c.greek).toSet();
    // This is an explicit source boundary: do not expand to all verb tables.
    expect(forms, {
      'έκανα',
      'θα κάνω',
      'είχα',
      'θα έχω',
      'ήμουν',
      'θα είμαι',
      'πήγα',
      'θα πάω',
      'είπα',
      'θα πω',
      'ήθελα',
      'θα θέλω',
      'έπρεπε',
    });
    final vocabulary = learningCollections
        .where((c) => c.section == LearningSection.words)
        .expand((c) => c.deck.cards);
    for (final card in vocabulary) {
      expect(forms.contains(card.greek), isFalse, reason: card.id);
      expect(
        card.alternatives.toSet().intersection(forms),
        isEmpty,
        reason: card.id,
      );
    }
  });

  test(
    'tense answers require the taught tense and stress, with optional I',
    () {
      final deck = learningDecks.singleWhere(
        (d) => d.id == 'grammar-past-future',
      );
      const matcher = GreekAnswer();
      for (final card in deck.cards) {
        expect(matcher.matches(card.greek, card), isTrue);
        for (final language in AppLanguage.values) {
          final prompt =
              '${card.prompt.resolve(language)} '
              '${card.meaning.resolve(language)}';
          expect(
            RegExp(r'[\u0370-\u03ff]').hasMatch(prompt),
            isFalse,
            reason: '${card.id}: no Greek answer hints',
          );
        }
        if (card.greek != 'έπρεπε') {
          expect(matcher.matches('εγώ ${card.greek}', card), isTrue);
        }
        if (card.greek.startsWith('θα ')) {
          expect(matcher.matches(card.greek.substring(3), card), isFalse);
        }
      }
      final was = deck.cards.singleWhere((c) => c.greek == 'ήμουν');
      expect(matcher.matches('είμαι', was), isFalse);
      expect(matcher.matches('ημουν', was), isFalse);
      final hadTo = deck.cards.singleWhere((c) => c.greek == 'έπρεπε');
      expect(matcher.matches('εγώ έπρεπε', hadTo), isFalse);
    },
  );
}
