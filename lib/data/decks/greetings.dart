import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const greetingsDeck = VocabularyDeck(
  id: 'greetings',
  title: LocalizedText(
    en: 'Greetings & courtesy',
    ru: 'Приветствия и вежливость',
  ),
  subtitle: LocalizedText(
    en: 'Hello, thank you, see you',
    ru: 'Привет, спасибо, до встречи',
  ),
  note: LocalizedText(
    en: 'Σου addresses one person informally; σας addresses several people or one person politely.',
    ru: 'Сравните ты/Вы: σου — одному на «ты», σας — нескольким или одному на «Вы».',
  ),
  cover: 'Γεια!',
  cards: [
    VocabularyCard(
      id: 'hello-informal',
      prompt: LocalizedText(
        en: 'Hello! (to a friend)',
        ru: 'Привет! (одному на «ты»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ya su', ru: 'я су'),
      explanation: LocalizedText(
        en: 'Γεια σου is an informal greeting or goodbye to one person.',
        ru: 'Γεια σου — приветствие или прощание на «ты»; σου здесь не подлежащее «ты».',
      ),
      greek: 'Γεια σου!',
    ),
    VocabularyCard(
      id: 'hello-polite',
      prompt: LocalizedText(
        en: 'Hello! (polite or plural)',
        ru: 'Здравствуйте! (на «Вы» / нескольким)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ya sas', ru: 'я сас'),
      explanation: LocalizedText(
        en: 'Σας marks a polite singular or a plural addressee.',
        ru: 'Как русское «Вы», σας здесь подходит и одному человеку вежливо, и нескольким.',
      ),
      greek: 'Γεια σας!',
    ),
    VocabularyCard(
      id: 'morning',
      prompt: LocalizedText(en: 'Good morning!', ru: 'Доброе утро!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ka-li-ME-ra', ru: 'ка-ли-МЭ-ра'),
      explanation: LocalizedText(
        en: 'Used in the morning and into the daytime.',
        ru: 'Буквально «хороший день»: καλή + μέρα. Утром это обычное «доброе утро».',
      ),
      greek: 'Καλημέρα!',
    ),
    VocabularyCard(
      id: 'evening',
      prompt: LocalizedText(en: 'Good evening!', ru: 'Добрый вечер!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ka-li-SPE-ra', ru: 'ка-ли-СПЭ-ра'),
      explanation: LocalizedText(
        en: 'A greeting in the later part of the day.',
        ru: 'Приветствие вечером. Для прощания перед сном нужно καληνύχτα.',
      ),
      greek: 'Καλησπέρα!',
    ),
    VocabularyCard(
      id: 'night',
      prompt: LocalizedText(en: 'Good night!', ru: 'Спокойной ночи!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ka-li-NI-khta', ru: 'ка-ли-НИ-хта'),
      explanation: LocalizedText(
        en: 'A farewell at night, especially before sleep.',
        ru: 'Пожелание при прощании ночью, особенно перед сном; не обычное вечернее приветствие.',
      ),
      greek: 'Καληνύχτα!',
    ),
    VocabularyCard(
      id: 'goodbye',
      prompt: LocalizedText(en: 'Goodbye!', ru: 'До свидания!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'a-DI-o', ru: 'а-ДИ-о'),
      explanation: LocalizedText(
        en: 'A general goodbye; γεια σου/σας can also be used when leaving.',
        ru: 'Общее прощание. Γεια σου / γεια σας тоже можно сказать, уходя.',
      ),
      greek: 'Αντίο!',
    ),
    VocabularyCard(
      id: 'thanks',
      prompt: LocalizedText(en: 'Thank you!', ru: 'Спасибо!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ef-kha-ri-STO', ru: 'эф-ха-ри-СТО'),
      explanation: LocalizedText(
        en: 'Ευ before χ sounds /ef/.',
        ru: 'Ευ перед χ звучит как «эф», не «эв». Корень χαρ- связан с благодарностью и радостью.',
      ),
      greek: 'Ευχαριστώ!',
    ),
    VocabularyCard(
      id: 'please',
      prompt: LocalizedText(en: 'Please / you are welcome', ru: 'Пожалуйста'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'pa-ra-ka-LO', ru: 'па-ра-ка-ЛО'),
      explanation: LocalizedText(
        en: 'Like Russian пожалуйста, this can accompany a request or answer thanks.',
        ru: 'Как русское «пожалуйста»: и в просьбе, и в ответ на «спасибо».',
      ),
      greek: 'Παρακαλώ!',
    ),
    VocabularyCard(
      id: 'sorry',
      prompt: LocalizedText(en: 'Excuse me / sorry', ru: 'Извините / извини'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'si-GHNO-mi', ru: 'си-ГНО-ми'),
      explanation: LocalizedText(
        en: 'The same word works for an apology or to get attention.',
        ru: 'Одно слово подходит и на «ты», и на «Вы»: извинение или вежливое привлечение внимания.',
      ),
      greek: 'Συγγνώμη!',
    ),
    VocabularyCard(
      id: 'nice-meeting',
      prompt: LocalizedText(
        en: 'Nice to meet you! (after an introduction)',
        ru: 'Рад знакомству! (одно слово, буквально «обрадовался»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'KHA-ri-ka', ru: 'ХА-ри-ка'),
      explanation: LocalizedText(
        en: 'Literally “I was pleased”; the speaker’s gender does not change the Greek form.',
        ru: 'Буквально «я обрадовался/обрадовалась». По-гречески форма одинакова для мужчины и женщины.',
      ),
      greek: 'Χάρηκα!',
    ),
    VocabularyCard(
      id: 'see-you',
      prompt: LocalizedText(en: 'See you!', ru: 'Увидимся!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ta LE-me', ru: 'та ЛЭ-мэ'),
      explanation: LocalizedText(
        en: 'An idiom: literally “we say them,” naturally “see you.”',
        ru: 'Устойчивое выражение: переводим «увидимся», а не дословно «мы их говорим».',
      ),
      greek: 'Τα λέμε!',
    ),
    VocabularyCard(
      id: 'see-tomorrow',
      prompt: LocalizedText(en: 'See you tomorrow!', ru: 'До завтра!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'ta LE-me AV-ri-o',
        ru: 'та ЛЭ-мэ АВ-ри-о',
      ),
      explanation: LocalizedText(
        en: 'Αύριο means tomorrow. Αυ before ρ sounds /av/.',
        ru: 'Αύριο — завтра; αυ перед ρ звучит «ав». Фраза означает «увидимся завтра».',
      ),
      greek: 'Τα λέμε αύριο!',
    ),
  ],
);
