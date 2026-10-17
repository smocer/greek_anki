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
  properNouns(
    LocalizedText(en: 'Proper nouns', zh: '专有名词', ru: 'Имена собственные'),
  ),
  people(
    LocalizedText(en: 'Jobs & work', zh: '职业&工作', ru: 'Профессии и работа'),
  ),
  classroom(LocalizedText(en: 'Classroom', zh: '课堂', ru: 'Учёба')),
  home(
    LocalizedText(en: 'Home & everyday life', zh: '家庭&日常生活', ru: 'Дом и быт'),
  ),
  food(LocalizedText(en: 'Food & drink', zh: '饮食', ru: 'Еда и напитки')),
  places(
    LocalizedText(
      en: 'Places & transport',
      zh: '地点&交通',
      ru: 'Места и транспорт',
    ),
  ),
  time(
    LocalizedText(
      en: 'Numbers, time & dates',
      zh: '数字、时间&日期',
      ru: 'Числа, время и даты',
    ),
  ),
  conversation(LocalizedText(en: 'Conversation', zh: '日常对话', ru: 'Общение'));

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
