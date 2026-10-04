import 'vocabulary.dart';
import 'app_language.dart';

enum VocabularyLabel {
  topic,
  noun,
  verb,
  adjective,
  adverb,
  pronoun,
  article,
  preposition,
  conjunction,
  numeral,
  interjection,
}

enum VocabularyPeriod {
  all,
  thisWeek,
  lastWeek,
  earlier;

  bool includes(String? week, DateTime now) {
    if (this == all) return true;
    final current = weekStamp(now);
    final previous = weekStamp(
      DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7)),
    );
    return switch (this) {
      all => true,
      thisWeek => week == current,
      lastWeek => week == previous,
      earlier => week == null || week.compareTo(previous) < 0,
    };
  }
}

String weekStamp(DateTime date) {
  final day = DateTime.utc(date.year, date.month, date.day);
  return day
      .subtract(Duration(days: day.weekday - 1))
      .toIso8601String()
      .substring(0, 10);
}

/// Stable within each week; unknown dates come after recorded dates.
List<VocabularyCard> newestFirst(Iterable<VocabularyCard> cards) {
  final indexed = cards.toList().asMap().entries.toList();
  indexed.sort((a, b) {
    final order = (b.value.addedWeek ?? '').compareTo(a.value.addedWeek ?? '');
    return order == 0 ? a.key.compareTo(b.key) : order;
  });
  return List.unmodifiable(indexed.map((entry) => entry.value));
}

class VocabularyCatalog {
  VocabularyCatalog(this.decks);
  final List<VocabularyDeck> decks;

  List<VocabularyCard> get cards {
    final unique = <String, VocabularyCard>{};
    for (final deck in decks) {
      for (final card in deck.cards) {
        final identity =
            card.reviewIdentity ??
            ReviewIdentity(deckId: deck.id, cardId: card.id);
        unique.putIfAbsent(
          identity.key(StudyMode.flashcards),
          () => card.withMetadata(reviewIdentity: identity),
        );
      }
    }
    return newestFirst(unique.values);
  }

  List<String> get weeks =>
      (cards.map((card) => card.addedWeek).whereType<String>().toSet().toList()
        ..sort((a, b) => b.compareTo(a)));

  List<String> get wordWeeks =>
      cards
          .expand((card) => card.words)
          .where((word) => word.labels.isNotEmpty)
          .map((word) => word.addedWeek)
          .whereType<String>()
          .toSet()
          .toList()
        ..sort((a, b) => b.compareTo(a));

  List<VocabularyWordEntry> words(VocabularyLabel label) {
    final entries = <String, VocabularyWordEntry>{};
    for (final card in cards) {
      for (final word in card.words.where(
        (word) => word.labels.contains(label),
      )) {
        final key = '${label.name}:${word.surface.toLowerCase()}';
        final entry = entries.putIfAbsent(
          key,
          () => VocabularyWordEntry(
            id: key,
            word: word,
            addedWeek: word.addedWeek ?? card.addedWeek,
          ),
        );
        if (!entry.sources.any(
          (source) =>
              source.reviewIdentity?.key(StudyMode.flashcards) ==
              card.reviewIdentity?.key(StudyMode.flashcards),
        )) {
          entry.sources.add(card);
        }
      }
    }
    final result = entries.values.toList().asMap().entries.toList();
    result.sort((a, b) {
      final order = (b.value.addedWeek ?? '').compareTo(
        a.value.addedWeek ?? '',
      );
      return order == 0 ? a.key.compareTo(b.key) : order;
    });
    return List.unmodifiable(result.map((entry) => entry.value));
  }

  VocabularyDeck category(VocabularyLabel label) => VocabularyDeck(
    id: 'category-${label.name}',
    title: labelTitle(label),
    subtitle: const LocalizedText(
      en: 'Words from across your vocabulary',
      ru: 'Слова из всех тем',
    ),
    cover: label == VocabularyLabel.noun ? 'ο · η · το' : labelTitle(label).en,
    cards: cards
        .where((card) => card.words.any((word) => word.labels.contains(label)))
        .toList(),
  );
}

class VocabularyWordEntry {
  VocabularyWordEntry({required this.id, required this.word, this.addedWeek});
  final String id;
  final VocabularyToken word;
  final String? addedWeek;
  final List<VocabularyCard> sources = [];
  VocabularyCard get example =>
      sources.reduce((a, b) => a.greek.length <= b.greek.length ? a : b);
}

List<VocabularyCard> sourceCardsFor(Iterable<VocabularyWordEntry> words) {
  final cards = <String, VocabularyCard>{};
  for (final entry in words) {
    for (final card in entry.sources) {
      final key = card.reviewIdentity!.key(StudyMode.flashcards);
      cards.putIfAbsent(key, () => card);
    }
  }
  return newestFirst(cards.values);
}

LocalizedText labelTitle(VocabularyLabel label) => switch (label) {
  VocabularyLabel.topic => const LocalizedText(en: 'Topic', ru: 'Тема'),
  VocabularyLabel.noun => const LocalizedText(
    en: 'Noun',
    ru: 'Существительное',
  ),
  VocabularyLabel.verb => const LocalizedText(en: 'Verb', ru: 'Глагол'),
  VocabularyLabel.adjective => const LocalizedText(
    en: 'Adjective',
    ru: 'Прилагательное',
  ),
  VocabularyLabel.adverb => const LocalizedText(en: 'Adverb', ru: 'Наречие'),
  VocabularyLabel.pronoun => const LocalizedText(
    en: 'Pronoun',
    ru: 'Местоимение',
  ),
  VocabularyLabel.article => const LocalizedText(en: 'Article', ru: 'Артикль'),
  VocabularyLabel.preposition => const LocalizedText(
    en: 'Preposition',
    ru: 'Предлог',
  ),
  VocabularyLabel.conjunction => const LocalizedText(
    en: 'Conjunction',
    ru: 'Союз',
  ),
  VocabularyLabel.numeral => const LocalizedText(
    en: 'Numeral',
    ru: 'Числительное',
  ),
  VocabularyLabel.interjection => const LocalizedText(
    en: 'Interjection',
    ru: 'Междометие',
  ),
};
