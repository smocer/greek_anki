import 'dart:math';

import 'app_language.dart';
import 'curriculum.dart';
import 'greek_text.dart';

enum GrammarDrillKind { nounPlural, adjectivePlural, quantity }

enum GrammaticalNumber { singular, plural }

enum QuantityCase { nominative, accusative }

const shoppingThemes = {
  LearningTheme.bakery,
  LearningTheme.kiosk,
  LearningTheme.streetMarket,
  LearningTheme.supermarket,
};

class PluralEntry {
  const PluralEntry(this.cardId, this.singular, this.pattern, this.answers);
  final String cardId, singular, pattern;
  final List<String> answers;
}

class QuantityEntry {
  const QuantityEntry(
    this.cardId,
    this.noun,
    this.answer,
    this.gender,
    this.number, {
    this.nominative,
  });
  final String cardId, noun, answer, gender;
  final String? nominative;
  final GrammaticalNumber number;
}

class GrammarDrillQuestion {
  const GrammarDrillQuestion({
    required this.cardId,
    required this.prompt,
    required this.pattern,
    required this.answers,
    required this.meaning,
    this.number,
    this.gender,
    this.quantityCase,
  });
  final String cardId, prompt, pattern;
  final List<String> answers;
  final LocalizedText meaning;
  final GrammaticalNumber? number;
  final String? gender;
  final QuantityCase? quantityCase;

  bool matches(String input) {
    final key = GreekText.answerKey(input);
    return answers.any((answer) => GreekText.answerKey(answer) == key);
  }

  String get solution => answers.join(' / ');
}

/// Select from eligible questions directly: no retry loop, no session progress.
/// The exclusion key is gender + singular ending for plurals, and the actual
/// answer form for quantity questions (πόσο and πόσον share one key).
class GrammarDrillGenerator {
  GrammarDrillGenerator(
    Iterable<GrammarDrillQuestion> questions, {
    Random? random,
  }) : questions = List.unmodifiable(questions),
       _random = random ?? Random() {
    if (this.questions.map((q) => q.pattern).toSet().length < 2) {
      throw ArgumentError('A drill needs at least two distinct form patterns.');
    }
  }
  final List<GrammarDrillQuestion> questions;
  final Random _random;
  String? _previousPattern;

  GrammarDrillQuestion next() {
    final eligible = questions
        .where((q) => q.pattern != _previousPattern)
        .toList();
    final question = eligible[_random.nextInt(eligible.length)];
    _previousPattern = question.pattern;
    return question;
  }
}

/// Factory keeps vocabulary lookup and drill construction out of the UI.
/// Only cards still in the supplied live catalog can become questions.
GrammarDrillGenerator createGrammarDrill({
  required GrammarDrillKind kind,
  required List<LearningCollection> collections,
  required List<PluralEntry> nouns,
  required List<PluralEntry> adjectives,
  required List<QuantityEntry> quantities,
  Random? random,
}) {
  final target = kind == GrammarDrillKind.adjectivePlural
      ? 'words-adjectives'
      : 'words-nouns';
  final collection = collections.firstWhere((c) => c.deck.id == target);
  final cards = {for (final card in collection.deck.cards) card.id: card};
  if (kind == GrammarDrillKind.quantity) {
    return GrammarDrillGenerator([
      for (final entry in quantities)
        if (cards.containsKey(entry.cardId) &&
            (collection.themes[entry.cardId]?.any(shoppingThemes.contains) ??
                false))
          for (final grammaticalCase in QuantityCase.values)
            _quantityQuestion(
              entry,
              cards[entry.cardId]!.prompt,
              grammaticalCase,
            ),
    ], random: random);
  }
  return GrammarDrillGenerator([
    for (final entry
        in kind == GrammarDrillKind.nounPlural ? nouns : adjectives)
      if (cards.containsKey(entry.cardId))
        GrammarDrillQuestion(
          cardId: entry.cardId,
          prompt: entry.singular,
          pattern: entry.pattern,
          answers: entry.answers,
          meaning: cards[entry.cardId]!.prompt,
        ),
  ], random: random);
}

GrammarDrillQuestion _quantityQuestion(
  QuantityEntry entry,
  LocalizedText meaning,
  QuantityCase grammaticalCase,
) {
  final nominative = grammaticalCase == QuantityCase.nominative;
  final singular = entry.number == GrammaticalNumber.singular;
  final answer = nominative && entry.gender == 'm'
      ? (singular ? 'πόσος' : 'πόσοι')
      : entry.answer;
  final noun = nominative ? (entry.nominative ?? entry.noun) : entry.noun;
  return GrammarDrillQuestion(
    cardId: entry.cardId,
    prompt: nominative
        ? '___ $noun ${singular ? 'υπάρχει' : 'υπάρχουν'} στο σπίτι;'
        : '___ $noun θέλεις;',
    pattern: answer,
    answers: [
      answer,
      if (!nominative && answer == 'πόσο' && entry.gender == 'm') 'πόσον',
    ],
    meaning: meaning,
    number: entry.number,
    gender: entry.gender,
    quantityCase: grammaticalCase,
  );
}
