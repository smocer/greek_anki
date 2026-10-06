import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const payPresentDeck = VocabularyDeck(
  id: 'pay-present',
  title: LocalizedText(en: 'To pay: πληρώνω', ru: 'Платить: πληρώνω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Πληρώνω is pay money, not cry.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. «Я плачу́» здесь от «платить», не «пла́чу» от «плакать». В πληρώνω ударение на ρώ.',
  ),
  cover: 'πληρώνω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I pay', ru: 'Я плачу (деньги)'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πληρώνω',
      pronunciation: LocalizedText(en: 'pli-RO-no', ru: 'пли-РО-но'),
      explanation: LocalizedText(
        en: 'First person singular. Πληρώνω is pay money, not cry.',
        ru: 'Первое лицо: я. «Я плачу́» здесь от «платить», не «пла́чу» от «плакать». В πληρώνω ударение на ρώ.',
      ),
      acceptedAnswers: ['εγώ πληρώνω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) pay', ru: 'Ты платишь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πληρώνεις',
      pronunciation: LocalizedText(en: 'pli-RO-nis', ru: 'пли-РО-нис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Πληρώνω is pay money, not cry.',
        ru: 'Второе лицо: ты. «Я плачу́» здесь от «платить», не «пла́чу» от «плакать». В πληρώνω ударение на ρώ.',
      ),
      acceptedAnswers: ['εσύ πληρώνεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He pays', ru: 'Он платит'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πληρώνει',
      pronunciation: LocalizedText(en: 'pli-RO-ni', ru: 'пли-РО-ни'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Πληρώνω is pay money, not cry.',
        ru: 'Третье лицо: он; та же форма для она/оно. «Я плачу́» здесь от «платить», не «пла́чу» от «плакать». В πληρώνω ударение на ρώ.',
      ),
      acceptedAnswers: ['αυτός πληρώνει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We pay', ru: 'Мы платим'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πληρώνουμε',
      pronunciation: LocalizedText(en: 'pli-RO-nu-me', ru: 'пли-РО-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Πληρώνω is pay money, not cry.',
        ru: 'Первое лицо множественного числа: мы. «Я плачу́» здесь от «платить», не «пла́чу» от «плакать». В πληρώνω ударение на ρώ.',
      ),
      acceptedAnswers: ['εμείς πληρώνουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) pay', ru: 'Вы платите'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πληρώνετε',
      pronunciation: LocalizedText(en: 'pli-RO-ne-te', ru: 'пли-РО-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Πληρώνω is pay money, not cry.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. «Я плачу́» здесь от «платить», не «пла́чу» от «плакать». В πληρώνω ударение на ρώ.',
      ),
      acceptedAnswers: ['εσείς πληρώνετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They pay', ru: 'Они платят'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πληρώνουν',
      pronunciation: LocalizedText(en: 'pli-RO-nun', ru: 'пли-РО-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. Πληρώνω is pay money, not cry.',
        ru: 'Третье лицо множественного числа: они. «Я плачу́» здесь от «платить», не «пла́чу» от «плакать». В πληρώνω ударение на ρώ.',
      ),
      alternatives: ['πληρώνουνε'],
      acceptedAnswers: [
        'αυτοί πληρώνουν',
        'αυτοί πληρώνουνε',
        'αυτές πληρώνουν',
        'αυτές πληρώνουνε',
        'αυτά πληρώνουν',
        'αυτά πληρώνουνε',
      ],
    ),
    VocabularyCard(
      id: 'pay-now',
      prompt: LocalizedText(en: 'I pay now.', ru: 'Я плачу сейчас.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πληρώνω τώρα.',
      pronunciation: LocalizedText(
        en: 'pli-RO-no TO-ra',
        ru: 'пли-РО-но ТО-ра',
      ),
      explanation: LocalizedText(
        en: 'Τώρα is now; it does not change the verb ending.',
        ru: 'Τώρα — «сейчас»; настоящее πληρώνω уже подходит для текущего действия.',
      ),
      acceptedAnswers: ['Εγώ πληρώνω τώρα.'],
    ),
    VocabularyCard(
      id: 'pay-bill',
      prompt: LocalizedText(en: 'We pay the bill.', ru: 'Мы оплачиваем счёт.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πληρώνουμε τον λογαριασμό.',
      pronunciation: LocalizedText(
        en: 'pli-RO-nu-me ton lo-gha-ria-ZMO',
        ru: 'пли-РО-ну-мэ тон ло-га-рья-ЗМО',
      ),
      explanation: LocalizedText(
        en: 'Ο λογαριασμός becomes τον λογαριασμό as the object.',
        ru: '«Оплачиваем что?» — винительный. Мужской род: ο λογαριασμός → τον λογαριασμό, без конечного -ς.',
      ),
      acceptedAnswers: ['Εμείς πληρώνουμε τον λογαριασμό.'],
    ),
  ],
);
