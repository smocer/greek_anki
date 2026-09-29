import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const seeingObjectsDeck = VocabularyDeck(
  id: 'seeing-objects',
  title: LocalizedText(
    en: 'I see…: the accusative',
    ru: 'Я вижу…: винительный',
  ),
  subtitle: LocalizedText(
    en: 'People, pictures and things',
    ru: 'Люди, картинки и предметы',
  ),
  cover: 'βλέπω',
  note: LocalizedText(
    en: 'Use βλέπω followed by the person or thing you see. Masculine names lose final ς; most feminine nouns change only their article; neuter forms stay the same. Εγώ is optional.',
    ru: 'После βλέπω «я вижу» — винительный: вижу кого? что? Мужские имена теряют -ς; у большинства женских слов меняется только артикль, у среднего рода обе формы совпадают. Εγώ «я» можно опустить.',
  ),
  cards: [
    VocabularyCard(
      id: 'george',
      prompt: LocalizedText(en: 'I see George.', ru: 'Я вижу Йоргоса.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω τον Γιώργο.',
      pronunciation: LocalizedText(
        en: 'VLE-po ton YOR-gho',
        ru: 'ВЛЭ-по тон ЙОР-го',
      ),
      explanation: LocalizedText(
        en: 'Ο Γιώργος → τον Γιώργο: the person seen is the direct object.',
        ru: 'Как «вижу кого? Йоргоса» — винительный. Ο Γιώργος → τον Γιώργο: меняется артикль и исчезает -ς.',
      ),
      acceptedAnswers: ['Εγώ βλέπω τον Γιώργο.'],
    ),
    VocabularyCard(
      id: 'kostas',
      prompt: LocalizedText(en: 'I see Kostas.', ru: 'Я вижу Костаса.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω τον Κώστα.',
      pronunciation: LocalizedText(
        en: 'VLE-po ton KOS-ta',
        ru: 'ВЛЭ-по тон КОС-та',
      ),
      explanation: LocalizedText(
        en: 'Ο Κώστας → τον Κώστα. A masculine name in -ας loses final ς in the accusative.',
        ru: 'Ο Κώστας → τον Κώστα. Как у имён на -ος, в винительном убираем конечную -ς.',
      ),
      acceptedAnswers: ['Εγώ βλέπω τον Κώστα.'],
    ),
    VocabularyCard(
      id: 'john',
      prompt: LocalizedText(en: 'I see Yiannis.', ru: 'Я вижу Янниса.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω τον Γιάννη.',
      pronunciation: LocalizedText(
        en: 'VLE-po ton YA-ni',
        ru: 'ВЛЭ-по тон Я-ни',
      ),
      explanation: LocalizedText(
        en: 'Ο Γιάννης → τον Γιάννη. A masculine name in -ης loses final ς.',
        ru: 'Ο Γιάννης → τον Γιάννη. По-русски «вижу Янниса», по-гречески окончание винительного -η.',
      ),
      acceptedAnswers: ['Εγώ βλέπω τον Γιάννη.'],
    ),
    VocabularyCard(
      id: 'maria',
      prompt: LocalizedText(en: 'I see Maria.', ru: 'Я вижу Марию.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω την Μαρία.',
      pronunciation: LocalizedText(
        en: 'VLE-po tin ma-RI-a',
        ru: 'ВЛЭ-по тин ма-РИ-а',
      ),
      explanation: LocalizedText(
        en: 'Η Μαρία → την Μαρία. The article changes; the name stays the same.',
        ru: 'По-русски «Мария → Марию», но в греческом имя не меняется: η Μαρία → την Μαρία. Винительный виден по артиклю.',
      ),
      alternatives: ['Βλέπω τη Μαρία.'],
      acceptedAnswers: ['Εγώ βλέπω την Μαρία.', 'Εγώ βλέπω τη Μαρία.'],
    ),
    VocabularyCard(
      id: 'eleni',
      prompt: LocalizedText(en: 'I see Eleni.', ru: 'Я вижу Элени.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω την Ελένη.',
      pronunciation: LocalizedText(
        en: 'VLE-po tin e-LE-ni',
        ru: 'ВЛЭ-по тин э-ЛЭ-ни',
      ),
      explanation: LocalizedText(
        en: 'Η Ελένη → την Ελένη. Feminine names in -η keep the same noun form.',
        ru: 'Имя Ελένη остаётся тем же: η → την. Для сравнения, русское «Елена → Елену» меняет окончание.',
      ),
      acceptedAnswers: ['Εγώ βλέπω την Ελένη.'],
    ),
    VocabularyCard(
      id: 'picture',
      prompt: LocalizedText(en: 'I see the picture.', ru: 'Я вижу картинку.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω την εικόνα.',
      pronunciation: LocalizedText(
        en: 'VLE-po tin i-KO-na',
        ru: 'ВЛЭ-по тин и-КО-на',
      ),
      explanation: LocalizedText(
        en: 'Η εικόνα → την εικόνα: a feminine direct object.',
        ru: '«Картинка → картинку»: в русском меняется окончание, а здесь только артикль: η εικόνα → την εικόνα.',
      ),
      acceptedAnswers: ['Εγώ βλέπω την εικόνα.'],
    ),
    VocabularyCard(
      id: 'train',
      prompt: LocalizedText(en: 'I see the train.', ru: 'Я вижу поезд.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω το τρένο.',
      pronunciation: LocalizedText(
        en: 'VLE-po to TRE-no',
        ru: 'ВЛЭ-по то ТРЭ-но',
      ),
      explanation: LocalizedText(
        en: 'Neuter nominative and accusative match: το τρένο in both cases.',
        ru: 'Το τρένο — средний род. Именительный и винительный совпадают: το τρένο. Роль объекта понятна из предложения.',
      ),
      acceptedAnswers: ['Εγώ βλέπω το τρένο.'],
    ),
    VocabularyCard(
      id: 'child',
      prompt: LocalizedText(en: 'I see the child.', ru: 'Я вижу ребёнка.'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω το παιδί.',
      pronunciation: LocalizedText(
        en: 'VLE-po to pe-DHI',
        ru: 'ВЛЭ-по то пэ-ДИ',
      ),
      explanation: LocalizedText(
        en: 'Το παιδί is neuter even though it names a person; its accusative is also το παιδί.',
        ru: 'В русском «ребёнок → ребёнка», но в греческом το παιδί — средний род. Винительный совпадает с именительным.',
      ),
      acceptedAnswers: ['Εγώ βλέπω το παιδί.'],
    ),
    VocabularyCard(
      id: 'letter',
      prompt: LocalizedText(
        en: 'I see the letter (message).',
        ru: 'Я вижу письмо.',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'Βλέπω το γράμμα.',
      pronunciation: LocalizedText(
        en: 'VLE-po to GHRA-ma',
        ru: 'ВЛЭ-по то ГРА-ма',
      ),
      explanation: LocalizedText(
        en: 'Neuter nouns in -μα also keep their form in the accusative.',
        ru: 'Как русское «вижу письмо», средний род здесь не меняет форму: το γράμμα → το γράμμα.',
      ),
      acceptedAnswers: ['Εγώ βλέπω το γράμμα.'],
    ),
  ],
);
