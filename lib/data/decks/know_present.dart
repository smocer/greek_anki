import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const knowPresentDeck = VocabularyDeck(
  id: 'know-present',
  title: LocalizedText(en: 'To know: ξέρω', ru: 'Знать: ξέρω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть форм и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Ξέρω is know; καταλαβαίνω is understand. Ξ is /ks/.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Как русские «знать» и «понимать», ξέρω и καταλαβαίνω различаются. Ξ — один знак для «кс».',
  ),
  cover: 'ξέρω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I know', ru: 'Я знаю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ξέρω',
      pronunciation: LocalizedText(en: 'KSE-ro', ru: 'КСЭ-ро'),
      explanation: LocalizedText(
        en: 'First person singular. Ξέρω is know; καταλαβαίνω is understand. Ξ is /ks/.',
        ru: 'Первое лицо: я. Как русские «знать» и «понимать», ξέρω и καταλαβαίνω различаются. Ξ — один знак для «кс».',
      ),
      acceptedAnswers: ['εγώ ξέρω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) know', ru: 'Ты знаешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ξέρεις',
      pronunciation: LocalizedText(en: 'KSE-ris', ru: 'КСЭ-рис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Ξέρω is know; καταλαβαίνω is understand. Ξ is /ks/.',
        ru: 'Второе лицо: ты. Как русские «знать» и «понимать», ξέρω и καταλαβαίνω различаются. Ξ — один знак для «кс».',
      ),
      acceptedAnswers: ['εσύ ξέρεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He knows', ru: 'Он знает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ξέρει',
      pronunciation: LocalizedText(en: 'KSE-ri', ru: 'КСЭ-ри'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Ξέρω is know; καταλαβαίνω is understand. Ξ is /ks/.',
        ru: 'Третье лицо: он; та же форма для она/оно. Как русские «знать» и «понимать», ξέρω и καταλαβαίνω различаются. Ξ — один знак для «кс».',
      ),
      acceptedAnswers: ['αυτός ξέρει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We know', ru: 'Мы знаем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ξέρουμε',
      pronunciation: LocalizedText(en: 'KSE-ru-me', ru: 'КСЭ-ру-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Ξέρω is know; καταλαβαίνω is understand. Ξ is /ks/.',
        ru: 'Первое лицо множественного числа: мы. Как русские «знать» и «понимать», ξέρω и καταλαβαίνω различаются. Ξ — один знак для «кс».',
      ),
      acceptedAnswers: ['εμείς ξέρουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) know', ru: 'Вы знаете'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ξέρετε',
      pronunciation: LocalizedText(en: 'KSE-re-te', ru: 'КСЭ-рэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Ξέρω is know; καταλαβαίνω is understand. Ξ is /ks/.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Как русские «знать» и «понимать», ξέρω и καταλαβαίνω различаются. Ξ — один знак для «кс».',
      ),
      acceptedAnswers: ['εσείς ξέρετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They know', ru: 'Они знают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ξέρουν',
      pronunciation: LocalizedText(en: 'KSE-run', ru: 'КСЭ-рун'),
      explanation: LocalizedText(
        en: 'Third person plural. Ξέρω is know; καταλαβαίνω is understand. Ξ is /ks/.',
        ru: 'Третье лицо множественного числа: они. Как русские «знать» и «понимать», ξέρω и καταλαβαίνω различаются. Ξ — один знак для «кс».',
      ),
      alternatives: ['ξέρουνε'],
      acceptedAnswers: [
        'αυτοί ξέρουν',
        'αυτοί ξέρουνε',
        'αυτές ξέρουν',
        'αυτές ξέρουνε',
        'αυτά ξέρουν',
        'αυτά ξέρουνε',
      ],
    ),
    VocabularyCard(
      id: 'know-english',
      prompt: LocalizedText(en: 'I know English.', ru: 'Я знаю английский.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ξέρω αγγλικά.',
      pronunciation: LocalizedText(
        en: 'KSE-ro an-gli-KA',
        ru: 'КСЭ-ро ан-гли-КА',
      ),
      explanation: LocalizedText(
        en: 'Knowing a language uses ξέρω + its name.',
        ru: 'Название языка αγγλικά здесь без артикля, как ελληνικά после μαθαίνω.',
      ),
      acceptedAnswers: ['Εγώ ξέρω αγγλικά.'],
    ),
    VocabularyCard(
      id: 'not-know-say',
      prompt: LocalizedText(
        en: 'I do not know what they are saying.',
        ru: 'Я не знаю, что они говорят.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Δεν ξέρω τι λένε.',
      pronunciation: LocalizedText(
        en: 'dhen KSE-ro ti LE-ne',
        ru: 'дэн КСЭ-ро ти ЛЭ-нэ',
      ),
      explanation: LocalizedText(
        en: 'Δεν negates ξέρω; λένε means they say.',
        ru: 'Как «не знаю»: δεν перед глаголом. Λένε — «они говорят», знакомая форма из Με λένε «меня зовут».',
      ),
      alternatives: ['Δε ξέρω τι λένε.'],
      acceptedAnswers: ['Εγώ δεν ξέρω τι λένε.', 'Εγώ δε ξέρω τι λένε.'],
    ),
  ],
);
