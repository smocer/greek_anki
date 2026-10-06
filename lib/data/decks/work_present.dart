import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const workPresentDeck = VocabularyDeck(
  id: 'work-present',
  title: LocalizedText(en: 'To work: δουλεύω', ru: 'Работать: δουλεύω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Εύ before a vowel sounds /ev/; ου sounds /u/.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Δουλεύω читается примерно «дулэво»: ου = «у», εύ перед гласной = «эв».',
  ),
  cover: 'δουλεύω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I work', ru: 'Я работаю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'δουλεύω',
      pronunciation: LocalizedText(en: 'dhu-LE-vo', ru: 'ду-ЛЭ-во'),
      explanation: LocalizedText(
        en: 'First person singular. Εύ before a vowel sounds /ev/; ου sounds /u/.',
        ru: 'Первое лицо: я. Δουλεύω читается примерно «дулэво»: ου = «у», εύ перед гласной = «эв».',
      ),
      acceptedAnswers: ['εγώ δουλεύω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) work', ru: 'Ты работаешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'δουλεύεις',
      pronunciation: LocalizedText(en: 'dhu-LE-vis', ru: 'ду-ЛЭ-вис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Εύ before a vowel sounds /ev/; ου sounds /u/.',
        ru: 'Второе лицо: ты. Δουλεύω читается примерно «дулэво»: ου = «у», εύ перед гласной = «эв».',
      ),
      acceptedAnswers: ['εσύ δουλεύεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He works', ru: 'Он работает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'δουλεύει',
      pronunciation: LocalizedText(en: 'dhu-LE-vi', ru: 'ду-ЛЭ-ви'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Εύ before a vowel sounds /ev/; ου sounds /u/.',
        ru: 'Третье лицо: он; та же форма для она/оно. Δουλεύω читается примерно «дулэво»: ου = «у», εύ перед гласной = «эв».',
      ),
      acceptedAnswers: ['αυτός δουλεύει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We work', ru: 'Мы работаем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'δουλεύουμε',
      pronunciation: LocalizedText(en: 'dhu-LE-vu-me', ru: 'ду-ЛЭ-ву-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Εύ before a vowel sounds /ev/; ου sounds /u/.',
        ru: 'Первое лицо множественного числа: мы. Δουλεύω читается примерно «дулэво»: ου = «у», εύ перед гласной = «эв».',
      ),
      acceptedAnswers: ['εμείς δουλεύουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) work', ru: 'Вы работаете'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'δουλεύετε',
      pronunciation: LocalizedText(en: 'dhu-LE-ve-te', ru: 'ду-ЛЭ-вэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Εύ before a vowel sounds /ev/; ου sounds /u/.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Δουλεύω читается примерно «дулэво»: ου = «у», εύ перед гласной = «эв».',
      ),
      acceptedAnswers: ['εσείς δουλεύετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They work', ru: 'Они работают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'δουλεύουν',
      pronunciation: LocalizedText(en: 'dhu-LE-vun', ru: 'ду-ЛЭ-вун'),
      explanation: LocalizedText(
        en: 'Third person plural. Εύ before a vowel sounds /ev/; ου sounds /u/.',
        ru: 'Третье лицо множественного числа: они. Δουλεύω читается примерно «дулэво»: ου = «у», εύ перед гласной = «эв».',
      ),
      alternatives: ['δουλεύουνε'],
      acceptedAnswers: [
        'αυτοί δουλεύουν',
        'αυτοί δουλεύουνε',
        'αυτές δουλεύουν',
        'αυτές δουλεύουνε',
        'αυτά δουλεύουν',
        'αυτά δουλεύουνε',
      ],
    ),
    VocabularyCard(
      id: 'work-bank',
      prompt: LocalizedText(
        en: 'I work at the bank.',
        ru: 'Я работаю в банке.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Δουλεύω στην τράπεζα.',
      pronunciation: LocalizedText(
        en: 'dhu-LE-vo stin TRA-pe-za',
        ru: 'ду-ЛЭ-во стин ТРА-пэ-за',
      ),
      explanation: LocalizedText(
        en: 'Keep ν before τ in στην τράπεζα.',
        ru: 'Русское «в банке» — предложный; греческое στην τράπεζα — винительный после σε.',
      ),
      acceptedAnswers: ['Εγώ δουλεύω στην τράπεζα.'],
    ),
    VocabularyCard(
      id: 'where-work',
      prompt: LocalizedText(
        en: 'Where do you work? (polite/plural)',
        ru: 'Где Вы работаете?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πού δουλεύετε;',
      pronunciation: LocalizedText(en: 'pu dhu-LE-ve-te', ru: 'пу ду-ЛЭ-вэ-тэ'),
      explanation: LocalizedText(
        en: 'The -ετε form addresses a group or one person politely.',
        ru: 'Как русское «работаете»: и множественное число, и вежливое Вы.',
      ),
      acceptedAnswers: ['Εσείς πού δουλεύετε;', 'Πού δουλεύετε εσείς;'],
    ),
  ],
);
