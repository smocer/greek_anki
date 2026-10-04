import 'app_language.dart';
import 'vocabulary_category.dart';

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
    this.labels = const [],
    this.addedWeek,
    this.words = const [],
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
  final List<VocabularyLabel> labels;
  // ISO Monday date: all additions within the same week share this stamp.
  final String? addedWeek;
  final List<VocabularyToken> words;

  VocabularyCard withMetadata({
    List<VocabularyLabel>? labels,
    String? addedWeek,
    ReviewIdentity? reviewIdentity,
    List<VocabularyToken>? words,
  }) => VocabularyCard(
    id: id,
    prompt: prompt,
    meaning: meaning,
    greek: greek,
    pronunciation: pronunciation,
    explanation: explanation,
    alternatives: alternatives,
    acceptedAnswers: acceptedAnswers,
    reviewIdentity: reviewIdentity ?? this.reviewIdentity,
    labels: labels ?? this.labels,
    addedWeek: addedWeek ?? this.addedWeek,
    words: words ?? this.words,
  );
}

class VocabularyToken {
  const VocabularyToken({
    required this.surface,
    required this.lemma,
    required this.labels,
    required this.start,
    required this.end,
    this.addedWeek,
    this.tag = '',
  });
  final String surface, lemma, tag;
  final int start, end;
  final List<VocabularyLabel> labels;
  final String? addedWeek;
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
    this.period = VocabularyPeriod.all,
  });

  final String id;
  final LocalizedText title;
  final LocalizedText subtitle;
  final String cover;
  final List<VocabularyCard> cards;
  final LocalizedText? note;
  final VocabularyPeriod period;
}

enum StudyMode { flashcards, typing }
