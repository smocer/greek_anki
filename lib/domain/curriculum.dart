import 'dart:math';

import 'app_language.dart';
import 'greek_text.dart';
import 'vocabulary.dart';
import 'vocabulary_category.dart';

enum LearningSection {
  words(LocalizedText(en: 'Words', zh: '单词', ru: 'Слова')),
  phrases(LocalizedText(en: 'Phrases', zh: '短语', ru: 'Фразы')),
  grammar(LocalizedText(en: 'Grammar', zh: '语法', ru: 'Грамматика'));

  const LearningSection(this.title);
  final LocalizedText title;
}

enum LearningTheme {
  people(LocalizedText(en: 'People', zh: '人物', ru: 'Люди')),
  family(LocalizedText(en: 'Family', zh: '家庭', ru: 'Семья')),
  classroom(LocalizedText(en: 'Classroom', zh: '课堂', ru: 'Учёба')),
  home(
    LocalizedText(en: 'Home & everyday life', zh: '家庭与日常生活', ru: 'Дом и быт'),
  ),
  food(LocalizedText(en: 'Food & drink', zh: '食物与饮品', ru: 'Еда и напитки')),
  places(LocalizedText(en: 'Places', zh: '地点', ru: 'Места')),
  travel(LocalizedText(en: 'Transport', zh: '交通', ru: 'Транспорт')),
  phone(LocalizedText(en: 'Phone', zh: '电话', ru: 'Телефон')),
  time(LocalizedText(en: 'Time & numbers', zh: '时间与数字', ru: 'Время и числа')),
  conversation(LocalizedText(en: 'Conversation', zh: '会话', ru: 'Общение'));

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
          card.prompt.zh ?? '',
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
