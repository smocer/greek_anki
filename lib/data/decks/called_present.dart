import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const calledPresentDeck = VocabularyDeck(
  id: 'called-present',
  title: LocalizedText(en: 'To be called: λέγομαι', ru: 'Зваться: λέγομαι'),
  subtitle: LocalizedText(
    en: 'A second way to give a name',
    ru: 'Ещё один способ назвать имя',
  ),
  note: LocalizedText(
    en: 'Learn these as a separate six-form set. Με λένε is an alternative construction, not the same conjugation.',
    ru: 'Это отдельное спряжение. Με λένε («меня называют») — другая конструкция, а не форма λέγομαι.',
  ),
  cover: 'Λέγομαι',
  cards: [
    VocabularyCard(
      id: 'i-called',
      prompt: LocalizedText(en: 'I am called', ru: 'Я зовусь'),
      meaning: LocalizedText(
        en: 'Use the λέγομαι conjugation; a subject pronoun is optional.',
        ru: 'Форма глагола λέγομαι; личное местоимение необязательно.',
      ),
      pronunciation: LocalizedText(en: 'LE-gho-me', ru: 'ЛЭ-го-мэ'),
      explanation: LocalizedText(
        en: 'Use a nominative name: λέγομαι Γιώργος.',
        ru: 'Ближе к «я зовусь». После λέγομαι имя в именительном: Γιώργος, не Γιώργο.',
      ),
      greek: 'λέγομαι',

      acceptedAnswers: ['εγώ λέγομαι'],
    ),
    VocabularyCard(
      id: 'you-called',
      prompt: LocalizedText(en: 'You are called (informal)', ru: 'Ты зовёшься'),
      meaning: LocalizedText(
        en: 'Use the λέγομαι conjugation; a subject pronoun is optional.',
        ru: 'Форма глагола λέγομαι; личное местоимение необязательно.',
      ),
      pronunciation: LocalizedText(en: 'LE-ghe-se', ru: 'ЛЭ-йе-сэ'),
      explanation: LocalizedText(
        en: 'Πώς λέγεσαι; is another way to ask a name informally.',
        ru: 'Πώς λέγεσαι; = «Как тебя зовут?». Окончание -σαι указывает на «ты».',
      ),
      greek: 'λέγεσαι',

      acceptedAnswers: ['εσύ λέγεσαι'],
    ),
    VocabularyCard(
      id: 'he-called',
      prompt: LocalizedText(
        en: 'He / she / it is called',
        ru: 'Он / она / оно называется',
      ),
      meaning: LocalizedText(
        en: 'Use the λέγομαι conjugation; a subject pronoun is optional.',
        ru: 'Форма глагола λέγομαι; личное местоимение необязательно.',
      ),
      pronunciation: LocalizedText(en: 'LE-ghe-te', ru: 'ЛЭ-йе-тэ'),
      explanation: LocalizedText(
        en: 'Also useful for things: πώς λέγεται; = what is it called?',
        ru: 'Можно о предмете: πώς λέγεται; — «как это называется?». -ται здесь, не -τε.',
      ),
      greek: 'λέγεται',

      acceptedAnswers: ['αυτός λέγεται', 'αυτή λέγεται', 'αυτό λέγεται'],
    ),
    VocabularyCard(
      id: 'we-called',
      prompt: LocalizedText(en: 'We are called', ru: 'Мы зовёмся'),
      meaning: LocalizedText(
        en: 'Use the λέγομαι conjugation; a subject pronoun is optional.',
        ru: 'Форма глагола λέγομαι; личное местоимение необязательно.',
      ),
      pronunciation: LocalizedText(en: 'le-GHO-ma-ste', ru: 'лэ-ГО-ма-стэ'),
      explanation: LocalizedText(
        en: 'Notice that the stress moves to γό.',
        ru: 'В отличие от λέγομαι, ударение сдвигается: λε-ΓΟ-ма-стэ. Как русское спряжение, учим форму целиком.',
      ),
      greek: 'λεγόμαστε',

      acceptedAnswers: ['εμείς λεγόμαστε'],
    ),
    VocabularyCard(
      id: 'you-called-polite',
      prompt: LocalizedText(
        en: 'You are called (polite/plural)',
        ru: 'Вы зовётесь / вы зовётесь',
      ),
      meaning: LocalizedText(
        en: 'Use the λέγομαι conjugation; a subject pronoun is optional.',
        ru: 'Форма глагола λέγομαι; личное местоимение необязательно.',
      ),
      pronunciation: LocalizedText(en: 'LE-ghe-ste', ru: 'ЛЭ-йе-стэ'),
      explanation: LocalizedText(
        en: 'Πώς λέγεστε; is the polite/plural question.',
        ru: 'Πώς λέγεστε; = «Как Вас/вас зовут?». Принцип ты/Вы тот же, что в русском.',
      ),
      greek: 'λέγεστε',

      acceptedAnswers: ['εσείς λέγεστε'],
    ),
    VocabularyCard(
      id: 'they-called',
      prompt: LocalizedText(en: 'They are called', ru: 'Они называются'),
      meaning: LocalizedText(
        en: 'Use the λέγομαι conjugation; a subject pronoun is optional.',
        ru: 'Форма глагола λέγομαι; личное местоимение необязательно.',
      ),
      pronunciation: LocalizedText(en: 'LE-ghon-de', ru: 'ЛЭ-гон-дэ'),
      explanation: LocalizedText(
        en: 'Third person plural; the name or noun identifies who “they” are.',
        ru: 'Множественное число: «они зовутся/называются». -νται отличается от -ται у «он/она».',
      ),
      greek: 'λέγονται',

      acceptedAnswers: ['αυτοί λέγονται', 'αυτές λέγονται', 'αυτά λέγονται'],
    ),
  ],
);
