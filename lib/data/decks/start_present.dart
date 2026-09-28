import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const startPresentDeck = VocabularyDeck(
  id: 'start-present',
  title: LocalizedText(en: 'To start: αρχίζω', ru: 'Начинать: αρχίζω'),
  subtitle: LocalizedText(
    en: 'Present tense in everyday speech',
    ru: 'Настоящее время в речи',
  ),
  note: LocalizedText(
    en: 'Greek verb endings identify the person. Pronouns are optional unless the prompt asks for them.',
    ru: 'Как в русском «пью/пьёшь/пьём», лицо видно по окончанию. Местоимение обычно можно опустить.',
  ),
  cover: 'Αρχίζω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I start', ru: 'Я начинаю'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ar-KHI-zo', ru: 'ар-ХИ-зо'),
      explanation: LocalizedText(
        en: 'First person singular. Αρχίζω means I start/begin.',
        ru: 'Первое лицо единственного числа: «я». Αρχίζω — «я начинаю», не отдельный инфинитив.',
      ),
      greek: 'αρχίζω',

      acceptedAnswers: ['εγώ αρχίζω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) start', ru: 'Ты начинаешь'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ar-KHI-zis', ru: 'ар-ХИ-зис'),
      explanation: LocalizedText(
        en: 'Second person singular. Αρχίζω means I start/begin.',
        ru: 'Второе лицо единственного числа: «ты». Αρχίζω — «я начинаю», не отдельный инфинитив.',
      ),
      greek: 'αρχίζεις',

      acceptedAnswers: ['εσύ αρχίζεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He starts', ru: 'Он начинает'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ar-KHI-zi', ru: 'ар-ХИ-зи'),
      explanation: LocalizedText(
        en: 'Third person singular; also she or it. Αρχίζω means I start/begin.',
        ru: 'Третье лицо единственного числа; та же форма для «она/оно». Αρχίζω — «я начинаю», не отдельный инфинитив.',
      ),
      greek: 'αρχίζει',

      acceptedAnswers: ['αυτός αρχίζει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We start', ru: 'Мы начинаем'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ar-KHI-zu-me', ru: 'ар-ХИ-зу-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Αρχίζω means I start/begin.',
        ru: 'Первое лицо множественного числа: «мы». Αρχίζω — «я начинаю», не отдельный инфинитив.',
      ),
      greek: 'αρχίζουμε',

      acceptedAnswers: ['εμείς αρχίζουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) start',
        ru: 'Вы / вы начинаете',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ar-KHI-ze-te', ru: 'ар-ХИ-зэ-тэ'),
      explanation: LocalizedText(
        en: 'Plural, also polite singular. Αρχίζω means I start/begin.',
        ru: 'Форма «вы/Вы», как русское вежливое множественное число. Αρχίζω — «я начинаю», не отдельный инфинитив.',
      ),
      greek: 'αρχίζετε',

      acceptedAnswers: ['εσείς αρχίζετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They start', ru: 'Они начинают'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ar-KHI-zun', ru: 'ар-ХИ-зун'),
      explanation: LocalizedText(
        en: 'Third person plural. Αρχίζω means I start/begin.',
        ru: 'Третье лицо множественного числа: «они». Αρχίζω — «я начинаю», не отдельный инфинитив.',
      ),
      greek: 'αρχίζουν',
      alternatives: ['αρχίζουνε'],
      acceptedAnswers: [
        'αυτοί αρχίζουν',
        'αυτές αρχίζουν',
        'αυτά αρχίζουν',
        'αυτοί αρχίζουνε',
      ],
    ),
    VocabularyCard(
      id: 'we-start-now',
      prompt: LocalizedText(en: 'We start now.', ru: 'Мы начинаем сейчас.'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(
        en: 'ar-KHI-zu-me TO-ra',
        ru: 'ар-ХИ-зу-мэ ТО-ра',
      ),
      explanation: LocalizedText(
        en: 'The -ουμε ending identifies “we.”',
        ru: 'Как «начинаем» указывает на «мы», -ουμε указывает на первое лицо мн. числа.',
      ),
      greek: 'Αρχίζουμε τώρα.',

      acceptedAnswers: ['Εμείς αρχίζουμε τώρα.'],
    ),
    VocabularyCard(
      id: 'lesson-starts',
      prompt: LocalizedText(en: 'The lesson starts.', ru: 'Урок начинается.'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(
        en: 'to MA-thi-ma ar-KHI-zi',
        ru: 'то МА-ти-ма ар-ХИ-зи',
      ),
      explanation: LocalizedText(
        en: 'Το μάθημα is the subject; αρχίζει can mean starts/begins.',
        ru: 'В русском «начинается» с -ся, в греческом достаточно αρχίζει. Μάθημα — урок, среднего рода.',
      ),
      greek: 'Το μάθημα αρχίζει.',
    ),
    VocabularyCard(
      id: 'lesson-always-nine',
      prompt: LocalizedText(
        en: 'The lesson always starts at nine.',
        ru: 'Урок всегда начинается в девять.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Το μάθημα πάντα αρχίζει στις εννέα.',
      alternatives: ['Το μάθημα πάντα αρχίζει στις εννιά.'],
      acceptedAnswers: [
        'Το μάθημα αρχίζει πάντα στις εννέα.',
        'Το μάθημα αρχίζει πάντα στις εννιά.',
      ],
      pronunciation: LocalizedText(
        en: 'to MA-thi-ma PAN-da ar-KHI-zi stis e-NE-a',
        ru: 'то МА-ти-ма ПАН-да ар-ХИ-зи стис э-НЭ-а',
      ),
      explanation: LocalizedText(
        en: 'A single lesson takes αρχίζει. Πάντα is always; στις introduces an hour, with ώρες understood.',
        ru: 'Урок один, поэтому αρχίζει, не αρχίζουν. «Всегда» — πάντα; «в девять» — στις εννέα, подразумевается ώρες «часы».',
      ),
    ),
  ],
);
