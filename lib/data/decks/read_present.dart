import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const readPresentDeck = VocabularyDeck(
  id: 'read-present',
  title: LocalizedText(
    en: 'To read / study: διαβάζω',
    ru: 'Читать / заниматься: διαβάζω',
  ),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть форм и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Διαβάζω means read, and also study/revise lessons; it is not limited to leisure reading.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Διαβάζω — читать, а также заниматься по учебнику, готовить уроки. Сравните «я читаю» и «я занимаюсь».',
  ),
  cover: 'διαβάζω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I read', ru: 'Я читаю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'διαβάζω',
      pronunciation: LocalizedText(en: 'dhya-VA-zo', ru: 'дья-ВА-зо'),
      explanation: LocalizedText(
        en: 'First person singular. Διαβάζω means read, and also study/revise lessons; it is not limited to leisure reading.',
        ru: 'Первое лицо: я. Διαβάζω — читать, а также заниматься по учебнику, готовить уроки. Сравните «я читаю» и «я занимаюсь».',
      ),
      acceptedAnswers: ['εγώ διαβάζω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) read', ru: 'Ты читаешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'διαβάζεις',
      pronunciation: LocalizedText(en: 'dhya-VA-zis', ru: 'дья-ВА-зис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Διαβάζω means read, and also study/revise lessons; it is not limited to leisure reading.',
        ru: 'Второе лицо: ты. Διαβάζω — читать, а также заниматься по учебнику, готовить уроки. Сравните «я читаю» и «я занимаюсь».',
      ),
      acceptedAnswers: ['εσύ διαβάζεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He reads', ru: 'Он читает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'διαβάζει',
      pronunciation: LocalizedText(en: 'dhya-VA-zi', ru: 'дья-ВА-зи'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Διαβάζω means read, and also study/revise lessons; it is not limited to leisure reading.',
        ru: 'Третье лицо: он; та же форма для она/оно. Διαβάζω — читать, а также заниматься по учебнику, готовить уроки. Сравните «я читаю» и «я занимаюсь».',
      ),
      acceptedAnswers: ['αυτός διαβάζει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We read', ru: 'Мы читаем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'διαβάζουμε',
      pronunciation: LocalizedText(en: 'dhya-VA-zu-me', ru: 'дья-ВА-зу-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Διαβάζω means read, and also study/revise lessons; it is not limited to leisure reading.',
        ru: 'Первое лицо множественного числа: мы. Διαβάζω — читать, а также заниматься по учебнику, готовить уроки. Сравните «я читаю» и «я занимаюсь».',
      ),
      acceptedAnswers: ['εμείς διαβάζουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) read', ru: 'Вы читаете'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'διαβάζετε',
      pronunciation: LocalizedText(en: 'dhya-VA-ze-te', ru: 'дья-ВА-зэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Διαβάζω means read, and also study/revise lessons; it is not limited to leisure reading.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Διαβάζω — читать, а также заниматься по учебнику, готовить уроки. Сравните «я читаю» и «я занимаюсь».',
      ),
      acceptedAnswers: ['εσείς διαβάζετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They read', ru: 'Они читают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'διαβάζουν',
      pronunciation: LocalizedText(en: 'dhya-VA-zun', ru: 'дья-ВА-зун'),
      explanation: LocalizedText(
        en: 'Third person plural. Διαβάζω means read, and also study/revise lessons; it is not limited to leisure reading.',
        ru: 'Третье лицо множественного числа: они. Διαβάζω — читать, а также заниматься по учебнику, готовить уроки. Сравните «я читаю» и «я занимаюсь».',
      ),
      alternatives: ['διαβάζουνε'],
      acceptedAnswers: [
        'αυτοί διαβάζουν',
        'αυτοί διαβάζουνε',
        'αυτές διαβάζουν',
        'αυτές διαβάζουνε',
        'αυτά διαβάζουν',
        'αυτά διαβάζουνε',
      ],
    ),
    VocabularyCard(
      id: 'read-my-book',
      prompt: LocalizedText(en: 'I read my book.', ru: 'Я читаю свою книгу.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Διαβάζω το βιβλίο μου.',
      pronunciation: LocalizedText(
        en: 'dhya-VA-zo to viv-LI-o mu',
        ru: 'дья-ВА-зо то вив-ЛИ-о му',
      ),
      explanation: LocalizedText(
        en: 'Greek uses μου after the noun where Russian naturally uses свой.',
        ru: 'Действующее лицо — «я», поэтому русское «свою» здесь передаём через μου: διαβάζω το βιβλίο μου. С «ты» было бы σου, с «мы» — μας.',
      ),
      acceptedAnswers: ['Εγώ διαβάζω το βιβλίο μου.'],
    ),
    VocabularyCard(
      id: 'read-page',
      prompt: LocalizedText(
        en: 'We read on page eight.',
        ru: 'Мы читаем на восьмой странице.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Διαβάζουμε στη σελίδα οκτώ.',
      pronunciation: LocalizedText(
        en: 'dhya-VA-zu-me sti se-LI-dha ok-TO',
        ru: 'дья-ВА-зу-мэ сти сэ-ЛИ-да ок-ТО',
      ),
      explanation: LocalizedText(
        en: 'Greek labels pages with cardinal numbers: σελίδα οκτώ.',
        ru: 'В русском «на восьмой странице», а в греческом «на странице восемь». Στη = σε + τη.',
      ),
      alternatives: [
        'Διαβάζουμε στη σελίδα οχτώ.',
        'Διαβάζουμε στην σελίδα οκτώ.',
        'Διαβάζουμε στην σελίδα οχτώ.',
      ],
    ),
  ],
);
