import 'dart:math';

import 'app_language.dart';
import 'greek_text.dart';
import 'vocabulary.dart';
import 'vocabulary_category.dart';

enum LearningSection {
  words(LocalizedText(en: 'Words', ru: 'Слова')),
  phrases(LocalizedText(en: 'Phrases', ru: 'Фразы')),
  grammar(LocalizedText(en: 'Grammar', ru: 'Грамматика'));

  const LearningSection(this.title);
  final LocalizedText title;
}

enum LearningTheme {
  people(LocalizedText(en: 'People', ru: 'Люди')),
  family(LocalizedText(en: 'Family', ru: 'Семья')),
  classroom(LocalizedText(en: 'Classroom', ru: 'Учёба')),
  home(LocalizedText(en: 'Home & everyday life', ru: 'Дом и быт')),
  food(LocalizedText(en: 'Food & drink', ru: 'Еда и напитки')),
  places(LocalizedText(en: 'Places', ru: 'Места')),
  travel(LocalizedText(en: 'Transport', ru: 'Транспорт')),
  phone(LocalizedText(en: 'Phone', ru: 'Телефон')),
  time(LocalizedText(en: 'Time & numbers', ru: 'Время и числа')),
  conversation(LocalizedText(en: 'Conversation', ru: 'Общение'));

  const LearningTheme(this.title);
  final LocalizedText title;
}

class LearningCollection {
  const LearningCollection({
    required this.section,
    required this.deck,
    this.themes = const {},
  });

  final LearningSection section;
  final VocabularyDeck deck;
  final Map<String, Set<LearningTheme>> themes;

  Set<LearningTheme> get availableThemes => {
    for (final tags in themes.values) ...tags,
  };

  VocabularyDeck filter({
    VocabularyPeriod period = VocabularyPeriod.all,
    LearningTheme? theme,
    String query = '',
    required DateTime now,
  }) {
    final terms = GreekText.searchKey(query).split(RegExp(r'\s+'));
    final cards = deck.cards.where((card) {
      final text = GreekText.searchKey(
        [
          card.prompt.en,
          card.prompt.ru,
          card.greek,
          card.displayedAnswer,
          ...card.alternatives,
        ].join(' '),
      );
      return period.includes(card.addedWeek, now) &&
          (theme == null || (themes[card.id]?.contains(theme) ?? false)) &&
          terms.every(text.contains);
    });
    return VocabularyDeck(
      id: deck.id,
      title: deck.title,
      subtitle: deck.subtitle,
      cover: deck.cover,
      note: deck.note,
      period: period,
      cards: newestFirst(cards),
    );
  }
}

/// Sample before constructing a session; mistakes can repeat within that batch.
List<VocabularyCard> sessionBatch(
  List<VocabularyCard> cards, {
  int limit = 15,
  Random? random,
}) {
  if (limit < 1) throw ArgumentError.value(limit, 'limit');
  return (List.of(cards)..shuffle(random)).take(limit).toList();
}
