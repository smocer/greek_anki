import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const phoneConversationsDeck = VocabularyDeck(
  id: 'phone-conversations',
  title: LocalizedText(en: 'On the phone', ru: 'По телефону'),
  subtitle: LocalizedText(
    en: 'Answering, asking and giving a number',
    ru: 'Ответить, спросить, назвать номер',
  ),
  note: LocalizedText(
    en: 'Ναι; and Παρακαλώ; can both answer a call. Τηλέφωνο can mean the device or, in context, a phone number.',
    ru: 'При ответе на звонок Ναι; и Παρακαλώ; работают как русское «алло». Τηλέφωνο — и аппарат, и по контексту номер телефона.',
  ),
  cover: 'Ναι;',
  cards: [
    VocabularyCard(
      id: 'answer-call',
      prompt: LocalizedText(
        en: 'Hello? (answer a phone call)',
        ru: 'Алло? (ответить на звонок)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ναι;',
      pronunciation: LocalizedText(en: 'ne', ru: 'нэ'),
      explanation: LocalizedText(
        en: 'Ναι literally means yes. Παρακαλώ is another ordinary phone greeting.',
        ru: 'Ναι буквально «да», но в телефоне — «алло». Παρακαλώ тоже подходит; это не только «пожалуйста».',
      ),
      alternatives: ['Παρακαλώ;'],
    ),
    VocabularyCard(
      id: 'phone-noun',
      prompt: LocalizedText(
        en: 'The phone (with article)',
        ru: 'Телефон (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το τηλέφωνο',
      pronunciation: LocalizedText(en: 'to ti-LE-fo-no', ru: 'то ти-ЛЭ-фо-но'),
      explanation: LocalizedText(
        en: 'Τηλέφωνο is neuter and stressed on λέ.',
        ru: 'Знакомое слово, но русский «телефон» мужского рода, греческое το τηλέφωνο — среднего, с другим ударением.',
      ),
    ),
    VocabularyCard(
      id: 'on-phone',
      prompt: LocalizedText(en: 'On the phone', ru: 'По телефону / у телефона'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'στο τηλέφωνο',
      pronunciation: LocalizedText(
        en: 'sto ti-LE-fo-no',
        ru: 'сто ти-ЛЭ-фо-но',
      ),
      explanation: LocalizedText(
        en: 'Σε + το = στο in this expression.',
        ru: 'Русское «по телефону» не переводим буквально: στο τηλέφωνο, σε с винительным.',
      ),
    ),
    VocabularyCard(
      id: 'who-calling',
      prompt: LocalizedText(
        en: 'Who is on the phone? (using “is”)',
        ru: 'Кто у телефона? (через «есть»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ποιος είναι στο τηλέφωνο;',
      pronunciation: LocalizedText(
        en: 'pyos I-ne sto ti-LE-fo-no',
        ru: 'пьос И-нэ сто ти-ЛЭ-фо-но',
      ),
      explanation: LocalizedText(
        en: 'An unknown caller is referred to in the third person: είναι.',
        ru: 'Вопрос «кто?» требует είναι «он/она есть», не είσαι «ты есть». Ποιος обычно без ударения.',
      ),
    ),
    VocabularyCard(
      id: 'giannis-there',
      prompt: LocalizedText(en: 'Is Giannis there?', ru: 'Яннис там?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ο Γιάννης είναι εκεί;',
      pronunciation: LocalizedText(
        en: 'o YA-nis I-ne e-KI',
        ru: 'о Я-нис И-нэ э-КИ',
      ),
      explanation: LocalizedText(
        en: 'A name as subject keeps its article and nominative ending.',
        ru: 'О Γιάννης — подлежащее, именительный с -ς. В русском «есть» опускается, в греческом είναι нужно.',
      ),
      acceptedAnswers: ['Είναι ο Γιάννης εκεί;', 'Είναι εκεί ο Γιάννης;'],
    ),
    VocabularyCard(
      id: 'where-giannis',
      prompt: LocalizedText(en: 'Where is Giannis?', ru: 'Где Яннис?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πού είναι ο Γιάννης;',
      pronunciation: LocalizedText(
        en: 'pu I-ne o YA-nis',
        ru: 'пу И-нэ о Я-нис',
      ),
      explanation: LocalizedText(
        en: 'Πού asks for a place; the verb is third person singular.',
        ru: 'Греческое «где он есть?» сохраняет είναι. Пишем πού с ударением.',
      ),
      acceptedAnswers: ['Ο Γιάννης πού είναι;'],
    ),
    VocabularyCard(
      id: 'this-maria',
      prompt: LocalizedText(
        en: 'This is Maria. (identifying yourself on the phone)',
        ru: 'Это Мария. (представиться по телефону)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Η Μαρία.',
      pronunciation: LocalizedText(en: 'i ma-RI-a', ru: 'и ма-РИ-а'),
      explanation: LocalizedText(
        en: 'A short phone identification can be just the article and name.',
        ru: 'Как русское «это Мария». Можно кратко η Μαρία или полностью Είμαι η Μαρία.',
      ),
      alternatives: ['Είμαι η Μαρία.'],
    ),
    VocabularyCard(
      id: 'my-phone',
      prompt: LocalizedText(
        en: 'My phone / my phone number',
        ru: 'Мой телефон / мой номер телефона',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το τηλέφωνό μου',
      pronunciation: LocalizedText(
        en: 'to ti-LE-fo-NO mu',
        ru: 'то ти-ЛЭ-фо-НО му',
      ),
      explanation: LocalizedText(
        en: 'The unstressed μου triggers a second accent on τηλέφωνό.',
        ru: 'У слова τηλέφωνο ударение на третьем слоге от конца; перед безударным μου добавляется второе: τηλέφωνό μου.',
      ),
    ),
    VocabularyCard(
      id: 'your-phone',
      prompt: LocalizedText(
        en: 'Your phone number (informal)',
        ru: 'Твой номер телефона',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το τηλέφωνό σου',
      pronunciation: LocalizedText(
        en: 'to ti-LE-fo-NO su',
        ru: 'то ти-ЛЭ-фо-НО су',
      ),
      explanation: LocalizedText(
        en: 'Σου means your, addressed to one person informally.',
        ru: 'Как «твой» при обращении на ты. Сохраняем два ударения: τηλέφωνό σου.',
      ),
    ),
    VocabularyCard(
      id: 'your-phone-polite',
      prompt: LocalizedText(
        en: 'Your phone number (polite/plural)',
        ru: 'Ваш номер телефона',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το τηλέφωνό σας',
      pronunciation: LocalizedText(
        en: 'to ti-LE-fo-NO sas',
        ru: 'то ти-ЛЭ-фо-НО сас',
      ),
      explanation: LocalizedText(
        en: 'Σας is possessive here, not the subject pronoun εσείς.',
        ru: 'Σας — «Ваш/ваш» после существительного. Подлежащее «Вы» было бы εσείς.',
      ),
    ),
    VocabularyCard(
      id: 'number-intro',
      prompt: LocalizedText(
        en: 'My phone number is…',
        ru: 'Мой номер телефона — …',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Το τηλέφωνό μου είναι…',
      pronunciation: LocalizedText(
        en: 'to ti-LE-fo-NO mu I-ne',
        ru: 'то ти-ЛЭ-фо-НО му И-нэ',
      ),
      explanation: LocalizedText(
        en: 'This phrase introduces the number; no actual number is required on this card.',
        ru: 'Фраза перед номером: είναι нужно, хотя в русском достаточно тире. Сам номер в этой карточке не требуется.',
      ),
    ),
    VocabularyCard(
      id: 'have-phone-polite',
      prompt: LocalizedText(
        en: 'Do you have a phone? (polite/plural)',
        ru: 'У Вас есть телефон?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Έχετε τηλέφωνο;',
      pronunciation: LocalizedText(
        en: 'E-khe-te ti-LE-fo-no',
        ru: 'Э-хэ-тэ ти-ЛЭ-фо-но',
      ),
      explanation: LocalizedText(
        en: 'Contrast informal έχεις with polite/plural έχετε.',
        ru: 'Ты: έχεις. Вы: έχετε. Как «у тебя» и «у Вас», но различие выражено формой глагола.',
      ),
    ),
  ],
);
