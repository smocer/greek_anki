import '../domain/app_language.dart';
import '../domain/curriculum.dart';
import '../domain/vocabulary.dart';
import '../domain/vocabulary_category.dart';
import 'curriculum_selections.dart';
import 'greek_decks.dart';
import 'october_lesson.dart';

final learningCollections = CurriculumCatalog(greekDecks).collections;
final learningDecks = List<VocabularyDeck>.unmodifiable(
  learningCollections.map((collection) => collection.deck),
);

/// Facade over authored lessons: navigation and word practice do not depend on
/// source deck layout or NLP token extraction. Existing exercises keep their keys.
class CurriculumCatalog {
  CurriculumCatalog(List<VocabularyDeck> sources) {
    for (final deck in sources) {
      for (final card in deck.cards) {
        final identity =
            card.reviewIdentity ??
            ReviewIdentity(deckId: deck.id, cardId: card.id);
        final key = '${identity.deckId}.${identity.cardId}';
        _source.putIfAbsent(
          key,
          () => card.withMetadata(reviewIdentity: identity),
        );
      }
    }
  }

  final _source = <String, VocabularyCard>{};
  VocabularyCard source(String key) =>
      _source[key] ?? (throw StateError('Unknown curriculum source: $key'));

  late final List<LearningCollection> collections = List.unmodifiable([
    _collection(
      'words-nouns',
      LearningSection.words,
      'Nouns',
      'Существительные',
      'One word at a time · articles optional',
      'По одному слову · артикли необязательны',
      'βιβλίο',
      [
        for (final key in nounWords) _noun(source(key), key),
        for (final card in octoberWords.where(
          (c) => c.labels.contains(VocabularyLabel.noun),
        ))
          _noun(card, 'october-lesson.${card.id}'),
      ],
    ),
    _collection(
      'words-verbs',
      LearningSection.words,
      'Verbs',
      'Глаголы',
      'First-person present',
      'Настоящее время · форма «я»',
      'μένω',
      [
        ..._existing(verbWords),
        ...octoberWords.where((c) => c.labels.contains(VocabularyLabel.verb)),
      ],
    ),
    _collection(
      'words-pronouns',
      LearningSection.words,
      'Pronouns',
      'Местоимения',
      'People, questions and possession',
      'Лица, вопросы и принадлежность',
      'εγώ',
      [..._existing(pronounWords), ...possessiveWords, ...demonstrativeWords],
    ),
    _collection(
      'words-descriptions',
      LearningSection.words,
      'Adjectives & adverbs',
      'Прилагательные и наречия',
      'Describe things, time and place',
      'Признаки, время и место',
      'ξανά',
      [
        ..._existing(descriptionWords),
        ...octoberWords.where(
          (c) => c.labels.any(
            (l) =>
                l == VocabularyLabel.adjective || l == VocabularyLabel.adverb,
          ),
        ),
      ],
    ),
    _collection(
      'words-connectors',
      LearningSection.words,
      'Connecting words & prepositions',
      'Связки и предлоги',
      'Small words that connect a sentence',
      'Короткие слова для связи в предложении',
      'και',
      [
        ..._existing(connectingWords),
        lessonCard(
          'from-word',
          'από',
          'From',
          'Из / от / с',
          'a-PO',
          'а-ПО',
          'A preposition used with the accusative.',
          'После από — винительный, хотя русское «из/от» требует родительного.',
        ),
        lessonCard(
          'in-word',
          'σε',
          'In / at / to (preposition)',
          'В / на / к (предлог)',
          'se',
          'сэ',
          'With the definite article: στον, στην, στο.',
          'Обозначает место и направление. Σε + артикль: στον, στην, στο.',
        ),
      ],
    ),
    _collection(
      'words-numbers',
      LearningSection.words,
      'Numbers',
      'Числа',
      'Units, tens and combinations',
      'Единицы, десятки и сочетания',
      'ένα',
      _existing(numberWords)..sort(
        (a, b) => int.parse(a.prompt.en).compareTo(int.parse(b.prompt.en)),
      ),
    ),
    _collection(
      'phrases-social',
      LearningSection.phrases,
      'Social conversations',
      'Общение и знакомство',
      'Greetings, introductions and small talk',
      'Приветствия, знакомство, как дела',
      'Γεια!',
      _existing(socialPractice),
    ),
    _collection(
      'phrases-classroom',
      LearningSection.phrases,
      'Classroom',
      'На уроке',
      'Ask, understand and learn',
      'Спрашивать, понимать и учиться',
      'Πες μου',
      [..._existing(classroomPractice), ...octoberPhrases.take(3)],
    ),
    _collection(
      'phrases-everyday',
      LearningSection.phrases,
      'Everyday situations',
      'Повседневные ситуации',
      'At home, at work and on the phone',
      'Дома, на работе и по телефону',
      'Ναι;',
      [..._existing(everydayPractice), ...octoberPhrases.skip(3)],
    ),
    _collection(
      'grammar-gender',
      LearningSection.grammar,
      'Articles & gender',
      'Артикли и род',
      'This is… · twelve familiar nouns',
      'Это… · двенадцать знакомых слов',
      'ο · η · το',
      _genderDrills(),
    ),
    _collection(
      'grammar-nouns',
      LearningSection.grammar,
      'Noun forms & cases',
      'Формы и падежи',
      'Subjects, objects, plurals and forms of address',
      'Подлежащее, дополнение, множественное число, обращения',
      'φίλος',
      _existing(nounFormsPractice),
    ),
    _collection(
      'grammar-verbs',
      LearningSection.grammar,
      'Verb forms',
      'Формы глаголов',
      'Three regular verbs and three distinct patterns',
      'Три обычных глагола и три особые модели',
      'μένουμε',
      [
        for (final key in verbFormsPractice)
          _copy(
            source(key),
            key,
            identity: verbWords.contains(key)
                ? ReviewIdentity(deckId: 'grammar-verbs', cardId: key)
                : null,
          ),
      ],
    ),
    _collection(
      'grammar-location',
      LearningSection.grammar,
      'Location & origin',
      'Где и откуда',
      'In, at, to and from',
      'В, на, куда и откуда',
      'στην',
      _existing(locationPractice),
    ),
    _collection(
      'grammar-possession',
      LearningSection.grammar,
      'Possession',
      'Принадлежность',
      'Whose? · owner, gender and stress',
      'Чей? · владелец, род и ударение',
      'μου',
      [..._existing(possessionPractice), ..._possessionDrills()],
    ),
    _collection(
      'grammar-questions',
      LearningSection.grammar,
      'Questions & negation',
      'Вопросы и отрицание',
      'Ask a question or say no',
      'Задать вопрос или сказать «нет»',
      'Πού;',
      _existing(questionsPractice),
    ),
  ]);

  List<VocabularyCard> _existing(List<String> keys) => [
    for (final key in keys) _copy(source(key), key),
  ];

  LearningCollection _collection(
    String id,
    LearningSection section,
    String en,
    String ru,
    String subtitleEn,
    String subtitleRu,
    String cover,
    List<VocabularyCard> cards,
  ) => LearningCollection(
    section: section,
    deck: VocabularyDeck(
      id: id,
      title: LocalizedText(en: en, ru: ru),
      subtitle: LocalizedText(en: subtitleEn, ru: subtitleRu),
      cover: cover,
      note: section == LearningSection.words
          ? const LocalizedText(
              en: 'Learn the meaning and spelling. Noun answers may omit the article; the answer shows it to help you remember gender.',
              ru: 'Учите значение и написание. У существительных артикль можно не вводить; в ответе он показан для запоминания рода.',
            )
          : const LocalizedText(
              en: 'Translate the complete prompt. In hard mode, the Greek answer and explanation appear only after checking.',
              ru: 'Переведите фразу целиком. В сложном режиме греческий ответ и пояснение появятся только после проверки.',
            ),
      cards: List.unmodifiable(
        cards.map(
          (card) => section == LearningSection.grammar
              ? _copy(
                  card,
                  card.id,
                  prompt: _withoutGreekHints(card.prompt),
                  meaning: translatePrompt,
                )
              : card,
        ),
      ),
    ),
    themes: {for (final card in cards) card.id: _themes(card)},
  );

  VocabularyCard _noun(VocabularyCard card, String key) {
    final article = card.greek.split(' ').first;
    String bare(String value) =>
        value.replaceFirst(RegExp(r'^(ο|η|το|οι) '), '');
    final gender = switch (article) {
      'ο' => const LocalizedText(en: 'Masculine', ru: 'Мужской род'),
      'η' => const LocalizedText(en: 'Feminine', ru: 'Женский род'),
      'οι' => const LocalizedText(
        en: 'Plural (feminine here)',
        ru: 'Множественное число (здесь женский род)',
      ),
      _ => const LocalizedText(en: 'Neuter', ru: 'Средний род'),
    };
    final override = _nounPrompts[key];
    String clean(String value) => value
        .replaceFirst(RegExp(r'^The '), '')
        .replaceAll(
          RegExp(r' \((with (the |its )?article|subject|as a subject)\)'),
          '',
        )
        .replaceAll(RegExp(r' \(с артиклем\)'), '')
        .replaceAll(RegExp(r' \(подлежащее\)'), '');
    return VocabularyCard(
      id: key,
      greek: bare(card.greek),
      answerDisplay: card.greek,
      prompt:
          override ??
          LocalizedText(
            en: _capitalize(clean(card.prompt.en)),
            ru: clean(card.prompt.ru),
          ),
      meaning: const LocalizedText(
        en: 'Write the word. The article is optional.',
        ru: 'Напишите слово. Артикль необязателен.',
      ),
      pronunciation: LocalizedText(
        en: card.pronunciation.en.replaceFirst(RegExp(r'^\S+ '), ''),
        ru: card.pronunciation.ru.replaceFirst(RegExp(r'^\S+ '), ''),
      ),
      explanation: LocalizedText(
        en: '${card.greek} · ${gender.en}. ${card.explanation?.en ?? ''}',
        ru: '${card.greek} · ${gender.ru}. ${card.explanation?.ru ?? ''}',
      ),
      alternatives: card.alternatives.map(bare).toList(),
      acceptedAnswers: [card.greek, ...card.alternatives],
      reviewIdentity: ReviewIdentity(deckId: 'words-nouns', cardId: key),
      addedWeek: card.addedWeek,
      labels: const [VocabularyLabel.noun],
    );
  }
}

VocabularyCard _copy(
  VocabularyCard card,
  String id, {
  ReviewIdentity? identity,
  LocalizedText? prompt,
  LocalizedText? meaning,
}) => VocabularyCard(
  id: id,
  prompt: prompt ?? card.prompt,
  meaning: meaning ?? card.meaning,
  greek: card.greek,
  pronunciation: card.pronunciation,
  explanation: card.explanation,
  alternatives: card.alternatives,
  acceptedAnswers: card.acceptedAnswers,
  reviewIdentity: identity ?? card.reviewIdentity,
  addedWeek: card.addedWeek,
  labels: card.labels,
  words: card.words,
  answerDisplay: card.answerDisplay,
);

LocalizedText _withoutGreekHints(LocalizedText prompt) => LocalizedText(
  en: prompt.en.replaceAll('λέγομαι', '“be called”'),
  ru: prompt.ru.replaceAll('λέγομαι', '«зваться»'),
);

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';

const _nounPrompts = {
  'noun-gender.maria': LocalizedText(en: 'Maria (name)', ru: 'Мария (имя)'),
  'noun-gender.eleni': LocalizedText(en: 'Eleni (name)', ru: 'Элени (имя)'),
  'noun-gender.paphos': LocalizedText(en: 'Paphos', ru: 'Пафос'),
  'noun-gender.limassol': LocalizedText(en: 'Limassol', ru: 'Лимасол'),
};

Set<LearningTheme> _themes(VocabularyCard card) {
  final source = card.id.contains('.')
      ? card.id.split('.').first
      : card.reviewIdentity?.deckId ?? '';
  final key = card.id;
  final greek = card.greek;
  final verbThemes = switch (source) {
    'drink-present' => {LearningTheme.food},
    'read-present' ||
    'write-present' ||
    'learn-present' ||
    'study-present' ||
    'understand-present' => {LearningTheme.classroom},
    'live-present' => {LearningTheme.home, LearningTheme.places},
    'work-present' || 'buy-present' || 'pay-present' => {LearningTheme.home},
    _ => null,
  };
  if (verbThemes != null) return verbThemes;
  if (RegExp(
    r'καφ|καφε|μπίρα|σοκολάτα|τυρόπιτα|παγωτό|τούρτα|καρπούζι|νερ',
  ).hasMatch(greek)) {
    return {LearningTheme.food};
  }
  if (RegExp(r'τηλέφων|κινητό|σταθερό|νούμερο').hasMatch(greek) ||
      source == 'phone-conversations') {
    return {LearningTheme.phone};
  }
  if (source.startsWith('numbers-') ||
      const {
        'small-words.now',
        'small-words.today',
        'small-words.tomorrow',
        'lesson-connectors.always',
        'lesson-connectors.still-yet',
        'questions.when',
      }.contains(key)) {
    return {LearningTheme.time};
  }
  if (source == 'transport-streets' || key.endsWith('.taxi')) {
    return {LearningTheme.travel, LearningTheme.places};
  }
  if ([
        'countries',
        'origin',
        'location',
        'living-places',
        'addresses-nearby',
        'nature-geography',
        'shops-services',
        'culture-dining',
        'everyday-places',
      ].contains(source) ||
      key.endsWith('.larnaca') ||
      key.endsWith('.nicosia') ||
      key.endsWith('.paphos') ||
      key.endsWith('.limassol')) {
    return {LearningTheme.places};
  }
  if (source == 'classroom-objects' ||
      source == 'classroom-phrases' ||
      RegExp(
        r'μαθητ|μαθήτρ|δάσκαλ|δασκάλ|καθηγ|φοιτη|φοιτή|μαρκαδόρ|βιβλί|μάθημα|σελίδα|μολύβι|πίνακα|τσάντα|τάξη|χαρτί',
      ).hasMatch(greek)) {
    return {LearningTheme.classroom};
  }
  if (source == 'subject-pronouns' ||
      source == 'forms-of-address' ||
      source == 'names-vocative' ||
      RegExp(r'μητέρ|κορίτσι|αγόρι|φίλ|γείτον').hasMatch(greek)) {
    return {LearningTheme.people};
  }
  if (source == 'pets-home' ||
      source == 'diminutives' ||
      source == 'everyday-nouns' ||
      RegExp(r'δουλειά|γραφείο').hasMatch(greek)) {
    return {LearningTheme.home};
  }
  return {LearningTheme.conversation};
}

typedef _PracticeNoun = ({
  String id,
  String greek,
  String demonstrative,
  String en,
  String ru,
  int russianGender,
  String soundEn,
  String soundRu,
});

const _practiceNouns = <_PracticeNoun>[
  (
    id: 'friend',
    greek: 'ο φίλος',
    demonstrative: 'Αυτός',
    en: 'male friend',
    ru: 'друг',
    russianGender: 0,
    soundEn: 'o FI-los',
    soundRu: 'о ФИ-лос',
  ),
  (
    id: 'marker',
    greek: 'ο μαρκαδόρος',
    demonstrative: 'Αυτός',
    en: 'marker',
    ru: 'маркер',
    russianGender: 0,
    soundEn: 'o mar-ka-DHO-ros',
    soundRu: 'о мар-ка-ДО-рос',
  ),
  (
    id: 'coffee',
    greek: 'ο καφές',
    demonstrative: 'Αυτός',
    en: 'coffee',
    ru: 'кофе',
    russianGender: 0,
    soundEn: 'o ka-FES',
    soundRu: 'о ка-ФЭС',
  ),
  (
    id: 'dog',
    greek: 'ο σκύλος',
    demonstrative: 'Αυτός',
    en: 'dog',
    ru: 'собака',
    russianGender: 1,
    soundEn: 'o SKI-los',
    soundRu: 'о СКИ-лос',
  ),
  (
    id: 'bag',
    greek: 'η τσάντα',
    demonstrative: 'Αυτή',
    en: 'bag',
    ru: 'сумка',
    russianGender: 1,
    soundEn: 'i TSAN-da',
    soundRu: 'и ЦАН-да',
  ),
  (
    id: 'mother',
    greek: 'η μητέρα',
    demonstrative: 'Αυτή',
    en: 'mother',
    ru: 'мама',
    russianGender: 1,
    soundEn: 'i mi-TE-ra',
    soundRu: 'и ми-ТЭ-ра',
  ),
  (
    id: 'cat',
    greek: 'η γάτα',
    demonstrative: 'Αυτή',
    en: 'cat (female)',
    ru: 'кошка',
    russianGender: 1,
    soundEn: 'i GHA-ta',
    soundRu: 'и ГА-та',
  ),
  (
    id: 'beer',
    greek: 'η μπίρα',
    demonstrative: 'Αυτή',
    en: 'beer',
    ru: 'пиво',
    russianGender: 2,
    soundEn: 'i BI-ra',
    soundRu: 'и БИ-ра',
  ),
  (
    id: 'book',
    greek: 'το βιβλίο',
    demonstrative: 'Αυτό',
    en: 'book',
    ru: 'книга',
    russianGender: 1,
    soundEn: 'to vi-VLI-o',
    soundRu: 'то ви-ВЛИ-о',
  ),
  (
    id: 'house',
    greek: 'το σπίτι',
    demonstrative: 'Αυτό',
    en: 'house',
    ru: 'дом',
    russianGender: 0,
    soundEn: 'to SPI-ti',
    soundRu: 'то СПИ-ти',
  ),
  (
    id: 'girl',
    greek: 'το κορίτσι',
    demonstrative: 'Αυτό',
    en: 'girl',
    ru: 'девочка',
    russianGender: 1,
    soundEn: 'to ko-RI-tsi',
    soundRu: 'то ко-РИ-ци',
  ),
  (
    id: 'phone',
    greek: 'το τηλέφωνο',
    demonstrative: 'Αυτό',
    en: 'phone',
    ru: 'телефон',
    russianGender: 0,
    soundEn: 'to ti-LE-fo-no',
    soundRu: 'то ти-ЛЭ-фо-но',
  ),
];

List<VocabularyCard> _genderDrills() => [
  for (final noun in _practiceNouns)
    lessonCard(
      'gender-${noun.id}',
      '${noun.demonstrative} είναι ${noun.greek}.',
      'This is the ${noun.en}.',
      'Это ${noun.ru}.',
      '${_demonstrativeSound(noun.demonstrative).en} I-ne ${noun.soundEn}',
      '${_demonstrativeSound(noun.demonstrative).ru} И-нэ ${noun.soundRu}',
      'This agrees with the Greek noun: αυτός + ο, αυτή + η, αυτό + το. Include the article.',
      'Русское «это» не меняется, а греческое согласуется с родом: αυτός + ο, αυτή + η, αυτό + το. Учитывайте греческий род, даже если русский другой.',
      alternatives: noun.id == 'beer' ? ['Αυτή είναι η μπύρα.'] : [],
    ),
];

LocalizedText _demonstrativeSound(String greek) => switch (greek) {
  'Αυτός' => const LocalizedText(en: 'af-TOS', ru: 'аф-ТОС'),
  'Αυτή' => const LocalizedText(en: 'af-TI', ru: 'аф-ТИ'),
  _ => const LocalizedText(en: 'af-TO', ru: 'аф-ТО'),
};

List<VocabularyCard> _possessionDrills() => [
  for (final owner in const [
    ('my', 'μου', 'my', ['мой', 'моя', 'моё'], 'mu', 'му'),
    ('your', 'σου', 'your (informal)', ['твой', 'твоя', 'твоё'], 'su', 'су'),
    ('his', 'του', 'his', ['его', 'его', 'его'], 'tu', 'ту'),
    ('her', 'της', 'her', ['её', 'её', 'её'], 'tis', 'тис'),
    ('our', 'μας', 'our', ['наш', 'наша', 'наше'], 'mas', 'мас'),
    (
      'your-plural',
      'σας',
      'your (polite/plural)',
      ['ваш', 'ваша', 'ваше'],
      'sas',
      'сас',
    ),
    ('their', 'τους', 'their', ['их', 'их', 'их'], 'tus', 'тус'),
  ])
    for (final noun in _practiceNouns.where(
      (n) => ['marker', 'bag', 'book', 'phone'].contains(n.id),
    ))
      lessonCard(
        'possession-${owner.$1}-${noun.id}',
        '${noun.demonstrative} είναι ${noun.greek} ${owner.$2}.'.replaceAll(
          'τηλέφωνο ',
          'τηλέφωνό ',
        ),
        'This is ${owner.$3.split(' (').first} ${noun.en}.${owner.$1 == 'your'
            ? ' (informal)'
            : owner.$1 == 'your-plural'
            ? ' (polite/plural)'
            : ''}',
        'Это ${owner.$4[noun.russianGender]} ${noun.ru}.${owner.$1 == 'your-plural' ? ' (Вы / вы)' : ''}',
        '${_demonstrativeSound(noun.demonstrative).en} I-ne ${noun.id == 'phone' ? 'to ti-LE-fo-NO' : noun.soundEn} ${owner.$5}',
        '${_demonstrativeSound(noun.demonstrative).ru} И-нэ ${noun.id == 'phone' ? 'то ти-ЛЭ-фо-НО' : noun.soundRu} ${owner.$6}',
        'The demonstrative and article follow the noun’s gender. The final possessive follows the owner.${noun.id == 'phone' ? ' Τηλέφωνό takes a second accent before the unstressed possessive.' : ''}',
        'Αυτός/αυτή/αυτό и артикль зависят от рода предмета; ${owner.$2} — от владельца. Как «его сумка»: владелец мужчина, но сумка женского рода.${noun.id == 'phone' ? ' Перед безударным ${owner.$2} нужно второе ударение: τηλέφωνό ${owner.$2}.' : ''}',
      ),
  lessonCard(
    'her-number',
    'Το νούμερό της είναι…',
    'Her phone number is…',
    'Её номер телефона — …',
    'to NU-me-RO tis I-ne',
    'то НУ-мэ-РО тис И-нэ',
    'Νούμερο has antepenultimate stress and gains an extra accent before της.',
    'Как τηλέφωνό μου: ударение на третьем слоге от конца требует второго ударения перед безударным της. Сам номер вводить не нужно.',
  ),
];
