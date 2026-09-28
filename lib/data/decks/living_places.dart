import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const livingPlacesDeck = VocabularyDeck(
  id: 'living-places',
  title: LocalizedText(en: 'Where I live', ru: 'Где я живу'),
  subtitle: LocalizedText(
    en: 'Greece, Cyprus and local districts',
    ru: 'Греция, Кипр и районы',
  ),
  note: LocalizedText(
    en: 'These are residence statements, not origin statements. Σε + accusative gives στον, στην/στη, στο, στα according to the place name.',
    ru: '«Я живу в…» отличается от «я из…». После σε — винительный: στον / στην / στο / στα. Род и число названия определяют артикль, а не русские «в/на».',
  ),
  cover: 'Μένω',
  cards: [
    VocabularyCard(
      id: 'live-greece',
      prompt: LocalizedText(en: 'I live in Greece.', ru: 'Я живу в Греции.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στην Ελλάδα.',
      pronunciation: LocalizedText(
        en: 'ME-no stin e-LA-dha',
        ru: 'МЭ-но стин э-ЛА-да',
      ),
      explanation: LocalizedText(
        en: 'Η Ελλάδα is feminine; keep ν before the vowel.',
        ru: 'Η Ελλάδα → στην Ελλάδα. Русское «в Греции» — предложный, но здесь винительный.',
      ),
      acceptedAnswers: ['Εγώ μένω στην Ελλάδα.'],
    ),
    VocabularyCard(
      id: 'live-athens',
      prompt: LocalizedText(en: 'I live in Athens.', ru: 'Я живу в Афинах.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στην Αθήνα.',
      pronunciation: LocalizedText(
        en: 'ME-no stin a-THI-na',
        ru: 'МЭ-но стин а-ТИ-на',
      ),
      explanation: LocalizedText(
        en: 'Modern Αθήνα is feminine singular, despite English Athens.',
        ru: 'В русском «Афины» — множественное число, в современном греческом η Αθήνα — единственное.',
      ),
      acceptedAnswers: ['Εγώ μένω στην Αθήνα.'],
    ),
    VocabularyCard(
      id: 'live-kypseli',
      prompt: LocalizedText(en: 'I live in Kypseli.', ru: 'Я живу в Кипсели.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στην Κυψέλη.',
      pronunciation: LocalizedText(
        en: 'ME-no stin ki-PSE-li',
        ru: 'МЭ-но стин ки-ПСЭ-ли',
      ),
      explanation: LocalizedText(
        en: 'Η Κυψέλη is feminine; ν remains before κ.',
        ru: 'Район η Κυψέλη: женский род, поэтому στην, не στον. Перед κ сохраняется ν.',
      ),
      acceptedAnswers: ['Εγώ μένω στην Κυψέλη.'],
    ),
    VocabularyCard(
      id: 'live-piraeus',
      prompt: LocalizedText(en: 'I live in Piraeus.', ru: 'Я живу в Пирее.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στον Πειραιά.',
      pronunciation: LocalizedText(
        en: 'ME-no ston pi-re-A',
        ru: 'МЭ-но стон пи-рэ-А',
      ),
      explanation: LocalizedText(
        en: 'Ο Πειραιάς becomes στον Πειραιά in the accusative.',
        ru: 'Как изменение «Пирей → в Пирее», но падеж другой: ο Πειραιάς → στον Πειραιά, без -ς.',
      ),
      acceptedAnswers: ['Εγώ μένω στον Πειραιά.'],
    ),
    VocabularyCard(
      id: 'live-pasalimani',
      prompt: LocalizedText(
        en: 'I live in Pasalimani.',
        ru: 'Я живу в Пасалимани.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στο Πασαλιμάνι.',
      pronunciation: LocalizedText(
        en: 'ME-no sto pa-sa-li-MA-ni',
        ru: 'МЭ-но сто па-са-ли-МА-ни',
      ),
      explanation: LocalizedText(
        en: 'Το Πασαλιμάνι is neuter, unlike masculine Piraeus.',
        ru: 'Το Πασαλιμάνι — средний род: στο, хотя для Пирея нужен στον.',
      ),
      acceptedAnswers: ['Εγώ μένω στο Πασαλιμάνι.'],
    ),
    VocabularyCard(
      id: 'live-nicosia',
      prompt: LocalizedText(en: 'I live in Nicosia.', ru: 'Я живу в Никосии.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στη Λευκωσία.',
      pronunciation: LocalizedText(
        en: 'ME-no sti lef-ko-SI-a',
        ru: 'МЭ-но сти лэф-ко-СИ-а',
      ),
      explanation: LocalizedText(
        en: 'Nicosia is Λευκωσία in Greek; στη normally loses ν before λ.',
        ru: 'Никосия по-гречески Λευκωσία. Перед λ обычно στη; вариант στην из тетради тоже принимается.',
      ),
      alternatives: ['Μένω στην Λευκωσία.'],
      acceptedAnswers: ['Εγώ μένω στη Λευκωσία.', 'Εγώ μένω στην Λευκωσία.'],
    ),
    VocabularyCard(
      id: 'live-latsia',
      prompt: LocalizedText(en: 'I live in Latsia.', ru: 'Я живу в Латсии.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στα Λατσιά.',
      pronunciation: LocalizedText(
        en: 'ME-no sta la-TSHA',
        ru: 'МЭ-но ста ла-ТША',
      ),
      explanation: LocalizedText(
        en: 'Τα Λατσιά is a plural place name: σε + τα = στα. Local τσι is often pronounced like ch.',
        ru: 'Τα Λατσιά — множественное число, поэтому στα. Это свойство названия, как у русских «Афины». Местное τσι звучит близко к «ч».',
      ),
      acceptedAnswers: ['Εγώ μένω στα Λατσιά.'],
    ),
    VocabularyCard(
      id: 'live-strovolos',
      prompt: LocalizedText(
        en: 'I live in Strovolos.',
        ru: 'Я живу в Строволосе.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στον Στρόβολο.',
      pronunciation: LocalizedText(
        en: 'ME-no ston STRO-vo-lo',
        ru: 'МЭ-но стон СТРО-во-ло',
      ),
      explanation: LocalizedText(
        en: 'Ο Στρόβολος loses final ς in the accusative.',
        ru: 'Мужской род: ο Στρόβολος → στον Στρόβολο. Винительный убирает конечное -ς.',
      ),
      acceptedAnswers: ['Εγώ μένω στον Στρόβολο.'],
    ),
    VocabularyCard(
      id: 'live-kalamaria',
      prompt: LocalizedText(
        en: 'I live in Kalamaria.',
        ru: 'Я живу в Каламарье.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στην Καλαμαριά.',
      pronunciation: LocalizedText(
        en: 'ME-no stin ka-la-ma-RYA',
        ru: 'МЭ-но стин ка-ла-ма-РЬЯ',
      ),
      explanation: LocalizedText(
        en: 'Η Καλαμαριά is feminine; use στην before κ.',
        ru: 'Η Καλαμαριά — женский род; σε + την = στην, ν перед κ сохраняется.',
      ),
      acceptedAnswers: ['Εγώ μένω στην Καλαμαριά.'],
    ),
    VocabularyCard(
      id: 'live-kaisariani',
      prompt: LocalizedText(
        en: 'I live in Kaisariani.',
        ru: 'Я живу в Кесариани.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στην Καισαριανή.',
      pronunciation: LocalizedText(
        en: 'ME-no stin ke-sa-ria-NI',
        ru: 'МЭ-но стин кэ-са-рья-НИ',
      ),
      explanation: LocalizedText(
        en: 'Η Καισαριανή is feminine; αι in Και- sounds /e/.',
        ru: 'Сочетание αι в начале читается «э». Женский род: στην Καισαριανή.',
      ),
      acceptedAnswers: ['Εγώ μένω στην Καισαριανή.'],
    ),
    VocabularyCard(
      id: 'live-filothei',
      prompt: LocalizedText(en: 'I live in Filothei.', ru: 'Я живу в Филотеи.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στη Φιλοθέη.',
      pronunciation: LocalizedText(
        en: 'ME-no sti fi-lo-THE-i',
        ru: 'МЭ-но сти фи-ло-ТЭ-и',
      ),
      explanation: LocalizedText(
        en: 'Η Φιλοθέη is feminine; στη usually loses ν before φ.',
        ru: 'Перед φ обычно στη. В Φιλοθέη сочетание έη — два гласных, не один.',
      ),
      alternatives: ['Μένω στην Φιλοθέη.'],
      acceptedAnswers: ['Εγώ μένω στη Φιλοθέη.'],
    ),
    VocabularyCard(
      id: 'live-goudi',
      prompt: LocalizedText(en: 'I live in Goudi.', ru: 'Я живу в Гуди.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω στο Γουδί.',
      pronunciation: LocalizedText(
        en: 'ME-no sto ghu-DHI',
        ru: 'МЭ-но сто гу-ДИ',
      ),
      explanation: LocalizedText(
        en: 'Το Γουδί is a neuter place name.',
        ru: 'Το Γουδί — средний род: στο Γουδί. Окончание имени здесь не меняется.',
      ),
      acceptedAnswers: ['Εγώ μένω στο Γουδί.'],
    ),
    VocabularyCard(
      id: 'live-china',
      prompt: LocalizedText(
        en: 'The children live in China now.',
        ru: 'Дети сейчас живут в Китае.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τα παιδιά μένουν στην Κίνα τώρα.',
      pronunciation: LocalizedText(
        en: 'ta pe-DHYA ME-nun stin KI-na TO-ra',
        ru: 'та пэ-ДЬЯ МЭ-нун стин КИ-на ТО-ра',
      ),
      explanation: LocalizedText(
        en: 'A plural subject needs μένουν; η Κίνα is feminine.',
        ru: 'Дети — множественное число: τα παιδιά μένουν. Китай по-гречески женского рода: η Κίνα → στην Κίνα.',
      ),
      alternatives: ['Τα παιδιά μένουνε στην Κίνα τώρα.'],
    ),
  ],
);
