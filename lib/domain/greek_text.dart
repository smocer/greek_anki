/// Text comparison for modern Greek. Keep grading and search policies explicit.
abstract final class GreekText {
  // Canonically equivalent ways to encode monotonic Greek vowels. Decomposing
  // preserves the stress position and diaeresis instead of discarding either.
  static const _decompositions = {
    'ά': 'α\u0301',
    'έ': 'ε\u0301',
    'ή': 'η\u0301',
    'ί': 'ι\u0301',
    'ό': 'ο\u0301',
    'ύ': 'υ\u0301',
    'ώ': 'ω\u0301',
    'ϊ': 'ι\u0308',
    'ϋ': 'υ\u0308',
    'ΐ': 'ι\u0308\u0301',
    'ΰ': 'υ\u0308\u0301',
    // Oxia spellings and deprecated combining marks have the same canonical
    // Unicode representation as the corresponding tonos forms.
    'ά': 'α\u0301',
    'έ': 'ε\u0301',
    'ή': 'η\u0301',
    'ί': 'ι\u0301',
    'ό': 'ο\u0301',
    'ύ': 'υ\u0301',
    'ώ': 'ω\u0301',
    'ΐ': 'ι\u0308\u0301',
    'ΰ': 'υ\u0308\u0301',
    '\u0341': '\u0301',
    '\u0344': '\u0308\u0301',
    'ς': 'σ',
  };

  // Capitalization, punctuation, and extra whitespace do not affect grading.
  // Stress, diaeresis, word boundaries, and Greek letters remain significant.
  static String answerKey(String input) => input
      .toLowerCase()
      .split('')
      .map((letter) => _decompositions[letter] ?? letter)
      .join()
      .replaceAll(RegExp(r'[.,;?!\u037e\u0387·…:]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  static String searchKey(String input) =>
      answerKey(input).replaceAll('\u0301', '');
}
