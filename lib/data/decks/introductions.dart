import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const introductionsDeck = VocabularyDeck(
  id: 'introductions',
  title: LocalizedText(en: 'Introducing yourself', ru: 'Знакомство'),
  subtitle: LocalizedText(
    en: 'Names and first conversations',
    ru: 'Имена и первые разговоры',
  ),
  note: LocalizedText(
    en: 'Names take different forms after με λένε and είμαι: compare Γιώργο and ο Γιώργος.',
    ru: 'После με λένε — винительный, после είμαι — именительный: Γιώργο и ο Γιώργος.',
  ),
  cover: 'Με λένε',
  cards: [
    VocabularyCard(
      id: 'ask-name',
      prompt: LocalizedText(
        en: 'What is your name? (informal)',
        ru: 'Как тебя зовут?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'pos se LE-ne', ru: 'пос сэ ЛЭ-нэ'),
      explanation: LocalizedText(
        en: 'Literally “how do they call you?” Σε is the unstressed object “you.”',
        ru: 'Почти как по-русски: «как тебя называют?». Σε = «тебя», а не «ты».',
      ),
      greek: 'Πώς σε λένε;',
    ),
    VocabularyCard(
      id: 'ask-name-polite',
      prompt: LocalizedText(
        en: 'What is your name? (polite/plural)',
        ru: 'Как Вас / вас зовут?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'pos sas LE-ne', ru: 'пос сас ЛЭ-нэ'),
      explanation: LocalizedText(
        en: 'Σας is the polite/plural object form corresponding to σε.',
        ru: 'Σε : σας здесь = тебя : вас/Вас. Подлежащее «вы» было бы εσείς.',
      ),
      greek: 'Πώς σας λένε;',
    ),
    VocabularyCard(
      id: 'called-george',
      prompt: LocalizedText(
        en: 'My name is George. (with “they call me”)',
        ru: 'Меня зовут Йоргос. (через «меня зовут»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'me LE-ne YOR-gho',
        ru: 'мэ ЛЭ-нэ ЙОР-го',
      ),
      explanation: LocalizedText(
        en: 'Με is me; Γιώργο is accusative, without the final ς.',
        ru: 'Με = «меня», Γιώργο — винительный. В русском обычно «меня зовут Александр» (именительный имени), поэтому русский падеж сюда не переносим.',
      ),
      greek: 'Με λένε Γιώργο.',
    ),
    VocabularyCard(
      id: 'called-maria',
      prompt: LocalizedText(
        en: 'My name is Maria. (with “they call me”)',
        ru: 'Меня зовут Мария. (через «меня зовут»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'me LE-ne ma-RI-a',
        ru: 'мэ ЛЭ-нэ ма-РИ-а',
      ),
      explanation: LocalizedText(
        en: 'Μαρία has the same spelling in nominative and accusative.',
        ru: 'В русском «Марию», а по-гречески Μαρία: винительный женского имени здесь совпадает с именительным.',
      ),
      greek: 'Με λένε Μαρία.',
    ),
    VocabularyCard(
      id: 'i-george',
      prompt: LocalizedText(
        en: 'I am George. (use “be” and the article)',
        ru: 'Я Йоргос. (через «быть», с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'I-me o YOR-ghos', ru: 'И-мэ о ЙОР-гос'),
      explanation: LocalizedText(
        en: 'After είμαι use nominative ο Γιώργος.',
        ru: 'В отличие от «меня зовут», после είμαι — именительный ο Γιώργος. Связка и артикль произносятся.',
      ),
      greek: 'Είμαι ο Γιώργος.',
    ),
    VocabularyCard(
      id: 'i-maria',
      prompt: LocalizedText(
        en: 'I am Maria. (use “be” and the article)',
        ru: 'Я Мария. (через «быть», с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'I-me i ma-RI-a', ru: 'И-мэ и ма-РИ-а'),
      explanation: LocalizedText(
        en: 'Η is the feminine nominative article; it sounds /i/.',
        ru: 'Η — артикль женского рода в именительном падеже; читается «и».',
      ),
      greek: 'Είμαι η Μαρία.',
    ),
    VocabularyCard(
      id: 'you-name',
      prompt: LocalizedText(
        en: 'And your name? (one word, informal)',
        ru: 'А тебя? (одно слово, на «ты»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'e-SE-na', ru: 'э-СЭ-на'),
      explanation: LocalizedText(
        en: 'The stressed object form, used after Με λένε…',
        ru: 'Полная ударная форма «тебя». После «меня зовут…» логично спросить «а тебя?» — εσένα, не εσύ.',
      ),
      greek: 'Εσένα;',
    ),
    VocabularyCard(
      id: 'you-name-polite',
      prompt: LocalizedText(
        en: 'And your name? (one word, polite/plural)',
        ru: 'А Вас / вас? (одно слово)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'e-SAS', ru: 'э-САС'),
      explanation: LocalizedText(
        en: 'The stressed polite/plural object form.',
        ru: 'Εσάς — полная форма «вас/Вас»; безударная краткая — σας.',
      ),
      greek: 'Εσάς;',
    ),
    VocabularyCard(
      id: 'name-mine',
      prompt: LocalizedText(
        en: 'My name (with article)',
        ru: 'Моё имя (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'to O-no-MA mu', ru: 'то О-но-МА му'),
      explanation: LocalizedText(
        en: 'Μου follows the noun. Όνομά gains a second written accent before the clitic.',
        ru: 'Μου после существительного = «моё». В όνομά μου появляется второе ударение перед безударным μου.',
      ),
      greek: 'Το όνομά μου',
    ),
    VocabularyCard(
      id: 'called-passive',
      prompt: LocalizedText(
        en: 'I am called George. (with λέγομαι)',
        ru: 'Я зовусь Йоргос. (через λέγομαι)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'LE-gho-me YOR-ghos',
        ru: 'ЛЭ-го-мэ ЙОР-гос',
      ),
      explanation: LocalizedText(
        en: 'With λέγομαι, the name is nominative; compare Με λένε Γιώργο.',
        ru: 'Λέγομαι ближе к «я зовусь». Имя — именительный Γιώργος; в Με λένε Γιώργο — винительный.',
      ),
      greek: 'Λέγομαι Γιώργος.',
    ),
  ],
);
