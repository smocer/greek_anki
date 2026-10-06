import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const waitPresentDeck = VocabularyDeck(
  id: 'wait-present',
  title: LocalizedText(en: 'To wait: περιμένω', ru: 'Ждать: περιμένω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Περιμένω keeps stress on μέ throughout these present forms.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Во всех этих формах ударение на μέ. Учите περιμένω отдельно от μένω «живу».',
  ),
  cover: 'περιμένω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I wait', ru: 'Я жду'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'περιμένω',
      pronunciation: LocalizedText(en: 'pe-ri-ME-no', ru: 'пэ-ри-МЭ-но'),
      explanation: LocalizedText(
        en: 'First person singular. Περιμένω keeps stress on μέ throughout these present forms.',
        ru: 'Первое лицо: я. Во всех этих формах ударение на μέ. Учите περιμένω отдельно от μένω «живу».',
      ),
      acceptedAnswers: ['εγώ περιμένω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) wait', ru: 'Ты ждёшь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'περιμένεις',
      pronunciation: LocalizedText(en: 'pe-ri-ME-nis', ru: 'пэ-ри-МЭ-нис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Περιμένω keeps stress on μέ throughout these present forms.',
        ru: 'Второе лицо: ты. Во всех этих формах ударение на μέ. Учите περιμένω отдельно от μένω «живу».',
      ),
      acceptedAnswers: ['εσύ περιμένεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He waits', ru: 'Он ждёт'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'περιμένει',
      pronunciation: LocalizedText(en: 'pe-ri-ME-ni', ru: 'пэ-ри-МЭ-ни'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Περιμένω keeps stress on μέ throughout these present forms.',
        ru: 'Третье лицо: он; та же форма для она/оно. Во всех этих формах ударение на μέ. Учите περιμένω отдельно от μένω «живу».',
      ),
      acceptedAnswers: ['αυτός περιμένει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We wait', ru: 'Мы ждём'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'περιμένουμε',
      pronunciation: LocalizedText(en: 'pe-ri-ME-nu-me', ru: 'пэ-ри-МЭ-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Περιμένω keeps stress on μέ throughout these present forms.',
        ru: 'Первое лицо множественного числа: мы. Во всех этих формах ударение на μέ. Учите περιμένω отдельно от μένω «живу».',
      ),
      acceptedAnswers: ['εμείς περιμένουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) wait', ru: 'Вы ждёте'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'περιμένετε',
      pronunciation: LocalizedText(en: 'pe-ri-ME-ne-te', ru: 'пэ-ри-МЭ-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Περιμένω keeps stress on μέ throughout these present forms.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Во всех этих формах ударение на μέ. Учите περιμένω отдельно от μένω «живу».',
      ),
      acceptedAnswers: ['εσείς περιμένετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They wait', ru: 'Они ждут'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'περιμένουν',
      pronunciation: LocalizedText(en: 'pe-ri-ME-nun', ru: 'пэ-ри-МЭ-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. Περιμένω keeps stress on μέ throughout these present forms.',
        ru: 'Третье лицо множественного числа: они. Во всех этих формах ударение на μέ. Учите περιμένω отдельно от μένω «живу».',
      ),
      alternatives: ['περιμένουνε'],
      acceptedAnswers: [
        'αυτοί περιμένουν',
        'αυτοί περιμένουνε',
        'αυτές περιμένουν',
        'αυτές περιμένουνε',
        'αυτά περιμένουν',
        'αυτά περιμένουνε',
      ],
    ),
    VocabularyCard(
      id: 'wait-what',
      prompt: LocalizedText(
        en: 'What are you waiting for? (informal)',
        ru: 'Чего ты ждёшь?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τι περιμένεις;',
      pronunciation: LocalizedText(
        en: 'ti pe-ri-ME-nis',
        ru: 'ти пэ-ри-МЭ-нис',
      ),
      explanation: LocalizedText(
        en: 'Greek needs no equivalent of English for here.',
        ru: 'В русском «чего ждёшь?», по-гречески просто τι περιμένεις, без предлога.',
      ),
    ),
    VocabularyCard(
      id: 'wait-maria',
      prompt: LocalizedText(en: 'I am waiting for Maria.', ru: 'Я жду Марию.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Περιμένω τη Μαρία.',
      pronunciation: LocalizedText(
        en: 'pe-ri-ME-no ti ma-RI-a',
        ru: 'пэ-ри-МЭ-но ти ма-РИ-а',
      ),
      explanation: LocalizedText(
        en: 'The object is accusative: η Μαρία → τη Μαρία.',
        ru: 'Как «жду Марию»: имя — дополнение, η → τη. Перед μ обычно без конечного ν.',
      ),
      alternatives: ['Περιμένω την Μαρία.'],
      acceptedAnswers: ['Εγώ περιμένω τη Μαρία.', 'Εγώ περιμένω την Μαρία.'],
    ),
  ],
);
