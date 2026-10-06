import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const subjectPronounsDeck = VocabularyDeck(
  id: 'subject-pronouns',
  title: LocalizedText(en: 'Personal pronouns', ru: 'Личные местоимения'),
  subtitle: LocalizedText(
    en: 'I, you, he, she, we, they',
    ru: 'Я, ты, он, она, мы, вы, они',
  ),
  note: LocalizedText(
    en: 'Greek often omits a subject pronoun because the verb ending identifies the person.',
    ru: 'Как в русском «иду», местоимение часто можно опустить: лицо понятно по глаголу.',
  ),
  cover: 'Εγώ',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I', ru: 'Я'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'e-GHO', ru: 'э-ГО'),
      explanation: LocalizedText(
        en: 'A subject pronoun, often omitted unless emphasized.',
        ru: 'Именительный: «я». Γ перед ω — щелевой звук, не обычный русский «г».',
      ),
      greek: 'εγώ',
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (one person, informal)', ru: 'Ты'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'e-SI', ru: 'э-СИ'),
      explanation: LocalizedText(
        en: 'Subject form for one person addressed informally.',
        ru: '«Ты» как подлежащее. Сравните εσένα/σε — «тебя».',
      ),
      greek: 'εσύ',
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He', ru: 'Он'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'af-TOS', ru: 'аф-ТОС'),
      explanation: LocalizedText(
        en: 'Masculine singular subject.',
        ru: 'Мужской род, единственное число; αυ перед τ звучит «аф».',
      ),
      greek: 'αυτός',
    ),
    VocabularyCard(
      id: 'she',
      prompt: LocalizedText(en: 'She', ru: 'Она'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'af-TI', ru: 'аф-ТИ'),
      explanation: LocalizedText(
        en: 'Feminine singular subject.',
        ru: 'Женский род, единственное число. Как он/она, αυτός/αυτή различаются по роду.',
      ),
      greek: 'αυτή',
    ),
    VocabularyCard(
      id: 'it',
      prompt: LocalizedText(en: 'It (neuter)', ru: 'Оно'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'af-TO', ru: 'аф-ТО'),
      explanation: LocalizedText(
        en: 'Neuter singular subject.',
        ru: 'Средний род; выбираем по греческому роду слова, который не всегда совпадает с русским.',
      ),
      greek: 'αυτό',
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We', ru: 'Мы'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'e-MIS', ru: 'э-МИС'),
      explanation: LocalizedText(
        en: 'First person plural subject.',
        ru: 'Именительный «мы»; глагол είμαστε — «мы есть».',
      ),
      greek: 'εμείς',
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(en: 'You (plural or polite)', ru: 'Вы'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'e-SIS', ru: 'э-СИС'),
      explanation: LocalizedText(
        en: 'Plural subject, also used for polite singular.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Именно подлежащее, не σας.',
      ),
      greek: 'εσείς',
    ),
    VocabularyCard(
      id: 'they-male',
      prompt: LocalizedText(
        en: 'They (men or mixed group)',
        ru: 'Они (мужчины / смешанная группа)',
      ),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'af-TI', ru: 'аф-ТИ'),
      explanation: LocalizedText(
        en: 'Masculine plural. Sounds like αυτή but has different spelling.',
        ru: 'В русском одно «они», а в греческом различается род. Αυτοί звучит как αυτή, но пишется иначе.',
      ),
      greek: 'αυτοί',
    ),
    VocabularyCard(
      id: 'they-female',
      prompt: LocalizedText(en: 'They (women)', ru: 'Они (женщины)'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'af-TES', ru: 'аф-ТЭС'),
      explanation: LocalizedText(
        en: 'Feminine plural subject.',
        ru: 'Женское множественное «они» — αυτές; для мужчин или смешанной группы — αυτοί.',
      ),
      greek: 'αυτές',
    ),
    VocabularyCard(
      id: 'they-neuter',
      prompt: LocalizedText(en: 'They (neuter nouns)', ru: 'Они (средний род)'),
      meaning: LocalizedText(
        en: 'Subject pronoun only.',
        ru: 'Только местоимение в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'af-TA', ru: 'аф-ТА'),
      explanation: LocalizedText(
        en: 'Neuter plural, for example τα παιδιά → αυτά.',
        ru: 'Например, τα παιδιά («дети») — грамматически средний род, поэтому αυτά.',
      ),
      greek: 'αυτά',
    ),
  ],
);
