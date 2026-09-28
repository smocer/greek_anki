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
    this.reviewIdentity,
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
  // A card keeps its review history when displayed in a different topic.
  final ReviewIdentity? reviewIdentity;
}

class ReviewIdentity {
  const ReviewIdentity({required this.deckId, required this.cardId});

  final String deckId;
  final String cardId;

  String key(StudyMode mode) => '$deckId.${mode.name}.$cardId';
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
