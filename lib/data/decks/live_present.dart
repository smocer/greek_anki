import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const livePresentDeck = VocabularyDeck(
  id: 'live-present',
  title: LocalizedText(
    en: 'To live / stay: μένω',
    ru: 'Жить / оставаться: μένω',
  ),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть форм и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Μένω describes where you live or stay; use σε + article for the place.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Μένω — жить или оставаться; для места — σε с артиклем и винительным, хотя по-русски «в городе» — предложный.',
  ),
  cover: 'μένω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I live / stay', ru: 'Я живу'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μένω',
      pronunciation: LocalizedText(en: 'ME-no', ru: 'МЭ-но'),
      explanation: LocalizedText(
        en: 'First person singular. Μένω describes where you live or stay; use σε + article for the place.',
        ru: 'Первое лицо: я. Μένω — жить или оставаться; для места — σε с артиклем и винительным, хотя по-русски «в городе» — предложный.',
      ),
      acceptedAnswers: ['εγώ μένω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) live', ru: 'Ты живёшь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μένεις',
      pronunciation: LocalizedText(en: 'ME-nis', ru: 'МЭ-нис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Μένω describes where you live or stay; use σε + article for the place.',
        ru: 'Второе лицо: ты. Μένω — жить или оставаться; для места — σε с артиклем и винительным, хотя по-русски «в городе» — предложный.',
      ),
      acceptedAnswers: ['εσύ μένεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He lives', ru: 'Он живёт'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μένει',
      pronunciation: LocalizedText(en: 'ME-ni', ru: 'МЭ-ни'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Μένω describes where you live or stay; use σε + article for the place.',
        ru: 'Третье лицо: он; та же форма для она/оно. Μένω — жить или оставаться; для места — σε с артиклем и винительным, хотя по-русски «в городе» — предложный.',
      ),
      acceptedAnswers: ['αυτός μένει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We live', ru: 'Мы живём'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μένουμε',
      pronunciation: LocalizedText(en: 'ME-nu-me', ru: 'МЭ-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Μένω describes where you live or stay; use σε + article for the place.',
        ru: 'Первое лицо множественного числа: мы. Μένω — жить или оставаться; для места — σε с артиклем и винительным, хотя по-русски «в городе» — предложный.',
      ),
      acceptedAnswers: ['εμείς μένουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) live', ru: 'Вы живёте'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μένετε',
      pronunciation: LocalizedText(en: 'ME-ne-te', ru: 'МЭ-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Μένω describes where you live or stay; use σε + article for the place.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Μένω — жить или оставаться; для места — σε с артиклем и винительным, хотя по-русски «в городе» — предложный.',
      ),
      acceptedAnswers: ['εσείς μένετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They live', ru: 'Они живут'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μένουν',
      pronunciation: LocalizedText(en: 'ME-nun', ru: 'МЭ-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. Μένω describes where you live or stay; use σε + article for the place.',
        ru: 'Третье лицо множественного числа: они. Μένω — жить или оставаться; для места — σε с артиклем и винительным, хотя по-русски «в городе» — предложный.',
      ),
      alternatives: ['μένουνε'],
      acceptedAnswers: [
        'αυτοί μένουν',
        'αυτοί μένουνε',
        'αυτές μένουν',
        'αυτές μένουνε',
        'αυτά μένουν',
        'αυτά μένουνε',
      ],
    ),
    VocabularyCard(
      id: 'ask-live',
      prompt: LocalizedText(
        en: 'Where do you live? (informal)',
        ru: 'Где ты живёшь?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πού μένεις;',
      pronunciation: LocalizedText(en: 'pu ME-nis', ru: 'пу МЭ-нис'),
      explanation: LocalizedText(
        en: 'Πού asks where; -εις addresses one person informally.',
        ru: 'Πού «где» пишется с ударением даже в одном слоге. Μένεις соответствует «ты живёшь».',
      ),
      acceptedAnswers: ['Εσύ πού μένεις;', 'Πού μένεις εσύ;'],
    ),
    VocabularyCard(
      id: 'we-here',
      prompt: LocalizedText(en: 'We live here.', ru: 'Мы живём здесь.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένουμε εδώ.',
      pronunciation: LocalizedText(en: 'ME-nu-me e-DHO', ru: 'МЭ-ну-мэ э-ДО'),
      explanation: LocalizedText(
        en: 'Εδώ needs no preposition or article.',
        ru: 'Как «живём здесь», без предлога σε: μένουμε εδώ. -ουμε показывает «мы».',
      ),
      acceptedAnswers: ['Εμείς μένουμε εδώ.'],
    ),
  ],
);
