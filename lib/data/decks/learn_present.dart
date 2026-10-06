import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const learnPresentDeck = VocabularyDeck(
  id: 'learn-present',
  title: LocalizedText(
    en: 'To learn: μαθαίνω',
    ru: 'Учить / осваивать: μαθαίνω',
  ),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть форм и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Μαθαίνω means acquire knowledge or a skill; it can also mean find out.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Μαθαίνω — усваивать знания, учить язык, осваивать навык; также «узнавать». Это шире, чем учёба в вузе: σπουδάζω.',
  ),
  cover: 'μαθαίνω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I learn', ru: 'Я учусь / осваиваю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μαθαίνω',
      pronunciation: LocalizedText(en: 'ma-THE-no', ru: 'ма-ТЭ-но'),
      explanation: LocalizedText(
        en: 'First person singular. Μαθαίνω means acquire knowledge or a skill; it can also mean find out.',
        ru: 'Первое лицо: я. Μαθαίνω — усваивать знания, учить язык, осваивать навык; также «узнавать». Это шире, чем учёба в вузе: σπουδάζω.',
      ),
      acceptedAnswers: ['εγώ μαθαίνω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(
        en: 'You (informal) learn',
        ru: 'Ты учишься / осваиваешь',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μαθαίνεις',
      pronunciation: LocalizedText(en: 'ma-THE-nis', ru: 'ма-ТЭ-нис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Μαθαίνω means acquire knowledge or a skill; it can also mean find out.',
        ru: 'Второе лицо: ты. Μαθαίνω — усваивать знания, учить язык, осваивать навык; также «узнавать». Это шире, чем учёба в вузе: σπουδάζω.',
      ),
      acceptedAnswers: ['εσύ μαθαίνεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He learns', ru: 'Он учится / осваивает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μαθαίνει',
      pronunciation: LocalizedText(en: 'ma-THE-ni', ru: 'ма-ТЭ-ни'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Μαθαίνω means acquire knowledge or a skill; it can also mean find out.',
        ru: 'Третье лицо: он; та же форма для она/оно. Μαθαίνω — усваивать знания, учить язык, осваивать навык; также «узнавать». Это шире, чем учёба в вузе: σπουδάζω.',
      ),
      acceptedAnswers: ['αυτός μαθαίνει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We learn', ru: 'Мы учимся / осваиваем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μαθαίνουμε',
      pronunciation: LocalizedText(en: 'ma-THE-nu-me', ru: 'ма-ТЭ-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Μαθαίνω means acquire knowledge or a skill; it can also mean find out.',
        ru: 'Первое лицо множественного числа: мы. Μαθαίνω — усваивать знания, учить язык, осваивать навык; также «узнавать». Это шире, чем учёба в вузе: σπουδάζω.',
      ),
      acceptedAnswers: ['εμείς μαθαίνουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) learn',
        ru: 'Вы учитесь / осваиваете',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μαθαίνετε',
      pronunciation: LocalizedText(en: 'ma-THE-ne-te', ru: 'ма-ТЭ-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Μαθαίνω means acquire knowledge or a skill; it can also mean find out.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Μαθαίνω — усваивать знания, учить язык, осваивать навык; также «узнавать». Это шире, чем учёба в вузе: σπουδάζω.',
      ),
      acceptedAnswers: ['εσείς μαθαίνετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They learn', ru: 'Они учатся / осваивают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μαθαίνουν',
      pronunciation: LocalizedText(en: 'ma-THE-nun', ru: 'ма-ТЭ-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. Μαθαίνω means acquire knowledge or a skill; it can also mean find out.',
        ru: 'Третье лицо множественного числа: они. Μαθαίνω — усваивать знания, учить язык, осваивать навык; также «узнавать». Это шире, чем учёба в вузе: σπουδάζω.',
      ),
      alternatives: ['μαθαίνουνε'],
      acceptedAnswers: [
        'αυτοί μαθαίνουν',
        'αυτοί μαθαίνουνε',
        'αυτές μαθαίνουν',
        'αυτές μαθαίνουνε',
        'αυτά μαθαίνουν',
        'αυτά μαθαίνουνε',
      ],
    ),
    VocabularyCard(
      id: 'learn-greek',
      prompt: LocalizedText(en: 'We learn Greek.', ru: 'Мы учим греческий.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μαθαίνουμε ελληνικά.',
      pronunciation: LocalizedText(
        en: 'ma-THE-nu-me e-li-ni-KA',
        ru: 'ма-ТЭ-ну-мэ э-ли-ни-КА',
      ),
      explanation: LocalizedText(
        en: 'Language names commonly appear without an article after μαθαίνω.',
        ru: 'Ελληνικά — название языка во множественном числе; в этой фразе без артикля.',
      ),
      acceptedAnswers: ['Εμείς μαθαίνουμε ελληνικά.'],
    ),
    VocabularyCard(
      id: 'learning-question',
      prompt: LocalizedText(
        en: 'Are you learning Greek? (informal)',
        ru: 'Ты учишь греческий?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μαθαίνεις ελληνικά;',
      pronunciation: LocalizedText(
        en: 'ma-THE-nis e-li-ni-KA',
        ru: 'ма-ТЭ-нис э-ли-ни-КА',
      ),
      explanation: LocalizedText(
        en: 'The present covers both learn and are learning.',
        ru: 'Отдельного времени для «учишь сейчас» не нужно: настоящее μαθαίνεις подходит и для процесса.',
      ),
      acceptedAnswers: ['Εσύ μαθαίνεις ελληνικά;'],
    ),
  ],
);
