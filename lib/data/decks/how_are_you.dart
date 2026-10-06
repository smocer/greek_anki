import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const howAreYouDeck = VocabularyDeck(
  id: 'how-are-you',
  title: LocalizedText(en: 'How are you?', ru: 'Как дела?'),
  subtitle: LocalizedText(
    en: 'Questions and natural replies',
    ru: 'Вопросы и обычные ответы',
  ),
  note: LocalizedText(
    en: 'Learn each informal question alongside its polite/plural partner.',
    ru: 'Учите вопросы парами: на «ты» и на «Вы». Глагольное окончание меняется, как в русском.',
  ),
  cover: 'Καλά',
  cards: [
    VocabularyCard(
      id: 'doing-informal',
      prompt: LocalizedText(
        en: 'How are you? (with “do”, informal)',
        ru: 'Как дела? (на «ты», выражение с глаголом «делать»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ti KA-nis', ru: 'ти КА-нис'),
      explanation: LocalizedText(
        en: 'Literally “what are you doing?”; also a routine greeting.',
        ru: 'Буквально «что ты делаешь?», но при встрече — «как дела?». Окончание -εις указывает на «ты».',
      ),
      greek: 'Τι κάνεις;',
    ),
    VocabularyCard(
      id: 'doing-polite',
      prompt: LocalizedText(
        en: 'How are you? (with “do”, polite/plural)',
        ru: 'Как у вас дела? (выражение с глаголом «делать»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ti KA-ne-te', ru: 'ти КА-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Κάνετε is you plural, also polite singular.',
        ru: 'Κάνετε соответствует «вы делаете»: множественное число служит и вежливым обращением.',
      ),
      greek: 'Τι κάνετε;',
    ),
    VocabularyCard(
      id: 'being-informal',
      prompt: LocalizedText(
        en: 'How are you? (with “be”, informal)',
        ru: 'Как ты? (с глаголом «быть»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'pos I-se', ru: 'пос И-сэ'),
      explanation: LocalizedText(
        en: 'Use είσαι with one person informally.',
        ru: 'В русском «есть» опускается: «как ты?». В греческом είσαι нужно произнести.',
      ),
      greek: 'Πώς είσαι;',
    ),
    VocabularyCard(
      id: 'being-polite',
      prompt: LocalizedText(
        en: 'How are you? (with “be”, polite/plural)',
        ru: 'Как Вы? (с глаголом «быть»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'pos I-ste', ru: 'пос И-стэ'),
      explanation: LocalizedText(
        en: 'Use είστε with several people or one politely.',
        ru: 'Είσαι : είστε = ты : вы/Вы. Принцип вежливого множественного похож на русский.',
      ),
      greek: 'Πώς είστε;',
    ),
    VocabularyCard(
      id: 'fine',
      prompt: LocalizedText(en: 'Fine / well', ru: 'Хорошо'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ka-LA', ru: 'ка-ЛА'),
      explanation: LocalizedText(
        en: 'Καλά describes how you are doing; it is an adverb here.',
        ru: 'Здесь καλά — наречие «хорошо», а не прилагательное «хороший».',
      ),
      greek: 'Καλά.',
    ),
    VocabularyCard(
      id: 'very-well',
      prompt: LocalizedText(en: 'Very well', ru: 'Очень хорошо'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'po-LI ka-LA', ru: 'по-ЛИ ка-ЛА'),
      explanation: LocalizedText(
        en: 'Πολύ intensifies καλά.',
        ru: 'Πολύ — «очень» в этой фразе; сравните русское «очень хорошо».',
      ),
      greek: 'Πολύ καλά.',
    ),
    VocabularyCard(
      id: 'just-fine',
      prompt: LocalizedText(
        en: 'Just fine!',
        ru: 'Всё отлично! (устойчивое выражение)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'mya kha-RA', ru: 'мья ха-РА'),
      explanation: LocalizedText(
        en: 'A natural reply meaning fine/great; literally “a joy.”',
        ru: 'Буквально «одна радость», естественный ответ «всё хорошо/отлично».',
      ),
      greek: 'Μια χαρά!',
    ),
    VocabularyCard(
      id: 'so-so',
      prompt: LocalizedText(en: 'So-so', ru: 'Так себе'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'E-tsi ki E-tsi', ru: 'Э-ци ки Э-ци'),
      explanation: LocalizedText(
        en: 'Κι is the shortened form of και.',
        ru: 'Κι — краткий вариант και («и»); всё выражение значит «так себе».',
      ),
      greek: 'Έτσι κι έτσι.',
      alternatives: ['Έτσι και έτσι.'],
    ),
    VocabularyCard(
      id: 'not-well',
      prompt: LocalizedText(en: 'Not very well', ru: 'Не очень хорошо'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'O-khi po-LI ka-LA',
        ru: 'О-хи по-ЛИ ка-ЛА',
      ),
      explanation: LocalizedText(
        en: 'Όχι negates this short reply; δεν is used before a finite verb.',
        ru: 'В кратком ответе — όχι. Перед личной формой глагола обычно δεν: δεν είμαι…',
      ),
      greek: 'Όχι πολύ καλά.',
    ),
    VocabularyCard(
      id: 'fine-thanks',
      prompt: LocalizedText(en: 'Fine, thank you', ru: 'Хорошо, спасибо'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'ka-LA ef-kha-ri-STO',
        ru: 'ка-ЛА эф-ха-ри-СТО',
      ),
      explanation: LocalizedText(
        en: 'A complete, natural reply to either form of “how are you?”.',
        ru: 'Ответ одинаков на вопросы с «ты» и «Вы»; меняется обращение к собеседнику, не «спасибо».',
      ),
      greek: 'Καλά, ευχαριστώ.',
    ),
    VocabularyCard(
      id: 'and-you',
      prompt: LocalizedText(
        en: 'And you? (informal subject)',
        ru: 'А ты? (с союзом перед местоимением)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ki e-SI', ru: 'ки э-СИ'),
      explanation: LocalizedText(
        en: 'Εσύ is the subject form. Και εσύ is also correct.',
        ru: 'Εσύ — именительный «ты». Και / κι здесь передаёт русское «а».',
      ),
      greek: 'Κι εσύ;',
      alternatives: ['Και εσύ;'],
    ),
    VocabularyCard(
      id: 'and-you-polite',
      prompt: LocalizedText(
        en: 'And you? (polite/plural subject)',
        ru: 'А Вы? (с союзом перед местоимением)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ki e-SIS', ru: 'ки э-СИС'),
      explanation: LocalizedText(
        en: 'Εσείς is subject “you”; do not replace it with σας here.',
        ru: 'Εσείς — «вы» в роли подлежащего. Σας — другие падежные функции, не эта форма.',
      ),
      greek: 'Κι εσείς;',
      alternatives: ['Και εσείς;'],
    ),
  ],
);
