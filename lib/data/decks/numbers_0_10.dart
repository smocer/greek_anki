import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

// Stable IDs keep saved progress intact when wording or deck order changes.
// Add vocabulary here; study screens and scheduling do not depend on numbers.
const numbers0To10Deck = VocabularyDeck(
  id: 'numbers-0-10',
  title: LocalizedText(en: 'The first eleven', ru: 'Первые одиннадцать'),
  subtitle: LocalizedText(en: 'Numbers · 0 to 10', ru: 'Числа · от 0 до 10'),
  cover: '0–10',
  note: LocalizedText(
    en: 'These are counting forms. Some numbers change with the gender of a noun.',
    ru: 'Это формы для счёта. Некоторые числительные изменяются в зависимости от рода существительного.',
  ),
  cards: [
    VocabularyCard(
      id: 'number-0',
      prompt: LocalizedText.shared('0'),
      meaning: LocalizedText(en: 'zero', ru: 'ноль'),
      greek: 'μηδέν',
      pronunciation: LocalizedText(en: 'mi-DHEN', ru: 'ми-ДЭН'),
    ),
    VocabularyCard(
      id: 'number-1',
      prompt: LocalizedText.shared('1'),
      meaning: LocalizedText(en: 'one', ru: 'один'),
      greek: 'ένα',
      pronunciation: LocalizedText(en: 'E-na', ru: 'Э-на'),
    ),
    VocabularyCard(
      id: 'number-2',
      prompt: LocalizedText.shared('2'),
      meaning: LocalizedText(en: 'two', ru: 'два'),
      greek: 'δύο',
      pronunciation: LocalizedText(en: 'DHI-o', ru: 'ДИ-о'),
    ),
    VocabularyCard(
      id: 'number-3',
      prompt: LocalizedText.shared('3'),
      meaning: LocalizedText(en: 'three', ru: 'три'),
      greek: 'τρία',
      pronunciation: LocalizedText(en: 'TRI-a', ru: 'ТРИ-а'),
    ),
    VocabularyCard(
      id: 'number-4',
      prompt: LocalizedText.shared('4'),
      meaning: LocalizedText(en: 'four', ru: 'четыре'),
      greek: 'τέσσερα',
      pronunciation: LocalizedText(en: 'TE-se-ra', ru: 'ТЭ-сэ-ра'),
    ),
    VocabularyCard(
      id: 'number-5',
      prompt: LocalizedText.shared('5'),
      meaning: LocalizedText(en: 'five', ru: 'пять'),
      greek: 'πέντε',
      pronunciation: LocalizedText(en: 'PEN-de', ru: 'ПЭН-дэ'),
    ),
    VocabularyCard(
      id: 'number-6',
      prompt: LocalizedText.shared('6'),
      meaning: LocalizedText(en: 'six', ru: 'шесть'),
      greek: 'έξι',
      pronunciation: LocalizedText(en: 'E-ksi', ru: 'Э-кси'),
    ),
    VocabularyCard(
      id: 'number-7',
      prompt: LocalizedText.shared('7'),
      meaning: LocalizedText(en: 'seven', ru: 'семь'),
      greek: 'εφτά',
      pronunciation: LocalizedText(en: 'ef-TA', ru: 'эф-ТА'),
      alternatives: ['επτά'],
      explanation: LocalizedText(
        en: 'Both εφτά (ef-TA) and επτά (ep-TA) are correct and accepted. This deck presents εφτά first.',
        ru: 'Оба варианта верны и принимаются: εφτά (эф-ТА) и επτά (эп-ТА). Основной вариант в этой колоде — εφτά.',
      ),
    ),
    VocabularyCard(
      id: 'number-8',
      prompt: LocalizedText.shared('8'),
      meaning: LocalizedText(en: 'eight', ru: 'восемь'),
      greek: 'οκτώ',
      pronunciation: LocalizedText(en: 'ok-TO', ru: 'ок-ТО'),
      alternatives: ['οχτώ'],
      explanation: LocalizedText(
        en: 'Both οκτώ (ok-TO) and οχτώ (okh-TO) are correct and accepted. Χ sounds like “ch” in Scottish “loch”.',
        ru: 'Оба варианта верны и принимаются: οκτώ (ок-ТО) и οχτώ (ох-ТО). В οχτώ пишется греческая χ, а не латинская x.',
      ),
    ),
    VocabularyCard(
      id: 'number-9',
      prompt: LocalizedText.shared('9'),
      meaning: LocalizedText(en: 'nine', ru: 'девять'),
      greek: 'εννέα',
      pronunciation: LocalizedText(en: 'e-NE-a', ru: 'э-НЭ-а'),
      alternatives: ['εννιά'],
    ),
    VocabularyCard(
      id: 'number-10',
      prompt: LocalizedText.shared('10'),
      meaning: LocalizedText(en: 'ten', ru: 'десять'),
      greek: 'δέκα',
      pronunciation: LocalizedText(en: 'DHE-ka', ru: 'ДЭ-ка'),
    ),
  ],
);
