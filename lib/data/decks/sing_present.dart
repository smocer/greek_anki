import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const singPresentDeck = VocabularyDeck(
  id: 'sing-present',
  title: LocalizedText(en: 'To sing: τραγουδώ', ru: 'Петь: τραγουδώ'),
  subtitle: LocalizedText(
    en: 'Present tense in everyday speech',
    ru: 'Настоящее время в речи',
  ),
  note: LocalizedText(
    en: 'Greek verb endings identify the person. Pronouns are optional unless the prompt asks for them.',
    ru: 'Как в русском «пью/пьёшь/пьём», лицо видно по окончанию. Местоимение обычно можно опустить.',
  ),
  cover: 'Τραγουδώ',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I sing', ru: 'Я пою'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'tra-ghu-DHO', ru: 'тра-гу-ДО'),
      explanation: LocalizedText(
        en: 'First person singular. This verb has common alternative present-tense forms.',
        ru: 'Первое лицо единственного числа: «я». Есть параллельные разговорные формы; они перечислены среди принимаемых ответов.',
      ),
      greek: 'τραγουδώ',
      alternatives: ['τραγουδάω'],
      acceptedAnswers: ['εγώ τραγουδώ', 'εγώ τραγουδάω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) sing', ru: 'Ты поёшь'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'tra-ghu-DHAS', ru: 'тра-гу-ДАС'),
      explanation: LocalizedText(
        en: 'Second person singular. This verb has common alternative present-tense forms.',
        ru: 'Второе лицо единственного числа: «ты». Есть параллельные разговорные формы; они перечислены среди принимаемых ответов.',
      ),
      greek: 'τραγουδάς',

      acceptedAnswers: ['εσύ τραγουδάς'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He sings', ru: 'Он поёт'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'tra-ghu-DHA-i', ru: 'тра-гу-ДА-и'),
      explanation: LocalizedText(
        en: 'Third person singular; also she or it. This verb has common alternative present-tense forms.',
        ru: 'Третье лицо единственного числа; та же форма для «она/оно». Есть параллельные разговорные формы; они перечислены среди принимаемых ответов.',
      ),
      greek: 'τραγουδάει',
      alternatives: ['τραγουδά'],
      acceptedAnswers: ['αυτός τραγουδάει', 'αυτός τραγουδά'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We sing', ru: 'Мы поём'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'tra-ghu-DHU-me', ru: 'тра-гу-ДУ-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. This verb has common alternative present-tense forms.',
        ru: 'Первое лицо множественного числа: «мы». Есть параллельные разговорные формы; они перечислены среди принимаемых ответов.',
      ),
      greek: 'τραγουδούμε',
      alternatives: ['τραγουδάμε'],
      acceptedAnswers: ['εμείς τραγουδούμε', 'εμείς τραγουδάμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) sing',
        ru: 'Вы / вы поёте',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'tra-ghu-DHA-te', ru: 'тра-гу-ДА-тэ'),
      explanation: LocalizedText(
        en: 'Plural, also polite singular. This verb has common alternative present-tense forms.',
        ru: 'Форма «вы/Вы», как русское вежливое множественное число. Есть параллельные разговорные формы; они перечислены среди принимаемых ответов.',
      ),
      greek: 'τραγουδάτε',

      acceptedAnswers: ['εσείς τραγουδάτε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They sing', ru: 'Они поют'),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(en: 'tra-ghu-DHUN', ru: 'тра-гу-ДУН'),
      explanation: LocalizedText(
        en: 'Third person plural. This verb has common alternative present-tense forms.',
        ru: 'Третье лицо множественного числа: «они». Есть параллельные разговорные формы; они перечислены среди принимаемых ответов.',
      ),
      greek: 'τραγουδούν',
      alternatives: ['τραγουδάνε', 'τραγουδούνε'],
      acceptedAnswers: [
        'αυτοί τραγουδούν',
        'αυτές τραγουδούν',
        'αυτά τραγουδούν',
        'αυτοί τραγουδάνε',
        'αυτοί τραγουδούνε',
      ],
    ),
    VocabularyCard(
      id: 'why-sing',
      prompt: LocalizedText(
        en: 'Why are you singing? (informal)',
        ru: 'Почему ты поёшь?',
      ),
      meaning: LocalizedText(
        en: 'Present tense; subject pronouns are optional.',
        ru: 'Настоящее время; личные местоимения необязательны.',
      ),
      pronunciation: LocalizedText(
        en: 'ya-TI tra-ghu-DHAS',
        ru: 'я-ТИ тра-гу-ДАС',
      ),
      explanation: LocalizedText(
        en: 'A notebook question word combined with a notebook verb.',
        ru: 'Соединяем γιατί («почему») и форму на «ты» τραγουδάς. Γ здесь не взрывной русский «г».',
      ),
      greek: 'Γιατί τραγουδάς;',
    ),
  ],
);
