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
  verbA(LocalizedText(en: 'A', ru: 'A', zh: 'A')),
  verbB1(LocalizedText(en: 'B1', ru: 'B1', zh: 'B1')),
  verbB2(LocalizedText(en: 'B2', ru: 'B2', zh: 'B2')),
  verbAB(LocalizedText(en: 'AB', ru: 'AB', zh: 'AB')),
  people(LocalizedText(en: 'People', ru: 'Люди', zh: '人物')),
  family(LocalizedText(en: 'Family', ru: 'Семья', zh: '家庭')),
  classroom(LocalizedText(en: 'Classroom', ru: 'Учёба', zh: '课堂')),
  home(
    LocalizedText(en: 'Home & everyday life', ru: 'Дом и быт', zh: '家庭与日常生活'),
  ),
  food(LocalizedText(en: 'Food & drink', ru: 'Еда и напитки', zh: '饮食')),
  places(LocalizedText(en: 'Places', ru: 'Места', zh: '地点')),
  travel(LocalizedText(en: 'Transport', ru: 'Транспорт', zh: '交通')),
  phone(LocalizedText(en: 'Phone', ru: 'Телефон', zh: '电话')),
  time(LocalizedText(en: 'Time & numbers', ru: 'Время и числа', zh: '时间与数字')),
  conversation(LocalizedText(en: 'Conversation', ru: 'Общение', zh: '日常对话'));

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
    Set<LearningTheme> excludedThemes = const {},
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
          !(themes[card.id]?.any(excludedThemes.contains) ?? false) &&
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
enum CardOrder { random, alphabet, addedTime }

List<VocabularyCard> sessionBatch(
  List<VocabularyCard> cards, {
  int limit = 15,
  Random? random,
  CardOrder order = CardOrder.random,
}) {
  if (limit < 1) throw ArgumentError.value(limit, 'limit');
  if (order == CardOrder.random) {
    return (List.of(cards)..shuffle(random)).take(limit).toList();
  }
  if (order == CardOrder.addedTime) {
    return newestFirst(cards).take(limit).toList();
  }
  final indexed = cards.asMap().entries.toList();
  String key(VocabularyCard card) =>
      GreekText.searchKey(card.greek).replaceAll('\u0308', '');
  indexed.sort((a, b) {
    final result = key(a.value).compareTo(key(b.value));
    return result == 0 ? a.key.compareTo(b.key) : result;
  });
  return indexed.take(limit).map((entry) => entry.value).toList();
}
