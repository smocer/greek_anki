import 'app_language.dart';

class VocabularyCard {
  const VocabularyCard({
    required this.id,
    required this.prompt,
    required this.meaning,
    required this.greek,
    required this.pronunciation,
    this.explanation,
    this.alternatives = const [],
    this.acceptedAnswers = const [],
  });

  final String id;
  final LocalizedText prompt;
  final LocalizedText meaning;
  final String greek;
  final LocalizedText pronunciation;
  final LocalizedText? explanation;
  final List<String> alternatives;
  // Valid full phrasings (for example, an optional subject pronoun) need not
  // crowd the displayed spelling alternatives on a revealed card.
  final List<String> acceptedAnswers;
}

class VocabularyDeck {
  const VocabularyDeck({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.cover,
    required this.cards,
    this.note,
  });

  final String id;
  final LocalizedText title;
  final LocalizedText subtitle;
  final String cover;
  final List<VocabularyCard> cards;
  final LocalizedText? note;
}

enum StudyMode { flashcards, typing }
