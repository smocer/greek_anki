import '../domain/app_language.dart';

LocalizedText _t(String en, String ru) => LocalizedText(en: en, ru: ru);

class GrammarTable {
  GrammarTable(this.title, this.headers, this.rows);
  final LocalizedText title;
  final List<LocalizedText> headers;
  final List<List<String>> rows;
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
);

// Original beginner explanations and examples. Sources for the paradigms:
// Centre for the Greek Language / Greek school grammar, linked in docs/grammar.md.
final _grammarTopics = <GrammarTopic>[
  GrammarTopic(
    'be',
    _t('Be · είμαι', 'Быть · είμαι'),
    _t(
      'All six persons: present, past and future.',
      'Все шесть лиц: настоящее, прошедшее и будущее.',
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
        'είμαι — неправильный глагол. Прошедшее «был» — ήμουν, будущее «буду» — θα είμαι. Принадлежность и падежи относятся к именам и местоимениям, а не к спряжению.',
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
    _t('Ordinary verbs · Present', 'Обычные глаголы · Настоящее'),
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
      'Ordinary verbs · Past & future',
      'Обычные глаголы · Прошедшее и будущее',
    ),
    _t(
      'Three basic tenses: present, past and future.',
      'Три основных времени: настоящее, прошедшее и будущее.',
    ),
    [
      _t(
        'γράφω = I write; έγραψα = I wrote; θα γράψω = I will write. Use the past for an action that happened and the future for an action you will do.',
        'γράφω = я пишу; έγραψα = я написал; θα γράψω = я напишу. Прошедшее — действие, которое произошло; будущее — действие, которое вы сделаете.',
      ),
      _t(
        'Common past endings: -α, -ες, -ε, -αμε, -ατε, -αν. Some verbs add έ- and move the stress: έγραψα, but γράψαμε. Learn the past form with each verb.',
        'Частые окончания прошедшего: -α, -ες, -ε, -αμε, -ατε, -αν. У некоторых глаголов появляется έ- и меняется ударение: έγραψα, но γράψαμε. Учите прошедшую форму вместе с глаголом.',
      ),
      _t(
        'The future uses θα, but the verb may change: γράφω → θα γράψω; διαβάζω → θα διαβάσω; βλέπω → θα δω; πηγαίνω → θα πάω. Do not simply add θα to every present form.',
        'Будущее образуется с θα, но глагол может измениться: γράφω → θα γράψω; διαβάζω → θα διαβάσω; βλέπω → θα δω; πηγαίνω → θα πάω. Не добавляйте θα к любой настоящей форме автоматически.',
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
    _t('Passive & middle voice', 'Пассив и средний залог'),
    _t(
      'Passive forms in the present, past and future.',
      'Пассив в настоящем, прошедшем и будущем.',
    ),
    [
      _t(
        'γράφω → γράφομαι: the subject receives the action. Το γράμμα γράφτηκε από τη Μαρία. = The letter was written by Maria. από introduces the agent.',
        'γράφω → γράφομαι: действие направлено на подлежащее. Το γράμμα γράφτηκε από τη Μαρία. = Письмо написала Мария. από вводит исполнителя.',
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
        'Пассив · Три времени',
        [
          _t('Present', 'Настоящее'),
          _t('Past', 'Прошедшее'),
          _t('Future', 'Будущее'),
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
    _t(
      'Gender, singular/plural and the four cases.',
      'Род, единственное/множественное число и четыре падежа.',
    ),
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
        'την can lose final ν before some consonants: τη Μαρία, but την Άννα. Masculine τον retains ν in standard school spelling. Neuter nominative, accusative and vocative forms are identical.',
        'την может терять конечное ν перед некоторыми согласными: τη Μαρία, но την Άννα. Мужское τον сохраняет ν в школьной орфографии. У среднего рода именительный, винительный и звательный совпадают.',
      ),
    ],
    [
      GrammarTable(
        _t('Definite articles', 'Определённые артикли'),
        [
          _t('Case', 'Падеж'),
          _t('M · singular / plural', 'М · ед. / мн.'),
          _t('F · singular / plural', 'Ж · ед. / мн.'),
          _t('N · singular / plural', 'Ср · ед. / мн.'),
        ],
        [
          ['Nominative', 'ο / οι', 'η / οι', 'το / τα'],
          ['Genitive', 'του / των', 'της / των', 'του / των'],
          ['Accusative', 'τον / τους', 'τη(ν) / τις', 'το / τα'],
          ['Vocative', '— / —', '— / —', '— / —'],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'nouns',
    _t('Noun changes · Declension', 'Изменения существительных · Склонение'),
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
        'The tables are representative patterns, not rules for every word with the same ending. Genitive stress often moves: το μάθημα → του μαθήματος → των μαθημάτων. Some plurals are irregular: ο άνθρωπος → οι άνθρωποι; η πόλη → οι πόλεις.',
        'Таблицы показывают типовые модели, а не правило для всех слов с таким окончанием. В родительном ударение может перемещаться: το μάθημα → του μαθήματος → των μαθημάτων. Есть особые модели: ο άνθρωπος → οι άνθρωποι; η πόλη → οι πόλεις.',
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
      'My/your/their and possession with noun endings.',
      'Мой/твой/их и принадлежность через падеж.',
    ),
    [
      _t(
        'A genitive noun answers “whose?”: το βιβλίο του Νίκου = Nikos’s book; η τσάντα της Μαρίας = Maria’s bag. Both the article and noun change to the genitive.',
        'Родительный отвечает на вопрос «чей?»: το βιβλίο του Νίκου = книга Никоса; η τσάντα της Μαρίας = сумка Марии. В родительном меняются и артикль, и существительное.',
      ),
      _t(
        'Short possessives follow the noun: μου, σου, του/της/του, μας, σας, τους. These forms identify the owner; they do not agree with the owned object. το σπίτι μου / τα σπίτια μου = my house / houses.',
        'Краткие притяжательные формы стоят после имени: μου, σου, του/της/του, μας, σας, τους. Они указывают владельца, а не род и число предмета. το σπίτι μου / τα σπίτια μου = мой дом / мои дома.',
      ),
      _t(
        'Emphasis: δικός μου / δική μου / δικό μου = mine. δικός agrees with the object: το δικό μου βιβλίο, η δική μου τσάντα. Add a second written stress when required: το μάθημά μου, το όνομά σου.',
        'Выделение: δικός μου / δική μου / δικό μου = мой/моя/моё. δικός согласуется с предметом: το δικό μου βιβλίο, η δική μου τσάντα. При необходимости добавляется второе ударение: το μάθημά μου, το όνομά σου.',
      ),
    ],
    [
      GrammarTable(
        _t('Possessive forms', 'Притяжательные формы'),
        [_t('Owner', 'Владелец'), _t('Form', 'Форма'), _t('Example', 'Пример')],
        [
          ['εγώ', 'μου', 'το βιβλίο μου'],
          ['εσύ', 'σου', 'το βιβλίο σου'],
          ['αυτός / αυτή / αυτό', 'του / της / του', 'το βιβλίο της'],
          ['εμείς', 'μας', 'το βιβλίο μας'],
          ['εσείς', 'σας', 'το βιβλίο σας'],
          ['αυτοί / αυτές / αυτά', 'τους', 'το βιβλίο τους'],
        ],
      ),
    ],
  ),
  GrammarTopic(
    'vocative',
    _t('Vocative · Calling someone', 'Звательный падеж · Обращение'),
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
        'Most everyday prepositions take an accusative noun phrase: σε = in/to/at, από = from/by, με = with, για = for, χωρίς = without. The preposition itself does not change for gender or number; its article and noun do.',
        'Большинство повседневных предлогов требуют винительного: σε = в/на/к, από = из/от, με = с, για = для, χωρίς = без. Предлог не меняется по роду и числу; меняются артикль и существительное.',
      ),
      _t(
        'σε + definite article contracts: στον, στην, στο; στους, στις, στα. Στο σχολείο. = At/to school. Από τη δουλειά. = From work. Με τους φίλους. = With the friends.',
        'σε с определённым артиклем сливается: στον, στην, στο; στους, στις, στα. Στο σχολείο. = В школу/в школе. Από τη δουλειά. = С работы. Με τους φίλους. = С друзьями.',
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
    'τη φωνή',
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
  'I',
  'You · singular',
  'He / She / It',
  'We',
  'You · plural / polite',
  'They',
];
const _caseLabels = ['Nominative', 'Genitive', 'Accusative', 'Vocative'];

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
      _t('Ordinary verbs', 'Обычные глаголы'),
      _t(
        'Person and number · Present, past and future.',
        'Лицо и число · Настоящее, прошедшее и будущее.',
      ),
      [...present.notes, ...pastFuture.notes],
      [
        GrammarTable(
          _t('Ordinary verbs · Three tenses', 'Обычные глаголы · Три времени'),
          [
            _t('Person', 'Лицо'),
            _t('Write · Present', 'Писать · Настоящее'),
            _t('Write · Past', 'Писать · Прошедшее'),
            _t('Write · Future', 'Писать · Будущее'),
            _t('Love · Present', 'Любить · Настоящее'),
            _t('Can · Present', 'Мочь · Настоящее'),
          ],
          [
            for (var i = 0; i < 6; i++)
              [
                ...pastFuture.tables.first.rows[i],
                ...present.tables.first.rows[i].skip(2),
              ],
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
        'Артикли и существительные вместе · Единственное, множественное и обращение.',
      ),
      [...cases.notes, ...nouns.notes, ...vocative.notes],
      [
        for (var i = 0; i < 4; i++)
          GrammarTable(
            LocalizedText.shared(_caseLabels[i]),
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
  // Row labels explain grammatical roles; Greek remains in example forms.
  for (final item in result) {
    if (['be', 'verbs', 'passive', 'possession'].contains(item.id)) {
      for (final table in item.tables) {
        for (var i = 0; i < table.rows.length; i++) {
          table.rows[i][0] = _personLabels[i];
        }
      }
    }
  }
  return result;
}
