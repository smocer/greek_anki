import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const understandPresentDeck = VocabularyDeck(
  id: 'understand-present',
  title: LocalizedText(
    en: 'To understand: καταλαβαίνω',
    ru: 'Понимать: καταλαβαίνω',
  ),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Keep stress on βαί; αι is one /e/ sound.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Во всех этих формах ударение на βαί: «вэ». Αι читается «э», а β — «в», не «б».',
  ),
  cover: 'καταλαβαίνω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I understand', ru: 'Я понимаю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'καταλαβαίνω',
      pronunciation: LocalizedText(en: 'ka-ta-la-VE-no', ru: 'ка-та-ла-ВЭ-но'),
      explanation: LocalizedText(
        en: 'First person singular. Keep stress on βαί; αι is one /e/ sound.',
        ru: 'Первое лицо: я. Во всех этих формах ударение на βαί: «вэ». Αι читается «э», а β — «в», не «б».',
      ),
      acceptedAnswers: ['εγώ καταλαβαίνω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(
        en: 'You (informal) understand',
        ru: 'Ты понимаешь',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'καταλαβαίνεις',
      pronunciation: LocalizedText(
        en: 'ka-ta-la-VE-nis',
        ru: 'ка-та-ла-ВЭ-нис',
      ),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Keep stress on βαί; αι is one /e/ sound.',
        ru: 'Второе лицо: ты. Во всех этих формах ударение на βαί: «вэ». Αι читается «э», а β — «в», не «б».',
      ),
      acceptedAnswers: ['εσύ καταλαβαίνεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He understands', ru: 'Он понимает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'καταλαβαίνει',
      pronunciation: LocalizedText(en: 'ka-ta-la-VE-ni', ru: 'ка-та-ла-ВЭ-ни'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Keep stress on βαί; αι is one /e/ sound.',
        ru: 'Третье лицо: он; та же форма для она/оно. Во всех этих формах ударение на βαί: «вэ». Αι читается «э», а β — «в», не «б».',
      ),
      acceptedAnswers: ['αυτός καταλαβαίνει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We understand', ru: 'Мы понимаем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'καταλαβαίνουμε',
      pronunciation: LocalizedText(
        en: 'ka-ta-la-VE-nu-me',
        ru: 'ка-та-ла-ВЭ-ну-мэ',
      ),
      explanation: LocalizedText(
        en: 'First person plural. Keep stress on βαί; αι is one /e/ sound.',
        ru: 'Первое лицо множественного числа: мы. Во всех этих формах ударение на βαί: «вэ». Αι читается «э», а β — «в», не «б».',
      ),
      acceptedAnswers: ['εμείς καταλαβαίνουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) understand',
        ru: 'Вы / вы понимаете',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'καταλαβαίνετε',
      pronunciation: LocalizedText(
        en: 'ka-ta-la-VE-ne-te',
        ru: 'ка-та-ла-ВЭ-нэ-тэ',
      ),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Keep stress on βαί; αι is one /e/ sound.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Во всех этих формах ударение на βαί: «вэ». Αι читается «э», а β — «в», не «б».',
      ),
      acceptedAnswers: ['εσείς καταλαβαίνετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They understand', ru: 'Они понимают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'καταλαβαίνουν',
      pronunciation: LocalizedText(
        en: 'ka-ta-la-VE-nun',
        ru: 'ка-та-ла-ВЭ-нун',
      ),
      explanation: LocalizedText(
        en: 'Third person plural. Keep stress on βαί; αι is one /e/ sound.',
        ru: 'Третье лицо множественного числа: они. Во всех этих формах ударение на βαί: «вэ». Αι читается «э», а β — «в», не «б».',
      ),
      alternatives: ['καταλαβαίνουνε'],
      acceptedAnswers: [
        'αυτοί καταλαβαίνουν',
        'αυτοί καταλαβαίνουνε',
        'αυτές καταλαβαίνουν',
        'αυτές καταλαβαίνουνε',
        'αυτά καταλαβαίνουν',
        'αυτά καταλαβαίνουνε',
      ],
    ),
    VocabularyCard(
      id: 'understand-say',
      prompt: LocalizedText(
        en: 'Do you understand what they are saying? (informal)',
        ru: 'Ты понимаешь, что они говорят?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Καταλαβαίνεις τι λένε;',
      pronunciation: LocalizedText(
        en: 'ka-ta-la-VE-nis ti LE-ne',
        ru: 'ка-та-ла-ВЭ-нис ти ЛЭ-нэ',
      ),
      explanation: LocalizedText(
        en: 'The listener is singular (-εις), the speakers are plural (λένε).',
        ru: '«Ты понимаешь» — καταλαβαίνεις; «они говорят» — λένε. Разные лица в одной фразе.',
      ),
    ),
    VocabularyCard(
      id: 'we-not-understand',
      prompt: LocalizedText(en: 'We do not understand.', ru: 'Мы не понимаем.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Δεν καταλαβαίνουμε.',
      pronunciation: LocalizedText(
        en: 'dhen ka-ta-la-VE-nu-me',
        ru: 'дэн ка-та-ла-ВЭ-ну-мэ',
      ),
      explanation: LocalizedText(
        en: 'Keep ν in δεν before κ; -ουμε marks we.',
        ru: 'Перед κ сохраняем ν в δεν. Окончание -ουμε обозначает «мы».',
      ),
      acceptedAnswers: ['Εμείς δεν καταλαβαίνουμε.'],
    ),
  ],
);
