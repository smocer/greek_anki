import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const doPresentDeck = VocabularyDeck(
  id: 'do-present',
  title: LocalizedText(en: 'To do: κάνω', ru: 'Делать: κάνω'),
  subtitle: LocalizedText(
    en: 'Present tense in everyday speech',
    ru: 'Настоящее время в речи',
  ),
  note: LocalizedText(
    en: 'Greek verb endings identify the person. Pronouns are optional unless the prompt asks for them.',
    ru: 'Как в русском «пью/пьёшь/пьём», лицо видно по окончанию. Местоимение обычно можно опустить.',
  ),
  cover: 'Κάνω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I do', ru: 'Я делаю'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'KA-no', ru: 'КА-но'),
      explanation: LocalizedText(
        en: 'First person singular. Κάνω means do or make.',
        ru: 'Первое лицо единственного числа: «я». Κάνω — делать; окончания учим вместе с лицом.',
      ),
      greek: 'κάνω',

      acceptedAnswers: ['εγώ κάνω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) do', ru: 'Ты делаешь'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'KA-nis', ru: 'КА-нис'),
      explanation: LocalizedText(
        en: 'Second person singular. Κάνω means do or make.',
        ru: 'Второе лицо единственного числа: «ты». Κάνω — делать; окончания учим вместе с лицом.',
      ),
      greek: 'κάνεις',

      acceptedAnswers: ['εσύ κάνεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He does', ru: 'Он делает'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'KA-ni', ru: 'КА-ни'),
      explanation: LocalizedText(
        en: 'Third person singular; also she or it. Κάνω means do or make.',
        ru: 'Третье лицо единственного числа; та же форма для «она/оно». Κάνω — делать; окончания учим вместе с лицом.',
      ),
      greek: 'κάνει',

      acceptedAnswers: ['αυτός κάνει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We do', ru: 'Мы делаем'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'KA-nu-me', ru: 'КА-ну-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Κάνω means do or make.',
        ru: 'Первое лицо множественного числа: «мы». Κάνω — делать; окончания учим вместе с лицом.',
      ),
      greek: 'κάνουμε',

      acceptedAnswers: ['εμείς κάνουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (polite/plural) do', ru: 'Вы делаете'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'KA-ne-te', ru: 'КА-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Plural, also polite singular. Κάνω means do or make.',
        ru: 'Форма «вы/Вы», как русское вежливое множественное число. Κάνω — делать; окончания учим вместе с лицом.',
      ),
      greek: 'κάνετε',

      acceptedAnswers: ['εσείς κάνετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They do', ru: 'Они делают'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'KA-nun', ru: 'КА-нун'),
      explanation: LocalizedText(
        en: 'Third person plural. Κάνω means do or make.',
        ru: 'Третье лицо множественного числа: «они». Κάνω — делать; окончания учим вместе с лицом.',
      ),
      greek: 'κάνουν',
      alternatives: ['κάνουνε'],
      acceptedAnswers: [
        'αυτοί κάνουν',
        'αυτές κάνουν',
        'αυτά κάνουν',
        'αυτοί κάνουνε',
      ],
    ),
    VocabularyCard(
      id: 'i-exercise',
      prompt: LocalizedText(
        en: 'I do the exercise.',
        ru: 'Я делаю упражнение.',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(
        en: 'KA-no tin A-ski-si',
        ru: 'КА-но тин А-ски-си',
      ),
      explanation: LocalizedText(
        en: 'Η άσκηση becomes την άσκηση as an object.',
        ru: 'Как «делаю что?», винительный: η → την. Перед гласной сохраняем ν.',
      ),
      greek: 'Κάνω την άσκηση.',

      acceptedAnswers: ['Εγώ κάνω την άσκηση.'],
    ),
    VocabularyCard(
      id: 'you-do-what',
      prompt: LocalizedText(
        en: 'What are you doing? (informal)',
        ru: 'Что ты делаешь?',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'ti KA-nis', ru: 'ти КА-нис'),
      explanation: LocalizedText(
        en: 'The same phrase also means “how are you?” as a greeting.',
        ru: 'В контексте действия — «что делаешь?», при встрече — «как дела?». Одна фраза, два употребления.',
      ),
      greek: 'Τι κάνεις;',
    ),
  ],
);
