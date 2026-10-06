import '../domain/vocabulary.dart';

/// Reuses authored cards while retaining their original review identities.
List<VocabularyCard> cardsFrom(VocabularyDeck source, {List<String>? ids}) {
  final selected = ids == null
      ? source.cards
      : ids.map((id) => source.cards.firstWhere((card) => card.id == id));
  return List.unmodifiable([
    for (final card in selected)
      VocabularyCard(
        id: '${source.id}.${card.id}',
        prompt: card.prompt,
        meaning: card.meaning,
        greek: card.greek,
        answerDisplay: card.answerDisplay,
        pronunciation: card.pronunciation,
        explanation: card.explanation,
        alternatives: card.alternatives,
        acceptedAnswers: card.acceptedAnswers,
        labels: card.labels,
        addedWeek: card.addedWeek,
        words: card.words,
        reviewIdentity:
            card.reviewIdentity ??
            ReviewIdentity(deckId: source.id, cardId: card.id),
      ),
  ]);
}

VocabularyDeck withExtraCards(
  VocabularyDeck deck,
  List<VocabularyCard> extraCards,
) => VocabularyDeck(
  id: deck.id,
  title: deck.title,
  subtitle: deck.subtitle,
  cover: deck.cover,
  note: deck.note,
  cards: List.unmodifiable([...deck.cards, ...extraCards]),
);
