import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const smallWordsDeck = VocabularyDeck(
  id: 'small-words',
  title: LocalizedText(
    en: 'Small words: time & links',
    ru: 'Короткие слова: время и связи',
  ),
  subtitle: LocalizedText(
    en: 'Connect a sentence and place it in time',
    ru: 'Соединить слова, указать время',
  ),
  note: LocalizedText(
    en: 'Learn the whole meaning in context. Γιατί can introduce either a question (why?) or a reason (because).',
    ru: 'Смысл зависит от контекста. Γιατί в вопросе — «почему», перед объяснением — «потому что».',
  ),
  cover: 'Και',
  cards: [
    VocabularyCard(
      id: 'and',
      prompt: LocalizedText(en: 'And', ru: 'И'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ke', ru: 'кэ'),
      explanation: LocalizedText(
        en: 'Κι is a shorter variant, often before a vowel.',
        ru: 'Και читается «кэ», не «кай»; перед гласной часто κι.',
      ),
      greek: 'και',
      alternatives: ['κι'],
    ),
    VocabularyCard(
      id: 'also',
      prompt: LocalizedText(
        en: 'Also / likewise',
        ru: 'Тоже / также / взаимно',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'e-PI-sis', ru: 'э-ПИ-сис'),
      explanation: LocalizedText(
        en: 'Can add another fact or return a wish.',
        ru: 'Επίσης — «также» и ответное «взаимно», например на пожелание хорошего дня.',
      ),
      greek: 'επίσης',
    ),
    VocabularyCard(
      id: 'but',
      prompt: LocalizedText(en: 'But', ru: 'Но'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'a-LA', ru: 'а-ЛА'),
      explanation: LocalizedText(
        en: 'Two λ in spelling; stress at the end.',
        ru: 'Αλλά — «но», с ударением в конце. Не путайте с άλλα — «другие» среднего рода мн. числа.',
      ),
      greek: 'αλλά',
    ),
    VocabularyCard(
      id: 'because',
      prompt: LocalizedText(en: 'Because', ru: 'Потому что'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ya-TI', ru: 'я-ТИ'),
      explanation: LocalizedText(
        en: 'The same word as why; here it introduces a reason.',
        ru: 'Одна форма для «почему?» и «потому что»: связь вопроса и ответа нужно понимать по контексту.',
      ),
      greek: 'γιατί',
    ),
    VocabularyCard(
      id: 'here',
      prompt: LocalizedText(en: 'Here', ru: 'Здесь / сюда'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'e-DHO', ru: 'э-ДО'),
      explanation: LocalizedText(
        en: 'Location in είμαι εδώ; destination in έλα εδώ.',
        ru: 'Εδώ = «здесь» с είμαι и «сюда» с έλα. В русском два разных наречия, в греческом одно.',
      ),
      greek: 'εδώ',
    ),
    VocabularyCard(
      id: 'there',
      prompt: LocalizedText(en: 'There', ru: 'Там / туда'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'e-KI', ru: 'э-КИ'),
      explanation: LocalizedText(
        en: 'Can indicate location or destination, depending on the verb.',
        ru: 'Как εδώ, слово εκεί может означать место («там») или направление («туда»).',
      ),
      greek: 'εκεί',
    ),
    VocabularyCard(
      id: 'today',
      prompt: LocalizedText(en: 'Today', ru: 'Сегодня'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'SI-me-ra', ru: 'СИ-мэ-ра'),
      explanation: LocalizedText(
        en: 'Stress the first syllable.',
        ru: 'Σήμερα — сегодня; ударение на σή, не на μέρα.',
      ),
      greek: 'σήμερα',
    ),
    VocabularyCard(
      id: 'tomorrow',
      prompt: LocalizedText(en: 'Tomorrow', ru: 'Завтра'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'AV-ri-o', ru: 'АВ-ри-о'),
      explanation: LocalizedText(
        en: 'Use in τα λέμε αύριο = see you tomorrow.',
        ru: 'Знакомо по τα λέμε αύριο. Αυ перед ρ звучит «ав».',
      ),
      greek: 'αύριο',
    ),
    VocabularyCard(
      id: 'now',
      prompt: LocalizedText(en: 'Now', ru: 'Сейчас'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'TO-ra', ru: 'ТО-ра'),
      explanation: LocalizedText(
        en: 'A simple time adverb.',
        ru: 'Τώρα — сейчас; не изменяется по падежам, как и русское наречие.',
      ),
      greek: 'τώρα',
    ),
    VocabularyCard(
      id: 'yes',
      prompt: LocalizedText(en: 'Yes', ru: 'Да'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ne', ru: 'нэ'),
      explanation: LocalizedText(
        en: 'Sounds like “ne,” but means yes.',
        ru: 'Ложный звуковой друг: ναι («нэ») значит «да», а не «нет».',
      ),
      greek: 'ναι',
    ),
    VocabularyCard(
      id: 'no',
      prompt: LocalizedText(en: 'No', ru: 'Нет'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'O-khi', ru: 'О-хи'),
      explanation: LocalizedText(
        en: 'Use for an independent “no”; δεν negates verbs.',
        ru: 'Όχι — самостоятельное «нет». Не перед глаголом: «не знаю» — δεν ξέρω.',
      ),
      greek: 'όχι',
    ),
  ],
);
