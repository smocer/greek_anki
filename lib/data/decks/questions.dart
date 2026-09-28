import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const questionsDeck = VocabularyDeck(
  id: 'questions',
  title: LocalizedText(en: 'Question words', ru: 'Вопросительные слова'),
  subtitle: LocalizedText(
    en: 'Who, what, where and why',
    ru: 'Кто, что, где и почему',
  ),
  note: LocalizedText(
    en: 'Unlike Russian кто, Greek ποιος changes with gender. Greek questions end with ; (typing punctuation is optional).',
    ru: 'Русское «кто» не различает род, а греческое ποιος / ποια / ποιο различает. Греческий знак вопроса — ;, но при вводе он необязателен.',
  ),
  cover: 'Ποιος;',
  cards: [
    VocabularyCard(
      id: 'what',
      prompt: LocalizedText(en: 'What?', ru: 'Что?'),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'ti', ru: 'ти'),
      explanation: LocalizedText(
        en: 'Τι is not accented, even when it asks a question.',
        ru: 'Τι — «что», пишется без ударения. Не путайте с женским артиклем τη.',
      ),
      greek: 'τι;',
    ),
    VocabularyCard(
      id: 'who-man',
      prompt: LocalizedText(
        en: 'Who? / which? (masculine singular)',
        ru: 'Кто? / который? (мужской род)',
      ),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'pyos', ru: 'пьос'),
      explanation: LocalizedText(
        en: 'Use masculine ποιος when asking about a man or a masculine noun.',
        ru: 'Ποιος — мужской род; в русском «кто» одинаково для мужчин и женщин.',
      ),
      greek: 'ποιος;',
    ),
    VocabularyCard(
      id: 'who-woman',
      prompt: LocalizedText(
        en: 'Who? / which? (feminine singular)',
        ru: 'Кто? / которая? (женский род)',
      ),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'pya', ru: 'пья'),
      explanation: LocalizedText(
        en: 'Feminine counterpart of ποιος.',
        ru: 'Ποια — женский род, например «кто она?». Не ставьте ударение на односложном слове.',
      ),
      greek: 'ποια;',
    ),
    VocabularyCard(
      id: 'which-neuter',
      prompt: LocalizedText(
        en: 'Which? (neuter singular)',
        ru: 'Которое? (средний род)',
      ),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'pyo', ru: 'пьо'),
      explanation: LocalizedText(
        en: 'Use with a neuter noun: ποιο βιβλίο; = which book?',
        ru: 'Ποιο βιβλίο; — «какая книга?». По-гречески βιβλίο среднего рода, поэтому ποιο.',
      ),
      greek: 'ποιο;',
    ),
    VocabularyCard(
      id: 'where',
      prompt: LocalizedText(en: 'Where?', ru: 'Где? / куда?'),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'pu', ru: 'пу'),
      explanation: LocalizedText(
        en: 'Πού can ask location or destination; context distinguishes them.',
        ru: 'Одно πού может значить «где» или «куда». В вопросе ставится ударение: πού.',
      ),
      greek: 'πού;',
    ),
    VocabularyCard(
      id: 'where-from',
      prompt: LocalizedText(en: 'From where?', ru: 'Откуда?'),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'a-PO pu', ru: 'а-ПО пу'),
      explanation: LocalizedText(
        en: 'Από adds the idea of origin.',
        ru: 'Από + πού: буквально «из/от где», естественно «откуда?».',
      ),
      greek: 'από πού;',
    ),
    VocabularyCard(
      id: 'how',
      prompt: LocalizedText(en: 'How?', ru: 'Как?'),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'pos', ru: 'пос'),
      explanation: LocalizedText(
        en: 'The question word πώς has a written accent.',
        ru: 'Вопросительное πώς пишется с ударением, в отличие от союза πως («что»).',
      ),
      greek: 'πώς;',
    ),
    VocabularyCard(
      id: 'when',
      prompt: LocalizedText(en: 'When?', ru: 'Когда?'),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'PO-te', ru: 'ПО-тэ'),
      explanation: LocalizedText(
        en: 'Stress the first syllable.',
        ru: 'Ударение важно: πότε — «когда?», ποτέ — «когда-либо/никогда» в зависимости от контекста.',
      ),
      greek: 'πότε;',
    ),
    VocabularyCard(
      id: 'why',
      prompt: LocalizedText(en: 'Why?', ru: 'Почему? / зачем?'),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'ya-TI', ru: 'я-ТИ'),
      explanation: LocalizedText(
        en: 'Also means because in an answer.',
        ru: 'Как вопрос — «почему/зачем?», в ответе — «потому что». Значение зависит от контекста.',
      ),
      greek: 'γιατί;',
    ),
    VocabularyCard(
      id: 'how-much',
      prompt: LocalizedText(
        en: 'How much? (one-word question)',
        ru: 'Сколько? (количество/цена, одно слово)',
      ),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'PO-so', ru: 'ПО-со'),
      explanation: LocalizedText(
        en: 'Πόσο can ask how much; forms change with gender and number when modifying nouns.',
        ru: 'Πόσο; — «сколько?». Перед существительным формы меняются по роду и числу.',
      ),
      greek: 'πόσο;',
    ),
    VocabularyCard(
      id: 'how-many',
      prompt: LocalizedText(en: 'How many children?', ru: 'Сколько детей?'),
      meaning: LocalizedText(
        en: 'Write the question word or phrase.',
        ru: 'Напишите вопросительное слово или фразу.',
      ),
      pronunciation: LocalizedText(en: 'PO-sa pe-DHYA', ru: 'ПО-са пэ-ДЬЯ'),
      explanation: LocalizedText(
        en: 'Πόσα agrees with neuter plural παιδιά.',
        ru: 'В русском «сколько детей», в греческом πόσα согласуется с παιδιά: средний род, множественное число.',
      ),
      greek: 'Πόσα παιδιά;',
    ),
  ],
);
