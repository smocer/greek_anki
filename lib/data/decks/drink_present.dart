import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const drinkPresentDeck = VocabularyDeck(
  id: 'drink-present',
  title: LocalizedText(en: 'To drink: πίνω', ru: 'Пить: πίνω'),
  subtitle: LocalizedText(
    en: 'Present tense in everyday speech',
    ru: 'Настоящее время в речи',
  ),
  note: LocalizedText(
    en: 'Greek verb endings identify the person. Pronouns are optional unless the prompt asks for them.',
    ru: 'Как в русском «пью/пьёшь/пьём», лицо видно по окончанию. Местоимение обычно можно опустить.',
  ),
  cover: 'Πίνω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I drink', ru: 'Я пью'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'PI-no', ru: 'ПИ-но'),
      explanation: LocalizedText(
        en: 'First person singular. The stress stays on πί.',
        ru: 'Первое лицо единственного числа: «я». Ударение остаётся на πί во всех этих формах.',
      ),
      greek: 'πίνω',

      acceptedAnswers: ['εγώ πίνω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) drink', ru: 'Ты пьёшь'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'PI-nis', ru: 'ПИ-нис'),
      explanation: LocalizedText(
        en: 'Second person singular. The stress stays on πί.',
        ru: 'Второе лицо единственного числа: «ты». Ударение остаётся на πί во всех этих формах.',
      ),
      greek: 'πίνεις',

      acceptedAnswers: ['εσύ πίνεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He drinks', ru: 'Он пьёт'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'PI-ni', ru: 'ПИ-ни'),
      explanation: LocalizedText(
        en: 'Third person singular; also she or it. The stress stays on πί.',
        ru: 'Третье лицо единственного числа; та же форма для «она/оно». Ударение остаётся на πί во всех этих формах.',
      ),
      greek: 'πίνει',

      acceptedAnswers: ['αυτός πίνει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We drink', ru: 'Мы пьём'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'PI-nu-me', ru: 'ПИ-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. The stress stays on πί.',
        ru: 'Первое лицо множественного числа: «мы». Ударение остаётся на πί во всех этих формах.',
      ),
      greek: 'πίνουμε',

      acceptedAnswers: ['εμείς πίνουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) drink', ru: 'Вы пьёте'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'PI-ne-te', ru: 'ПИ-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Plural, also polite singular. The stress stays on πί.',
        ru: 'Форма «вы/Вы», как русское вежливое множественное число. Ударение остаётся на πί во всех этих формах.',
      ),
      greek: 'πίνετε',

      acceptedAnswers: ['εσείς πίνετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They drink', ru: 'Они пьют'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'PI-nun', ru: 'ПИ-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. The stress stays on πί.',
        ru: 'Третье лицо множественного числа: «они». Ударение остаётся на πί во всех этих формах.',
      ),
      greek: 'πίνουν',
      alternatives: ['πίνουνε'],
      acceptedAnswers: [
        'αυτοί πίνουν',
        'αυτές πίνουν',
        'αυτά πίνουν',
        'αυτοί πίνουνε',
      ],
    ),
    VocabularyCard(
      id: 'i-water',
      prompt: LocalizedText(en: 'I drink water.', ru: 'Я пью воду.'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'PI-no ne-RO', ru: 'ПИ-но нэ-РО'),
      explanation: LocalizedText(
        en: 'Νερό is water; no article is needed for this general statement.',
        ru: 'Νερό — вода, среднего рода. Здесь вещество в общем смысле, поэтому без артикля.',
      ),
      greek: 'Πίνω νερό.',

      acceptedAnswers: ['Εγώ πίνω νερό.'],
    ),
    VocabularyCard(
      id: 'you-drink-what',
      prompt: LocalizedText(
        en: 'What are you drinking? (informal)',
        ru: 'Что ты пьёшь?',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ti PI-nis', ru: 'ти ПИ-нис'),
      explanation: LocalizedText(
        en: 'Greek present covers “drink” and “are drinking.”',
        ru: 'В греческом нет отдельной формы как английское are drinking: πίνεις подходит и для привычки, и для действия сейчас.',
      ),
      greek: 'Τι πίνεις;',
    ),
  ],
);
