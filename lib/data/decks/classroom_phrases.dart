import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const classroomPhrasesDeck = VocabularyDeck(
  id: 'classroom-phrases',
  title: LocalizedText(en: 'Useful classroom phrases', ru: 'Фразы на уроке'),
  subtitle: LocalizedText(
    en: 'Understand, ask and follow along',
    ru: 'Понять, спросить, выполнить',
  ),
  note: LocalizedText(
    en: 'Commands also distinguish ты and вы/Вы: έλα / ελάτε. Learn useful whole phrases, not only isolated words.',
    ru: 'В повелительном наклонении тоже есть ты/Вы: έλα / ελάτε, как «иди / идите». Учим фразы целиком.',
  ),
  cover: 'Τι σημαίνει;',
  cards: [
    VocabularyCard(
      id: 'come',
      prompt: LocalizedText(
        en: 'Come here! (informal)',
        ru: 'Иди сюда! (на «ты»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'E-la e-DHO', ru: 'Э-ла э-ДО'),
      explanation: LocalizedText(
        en: 'Έλα is the singular command “come”; εδώ is here.',
        ru: 'Έλα — «иди сюда/подойди» одному. Это повелительная форма, не «я иду».',
      ),
      greek: 'Έλα εδώ!',
    ),
    VocabularyCard(
      id: 'come-word',
      prompt: LocalizedText(
        en: 'Come! (informal, one word)',
        ru: 'Иди сюда! (на «ты», одно слово)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'E-la', ru: 'Э-ла'),
      explanation: LocalizedText(
        en: 'Often used alone in speech.',
        ru: 'Έλα — обращение к одному на «ты», как «подойди». Для группы или вежливого обращения — ελάτε.',
      ),
      greek: 'Έλα!',
    ),
    VocabularyCard(
      id: 'come-polite',
      prompt: LocalizedText(
        en: 'Come! (polite/plural, one word)',
        ru: 'Подойдите! (на «Вы» / нескольким)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'e-LA-te', ru: 'э-ЛА-тэ'),
      explanation: LocalizedText(
        en: 'Plural command, also polite to one person.',
        ru: 'Έλα → ελάτε: как «подойди → подойдите», с переносом ударения.',
      ),
      greek: 'Ελάτε!',
    ),
    VocabularyCard(
      id: 'lets-go',
      prompt: LocalizedText(en: 'Let’s go!', ru: 'Пойдём! / Пойдёмте!'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'PA-me', ru: 'ПА-мэ'),
      explanation: LocalizedText(
        en: 'Literally “we go”; used as an invitation.',
        ru: 'Форма «мы идём» употребляется как побуждение «пойдём(те)!».',
      ),
      greek: 'Πάμε!',
    ),
    VocabularyCard(
      id: 'meaning',
      prompt: LocalizedText(en: 'What does it mean?', ru: 'Что это значит?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ti si-ME-ni', ru: 'ти си-МЭ-ни'),
      explanation: LocalizedText(
        en: 'Τι = what; σημαίνει = it means.',
        ru: 'Σημαίνει — третье лицо, «значит». Вопросительный знак по-гречески выглядит как точка с запятой.',
      ),
      greek: 'Τι σημαίνει;',
    ),
    VocabularyCard(
      id: 'dont-know',
      prompt: LocalizedText(en: 'I don’t know.', ru: 'Я не знаю.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'dhen KSE-ro', ru: 'дэн КСЭ-ро'),
      explanation: LocalizedText(
        en: 'Δεν negates the verb; ξ is /ks/.',
        ru: 'Δεν перед глаголом соответствует «не». Ξ — один знак для звуков «кс».',
      ),
      greek: 'Δεν ξέρω.',

      acceptedAnswers: ['Εγώ δεν ξέρω.'],
    ),
    VocabularyCard(
      id: 'dont-understand',
      prompt: LocalizedText(en: 'I don’t understand.', ru: 'Я не понимаю.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'dhen ka-ta-la-VE-no',
        ru: 'дэн ка-та-ла-ВЭ-но',
      ),
      explanation: LocalizedText(
        en: 'Β is /v/; αι is /e/.',
        ru: 'Δεν + глагол, как «не + понимаю». Β произносится «в», αι — «э».',
      ),
      greek: 'Δεν καταλαβαίνω.',

      acceptedAnswers: ['Εγώ δεν καταλαβαίνω.'],
    ),
    VocabularyCard(
      id: 'slower',
      prompt: LocalizedText(
        en: 'More slowly, please.',
        ru: 'Помедленнее, пожалуйста.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'pyo ar-GHA pa-ra-ka-LO',
        ru: 'пьо ар-ГА па-ра-ка-ЛО',
      ),
      explanation: LocalizedText(
        en: 'Πιο makes a comparison: more slowly.',
        ru: 'Πιο соответствует «более»: πιο αργά — более медленно, помедленнее.',
      ),
      greek: 'Πιο αργά, παρακαλώ.',
    ),
    VocabularyCard(
      id: 'repeat',
      prompt: LocalizedText(
        en: 'Repeat, please. (polite/plural command)',
        ru: 'Повторите, пожалуйста. (повелительное)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'e-pa-na-LA-ve-te pa-ra-ka-LO',
        ru: 'э-па-на-ЛА-вэ-тэ па-ра-ка-ЛО',
      ),
      explanation: LocalizedText(
        en: 'A polite/plural command; β sounds /v/.',
        ru: 'Окончание -τε, как обращение на «Вы» или к группе. Не форма «повтори».',
      ),
      greek: 'Επαναλάβετε, παρακαλώ.',
    ),
    VocabularyCard(
      id: 'say-greek',
      prompt: LocalizedText(
        en: 'How do we say it in Greek?',
        ru: 'Как это сказать по-гречески? (используйте глагол «говорить» в форме «мы»)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'pos to LE-me sta e-li-ni-KA',
        ru: 'пос то ЛЭ-мэ ста э-ли-ни-КА',
      ),
      explanation: LocalizedText(
        en: 'Το is the object “it”; στα ελληνικά means in Greek.',
        ru: 'Το здесь «это», краткое дополнение. Στα ελληνικά — «по-гречески», буквально «на греческом».',
      ),
      greek: 'Πώς το λέμε στα ελληνικά;',
    ),
    VocabularyCard(
      id: 'open-book',
      prompt: LocalizedText(
        en: 'Open the book! (polite/plural)',
        ru: 'Откройте книгу!',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-NIK-ste to viv-LI-o',
        ru: 'а-НИК-стэ то вив-ЛИ-о',
      ),
      explanation: LocalizedText(
        en: 'Το βιβλίο is accusative, identical to the nominative for this neuter noun.',
        ru: 'В русском «книгу» — винительный. В греческом το βιβλίο тоже винительный, но форма среднего рода не меняется.',
      ),
      greek: 'Ανοίξτε το βιβλίο!',
    ),
    VocabularyCard(
      id: 'for-example',
      prompt: LocalizedText(en: 'For example', ru: 'Например'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'ya pa-RA-dhigh-ma',
        ru: 'я па-РА-диг-ма',
      ),
      explanation: LocalizedText(
        en: 'A fixed expression; no article in this phrase.',
        ru: 'Устойчивое «например»: здесь нет артикля το, хотя отдельно учим το παράδειγμα.',
      ),
      greek: 'Για παράδειγμα',
    ),
  ],
);
