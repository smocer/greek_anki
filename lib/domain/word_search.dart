import 'curriculum.dart';
import 'greek_text.dart';
import 'vocabulary.dart';

/// A lookup over all learning content, independent of the study selection.
class WordSearch {
  WordSearch(Iterable<LearningCollection> collections) {
    final seen = <String>{};
    for (final collection in collections) {
      for (final card in collection.deck.cards) {
        final identity =
            card.reviewIdentity?.key(StudyMode.flashcards) ??
            '${collection.deck.id}/${card.id}';
        if (!seen.add(identity)) continue;
        _entries.add((
          card: card,
          spellings: {
            card.greek,
            card.displayedAnswer,
            ...card.alternatives,
            ...card.acceptedAnswers,
            for (final form in card.forms) ...[form.greek, form.answerDisplay],
          }.map(GreekText.searchKey).toList(),
        ));
      }
    }
    _entries.sort(
      (a, b) => GreekText.searchKey(
        a.card.greek,
      ).compareTo(GreekText.searchKey(b.card.greek)),
    );
  }

  final _entries = <({VocabularyCard card, List<String> spellings})>[];

  List<VocabularyCard> get cards => [for (final entry in _entries) entry.card];

  List<VocabularyCard> find(String query) {
    final key = GreekText.searchKey(query);
    if (key.isEmpty) return [];
    return [
      for (final entry in _entries)
        if (entry.spellings.any((spelling) => spelling.contains(key)))
          entry.card,
    ];
  }
}
