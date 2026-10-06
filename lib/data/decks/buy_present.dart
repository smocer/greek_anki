import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const buyPresentDeck = VocabularyDeck(
  id: 'buy-present',
  title: LocalizedText(en: 'To buy: αγοράζω', ru: 'Покупать: αγοράζω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть форм и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Αγοράζω describes buying; πληρώνω describes paying.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Как «покупать» и «платить»: αγοράζω — приобретать, πληρώνω — отдавать деньги. Окончания одинакового типа.',
  ),
  cover: 'αγοράζω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I buy', ru: 'Я покупаю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'αγοράζω',
      pronunciation: LocalizedText(en: 'a-gho-RA-zo', ru: 'а-го-РА-зо'),
      explanation: LocalizedText(
        en: 'First person singular. Αγοράζω describes buying; πληρώνω describes paying.',
        ru: 'Первое лицо: я. Как «покупать» и «платить»: αγοράζω — приобретать, πληρώνω — отдавать деньги. Окончания одинакового типа.',
      ),
      acceptedAnswers: ['εγώ αγοράζω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) buy', ru: 'Ты покупаешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'αγοράζεις',
      pronunciation: LocalizedText(en: 'a-gho-RA-zis', ru: 'а-го-РА-зис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Αγοράζω describes buying; πληρώνω describes paying.',
        ru: 'Второе лицо: ты. Как «покупать» и «платить»: αγοράζω — приобретать, πληρώνω — отдавать деньги. Окончания одинакового типа.',
      ),
      acceptedAnswers: ['εσύ αγοράζεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He buys', ru: 'Он покупает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'αγοράζει',
      pronunciation: LocalizedText(en: 'a-gho-RA-zi', ru: 'а-го-РА-зи'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Αγοράζω describes buying; πληρώνω describes paying.',
        ru: 'Третье лицо: он; та же форма для она/оно. Как «покупать» и «платить»: αγοράζω — приобретать, πληρώνω — отдавать деньги. Окончания одинакового типа.',
      ),
      acceptedAnswers: ['αυτός αγοράζει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We buy', ru: 'Мы покупаем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'αγοράζουμε',
      pronunciation: LocalizedText(en: 'a-gho-RA-zu-me', ru: 'а-го-РА-зу-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Αγοράζω describes buying; πληρώνω describes paying.',
        ru: 'Первое лицо множественного числа: мы. Как «покупать» и «платить»: αγοράζω — приобретать, πληρώνω — отдавать деньги. Окончания одинакового типа.',
      ),
      acceptedAnswers: ['εμείς αγοράζουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) buy', ru: 'Вы покупаете'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'αγοράζετε',
      pronunciation: LocalizedText(en: 'a-gho-RA-ze-te', ru: 'а-го-РА-зэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Αγοράζω describes buying; πληρώνω describes paying.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Как «покупать» и «платить»: αγοράζω — приобретать, πληρώνω — отдавать деньги. Окончания одинакового типа.',
      ),
      acceptedAnswers: ['εσείς αγοράζετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They buy', ru: 'Они покупают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'αγοράζουν',
      pronunciation: LocalizedText(en: 'a-gho-RA-zun', ru: 'а-го-РА-зун'),
      explanation: LocalizedText(
        en: 'Third person plural. Αγοράζω describes buying; πληρώνω describes paying.',
        ru: 'Третье лицо множественного числа: они. Как «покупать» и «платить»: αγοράζω — приобретать, πληρώνω — отдавать деньги. Окончания одинакового типа.',
      ),
      alternatives: ['αγοράζουνε'],
      acceptedAnswers: [
        'αυτοί αγοράζουν',
        'αυτοί αγοράζουνε',
        'αυτές αγοράζουν',
        'αυτές αγοράζουνε',
        'αυτά αγοράζουν',
        'αυτά αγοράζουνε',
      ],
    ),
    VocabularyCard(
      id: 'buy-supermarket',
      prompt: LocalizedText(
        en: 'What do you buy from the supermarket? (informal)',
        ru: 'Что ты покупаешь в супермаркете?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τι αγοράζεις από το σουπερμάρκετ;',
      pronunciation: LocalizedText(
        en: 'ti a-gho-RA-zis a-PO to su-per-MAR-ket',
        ru: 'ти а-го-РА-зис а-ПО то су-пэр-МАР-кэт',
      ),
      explanation: LocalizedText(
        en: 'Από marks the source. The shop name is also written σούπερ μάρκετ.',
        ru: 'Буквально «из супермаркета»: από + винительный το. Вариант написания σούπερ μάρκετ тоже принят.',
      ),
      alternatives: [
        'Τι αγοράζεις από το σούπερ μάρκετ;',
        'Τι αγοράζεις στο σουπερμάρκετ;',
        'Τι αγοράζεις στο σούπερ μάρκετ;',
      ],
    ),
    VocabularyCard(
      id: 'buy-books',
      prompt: LocalizedText(en: 'We buy books.', ru: 'Мы покупаем книги.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Αγοράζουμε βιβλία.',
      pronunciation: LocalizedText(
        en: 'a-gho-RA-zu-me viv-LI-a',
        ru: 'а-го-РА-зу-мэ вив-ЛИ-а',
      ),
      explanation: LocalizedText(
        en: 'An indefinite plural can omit the article.',
        ru: '«Книги вообще», не определённые книги: βιβλία без артикля.',
      ),
      acceptedAnswers: ['Εμείς αγοράζουμε βιβλία.'],
    ),
  ],
);
