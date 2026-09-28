import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const moreGreetingsDeck = VocabularyDeck(
  id: 'more-greetings',
  title: LocalizedText(
    en: 'More greetings & farewells',
    ru: 'Ещё приветствия и прощания',
  ),
  subtitle: LocalizedText(
    en: 'Short everyday expressions',
    ru: 'Короткие разговорные фразы',
  ),
  note: LocalizedText(
    en: 'Several greetings also work as farewells. Register matters: Χαίρετε is polite; Άντε, γεια is familiar.',
    ru: 'Некоторые выражения годятся и при встрече, и при прощании. Χαίρετε — вежливо, Άντε, γεια — разговорное «ну, пока».',
  ),
  cover: 'Χαίρετε',
  cards: [
    VocabularyCard(
      id: 'hello-short',
      prompt: LocalizedText(
        en: 'Hi! / Bye! (one short word)',
        ru: 'Привет! / Пока! (одно короткое слово)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Γεια!',
      pronunciation: LocalizedText(en: 'ya', ru: 'я'),
      explanation: LocalizedText(
        en: 'A short informal greeting or farewell; no stress mark on this single syllable.',
        ru: 'Односложное γεια без ударения. Как «привет/пока» — смысл зависит от встречи или прощания.',
      ),
    ),
    VocabularyCard(
      id: 'polite-greeting',
      prompt: LocalizedText(
        en: 'Hello! (polite, one word)',
        ru: 'Здравствуйте! (вежливо, одно слово)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Χαίρετε!',
      pronunciation: LocalizedText(en: 'KHE-re-te', ru: 'ХЭ-рэ-тэ'),
      explanation: LocalizedText(
        en: 'Literally a plural/polite greeting related to rejoice; also used on leaving.',
        ru: 'Как «здравствуйте»: вежливая форма, также возможна при прощании. Αί читается «э».',
      ),
    ),
    VocabularyCard(
      id: 'cheerful-greeting',
      prompt: LocalizedText(
        en: 'Hi there! (with the word “joy”)',
        ru: 'Привет! (приветствие со словом «радость»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Γεια χαρά!',
      pronunciation: LocalizedText(en: 'ya kha-RA', ru: 'я ха-РА'),
      explanation: LocalizedText(
        en: 'An everyday greeting or farewell; χαρά means joy.',
        ru: 'Χαρά — «радость», как в μια χαρά. Устойчивое приветствие, не переводим буквально «здоровье радость».',
      ),
    ),
    VocabularyCard(
      id: 'good-evening-farewell',
      prompt: LocalizedText(
        en: 'Have a good evening! (when leaving)',
        ru: 'Хорошего вечера! (при прощании)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Καλό βράδυ!',
      pronunciation: LocalizedText(en: 'ka-LO VRA-dhi', ru: 'ка-ЛО ВРА-ди'),
      explanation: LocalizedText(
        en: 'A wish on leaving; καλησπέρα usually greets someone.',
        ru: 'Как разница «добрый вечер» и «хорошего вечера»: καλησπέρα при встрече, καλό βράδυ при прощании.',
      ),
    ),
    VocabularyCard(
      id: 'bye-familiar',
      prompt: LocalizedText(
        en: 'Well, bye! (familiar)',
        ru: 'Ну, пока! (разговорное)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Άντε, γεια!',
      pronunciation: LocalizedText(en: 'AN-de ya', ru: 'АН-дэ я'),
      explanation: LocalizedText(
        en: 'Άντε can signal wrapping up a conversation; this is informal.',
        ru: 'Άντε здесь как русское «ну/ладно» при завершении разговора. Для официальной ситуации слишком фамильярно.',
      ),
    ),
    VocabularyCard(
      id: 'see-soon',
      prompt: LocalizedText(en: 'See you soon!', ru: 'Скоро увидимся!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τα λέμε σύντομα!',
      pronunciation: LocalizedText(
        en: 'ta LE-me SIN-do-ma',
        ru: 'та ЛЭ-мэ СИН-до-ма',
      ),
      explanation: LocalizedText(
        en: 'Σύντομα means soon; this extends the familiar τα λέμε.',
        ru: 'Добавляем σύντομα «скоро» к знакомому τα λέμε «увидимся». Не переводим λέμε буквально «говорим».',
      ),
    ),
  ],
);
