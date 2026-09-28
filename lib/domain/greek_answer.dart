import 'greek_text.dart';
import 'vocabulary.dart';

class GreekAnswer {
  const GreekAnswer();

  bool matches(String input, VocabularyCard card) {
    final answer = GreekText.answerKey(input);
    return [
      card.greek,
      ...card.alternatives,
      ...card.acceptedAnswers,
    ].any((candidate) => GreekText.answerKey(candidate) == answer);
  }
}
