import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const bePresentDeck = VocabularyDeck(
  id: 'be-present',
  title: LocalizedText(en: 'To be: είμαι', ru: 'Быть: είμαι'),
  subtitle: LocalizedText(
    en: 'Six persons and simple sentences',
    ru: 'Шесть лиц и простые предложения',
  ),
  note: LocalizedText(
    en: 'Unlike Russian, Greek normally keeps “be” in present-tense sentences: είμαι εδώ = я здесь.',
    ru: 'Русское «я здесь» обходится без «есть». В греческом связка нужна: είμαι εδώ.',
  ),
  cover: 'Είμαι',
  cards: [
    VocabularyCard(
      id: 'i-am',
      prompt: LocalizedText(en: 'I am', ru: 'Я есть'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-me', ru: 'И-мэ'),
      explanation: LocalizedText(
        en: 'First person singular. Εγώ is optional.',
        ru: '«Я есть»: εγώ είμαι. В обычной речи εγώ можно опустить.',
      ),
      greek: 'είμαι',

      acceptedAnswers: ['εγώ είμαι'],
    ),
    VocabularyCard(
      id: 'you-are',
      prompt: LocalizedText(en: 'You are (informal)', ru: 'Ты есть'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-se', ru: 'И-сэ'),
      explanation: LocalizedText(
        en: 'Second person singular, the ты form.',
        ru: 'Форма «ты» — είσαι. Не путайте с είστε — «вы/Вы».',
      ),
      greek: 'είσαι',

      acceptedAnswers: ['εσύ είσαι'],
    ),
    VocabularyCard(
      id: 'he-is',
      prompt: LocalizedText(en: 'He is', ru: 'Он есть'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-ne', ru: 'И-нэ'),
      explanation: LocalizedText(
        en: 'The same verb form serves he, she and it.',
        ru: 'Он/она/оно — всё είναι; пол не меняет глагол в настоящем времени.',
      ),
      greek: 'είναι',

      acceptedAnswers: ['αυτός είναι'],
    ),
    VocabularyCard(
      id: 'we-are',
      prompt: LocalizedText(en: 'We are', ru: 'Мы есть'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-ma-ste', ru: 'И-ма-стэ'),
      explanation: LocalizedText(
        en: 'First person plural.',
        ru: 'Εμείς είμαστε: «мы есть». Запомните -μαστε.',
      ),
      greek: 'είμαστε',

      acceptedAnswers: ['εμείς είμαστε'],
    ),
    VocabularyCard(
      id: 'you-are-polite',
      prompt: LocalizedText(
        en: 'You are (polite/plural)',
        ru: 'Вы есть / вы есть',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-ste', ru: 'И-стэ'),
      explanation: LocalizedText(
        en: 'Polite singular and plural share this form.',
        ru: 'Как «Вы работаете», вежливое обращение использует форму множественного числа.',
      ),
      greek: 'είστε',

      acceptedAnswers: ['εσείς είστε'],
    ),
    VocabularyCard(
      id: 'they-are',
      prompt: LocalizedText(en: 'They are', ru: 'Они есть'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-ne', ru: 'И-нэ'),
      explanation: LocalizedText(
        en: 'Same verb as he/she/it; context or a pronoun shows the number.',
        ru: 'И «он есть», и «они есть» — είναι. Число понятно из контекста или местоимения.',
      ),
      greek: 'είναι',

      acceptedAnswers: ['αυτοί είναι', 'αυτές είναι', 'αυτά είναι'],
    ),
    VocabularyCard(
      id: 'i-here',
      prompt: LocalizedText(en: 'I am here.', ru: 'Я здесь.'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-me e-DHO', ru: 'И-мэ э-ДО'),
      explanation: LocalizedText(
        en: 'Keep είμαι; the subject pronoun may be omitted.',
        ru: 'В русском связка нулевая, в греческом произносим είμαι. Εδώ — здесь.',
      ),
      greek: 'Είμαι εδώ.',

      acceptedAnswers: ['Εγώ είμαι εδώ.'],
    ),
    VocabularyCard(
      id: 'she-here',
      prompt: LocalizedText(
        en: 'She is here. (include “she”)',
        ru: 'Она здесь. (с местоимением «она»)',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(
        en: 'af-TI I-ne e-DHO',
        ru: 'аф-ТИ И-нэ э-ДО',
      ),
      explanation: LocalizedText(
        en: 'Αυτή makes it clear that we mean she.',
        ru: 'Αυτή — она. Без местоимения είναι εδώ могло бы означать «он/она/оно/они здесь».',
      ),
      greek: 'Αυτή είναι εδώ.',
    ),
    VocabularyCard(
      id: 'not-here',
      prompt: LocalizedText(
        en: 'I am not here.',
        ru: 'Меня здесь нет. (буквально «я не здесь»)',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'dhen I-me e-DHO', ru: 'дэн И-мэ э-ДО'),
      explanation: LocalizedText(
        en: 'Δεν goes before the verb to negate a statement.',
        ru: 'Δεν перед глаголом = «не»: δεν είμαι. В русском естественно «меня здесь нет».',
      ),
      greek: 'Δεν είμαι εδώ.',

      acceptedAnswers: ['Εγώ δεν είμαι εδώ.'],
    ),
    VocabularyCard(
      id: 'we-here',
      prompt: LocalizedText(en: 'We are here.', ru: 'Мы здесь.'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns may be omitted unless requested.',
        ru: 'Настоящее время; местоимение можно опустить, если не указано обратное.',
      ),
      pronunciation: LocalizedText(en: 'I-ma-ste e-DHO', ru: 'И-ма-стэ э-ДО'),
      explanation: LocalizedText(
        en: 'The verb alone already tells us “we.”',
        ru: 'Окончание глагола указывает на «мы»; εμείς можно не произносить.',
      ),
      greek: 'Είμαστε εδώ.',

      acceptedAnswers: ['Εμείς είμαστε εδώ.'],
    ),
  ],
);
