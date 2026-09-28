import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const numbers1120Deck = VocabularyDeck(
  id: 'numbers-11-20',
  title: LocalizedText(en: 'Numbers 11–20', ru: 'Числа 11–20'),
  subtitle: LocalizedText(
    en: 'Counting a little further',
    ru: 'Продолжаем считать',
  ),
  note: LocalizedText(
    en: 'These are counting forms. Learn 11 and 12 separately; 13–19 build on ten.',
    ru: 'Формы для счёта. 11 и 12 запоминаем отдельно; в 13–19 узнаются десять и единицы.',
  ),
  cover: '11–20',
  cards: [
    VocabularyCard(
      id: 'number-11',
      prompt: LocalizedText(en: '11', ru: '11'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'EN-de-ka', ru: 'ЭН-дэ-ка'),
      explanation: LocalizedText(
        en: 'Ένδεκα is another spelling of eleven.',
        ru: 'Έντεκα и ένδεκα — варианты числа 11. Здесь основной — έντεκα.',
      ),
      greek: 'έντεκα',
      alternatives: ['ένδεκα'],
    ),
    VocabularyCard(
      id: 'number-12',
      prompt: LocalizedText(en: '12', ru: '12'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'DHO-dhe-ka', ru: 'ДО-дэ-ка'),
      explanation: LocalizedText(
        en: 'Twelve: learn the whole word.',
        ru: 'Двенадцать: запомните целое слово; δ — межзубный звук, а не обычное русское «д».',
      ),
      greek: 'δώδεκα',
    ),
    VocabularyCard(
      id: 'number-13',
      prompt: LocalizedText(en: '13', ru: '13'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'dhe-ka-TRI-a', ru: 'дэ-ка-ТРИ-а'),
      explanation: LocalizedText(
        en: 'Ten plus three; one written word.',
        ru: 'Δέκα + τρία: десять + три; пишется слитно, ударение на τρί.',
      ),
      greek: 'δεκατρία',
    ),
    VocabularyCard(
      id: 'number-14',
      prompt: LocalizedText(en: '14', ru: '14'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'dhe-ka-TE-se-ra', ru: 'дэ-ка-ТЭ-сэ-ра'),
      explanation: LocalizedText(
        en: 'Ten plus four. This is the counting/neuter form.',
        ru: 'Как и τρία, форма τέσσερα используется при счёте и со средним родом.',
      ),
      greek: 'δεκατέσσερα',
    ),
    VocabularyCard(
      id: 'number-15',
      prompt: LocalizedText(en: '15', ru: '15'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'dhe-ka-PEN-de', ru: 'дэ-ка-ПЭН-дэ'),
      explanation: LocalizedText(
        en: 'Ten plus five; stress stays on πέν.',
        ru: 'Десять + пять; ударение на πέν, не на δέκα.',
      ),
      greek: 'δεκαπέντε',
    ),
    VocabularyCard(
      id: 'number-16',
      prompt: LocalizedText(en: '16', ru: '16'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'dhe-ka-E-ksi', ru: 'дэ-ка-Э-кси'),
      explanation: LocalizedText(
        en: 'Both δεκαέξι and the contracted δεκάξι are correct; each has its own stress position.',
        ru: 'Δεκαέξι и сокращённое δεκάξι — правильные варианты. Ударение ставим по выбранной форме: έ или ά.',
      ),
      greek: 'δεκαέξι',
      alternatives: ['δεκάξι'],
    ),
    VocabularyCard(
      id: 'number-17',
      prompt: LocalizedText(en: '17', ru: '17'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'dhe-ka-ef-TA', ru: 'дэ-ка-эф-ТА'),
      explanation: LocalizedText(
        en: 'Uses εφτά, the everyday form; δεκαεπτά is also correct.',
        ru: 'Основной вариант с εφτά, как в карточке 7. Δεκαεπτά тоже верно.',
      ),
      greek: 'δεκαεφτά',
      alternatives: ['δεκαεπτά'],
    ),
    VocabularyCard(
      id: 'number-18',
      prompt: LocalizedText(en: '18', ru: '18'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'dhe-ka-ok-TO', ru: 'дэ-ка-ок-ТО'),
      explanation: LocalizedText(
        en: 'Both δεκαοκτώ and δεκαοχτώ are used.',
        ru: 'Как οκτώ / οχτώ, у числа 18 есть два варианта.',
      ),
      greek: 'δεκαοκτώ',
      alternatives: ['δεκαοχτώ'],
    ),
    VocabularyCard(
      id: 'number-19',
      prompt: LocalizedText(en: '19', ru: '19'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'dhe-ka-e-NE-a', ru: 'дэ-ка-э-НЭ-а'),
      explanation: LocalizedText(
        en: 'Δεκαεννιά is another common form.',
        ru: 'Вариант δεκαεννιά тоже обычный, как εννέα / εννιά для 9.',
      ),
      greek: 'δεκαεννέα',
      alternatives: ['δεκαεννιά'],
    ),
    VocabularyCard(
      id: 'number-20',
      prompt: LocalizedText(en: '20', ru: '20'),
      meaning: LocalizedText(
        en: 'Write the number name.',
        ru: 'Напишите числительное.',
      ),
      pronunciation: LocalizedText(en: 'I-ko-si', ru: 'И-ко-си'),
      explanation: LocalizedText(
        en: 'Twenty. The letters ει make one /i/ sound.',
        ru: 'Ει читается как «и»: И-ко-си. Это одна гласная, не «эй».',
      ),
      greek: 'είκοσι',
    ),
  ],
);
