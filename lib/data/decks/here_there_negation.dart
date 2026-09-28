import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const hereThereNegationDeck = VocabularyDeck(
  id: 'here-there-negation',
  title: LocalizedText(
    en: 'Here, there & not here',
    ru: 'Здесь, там и отрицание',
  ),
  subtitle: LocalizedText(
    en: 'To be in a real conversation',
    ru: 'Είμαι в разговоре',
  ),
  note: LocalizedText(
    en: 'Greek keeps the verb to be and puts δεν before it. Με takes an accusative companion, unlike Russian с + instrumental.',
    ru: 'Греческий сохраняет «быть», даже когда русский обходится без него. Δεν перед глаголом — «не»; με «с» требует винительного, а не русского творительного.',
  ),
  cover: 'Εκεί',
  cards: [
    VocabularyCard(
      id: 'he-not-here',
      prompt: LocalizedText(en: 'He is not here.', ru: 'Его здесь нет.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Δεν είναι εδώ.',
      pronunciation: LocalizedText(en: 'dhen I-ne e-DHO', ru: 'дэн И-нэ э-ДО'),
      explanation: LocalizedText(
        en: 'Είναι serves he/she/it; δεν makes the statement negative.',
        ru: 'Русское «его нет» передаём δεν είναι «он не есть». Не используем όχι вместо отрицания перед глаголом.',
      ),
      acceptedAnswers: ['Αυτός δεν είναι εδώ.'],
    ),
    VocabularyCard(
      id: 'where-you',
      prompt: LocalizedText(en: 'Where are you? (informal)', ru: 'Ты где?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πού είσαι;',
      pronunciation: LocalizedText(en: 'pu I-se', ru: 'пу И-сэ'),
      explanation: LocalizedText(
        en: 'Είσαι is the informal second person of είμαι.',
        ru: 'В русском можно «ты где?», но по-гречески нужен είσαι, не μένεις «живёшь».',
      ),
      acceptedAnswers: ['Εσύ πού είσαι;', 'Πού είσαι εσύ;'],
    ),
    VocabularyCard(
      id: 'not-airport',
      prompt: LocalizedText(
        en: 'Are you not at the airport? (informal)',
        ru: 'Разве ты не в аэропорту?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Δεν είσαι στο αεροδρόμιο;',
      pronunciation: LocalizedText(
        en: 'dhen I-se sto a-e-ro-DHRO-mi-o',
        ru: 'дэн И-сэ сто а-э-ро-ДРО-ми-о',
      ),
      explanation: LocalizedText(
        en: 'A negative question still uses δεν before the verb.',
        ru: 'Как русское «ты не…?»: δεν перед είσαι. Το αεροδρόμιο — средний род, поэтому στο.',
      ),
    ),
    VocabularyCard(
      id: 'i-home',
      prompt: LocalizedText(en: 'I am at home.', ru: 'Я дома.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Είμαι στο σπίτι.',
      pronunciation: LocalizedText(
        en: 'I-me sto SPI-ti',
        ru: 'И-мэ сто СПИ-ти',
      ),
      explanation: LocalizedText(
        en: 'Greek uses είμαι + στο σπίτι for at home.',
        ru: 'Русское наречие «дома» передаём στο σπίτι: предлог + артикль + существительное.',
      ),
      acceptedAnswers: ['Εγώ είμαι στο σπίτι.'],
    ),
    VocabularyCard(
      id: 'home-with-julia',
      prompt: LocalizedText(
        en: 'I am at home with Julia.',
        ru: 'Я дома с Джулией.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Είμαι στο σπίτι με την Τζούλια.',
      pronunciation: LocalizedText(
        en: 'I-me sto SPI-ti me tin DZU-lya',
        ru: 'И-мэ сто СПИ-ти мэ тин ДЗУ-ля',
      ),
      explanation: LocalizedText(
        en: 'Με takes the accusative; keep ν before τζ.',
        ru: 'В русском «с Джулией» — творительный; в греческом με την Τζούλια — винительный. Перед τζ сохраняем ν.',
      ),
      acceptedAnswers: ['Εγώ είμαι στο σπίτι με την Τζούλια.'],
    ),
    VocabularyCard(
      id: 'giannis-airport',
      prompt: LocalizedText(
        en: 'Giannis is at the airport.',
        ru: 'Яннис в аэропорту.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ο Γιάννης είναι στο αεροδρόμιο.',
      pronunciation: LocalizedText(
        en: 'o YA-nis I-ne sto a-e-ro-DHRO-mi-o',
        ru: 'о Я-нис И-нэ сто а-э-ро-ДРО-ми-о',
      ),
      explanation: LocalizedText(
        en: 'The subject has ο; the location uses στο.',
        ru: 'Ο Γιάννης — именительный, στο αεροδρόμιο — место после σε с винительным.',
      ),
    ),
    VocabularyCard(
      id: 'they-not-near',
      prompt: LocalizedText(
        en: 'They do not live nearby.',
        ru: 'Они не живут рядом.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Δεν μένουν κοντά.',
      pronunciation: LocalizedText(
        en: 'dhen ME-nun kon-DA',
        ru: 'дэн МЭ-нун кон-ДА',
      ),
      explanation: LocalizedText(
        en: 'Δεν/δε can precede μένουν; μένουνε is also a plural form.',
        ru: 'Как «не живут»: δεν перед глаголом. Перед μ встречаются δεν и δε; μένουνε — вариант множественного.',
      ),
      alternatives: [
        'Δε μένουν κοντά.',
        'Δεν μένουνε κοντά.',
        'Δε μένουνε κοντά.',
      ],
      acceptedAnswers: ['Αυτοί δεν μένουν κοντά.', 'Αυτές δεν μένουν κοντά.'],
    ),
    VocabularyCard(
      id: 'we-there',
      prompt: LocalizedText(en: 'We are there.', ru: 'Мы там.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Είμαστε εκεί.',
      pronunciation: LocalizedText(en: 'I-ma-ste e-KI', ru: 'И-ма-стэ э-КИ'),
      explanation: LocalizedText(
        en: 'Εκεί is there; εδώ is here.',
        ru: 'Сравните здесь/там: εδώ/εκεί. Для «мы» нужна форма είμαστε.',
      ),
      acceptedAnswers: ['Εμείς είμαστε εκεί.'],
    ),
  ],
);
