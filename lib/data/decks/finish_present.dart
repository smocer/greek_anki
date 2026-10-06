import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const finishPresentDeck = VocabularyDeck(
  id: 'finish-present',
  title: LocalizedText(en: 'To finish: τελειώνω', ru: 'Заканчивать: τελειώνω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть форм и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Τελειώνω can mean finish something or come to an end.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Как «заканчивать» и «заканчиваться»: τελειώνω подходит и человеку, и уроку. В настоящем ударение на ώ.',
  ),
  cover: 'τελειώνω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I finish', ru: 'Я заканчиваю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τελειώνω',
      pronunciation: LocalizedText(en: 'te-li-O-no', ru: 'тэ-ли-О-но'),
      explanation: LocalizedText(
        en: 'First person singular. Τελειώνω can mean finish something or come to an end.',
        ru: 'Первое лицо: я. Как «заканчивать» и «заканчиваться»: τελειώνω подходит и человеку, и уроку. В настоящем ударение на ώ.',
      ),
      acceptedAnswers: ['εγώ τελειώνω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) finish', ru: 'Ты заканчиваешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τελειώνεις',
      pronunciation: LocalizedText(en: 'te-li-O-nis', ru: 'тэ-ли-О-нис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Τελειώνω can mean finish something or come to an end.',
        ru: 'Второе лицо: ты. Как «заканчивать» и «заканчиваться»: τελειώνω подходит и человеку, и уроку. В настоящем ударение на ώ.',
      ),
      acceptedAnswers: ['εσύ τελειώνεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He finishes', ru: 'Он заканчивает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τελειώνει',
      pronunciation: LocalizedText(en: 'te-li-O-ni', ru: 'тэ-ли-О-ни'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Τελειώνω can mean finish something or come to an end.',
        ru: 'Третье лицо: он; та же форма для она/оно. Как «заканчивать» и «заканчиваться»: τελειώνω подходит и человеку, и уроку. В настоящем ударение на ώ.',
      ),
      acceptedAnswers: ['αυτός τελειώνει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We finish', ru: 'Мы заканчиваем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τελειώνουμε',
      pronunciation: LocalizedText(en: 'te-li-O-nu-me', ru: 'тэ-ли-О-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Τελειώνω can mean finish something or come to an end.',
        ru: 'Первое лицо множественного числа: мы. Как «заканчивать» и «заканчиваться»: τελειώνω подходит и человеку, и уроку. В настоящем ударение на ώ.',
      ),
      acceptedAnswers: ['εμείς τελειώνουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) finish',
        ru: 'Вы заканчиваете',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τελειώνετε',
      pronunciation: LocalizedText(en: 'te-li-O-ne-te', ru: 'тэ-ли-О-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Τελειώνω can mean finish something or come to an end.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Как «заканчивать» и «заканчиваться»: τελειώνω подходит и человеку, и уроку. В настоящем ударение на ώ.',
      ),
      acceptedAnswers: ['εσείς τελειώνετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They finish', ru: 'Они заканчивают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τελειώνουν',
      pronunciation: LocalizedText(en: 'te-li-O-nun', ru: 'тэ-ли-О-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. Τελειώνω can mean finish something or come to an end.',
        ru: 'Третье лицо множественного числа: они. Как «заканчивать» и «заканчиваться»: τελειώνω подходит и человеку, и уроку. В настоящем ударение на ώ.',
      ),
      alternatives: ['τελειώνουνε'],
      acceptedAnswers: [
        'αυτοί τελειώνουν',
        'αυτοί τελειώνουνε',
        'αυτές τελειώνουν',
        'αυτές τελειώνουνε',
        'αυτά τελειώνουν',
        'αυτά τελειώνουνε',
      ],
    ),
    VocabularyCard(
      id: 'they-finish-lesson',
      prompt: LocalizedText(
        en: 'They finish the lesson now.',
        ru: 'Они сейчас заканчивают урок.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τελειώνουν το μάθημα τώρα.',
      pronunciation: LocalizedText(
        en: 'te-li-O-nun to MA-thi-ma TO-ra',
        ru: 'тэ-ли-О-нун то МА-ти-ма ТО-ра',
      ),
      explanation: LocalizedText(
        en: 'Two named people, such as Haris and Magda, require the plural τελειώνουν.',
        ru: 'Два человека — «они»: τελειώνουν. Το μάθημα — дополнение «что? урок».',
      ),
      alternatives: ['Τελειώνουνε το μάθημα τώρα.'],
      acceptedAnswers: [
        'Αυτοί τελειώνουν το μάθημα τώρα.',
        'Αυτές τελειώνουν το μάθημα τώρα.',
      ],
    ),
    VocabularyCard(
      id: 'lesson-finishes',
      prompt: LocalizedText(
        en: 'The lesson finishes at two.',
        ru: 'Урок заканчивается в два.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Το μάθημα τελειώνει στις δύο.',
      pronunciation: LocalizedText(
        en: 'to MA-thi-ma te-li-O-ni stis DHI-o',
        ru: 'то МА-ти-ма тэ-ли-О-ни стис ДИ-о',
      ),
      explanation: LocalizedText(
        en: 'A single lesson takes third person singular τελειώνει.',
        ru: 'Το μάθημα — средний род, единственное число; окончание глагола -ει, как для «он/она».',
      ),
    ),
  ],
);
