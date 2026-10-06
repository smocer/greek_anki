import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const closePresentDeck = VocabularyDeck(
  id: 'close-present',
  title: LocalizedText(en: 'To close: κλείνω', ru: 'Закрывать: κλείνω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть форм и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Κλείνω is the opposite of ανοίγω; ει sounds /i/.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Κλείνω — закрываю, ανοίγω — открываю. В κλείνω сочетание εί даёт один ударный «и».',
  ),
  cover: 'κλείνω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I close', ru: 'Я закрываю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κλείνω',
      pronunciation: LocalizedText(en: 'KLI-no', ru: 'КЛИ-но'),
      explanation: LocalizedText(
        en: 'First person singular. Κλείνω is the opposite of ανοίγω; ει sounds /i/.',
        ru: 'Первое лицо: я. Κλείνω — закрываю, ανοίγω — открываю. В κλείνω сочетание εί даёт один ударный «и».',
      ),
      acceptedAnswers: ['εγώ κλείνω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) close', ru: 'Ты закрываешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κλείνεις',
      pronunciation: LocalizedText(en: 'KLI-nis', ru: 'КЛИ-нис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Κλείνω is the opposite of ανοίγω; ει sounds /i/.',
        ru: 'Второе лицо: ты. Κλείνω — закрываю, ανοίγω — открываю. В κλείνω сочетание εί даёт один ударный «и».',
      ),
      acceptedAnswers: ['εσύ κλείνεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He closes', ru: 'Он закрывает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κλείνει',
      pronunciation: LocalizedText(en: 'KLI-ni', ru: 'КЛИ-ни'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Κλείνω is the opposite of ανοίγω; ει sounds /i/.',
        ru: 'Третье лицо: он; та же форма для она/оно. Κλείνω — закрываю, ανοίγω — открываю. В κλείνω сочетание εί даёт один ударный «и».',
      ),
      acceptedAnswers: ['αυτός κλείνει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We close', ru: 'Мы закрываем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κλείνουμε',
      pronunciation: LocalizedText(en: 'KLI-nu-me', ru: 'КЛИ-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Κλείνω is the opposite of ανοίγω; ει sounds /i/.',
        ru: 'Первое лицо множественного числа: мы. Κλείνω — закрываю, ανοίγω — открываю. В κλείνω сочетание εί даёт один ударный «и».',
      ),
      acceptedAnswers: ['εμείς κλείνουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) close',
        ru: 'Вы закрываете',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κλείνετε',
      pronunciation: LocalizedText(en: 'KLI-ne-te', ru: 'КЛИ-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Κλείνω is the opposite of ανοίγω; ει sounds /i/.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Κλείνω — закрываю, ανοίγω — открываю. В κλείνω сочетание εί даёт один ударный «и».',
      ),
      acceptedAnswers: ['εσείς κλείνετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They close', ru: 'Они закрывают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κλείνουν',
      pronunciation: LocalizedText(en: 'KLI-nun', ru: 'КЛИ-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. Κλείνω is the opposite of ανοίγω; ει sounds /i/.',
        ru: 'Третье лицо множественного числа: они. Κλείνω — закрываю, ανοίγω — открываю. В κλείνω сочетание εί даёт один ударный «и».',
      ),
      alternatives: ['κλείνουνε'],
      acceptedAnswers: [
        'αυτοί κλείνουν',
        'αυτοί κλείνουνε',
        'αυτές κλείνουν',
        'αυτές κλείνουνε',
        'αυτά κλείνουν',
        'αυτά κλείνουνε',
      ],
    ),
    VocabularyCard(
      id: 'bank-closes',
      prompt: LocalizedText(
        en: 'The bank closes at two.',
        ru: 'Банк закрывается в два.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Η τράπεζα κλείνει στις δύο.',
      pronunciation: LocalizedText(
        en: 'i TRA-pe-za KLI-ni stis DHI-o',
        ru: 'и ТРА-пэ-за КЛИ-ни стис ДИ-о',
      ),
      explanation: LocalizedText(
        en: 'A singular bank takes κλείνει; the hour follows στις.',
        ru: 'Η τράπεζα — единственное число, поэтому κλείνει, не κλείνουν. Στις δύο — в два часа.',
      ),
    ),
    VocabularyCard(
      id: 'close-book',
      prompt: LocalizedText(en: 'I close the book.', ru: 'Я закрываю книгу.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Κλείνω το βιβλίο.',
      pronunciation: LocalizedText(
        en: 'KLI-no to viv-LI-o',
        ru: 'КЛИ-но то вив-ЛИ-о',
      ),
      explanation: LocalizedText(
        en: 'Το βιβλίο is the accusative object.',
        ru: 'Как «закрываю что? книгу», винительный; средний род το βιβλίο не меняет форму.',
      ),
      acceptedAnswers: ['Εγώ κλείνω το βιβλίο.'],
    ),
  ],
);
