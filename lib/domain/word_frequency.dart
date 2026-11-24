import 'greek_frequency_data.dart';
import 'greek_text.dart';
import 'vocabulary.dart';

/// An offline, word-form frequency estimate, not an exam difficulty score.
abstract final class WordFrequency {
  static final _words = RegExp(r'[\u0370-\u03ff\u1f00-\u1fff\u0300-\u036f]+');

  static List<String> tokens(String text) => _words
      .allMatches(GreekText.answerKey(text))
      .map((match) => match[0]!)
      .toList();

  // Compounds/phrases are limited by their least frequent word. Using the most
  // frequent token would rank every noun with "το" ahead of ordinary words.
  static int _count(String text) {
    final words = tokens(text);
    if (words.isEmpty) return 0;
    return words
        .map((word) => greekFrequencyCounts[word] ?? 0)
        .reduce((a, b) => a < b ? a : b);
  }

  // Equivalent spellings/gender forms must not make a common word look rare.
  // Do not use accepted full sentences, which may contain unrelated words.
  static int score(VocabularyCard card) => [
    card.greek,
    ...card.alternatives,
    for (final form in card.forms) form.greek,
  ].map(_count).reduce((a, b) => a > b ? a : b);
}
