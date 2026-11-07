import '../domain/app_language.dart';

LocalizedText _t(String en, String ru) =>
    LocalizedText(en: en, ru: ru, zh: _chineseReference[en]);

class GrammarTable {
  GrammarTable(this.title, this.headers, this.rows, {this.rowLabels});
  final LocalizedText title;
  final List<LocalizedText> headers;
  final List<List<String>> rows;

  /// Localized first-column labels; Greek examples remain unchanged.
  final List<LocalizedText>? rowLabels;
}

class GrammarTopic {
  GrammarTopic(this.id, this.title, this.summary, this.notes, this.tables);
  final String id;
  final LocalizedText title, summary;
  final List<LocalizedText> notes;
  final List<GrammarTable> tables;
}

const grammarPersons = [
  'εγώ',
  'εσύ',
  'αυτός / αυτή / αυτό',
  'εμείς',
  'εσείς',
  'αυτοί / αυτές / αυτά',
];
const _writePresent = [
  'γράφω',
  'γράφεις',
  'γράφει',
  'γράφουμε',
  'γράφετε',
  'γράφουν',
];
const _writeFuture = [
  'γράψω',
  'γράψεις',
  'γράψει',
  'γράψουμε',
  'γράψετε',
  'γράψουν',
];

GrammarTable _verbs(
  String en,
  String ru,
  List<LocalizedText> headings,
  List<List<String>> forms,
) => GrammarTable(
  _t(en, ru),
  [_t('Person', 'Лицо'), ...headings],
  [
    for (var i = 0; i < 6; i++)
      [grammarPersons[i], for (final column in forms) column[i]],
  ],
  rowLabels: _personLabels,
);

// Original beginner explanations and examples. Sources for the paradigms:
// Centre for the Greek Language / Greek school grammar, linked in docs/grammar.md.
final _grammarTopics = <GrammarTopic>[
  GrammarTopic(
    'be',
    _t('Be · είμαι', 'Быть · είμαι'),
    _t(
      'All persons, singular and plural: present, past and future.',
      'Три лица в единственном и множественном числе: настоящее, прошедшее и будущее.',
    ),
    [
      _t(
        'εγώ = I, εσύ = you (one person), αυτός/αυτή/αυτό = he/she/it; εμείς = we, εσείς = you (plural or polite), αυτοί/αυτές/αυτά = they. The first three are singular; the last three plural.',
        'εγώ = я, εσύ = ты, αυτός/αυτή/αυτό = он/она/оно; εμείς = мы, εσείς = вы (множественное или вежливое), αυτοί/αυτές/αυτά = они. Первые три — единственное число, остальные — множественное.',
      ),
      _t(
        'The verb ending usually identifies the person, so subject pronouns can be omitted. Είμαι εδώ. = I am here. Ήμασταν σπίτι. = We were home. Θα είσαι εκεί; = Will you be there?',
        'Окончание обычно указывает лицо, поэтому местоимение можно опустить. Είμαι εδώ. = Я здесь. Ήμασταν σπίτι. = Мы были дома. Θα είσαι εκεί; = Ты будешь там?',
      ),
      _t(
        'είμαι is irregular. Use ήμουν for past “was” and θα είμαι for future “will be”. Possession and noun cases belong to nouns and pronouns, not verb conjugation.',
        'είμαι — неправильный глагол. Прошедшее «был» — ήμουν, будущее «буду» — θα είμαι. Принадлежность и падежи относятся к существительным и местоимениям, а не к спряжению.',
      ),
    ],
    [
      _verbs(
        'Be · Three tenses',
        'Быть · Три времени',
        [
          _t('Present', 'Настоящее'),
          _t('Past', 'Прошедшее'),
          _t('Future', 'Будущее'),
        ],
        [
          ['είμαι', 'είσαι', 'είναι', 'είμαστε', 'είστε', 'είναι'],
          ['ήμουν', 'ήσουν', 'ήταν', 'ήμασταν', 'ήσασταν', 'ήταν'],
          [
            'θα είμαι',
            'θα είσαι',
            'θα είναι',
            'θα είμαστε',
            'θα είστε',
            'θα είναι',
          ],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'present',
    _t('Verb conjugation · Present', 'Обычные глаголы · Настоящее'),
    _t(
      'Person, number and common conjugation groups.',
      'Лицо, число и основные группы спряжения.',
    ),
    [
      _t(
        'Many verbs with an unstressed -ω use -ω, -εις, -ει, -ουμε, -ετε, -ουν. γράφω = I write / am writing. The same present form expresses habits and ongoing actions.',
        'Многие глаголы с безударным -ω имеют окончания -ω, -εις, -ει, -ουμε, -ετε, -ουν. γράφω = я пишу. Одна форма передаёт привычку и действие сейчас.',
      ),
      _t(
        'Stressed -άω/-ώ and -ώ verbs use other endings: αγαπάω/αγαπώ = I love; μπορώ = I can. Some forms have alternatives such as αγαπά/αγαπάει and γράφουν/γράφουνε. Learn the group together with the verb.',
        'Глаголы с ударным -άω/-ώ и -ώ имеют другие окончания: αγαπάω/αγαπώ = я люблю; μπορώ = я могу. Есть варианты вроде αγαπά/αγαπάει и γράφουν/γράφουνε. Учите группу вместе с глаголом.',
      ),
      _t(
        'Negation: δεν γράφω = I do not write. Questions use the same conjugation: Γράφεις; = Are you writing? The Greek question mark is ;.',
        'Отрицание: δεν γράφω = я не пишу. Вопрос не меняет спряжение: Γράφεις; = Ты пишешь? Греческий вопросительный знак — ;.',
      ),
    ],
    [
      _verbs(
        'Present groups',
        'Группы настоящего времени',
        [_t('Write', 'Писать'), _t('Love', 'Любить'), _t('Can', 'Мочь')],
        [
          _writePresent,
          ['αγαπώ', 'αγαπάς', 'αγαπά', 'αγαπάμε', 'αγαπάτε', 'αγαπούν'],
          ['μπορώ', 'μπορείς', 'μπορεί', 'μπορούμε', 'μπορείτε', 'μπορούν'],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'past-future',
    _t(
      'Verb conjugation · Past & future',
      'Обычные глаголы · Прошедшее и будущее',
    ),
    _t(
      'Three basic tenses: present, past and future.',
      'Три основных времени: настоящее, прошедшее и будущее.',
    ),
    [
      _t(
        'Aspect distinguishes a process or repetition from an action viewed as a whole: έγραφα = I was writing / used to write; έγραψα = I wrote; θα γράφω = I will be writing; θα γράψω = I will write (as a whole action).',
        'Сравните: έγραφα — «писал» (процесс или повторение), έγραψα — «написал» (действие как целое); θα γράφω — «буду писать», θα γράψω — «напишу». Это помогает понять греческий вид, хотя он не во всём совпадает с русским совершенным и несовершенным видом.',
      ),
      _t(
        'Common aorist endings (action viewed as a whole): -α, -ες, -ε, -αμε, -ατε, -αν. Some verbs add έ- and move the stress: έγραψα, but γράψαμε. Learn the past form with each verb.',
        'Частые окончания аориста (действие как целое): -α, -ες, -ε, -αμε, -ατε, -αν. У некоторых глаголов появляется έ- и меняется ударение: έγραψα, но γράψαμε. Учите прошедшую форму вместе с глаголом.',
      ),
      _t(
        'For a process or repetition, use θα with the present form: θα γράφω. For an action viewed as a whole, use the perfective stem: θα γράψω, θα διαβάσω, θα δω, θα πάω.',
        'Для процесса или повторения используем θα с формой настоящего: θα γράφω — «буду писать». Для действия как целого нужна другая основа: θα γράψω — «напишу», θα διαβάσω — «прочитаю», θα δω — «увижу», θα πάω — «пойду».',
      ),
    ],
    [
      _verbs(
        'γράφω · Three tenses',
        'γράφω · Три времени',
        [
          _t('Present', 'Настоящее'),
          _t('Past', 'Прошедшее'),
          _t('Future', 'Будущее'),
        ],
        [
          _writePresent,
          ['έγραψα', 'έγραψες', 'έγραψε', 'γράψαμε', 'γράψατε', 'έγραψαν'],
          [for (final form in _writeFuture) 'θα $form'],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'passive',
    _t('Passive & middle voice', 'Страдательный и средний залог'),
    _t(
      'Passive forms in the present, past and future.',
      'Страдательный залог в настоящем, прошедшем и будущем времени.',
    ),
    [
      _t(
        'γράφω → γράφομαι: the subject receives the action. Το γράμμα γράφτηκε από την Μαρία. = The letter was written by Maria. από introduces the agent.',
        'γράφω → γράφομαι: действие направлено на подлежащее. Το γράμμα γράφτηκε από την Μαρία. = Письмо было написано Марией. από вводит исполнителя.',
      ),
      _t(
        'Common present endings: -ομαι, -εσαι, -εται, -όμαστε, -εστε, -ονται. Past passive often uses -τηκα or -θηκα, but stems and stress vary by verb. Other passive conjugation groups also exist.',
        'Частые окончания настоящего: -ομαι, -εσαι, -εται, -όμαστε, -εστε, -ονται. Прошедший пассив часто имеет -τηκα или -θηκα, но основа и ударение зависят от глагола. Есть и другие группы.',
      ),
      _t(
        'Past: γράφτηκε = it was written. Future: θα γραφτεί = it will be written. Use the table below to change the person.',
        'Прошедшее: γράφτηκε = было написано. Будущее: θα γραφτεί = будет написано. Формы для разных лиц приведены в таблице ниже.',
      ),
      _t(
        'An -μαι ending does not always mean passive: έρχομαι = I come; κοιμάμαι = I sleep; σηκώνομαι = I get up. Learn meaning and voice together.',
        'Окончание -μαι не всегда означает пассив: έρχομαι = я прихожу; κοιμάμαι = я сплю; σηκώνομαι = я встаю. Учите значение вместе с формой.',
      ),
    ],
    [
      _verbs(
        'Passive · Three tenses',
        'Страдательный залог · Три времени',
        [
          _t('Present', 'Настоящее'),
          _t('Past · whole action', 'Прошедшее · действие целиком'),
          _t('Future · whole action', 'Будущее · действие целиком'),
        ],
        [
          [
            'γράφομαι',
            'γράφεσαι',
            'γράφεται',
            'γραφόμαστε',
            'γράφεστε',
            'γράφονται',
          ],
          [
            'γράφτηκα',
            'γράφτηκες',
            'γράφτηκε',
            'γραφτήκαμε',
            'γραφτήκατε',
            'γράφτηκαν',
          ],
          [
            'θα γραφτώ',
            'θα γραφτείς',
            'θα γραφτεί',
            'θα γραφτούμε',
            'θα γραφτείτε',
            'θα γραφτούν',
          ],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'cases',
    _t('Cases & articles', 'Падежи и артикли'),
    _t('Gender, number and the four cases.', 'Род, число и четыре падежа.'),
    [
      _t(
        'Nouns have masculine, feminine or neuter gender. Learn the article with the noun. Case marks its role: nominative = subject; accusative = direct object and many prepositions; genitive = possession/relationship; vocative = direct address.',
        'У существительного мужской, женский или средний род. Учите слово с артиклем. Именительный — подлежащее; винительный — прямое дополнение и многие предлоги; родительный — принадлежность/отношение; звательный — обращение.',
      ),
      _t(
        'Ο φίλος βλέπει τον δάσκαλο. = The friend sees the teacher. Το βιβλίο του φίλου. = The friend’s book. Φίλε! = Friend! Vocatives normally have no article.',
        'Ο φίλος βλέπει τον δάσκαλο. = Друг видит учителя. Το βιβλίο του φίλου. = Книга друга. Φίλε! = Друг! При обращении артикля обычно нет.',
      ),
      _t(
        'Neuter nominative, accusative and vocative forms are identical: το βιβλίο, το βιβλίο, βιβλίο! The article is omitted in direct address.',
        'У среднего рода именительный, винительный и звательный совпадают: το βιβλίο, το βιβλίο, βιβλίο! При обращении артикль опускается.',
      ),
    ],
    [
      GrammarTable(
        _t('Definite articles', 'Определённые артикли'),
        [
          _t('Case', 'Падеж'),
          _t('Masculine · singular / plural', 'М · ед. / мн.'),
          _t('Feminine · singular / plural', 'Ж · ед. / мн.'),
          _t('Neuter · singular / plural', 'Ср · ед. / мн.'),
        ],
        [
          ['Nominative', 'ο / οι', 'η / οι', 'το / τα'],
          ['Genitive', 'του / των', 'της / των', 'του / των'],
          ['Accusative', 'τον / τους', 'την / τις', 'το / τα'],
          ['Vocative', '— / —', '— / —', '— / —'],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'nouns',
    _t('Noun forms · Declension', 'Склонение существительных'),
    _t(
      'Common endings with full singular and plural examples.',
      'Частые окончания: примеры во всех падежах и числах.',
    ),
    [
      _t(
        'Gender and noun class determine endings; there is no single rule for all nouns. Common plural patterns: masculine -ος → -οι, -ας → -ες, -ης → -ες; feminine -α/-η → -ες; neuter -ο → -α, -ι → -ια, -μα → -ματα.',
        'Окончания зависят от рода и типа склонения; единого правила нет. Частые формы множественного: муж. -ος → -οι, -ας → -ες, -ης → -ες; жен. -α/-η → -ες; ср. -ο → -α, -ι → -ια, -μα → -ματα.',
      ),
      _t(
        'The tables show common patterns, not rules for every noun with the same ending. Genitive stress often moves: το μάθημα → του μαθήματος → των μαθημάτων. Other noun classes have different patterns, such as η πόλη → οι πόλεις.',
        'Таблицы показывают типовые модели, а не правило для всех слов с таким окончанием. В родительном ударение может перемещаться: το μάθημα → του μαθήματος → των μαθημάτων. У других типов склонения свои модели: например, η πόλη → οι πόλεις.',
      ),
    ],
    [
      for (final entry in _nounPatterns.entries)
        GrammarTable(
          LocalizedText.shared(entry.key),
          [
            _t('Case', 'Падеж'),
            _t('Singular', 'Единственное'),
            _t('Plural', 'Множественное'),
          ],
          [
            for (var i = 0; i < 4; i++)
              [
                ['Nominative', 'Genitive', 'Accusative', 'Vocative'][i],
                entry.value[i],
                entry.value[i + 4],
              ],
          ],
        ),
    ],
  ),
  GrammarTopic(
    'possession',
    _t('Genitive & possession', 'Родительный падеж и принадлежность'),
    _t(
      'Possession with pronouns and genitive noun forms.',
      'Как сказать «мой», «твой», «их» и указать владельца.',
    ),
    [
      _t(
        'A genitive noun answers “whose?”: το βιβλίο του Νίκου = Nikos’s book; η τσάντα της Μαρίας = Maria’s bag. The article changes to the genitive; declinable nouns also change their ending.',
        'Родительный можно сопоставить с русским «кого? чего?». Он в том числе показывает принадлежность: το βιβλίο του Νίκου — книга Никоса (чья книга?); η τσάντα της Μαρίας — сумка Марии. Артикль принимает форму родительного; окончание существительного меняется, если слово склоняется.',
      ),
      _t(
        'Short possessives follow the noun: μου, σου, του/της/του, μας, σας, τους. These forms identify the owner; they do not agree with the owned object. το σπίτι μου / τα σπίτια μου = my house / houses.',
        'Краткие притяжательные формы стоят после существительного: μου, σου, του, της, μας, σας, τους. Они указывают, к кому относится слово, и не меняются по роду или числу этого существительного: το σπίτι μου / τα σπίτια μου — мой дом / мои дома. Του относится к αυτός или αυτό; της — к αυτή; τους — к любому «они».',
      ),
      _t(
        'Emphasis: δικός μου / δική μου / δικό μου = mine. δικός agrees with the object: το δικό μου βιβλίο, η δική μου τσάντα. Add a second written stress when required: το μάθημά μου, το όνομά σου.',
        'Для подчёркивания принадлежности: το δικό μου βιβλίο — именно моя книга; η δική μου τσάντα — именно моя сумка. Δικός меняется по роду греческого существительного, а μου остаётся тем же. Если у существительного ударение на третьем слоге от конца, перед краткой притяжательной формой добавляется ещё одно на последнем: το μάθημά μου, το όνομά σου. У βιβλίο ударение на втором слоге от конца, поэтому το βιβλίο μου — без второго ударения.',
      ),
      _t(
        'Match the possessive to the owner: διαβάζω το βιβλίο μου — I read my book; διαβάζεις το βιβλίο σου — you read your book; διαβάζουμε τα βιβλία μας — we read our books.',
        'Русское «свой» здесь передаём формой, которая соответствует действующему лицу: διαβάζω το βιβλίο μου — я читаю свою книгу; διαβάζεις το βιβλίο σου — ты читаешь свою книгу; διαβάζουμε τα βιβλία μας — мы читаем свои книги. Одной неизменной замены для «свой» в этих конструкциях нет.',
      ),
    ],
    [
      GrammarTable(
        _t('Possessive forms', 'Притяжательные формы'),
        [
          _t('Refers to', 'К кому относится'),
          _t('Form', 'Форма'),
          _t('Example', 'Пример'),
        ],
        [
          ['εγώ', 'μου', 'το βιβλίο μου'],
          ['εσύ', 'σου', 'το βιβλίο σου'],
          ['αυτός / αυτή / αυτό', 'του / της / του', 'το βιβλίο της'],
          ['εμείς', 'μας', 'το βιβλίο μας'],
          ['εσείς', 'σας', 'το βιβλίο σας'],
          ['αυτοί / αυτές / αυτά', 'τους', 'το βιβλίο τους'],
        ],
        rowLabels: _personLabels,
      ),
    ],
  ),
  GrammarTopic(
    'vocative',
    _t('Vocative · Direct address', 'Звательный падеж · Обращение'),
    _t(
      'How names and nouns change in direct address.',
      'Как меняются имена и существительные при обращении.',
    ),
    [
      _t(
        'Use the vocative when speaking directly to someone. Many masculine -ος nouns use -ε: φίλος → φίλε. Masculine -ας/-ης often drop -ς: Νίκος → Νίκο is a common name-specific -ο form; Αντρέας → Αντρέα; Γιάννης → Γιάννη.',
        'Звательный нужен при прямом обращении. Многие мужские слова на -ος дают -ε: φίλος → φίλε. Мужские на -ας/-ης часто теряют -ς: Αντρέας → Αντρέα; Γιάννης → Γιάννη. У имён на -ος встречается -ο: Νίκος → Νίκο.',
      ),
      _t(
        'Feminine and neuter vocatives usually match the nominative. Plural vocatives usually match the nominative plural, without its article. Name forms vary, so learn familiar names separately.',
        'У женского и среднего рода звательный обычно совпадает с именительным. Во множественном обычно совпадает с именительным множественного без артикля. Формы имён могут различаться — учите их отдельно.',
      ),
    ],
    [
      GrammarTable(
        _t('Direct address', 'Обращение'),
        [_t('Nominative', 'Именительный'), _t('Vocative', 'Звательный')],
        [
          ['ο φίλος', 'φίλε!'],
          ['ο δάσκαλος', 'δάσκαλε!'],
          ['ο Νίκος', 'Νίκο!'],
          ['ο Γιάννης', 'Γιάννη!'],
          ['η Μαρία', 'Μαρία!'],
          ['το παιδί', 'παιδί!'],
          ['οι φίλοι', 'φίλοι!'],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'prepositions',
    _t('Prepositions & noun cases', 'Предлоги и падежи'),
    _t(
      'σε, από, με, για and article contractions.',
      'σε, από, με, για и слияние с артиклем.',
    ),
    [
      _t(
        'Most everyday prepositions take an accusative noun phrase: σε = in/to/at, από = from/by, με = with, για = for, χωρίς = without. The preposition itself does not change. The article and declinable noun take the required case; the noun keeps its gender.',
        'Большинство повседневных предлогов требуют винительного: σε = в/на/к, από = из/от, με = с, για = для, χωρίς = без. Предлог сам не изменяется. Артикль и склоняемое существительное принимают форму нужного падежа; род существительного остаётся прежним.',
      ),
      _t(
        'σε + definite article contracts: στον, στην, στο; στους, στις, στα. Στο σχολείο. = At/to school. Από την δουλειά. = From work. Με τους φίλους. = With the friends.',
        'σε с определённым артиклем сливается: στον, στην, στο; στους, στις, στα. Στο σχολείο. = В школу/в школе. Από την δουλειά. = С работы. Με τους φίλους. = С друзьями.',
      ),
      _t(
        'Some formal prepositions take genitive: λόγω της βροχής = because of the rain; εκτός της πόλης = outside the city. Compound expressions have their own patterns: μπροστά από το σπίτι, κοντά στο σπίτι. Case depends on the expression.',
        'Некоторые книжные предлоги требуют родительного: λόγω της βροχής = из-за дождя; εκτός της πόλης = вне города. У составных выражений свои модели: μπροστά από το σπίτι, κοντά στο σπίτι. Падеж зависит от выражения.',
      ),
    ],
    [
      GrammarTable(
        _t(
          'Prepositions · Article combinations',
          'Предлоги · Сочетания с артиклем',
        ),
        [
          _t('Gender', 'Род'),
          _t('Singular', 'Единственное'),
          _t('Plural', 'Множественное'),
        ],
        [
          ['Masculine', 'σε + τον → στον φίλο', 'σε + τους → στους φίλους'],
          ['Feminine', 'σε + την → στην πόρτα', 'σε + τις → στις πόρτες'],
          ['Neuter', 'σε + το → στο βιβλίο', 'σε + τα → στα βιβλία'],
        ],
        rowLabels: [
          _t('Masculine', 'Мужской'),
          _t('Feminine', 'Женский'),
          _t('Neuter', 'Средний'),
        ],
      ),
    ],
  ),
];

const _nounPatterns = <String, List<String>>{
  'ο φίλος · -ος': [
    'ο φίλος',
    'του φίλου',
    'τον φίλο',
    'φίλε',
    'οι φίλοι',
    'των φίλων',
    'τους φίλους',
    'φίλοι',
  ],
  'ο μαθητής · -ης': [
    'ο μαθητής',
    'του μαθητή',
    'τον μαθητή',
    'μαθητή',
    'οι μαθητές',
    'των μαθητών',
    'τους μαθητές',
    'μαθητές',
  ],
  'ο πατέρας · -ας': [
    'ο πατέρας',
    'του πατέρα',
    'τον πατέρα',
    'πατέρα',
    'οι πατέρες',
    'των πατέρων',
    'τους πατέρες',
    'πατέρες',
  ],
  'η πόρτα · -α': [
    'η πόρτα',
    'της πόρτας',
    'την πόρτα',
    'πόρτα',
    'οι πόρτες',
    'των πορτών',
    'τις πόρτες',
    'πόρτες',
  ],
  'η φωνή · -η': [
    'η φωνή',
    'της φωνής',
    'την φωνή',
    'φωνή',
    'οι φωνές',
    'των φωνών',
    'τις φωνές',
    'φωνές',
  ],
  'το βιβλίο · -ο': [
    'το βιβλίο',
    'του βιβλίου',
    'το βιβλίο',
    'βιβλίο',
    'τα βιβλία',
    'των βιβλίων',
    'τα βιβλία',
    'βιβλία',
  ],
  'το παιδί · -ι': [
    'το παιδί',
    'του παιδιού',
    'το παιδί',
    'παιδί',
    'τα παιδιά',
    'των παιδιών',
    'τα παιδιά',
    'παιδιά',
  ],
  'το μάθημα · -μα': [
    'το μάθημα',
    'του μαθήματος',
    'το μάθημα',
    'μάθημα',
    'τα μαθήματα',
    'των μαθημάτων',
    'τα μαθήματα',
    'μαθήματα',
  ],
};

const _personLabels = [
  LocalizedText(en: 'I', zh: '我', ru: 'Я'),
  LocalizedText(en: 'You · singular', zh: '你 · 单数', ru: 'Ты'),
  LocalizedText(en: 'He / She / It', zh: '他／她／它', ru: 'Он / она / оно'),
  LocalizedText(en: 'We', zh: '我们', ru: 'Мы'),
  LocalizedText(
    en: 'You · plural / polite',
    zh: '你们／您',
    ru: 'Вы · группа или вежливое обращение',
  ),
  LocalizedText(en: 'They', zh: '他们', ru: 'Они'),
];
const _caseLabels = [
  LocalizedText(en: 'Nominative', zh: '主格', ru: 'Именительный'),
  LocalizedText(en: 'Genitive', zh: '属格', ru: 'Родительный'),
  LocalizedText(en: 'Accusative', zh: '宾格', ru: 'Винительный'),
  LocalizedText(en: 'Vocative', zh: '呼格', ru: 'Звательный'),
];

// Consolidate topics that teach the same forms, preserving their explanations.
final greekGrammar = _mergeGrammar();

List<GrammarTopic> _mergeGrammar() {
  GrammarTopic topic(String id) =>
      _grammarTopics.firstWhere((item) => item.id == id);
  final present = topic('present');
  final pastFuture = topic('past-future');
  final cases = topic('cases');
  final nouns = topic('nouns');
  final vocative = topic('vocative');
  final result = <GrammarTopic>[
    topic('be'),
    GrammarTopic(
      'verbs',
      _t('Verb conjugation', 'Обычные глаголы'),
      _t(
        'Person and number · Present, past and future.',
        'Лицо и число · Настоящее, прошедшее и будущее.',
      ),
      [...present.notes, ...pastFuture.notes],
      [
        ...present.tables,
        _verbs(
          'Writing · Past and future',
          'Писать · Прошедшее и будущее',
          [
            _t('Past · process / repetition', 'Писал · процесс / повторение'),
            _t('Past · whole action', 'Написал · действие целиком'),
            _t(
              'Future · process / repetition',
              'Буду писать · процесс / повторение',
            ),
            _t('Future · whole action', 'Напишу · действие целиком'),
          ],
          [
            ['έγραφα', 'έγραφες', 'έγραφε', 'γράφαμε', 'γράφατε', 'έγραφαν'],
            ['έγραψα', 'έγραψες', 'έγραψε', 'γράψαμε', 'γράψατε', 'έγραψαν'],
            [for (final form in _writePresent) 'θα $form'],
            [for (final form in _writeFuture) 'θα $form'],
          ],
        ),
      ],
    ),
    topic('passive'),
    GrammarTopic(
      'nouns',
      _t('Nouns, articles & cases', 'Существительные, артикли и падежи'),
      _t(
        'Articles and nouns together · Singular, plural and direct address.',
        'Артикли и существительные: единственное и множественное число, формы обращения.',
      ),
      [...cases.notes, ...nouns.notes, ...vocative.notes],
      [
        for (var i = 0; i < 4; i++)
          GrammarTable(
            _caseLabels[i],
            [
              _t('Noun', 'Существительное'),
              _t('Singular', 'Единственное'),
              _t('Plural', 'Множественное'),
            ],
            [
              for (final entry in _nounPatterns.entries)
                [
                  entry.key.split(' · ').first,
                  entry.value[i],
                  entry.value[i + 4],
                ],
            ],
          ),
        ...vocative.tables,
      ],
    ),
    topic('possession'),
    topic('prepositions'),
  ];
  return result;
}

const _chineseReference = <String, String>{
  'εγώ = I, εσύ = you (one person), αυτός/αυτή/αυτό = he/she/it; εμείς = we, εσείς = you (plural or polite), αυτοί/αυτές/αυτά = they. The first three are singular; the last three plural.':
      'εγώ 表示“我”，εσύ 表示“你（一个人）”，αυτός／αυτή／αυτό 表示“他／她／它”；εμείς 表示“我们”，εσείς 表示“你们／您”，αυτοί／αυτές／αυτά 表示“他们／她们／它们”。前三组是单数，后三组是复数。',
  'The verb ending usually identifies the person, so subject pronouns can be omitted. Είμαι εδώ. = I am here. Ήμασταν σπίτι. = We were home. Θα είσαι εκεί; = Will you be there?':
      '动词词尾通常能表明人称，因此主语代词可以省略。Είμαι εδώ.（我在这里。）Ήμασταν σπίτι.（我们当时在家。）Θα είσαι εκεί;（你会在那里吗？）',
  'είμαι is irregular. Use ήμουν for past “was” and θα είμαι for future “will be”. Possession and noun cases belong to nouns and pronouns, not verb conjugation.':
      'Είμαι 是不规则动词。过去“是”用 ήμουν，将来用 θα είμαι。所属关系与格是名词和代词的语法变化，不属于动词变位。',
  'Many verbs with an unstressed -ω use -ω, -εις, -ει, -ουμε, -ετε, -ουν. γράφω = I write / am writing. The same present form expresses habits and ongoing actions.':
      '许多以非重读 -ω 结尾的动词使用 -ω、-εις、-ει、-ουμε、-ετε、-ουν 这组词尾。Γράφω 可表示“我写”或“我正在写”；同一个现在时形式既可表达习惯，也可表达正在进行的动作。',
  'Stressed -άω/-ώ and -ώ verbs use other endings: αγαπάω/αγαπώ = I love; μπορώ = I can. Some forms have alternatives such as αγαπά/αγαπάει and γράφουν/γράφουνε. Learn the group together with the verb.':
      '重音在 -άω／-ώ 或 -ώ 上的动词使用其他词尾：αγαπάω／αγαπώ（我爱）、μπορώ（我能）。有些形式有变体，如 αγαπά／αγαπάει、γράφουν／γράφουνε。记忆动词时也要记住它所属的变位组。',
  'Negation: δεν γράφω = I do not write. Questions use the same conjugation: Γράφεις; = Are you writing? The Greek question mark is ;.':
      '否定：δεν γράφω（我不写）。疑问句使用相同的变位：Γράφεις;（你在写吗？）。希腊语问号写作 ;。',
  'Aspect distinguishes a process or repetition from an action viewed as a whole: έγραφα = I was writing / used to write; έγραψα = I wrote; θα γράφω = I will be writing; θα γράψω = I will write (as a whole action).':
      '动词的体区分过程或反复动作与作为整体来看待的动作：έγραφα（我当时在写／过去常写）、έγραψα（我写了）；θα γράφω（我将会在写／经常写）、θα γράψω（我将写，视为一个整体动作）。',
  'Common aorist endings (action viewed as a whole): -α, -ες, -ε, -αμε, -ατε, -αν. Some verbs add έ- and move the stress: έγραψα, but γράψαμε. Learn the past form with each verb.':
      '简单过去时（把动作看作整体）常用词尾 -α、-ες、-ε、-αμε、-ατε、-αν。有些动词加 έ- 并移动重音：έγραψα，但 γράψαμε。应连同过去时形式一起记忆动词。',
  'For a process or repetition, use θα with the present form: θα γράφω. For an action viewed as a whole, use the perfective stem: θα γράψω, θα διαβάσω, θα δω, θα πάω.':
      '表达将来的过程或反复动作时，θα 后用未完成体形式，如 θα γράφω。表达作为整体来看待的动作时，用完成体形式，如 θα γράψω、θα διαβάσω、θα δω、θα πάω。',
  'γράφω → γράφομαι: the subject receives the action. Το γράμμα γράφτηκε από την Μαρία. = The letter was written by Maria. από introduces the agent.':
      'Γράφω → γράφομαι：主语承受动作。Το γράμμα γράφτηκε από τη Μαρία.（信是玛丽亚写的。）Από 引出动作的执行者。',
  'Common present endings: -ομαι, -εσαι, -εται, -όμαστε, -εστε, -ονται. Past passive often uses -τηκα or -θηκα, but stems and stress vary by verb. Other passive conjugation groups also exist.':
      '常见的现在时词尾为 -ομαι、-εσαι、-εται、-όμαστε、-εστε、-ονται。过去时被动形式常用 -τηκα 或 -θηκα，但词干和重音因动词而异。被动形式也有其他变位组。',
  'Past: γράφτηκε = it was written. Future: θα γραφτεί = it will be written. Use the table below to change the person.':
      '过去时：γράφτηκε（它被写了）。将来时：θα γραφτεί（它将被写）。下表展示各人称形式。',
  'An -μαι ending does not always mean passive: έρχομαι = I come; κοιμάμαι = I sleep; σηκώνομαι = I get up. Learn meaning and voice together.':
      '以 -μαι 结尾并不一定表示被动：έρχομαι（我来）、κοιμάμαι（我睡觉）、σηκώνομαι（我起身）。要结合词义学习语态。',
  'Nouns have masculine, feminine or neuter gender. Learn the article with the noun. Case marks its role: nominative = subject; accusative = direct object and many prepositions; genitive = possession/relationship; vocative = direct address.':
      '名词有阳性、阴性和中性，应连同冠词一起记忆。格表明它在句中的作用：主格常作主语，宾格常作直接宾语或用于介词后，属格可表达所属等关系，呼格用于直接称呼。',
  'Ο φίλος βλέπει τον δάσκαλο. = The friend sees the teacher. Το βιβλίο του φίλου. = The friend’s book. Φίλε! = Friend! Vocatives normally have no article.':
      'Ο φίλος βλέπει τον δάσκαλο.（朋友看见老师。）Το βιβλίο του φίλου.（朋友的书。）Φίλε!（朋友！）呼格通常不加冠词。',
  'Neuter nominative, accusative and vocative forms are identical: το βιβλίο, το βιβλίο, βιβλίο! The article is omitted in direct address.':
      '中性名词的主格、宾格和呼格形式相同，如 το βιβλίο、το βιβλίο、βιβλίο!。直接称呼时省略冠词。',
  'Gender and noun class determine endings; there is no single rule for all nouns. Common plural patterns: masculine -ος → -οι, -ας → -ες, -ης → -ες; feminine -α/-η → -ες; neuter -ο → -α, -ι → -ια, -μα → -ματα.':
      '词尾由语法性别和变格类别决定，没有适用于所有名词的单一规则。常见复数模式：阳性 -ος → -οι、-ας → -ες、-ης → -ες；阴性 -α／-η → -ες；中性 -ο → -α、-ι → -ια、-μα → -ματα。',
  'The tables show common patterns, not rules for every noun with the same ending. Genitive stress often moves: το μάθημα → του μαθήματος → των μαθημάτων. Other noun classes have different patterns, such as η πόλη → οι πόλεις.':
      '表格展示典型变格模式，不能套用于所有同词尾名词。属格重音常会移动：το μάθημα → του μαθήματος → των μαθημάτων。其他名词类别有各自的变化模式，例如 η πόλη → οι πόλεις。',
  'A genitive noun answers “whose?”: το βιβλίο του Νίκου = Nikos’s book; η τσάντα της Μαρίας = Maria’s bag. The article changes to the genitive; declinable nouns also change their ending.':
      '属格名词可回答“谁的”：το βιβλίο του Νίκου（尼科斯的书）、η τσάντα της Μαρίας（玛丽亚的包）。冠词变为属格，可变格的名词也相应改变词尾。',
  'Short possessives follow the noun: μου, σου, του/της/του, μας, σας, τους. These forms identify the owner; they do not agree with the owned object. το σπίτι μου / τα σπίτια μου = my house / houses.':
      '弱式所属代词放在名词后：μου、σου、του／της／του、μας、σας、τους。它们表示所有者，不随被拥有事物的性和数变化：το σπίτι μου／τα σπίτια μου（我的房子，单数／复数）。',
  'Emphasis: δικός μου / δική μου / δικό μου = mine. δικός agrees with the object: το δικό μου βιβλίο, η δική μου τσάντα. Add a second written stress when required: το μάθημά μου, το όνομά σου.':
      '强调所属关系时用 δικός μου／δική μου／δικό μου（我的）。Δικός 与所指事物的性、数、格一致：το δικό μου βιβλίο（我的书）、η δική μου τσάντα（我的包）。必要时增加第二个重音：το μάθημά μου、το όνομά σου。',
  'Match the possessive to the owner: διαβάζω το βιβλίο μου — I read my book; διαβάζεις το βιβλίο σου — you read your book; διαβάζουμε τα βιβλία μας — we read our books.':
      '表达“自己的”时，这些希腊语结构中的所属代词要与所有者对应：διαβάζω το βιβλίο μου（我读自己的书）、διαβάζεις το βιβλίο σου（你读自己的书）、διαβάζουμε τα βιβλία μας（我们读自己的书）。',
  'Use the vocative when speaking directly to someone. Many masculine -ος nouns use -ε: φίλος → φίλε. Masculine -ας/-ης often drop -ς: Νίκος → Νίκο is a common name-specific -ο form; Αντρέας → Αντρέα; Γιάννης → Γιάννη.':
      '直接称呼他人时用呼格。许多阳性 -ος 名词变为 -ε：φίλος → φίλε；有些人名用 -ο，如 Νίκος → Νίκο。阳性 -ας／-ης 常去掉 -ς：Αντρέας → Αντρέα、Γιάννης → Γιάννη。',
  'Feminine and neuter vocatives usually match the nominative. Plural vocatives usually match the nominative plural, without its article. Name forms vary, so learn familiar names separately.':
      '阴性和中性名词的呼格通常与主格相同。复数呼格通常与复数主格相同，但不带冠词。人名的变化有差异，常见人名要单独记忆。',
  'Most everyday prepositions take an accusative noun phrase: σε = in/to/at, από = from/by, με = with, για = for, χωρίς = without. The preposition itself does not change. The article and declinable noun take the required case; the noun keeps its gender.':
      '多数日常介词后接宾格名词短语：σε（在／到）、από（从／由）、με（和／用）、για（给／为了）、χωρίς（没有）。介词自身不变；冠词和可变格名词使用所需的格，名词的语法性别不变。',
  'σε + definite article contracts: στον, στην, στο; στους, στις, στα. Στο σχολείο. = At/to school. Από την δουλειά. = From work. Με τους φίλους. = With the friends.':
      'Σε 与定冠词缩合：στον、στην、στο；στους、στις、στα。Στο σχολείο.（在／到学校。）Από τη δουλειά.（从工作地点。）Με τους φίλους.（和朋友们一起。）',
  'Some formal prepositions take genitive: λόγω της βροχής = because of the rain; εκτός της πόλης = outside the city. Compound expressions have their own patterns: μπροστά από το σπίτι, κοντά στο σπίτι. Case depends on the expression.':
      '有些正式用语中的介词后接属格，如 λόγω της βροχής（因为下雨）、εκτός της πόλης（在城外）。复合表达有各自的结构，如 μπροστά από το σπίτι（在房子前）、κοντά στο σπίτι（在家附近）。应按具体表达选择格。',

  'Be · Three tenses': '是 · 三种时态',
  'Present groups': '现在时变位组',
  'γράφω · Three tenses': 'γράφω · 三种时态',
  'Passive · Three tenses': '被动语态 · 三种时态',
  'Writing · Past and future': '写 · 过去时与将来时',
  'All persons, singular and plural: present, past and future.':
      '六种人称：现在时、过去时和将来时。',
  'Articles and nouns together · Singular, plural and direct address.':
      '冠词与名词搭配 · 单数、复数与直接称呼。',
  'Be · είμαι': '是 · είμαι',
  'Can': '能够',
  'Case': '格',
  'Cases & articles': '格与冠词',
  'Common endings with full singular and plural examples.': '常见词尾及完整的单复数示例。',
  'Definite articles': '定冠词',
  'Direct address': '直接称呼',
  'Example': '例子',
  'Feminine · singular / plural': '阴性 · 单数／复数',
  'Feminine': '阴性',
  'Form': '形式',
  'Future': '将来时',
  'Future · process / repetition': '将来时 · 过程／反复动作',
  'Future · whole action': '将来时 · 完整动作',
  'Gender': '语法性别',
  'Gender, number and the four cases.': '语法性别、单复数与四种格。',
  'Genitive & possession': '属格与所属关系',
  'How names and nouns change in direct address.': '直接称呼时人名与名词的变化。',
  'Love': '爱',
  'Masculine · singular / plural': '阳性 · 单数／复数',
  'Masculine': '阳性',
  'Possession with pronouns and genitive noun forms.':
      '我的／你的／他们的，以及通过名词词尾表达所属关系。',
  'Neuter · singular / plural': '中性 · 单数／复数',
  'Neuter': '中性',
  'Nominative': '主格',
  'Noun': '名词',
  'Noun forms · Declension': '名词变化 · 变格',
  'Nouns, articles & cases': '名词、冠词与格',
  'Verb conjugation': '普通动词',
  'Verb conjugation · Past & future': '普通动词 · 过去时与将来时',
  'Verb conjugation · Present': '普通动词 · 现在时',
  'Passive & middle voice': '被动与中间语态',
  'Passive forms in the present, past and future.': '被动语态的现在时、过去时与将来时。',
  'Past': '过去时',
  'Past · process / repetition': '过去时 · 过程／反复动作',
  'Past · whole action': '过去时 · 完整动作',
  'Person': '人称',
  'Person and number · Present, past and future.': '人称与数 · 现在时、过去时与将来时。',
  'Person, number and common conjugation groups.': '人称、数与常见变位组。',
  'Plural': '复数',
  'Possessive forms': '所属关系的表达',
  'Prepositions & noun cases': '介词与名词的格',
  'Prepositions · Article combinations': '介词 · 冠词组合',
  'Present': '现在时',
  'Refers to': '所指人称',
  'Singular': '单数',
  'Three basic tenses: present, past and future.': '三种基本时态：现在时、过去时和将来时。',
  'Vocative': '呼格',
  'Vocative · Direct address': '呼格 · 称呼他人',
  'Write': '写',
  'σε, από, με, για and article contractions.': 'σε、από、με、για 及其与冠词的缩合。',
};
