import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const lessonConnectorsDeck = VocabularyDeck(
  id: 'lesson-connectors',
  title: LocalizedText(
    en: 'Small words, big differences',
    ru: 'Маленькие слова и различия',
  ),
  subtitle: LocalizedText(
    en: 'Or, not, always, still, perhaps',
    ru: 'Или, не, всегда, ещё, может быть',
  ),
  note: LocalizedText(
    en: 'A stress mark can distinguish words: η is an article, ή means or. Δεν negates a verb; όχι is a standalone no.',
    ru: 'Ударение меняет значение: η — артикль, ή — «или». Δεν ставим перед глаголом как «не», а όχι — отдельное «нет».',
  ),
  cover: 'η / ή',
  cards: [
    VocabularyCard(
      id: 'or',
      prompt: LocalizedText(en: 'Or', ru: 'Или'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ή',
      pronunciation: LocalizedText(en: 'i', ru: 'и'),
      explanation: LocalizedText(
        en: 'The conjunction ή keeps its stress mark even though it has one syllable.',
        ru: 'Исключение для односложного слова: ή «или» обязательно с ударением, чтобы отличить от артикля η.',
      ),
    ),
    VocabularyCard(
      id: 'feminine-article',
      prompt: LocalizedText(
        en: 'The feminine singular article (subject form)',
        ru: 'Артикль женского рода, ед. число, именительный',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'η',
      pronunciation: LocalizedText(en: 'i', ru: 'и'),
      explanation: LocalizedText(
        en: 'The article η has no accent: η Μαρία, η γάτα.',
        ru: 'В русском артикля нет. Η перед существительным без ударения: η Μαρία, η γάτα; не путайте с ή «или».',
      ),
    ),
    VocabularyCard(
      id: 'not',
      prompt: LocalizedText(
        en: 'Not (before a present-tense verb)',
        ru: 'Не (перед глаголом настоящего времени)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'δεν',
      pronunciation: LocalizedText(en: 'dhen', ru: 'дэн'),
      explanation: LocalizedText(
        en: 'Use δεν είμαι, δεν έχω. Δε is possible before some consonants.',
        ru: 'Как «не» перед глаголом: δεν είμαι, δεν έχω. Перед некоторыми согласными бывает δε, но не перед гласной.',
      ),
      alternatives: ['δε'],
    ),
    VocabularyCard(
      id: 'always',
      prompt: LocalizedText(en: 'Always', ru: 'Всегда'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πάντα',
      pronunciation: LocalizedText(en: 'PAN-da', ru: 'ПАН-да'),
      explanation: LocalizedText(
        en: 'Πάντα describes frequency and does not alter the verb form.',
        ru: 'Как наречие «всегда»: не изменяется. Το μάθημα πάντα αρχίζει… — урок всегда начинается…',
      ),
    ),
    VocabularyCard(
      id: 'still-yet',
      prompt: LocalizedText(en: 'Still / yet', ru: 'Ещё / пока ещё'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ακόμα',
      pronunciation: LocalizedText(en: 'a-KO-ma', ru: 'а-КО-ма'),
      explanation: LocalizedText(
        en: 'Ακόμη is another standard form; use it with negatives for not yet.',
        ru: 'Как «ещё» в «у нас ещё нет»: δεν έχουμε… ακόμα. Ακόμη — допустимый вариант.',
      ),
      alternatives: ['ακόμη'],
    ),
    VocabularyCard(
      id: 'perhaps',
      prompt: LocalizedText(
        en: 'Perhaps / by any chance (in a question)',
        ru: 'Может быть / случайно не…? (в вопросе)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μήπως',
      pronunciation: LocalizedText(en: 'MI-pos', ru: 'МИ-пос'),
      explanation: LocalizedText(
        en: 'Μήπως can make a question tentative, as in μήπως ξέρεις;.',
        ru: 'Как «ты случайно не знаешь?». Μήπως — осторожный вопрос, а не отрицание само по себе.',
      ),
    ),
    VocabularyCard(
      id: 'with',
      prompt: LocalizedText(en: 'With', ru: 'С (вместе с)'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'με',
      pronunciation: LocalizedText(en: 'me', ru: 'мэ'),
      explanation: LocalizedText(
        en: 'Με takes the accusative, for example με τη Μαρία.',
        ru: 'В русском «с Марией» — творительный; в греческом με τη Μαρία — винительный. Με без ударения.',
      ),
    ),
    VocabularyCard(
      id: 'dog-or-cat',
      prompt: LocalizedText(
        en: 'The dog or the cat?',
        ru: 'Пёс или кошка? (с определёнными артиклями)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ο σκύλος ή η γάτα;',
      pronunciation: LocalizedText(
        en: 'o SKI-los i i GHA-ta',
        ru: 'о СКИ-лос и и ГА-та',
      ),
      explanation: LocalizedText(
        en: 'Ή is or; the following η is the feminine article.',
        ru: 'Рядом стоят ή η: первое «или» с ударением, второе — артикль «кошка» без ударения.',
      ),
    ),
  ],
);
