import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const smallTalkRepliesDeck = VocabularyDeck(
  id: 'small-talk-replies',
  title: LocalizedText(
    en: 'Small talk & how you feel',
    ru: 'Как дела: больше ответов',
  ),
  subtitle: LocalizedText(
    en: 'From doing fine to feeling terrible',
    ru: 'От «неплохо» до «ужасно»',
  ),
  note: LocalizedText(
    en: 'These are everyday idioms. A question such as Τι γίνεται; asks how things are going, not necessarily what action is happening.',
    ru: 'Это разговорные формулы. Как русское «как жизнь?», их перевод часто не совпадает с буквальным значением каждого слова.',
  ),
  cover: 'Τι νέα;',
  cards: [
    VocabularyCard(
      id: 'how-going',
      prompt: LocalizedText(en: 'How is it going?', ru: 'Как идут дела?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πώς πάει;',
      pronunciation: LocalizedText(en: 'pos PA-i', ru: 'пос ПА-и'),
      explanation: LocalizedText(
        en: 'Literally how does it go; an informal greeting.',
        ru: 'Буквально «как идёт?», естественно «как дела?». Πώς с ударением; πάει — два слога.',
      ),
    ),
    VocabularyCard(
      id: 'whats-happening',
      prompt: LocalizedText(
        en: 'How are things? (literally “what is happening?”)',
        ru: 'Как дела? (буквально «что происходит?»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τι γίνεται;',
      pronunciation: LocalizedText(en: 'ti YI-ne-te', ru: 'ти ЙИ-нэ-тэ'),
      explanation: LocalizedText(
        en: 'A common conversational greeting, not always a literal question.',
        ru: 'Как русское «ну что там?»: часто просто приветствие. Τι без ударения.',
      ),
    ),
    VocabularyCard(
      id: 'whats-new',
      prompt: LocalizedText(en: 'What is new?', ru: 'Что нового?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τι νέα;',
      pronunciation: LocalizedText(en: 'ti NE-a', ru: 'ти НЭ-а'),
      explanation: LocalizedText(
        en: 'Νέα is news, grammatically neuter plural.',
        ru: 'Νέα — «новости», средний род множественного. По-русски естественно «что нового?».',
      ),
    ),
    VocabularyCard(
      id: 'same',
      prompt: LocalizedText(en: 'Same as usual.', ru: 'Всё по-прежнему.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τα ίδια.',
      pronunciation: LocalizedText(en: 'ta I-dhya', ru: 'та И-дья'),
      explanation: LocalizedText(
        en: 'Literally the same things; a reply to how are things.',
        ru: 'Как «всё то же»: τα ίδια — устойчивый ответ, не требуется глагол.',
      ),
    ),
    VocabularyCard(
      id: 'not-so-well',
      prompt: LocalizedText(
        en: 'Not so well. (with “and so”)',
        ru: 'Не так уж хорошо. (с «и так»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Όχι και τόσο καλά.',
      pronunciation: LocalizedText(
        en: 'O-khi ke TO-so ka-LA',
        ru: 'О-хи кэ ТО-со ка-ЛА',
      ),
      explanation: LocalizedText(
        en: 'Και τόσο softens the negative reply: not all that well.',
        ru: 'Устойчивое όχι και τόσο — «не так уж». Не путаем с δεν перед глаголом.',
      ),
    ),
    VocabularyCard(
      id: 'fairly-well',
      prompt: LocalizedText(
        en: 'Fairly well / not bad (one word)',
        ru: 'Неплохо / более-менее (одно слово)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Καλούτσικα.',
      pronunciation: LocalizedText(en: 'ka-LU-tsi-ka', ru: 'ка-ЛУ-ци-ка'),
      explanation: LocalizedText(
        en: 'An informal, qualified version of καλά: fairly well.',
        ru: 'Как «неплохо», с оттенком «так, ничего». Это слабее, чем πολύ καλά «очень хорошо».',
      ),
    ),
    VocabularyCard(
      id: 'terrible',
      prompt: LocalizedText(
        en: 'Terrible! (answer to “how are you?”)',
        ru: 'Ужасно! (о том, как дела)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Χάλια!',
      pronunciation: LocalizedText(en: 'KHA-lya', ru: 'ХА-лья'),
      explanation: LocalizedText(
        en: 'An informal strongly negative reply.',
        ru: 'Разговорное «ужасно / дела плохи». Χάλια — не вежливое нейтральное «так себе».',
      ),
    ),
    VocabularyCard(
      id: 'surprise',
      prompt: LocalizedText(
        en: 'Oh wow! / Oh dear! (expression of surprise)',
        ru: 'Ого! / Вот это да! (удивление)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πω πω!',
      pronunciation: LocalizedText(en: 'po po', ru: 'по по'),
      explanation: LocalizedText(
        en: 'An exclamation of surprise or dismay, not a literal reference to God.',
        ru: 'Πω πω может выражать удивление или огорчение. Это не буквальное «о мой Бог», как подписано в тетради.',
      ),
    ),
    VocabularyCard(
      id: 'how-panagiotis',
      prompt: LocalizedText(
        en: 'How is Panagiotis? (using “does”)',
        ru: 'Как дела у Панайотиса? (через «делает»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τι κάνει ο Παναγιώτης;',
      pronunciation: LocalizedText(
        en: 'ti KA-ni o pa-na-YO-tis',
        ru: 'ти КА-ни о па-на-ЙО-тис',
      ),
      explanation: LocalizedText(
        en: 'For a third person use κάνει, not κάνεις or κάνετε.',
        ru: 'Спрашиваем о нём: κάνει. Сравните «ты как?» Τι κάνεις; и «он как?» Τι κάνει;',
      ),
    ),
  ],
);
