import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';
import '../../domain/vocabulary_category.dart';
import '../deck_composition.dart';
import 'addresses_nearby.dart';
import 'articles_cases.dart';
import 'classroom_objects.dart';
import 'countries.dart';
import 'culture_dining.dart';
import 'everyday_places.dart';
import 'forms_of_address.dart';
import 'introductions.dart';
import 'nature_geography.dart';
import 'pets_home.dart';
import 'phone_conversations.dart';
import 'shops_services.dart';
import 'transport_streets.dart';

final everydayNounsDeck = VocabularyDeck(
  id: 'everyday-nouns',
  title: const LocalizedText(
    en: 'Everyday nouns',
    ru: 'Повседневные существительные',
  ),
  subtitle: const LocalizedText(
    en: '63 nouns with articles · 9 case and plural cards',
    ru: '63 слова с артиклями · 9 карточек на падежи и число',
  ),
  cover: 'ο · η · το',
  note: const LocalizedText(
    en: 'Learn each noun with its nominative article: ο, η or το. Include the article in your answer. Compare teachers and students, everyday objects, food and places. The last nine cards practise the accusative, genitive and plural of μαθητής, τσάντα and πρόβλημα; their prompts specify the required form.',
    ru: 'Учите слово с артиклем: ο — мужской род, η — женский, το — средний. В ответе нужен и артикль. Род не всегда совпадает с русским: το κορίτσι — девочка, το πρόβλημα — проблема. Последние девять карточек тренируют винительный, родительный и множественное число слов μαθητής, τσάντα и πρόβλημα; нужная форма указана в вопросе.',
  ),
  cards: [
    ..._newNouns,
    ...cardsFrom(
      cultureDiningDeck,
      ids: const ['museum', 'theatre', 'restaurant', 'tavern'],
    ),
    ...cardsFrom(introductionsDeck, ids: const ['name']),
    ...cardsFrom(
      articlesCasesDeck,
      ids: const ['friend-nom', 'female-friend-nom'],
    ),
    ...cardsFrom(
      shopsServicesDeck,
      ids: const ['hospital', 'bakery', 'kiosk', 'hotel', 'pharmacy'],
    ),
    ...cardsFrom(petsHomeDeck, ids: const ['house', 'cat', 'dog']),
    ...cardsFrom(transportStreetsDeck, ids: const ['train', 'bus', 'port']),
    ...cardsFrom(natureGeographyDeck, ids: const ['sea', 'sun', 'sky']),
    ...cardsFrom(addressesNearbyDeck, ids: const ['street']),
    ...cardsFrom(formsOfAddressDeck, ids: const ['madam-noun', 'sir-noun']),
    ...cardsFrom(
      classroomObjectsDeck,
      ids: const ['child', 'board', 'book', 'page'],
    ),
    ...cardsFrom(countriesDeck, ids: const ['greece']),
    ...cardsFrom(phoneConversationsDeck, ids: const ['phone-noun']),
    ...cardsFrom(everydayPlacesDeck, ids: const ['airport', 'bank']),
    ..._casePractice,
  ],
);

const _nounMeaning = LocalizedText(
  en: 'Include the nominative article and the whole noun.',
  ru: 'Напишите артикль и существительное в именительном падеже.',
);

const _newNouns = [
  VocabularyCard(
    id: 'teacher-male',
    prompt: LocalizedText(
      en: 'The teacher (male; especially primary school)',
      ru: 'Учитель (мужчина; особенно начальных классов)',
    ),
    meaning: _nounMeaning,
    greek: 'ο δάσκαλος',
    pronunciation: LocalizedText(en: 'o DHAS-ka-los', ru: 'о ДАС-ка-лос'),
    explanation: LocalizedText(
      en: 'Masculine: ο δάσκαλος, not το. Female: η δασκάλα, with a different stress. Accusative: τον δάσκαλο; plural: οι δάσκαλοι.',
      ru: 'Δάσκαλος — учитель, особенно начальных классов; мужской род. Учительница — δασκάλα, с другим ударением. Δ произносится как th в английском this.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'teacher-female',
    prompt: LocalizedText(
      en: 'The teacher (female; especially primary school)',
      ru: 'Учительница (особенно начальных классов)',
    ),
    meaning: _nounMeaning,
    greek: 'η δασκάλα',
    pronunciation: LocalizedText(en: 'i dhas-KA-la', ru: 'и дас-КА-ла'),
    explanation: LocalizedText(
      en: 'Compare ο δάσκαλος / η δασκάλα. The stress moves. Accusative: την δασκάλα; genitive: της δασκάλας; plural: οι δασκάλες.',
      ru: 'Учительница, особенно начальных классов; женский род. Сравните ударение: δάσκαλος — учитель, δασκάλα — учительница.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'subject-teacher-male',
    prompt: LocalizedText(
      en: 'The subject teacher / professor (male)',
      ru: 'Преподаватель (мужчина)',
    ),
    meaning: _nounMeaning,
    greek: 'ο καθηγητής',
    pronunciation: LocalizedText(en: 'o ka-thi-yi-TIS', ru: 'о ка-ти-йи-ТИС'),
    explanation: LocalizedText(
      en: 'A subject teacher, for example at secondary school, or a university professor. Accusative and genitive: τον / του καθηγητή. Female: η καθηγήτρια.',
      ru: 'Преподаватель предмета в средней школе или вузе; не обязательно профессор по званию. Мужской род; преподавательница — καθηγήτρια. Θ — как th в think.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'subject-teacher-female',
    prompt: LocalizedText(
      en: 'The subject teacher / professor (female)',
      ru: 'Преподавательница',
    ),
    meaning: _nounMeaning,
    greek: 'η καθηγήτρια',
    pronunciation: LocalizedText(
      en: 'i ka-thi-YI-tri-a',
      ru: 'и ка-ти-ЙИ-три-а',
    ),
    explanation: LocalizedText(
      en: 'Female counterpart of καθηγητής. Accusative: την καθηγήτρια; genitive: της καθηγήτριας; plural: οι καθηγήτριες.',
      ru: 'Преподавательница; женский род. Сравните καθηγητής — преподаватель и καθηγήτρια — преподавательница.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'school-student-male',
    prompt: LocalizedText(en: 'The pupil / learner (male)', ru: 'Ученик'),
    meaning: _nounMeaning,
    greek: 'ο μαθητής',
    pronunciation: LocalizedText(en: 'o ma-thi-TIS', ru: 'о ма-ти-ТИС'),
    explanation: LocalizedText(
      en: 'A pupil or learner; a university student is φοιτητής. Accusative: τον μαθητή; genitive: του μαθητή; plural: οι μαθητές.',
      ru: 'Ученик, учащийся; мужской род. Студент вуза — φοιτητής. Θ — как th в английском think.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'school-student-female',
    prompt: LocalizedText(en: 'The pupil / learner (female)', ru: 'Ученица'),
    meaning: _nounMeaning,
    greek: 'η μαθήτρια',
    pronunciation: LocalizedText(en: 'i ma-THI-tri-a', ru: 'и ма-ТИ-три-а'),
    explanation: LocalizedText(
      en: 'Compare μαθητής / μαθήτρια, pupil, with φοιτητής / φοιτήτρια, university student. Accusative: την μαθήτρια; plural: οι μαθήτριες.',
      ru: 'Ученица; женский род. Сравните μαθητής — ученик и μαθήτρια — ученица. Студентка вуза — φοιτήτρια.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'university-student-male',
    prompt: LocalizedText(
      en: 'The university student (male)',
      ru: 'Студент вуза',
    ),
    meaning: _nounMeaning,
    greek: 'ο φοιτητής',
    pronunciation: LocalizedText(en: 'o fi-ti-TIS', ru: 'о фи-ти-ТИС'),
    explanation: LocalizedText(
      en: 'A university student, unlike μαθητής, a pupil. The οι is pronounced /i/. Accusative: τον φοιτητή; genitive: του φοιτητή; plural: οι φοιτητές.',
      ru: 'Студент вуза; мужской род. Школьник — μαθητής. Сочетание οι читается «и».',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'university-student-female',
    prompt: LocalizedText(
      en: 'The university student (female)',
      ru: 'Студентка вуза',
    ),
    meaning: _nounMeaning,
    greek: 'η φοιτήτρια',
    pronunciation: LocalizedText(en: 'i fi-TI-tri-a', ru: 'и фи-ТИ-три-а'),
    explanation: LocalizedText(
      en: 'Female counterpart of φοιτητής. Accusative: την φοιτήτρια; genitive: της φοιτήτριας; plural: οι φοιτήτριες.',
      ru: 'Студентка вуза; женский род. Сравните φοιτητής — студент и φοιτήτρια — студентка. Ученица — μαθήτρια.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'girl',
    prompt: LocalizedText(en: 'The girl', ru: 'Девочка'),
    meaning: _nounMeaning,
    greek: 'το κορίτσι',
    pronunciation: LocalizedText(en: 'to ko-RI-tsi', ru: 'то ко-РИ-ци'),
    explanation: LocalizedText(
      en: 'Grammatically neuter, even though it refers to a girl. Accusative stays το κορίτσι; plural: τα κορίτσια.',
      ru: '«Девочка» — женский род в русском, но κορίτσι — средний в греческом. Грамматический род слова не обязательно совпадает с полом человека.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'boy',
    prompt: LocalizedText(en: 'The boy', ru: 'Мальчик'),
    meaning: _nounMeaning,
    greek: 'το αγόρι',
    pronunciation: LocalizedText(en: 'to a-GHO-ri', ru: 'то а-ГО-ри'),
    explanation: LocalizedText(
      en: 'Neuter, like παιδί and κορίτσι. Accusative stays το αγόρι; plural: τα αγόρια.',
      ru: 'В русском «мальчик» мужского рода, а в греческом αγόρι — среднего, как παιδί и κορίτσι.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'marker',
    prompt: LocalizedText(
      en: 'The marker / felt-tip pen',
      ru: 'Маркер / фломастер',
    ),
    meaning: _nounMeaning,
    greek: 'ο μαρκαδόρος',
    pronunciation: LocalizedText(en: 'o mar-ka-DHO-ros', ru: 'о мар-ка-ДО-рос'),
    explanation: LocalizedText(
      en: 'Masculine. Accusative: τον μαρκαδόρο; plural: οι μαρκαδόροι. A board marker or felt-tip pen.',
      ru: 'Мужской род, как русское «маркер». Ударение на δό; δ произносится как th в английском this.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'computer',
    prompt: LocalizedText(en: 'The computer', ru: 'Компьютер'),
    meaning: _nounMeaning,
    greek: 'ο υπολογιστής',
    pronunciation: LocalizedText(
      en: 'o i-po-lo-yi-STIS',
      ru: 'о и-по-ло-йи-СТИС',
    ),
    explanation: LocalizedText(
      en: 'Masculine noun in -τής, like μαθητής. Accusative: τον υπολογιστή; genitive: του υπολογιστή; plural: οι υπολογιστές.',
      ru: 'Мужской род, как русское «компьютер». Перед ι буква γ звучит близко к «й». Ударение на последнем слоге.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'bag',
    prompt: LocalizedText(en: 'The bag', ru: 'Сумка'),
    meaning: _nounMeaning,
    greek: 'η τσάντα',
    pronunciation: LocalizedText(en: 'i TSAN-da', ru: 'и ЦАН-да'),
    explanation: LocalizedText(
      en: 'Feminine. Accusative: την τσάντα; genitive: της τσάντας; plural: οι τσάντες. Initial τσ sounds /ts/.',
      ru: 'Женский род, как русское «сумка». Сочетание τσ звучит как «ц».',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'class',
    prompt: LocalizedText(en: 'The class / classroom', ru: 'Класс (учебный)'),
    meaning: _nounMeaning,
    greek: 'η τάξη',
    pronunciation: LocalizedText(en: 'i TA-ksi', ru: 'и ТА-кси'),
    explanation: LocalizedText(
      en: 'Feminine; τάξη can mean a class, classroom or order. At/in class: στην τάξη. Plural: οι τάξεις. Do not confuse it with το ταξί, taxi.',
      ru: '«Класс» мужского рода в русском, τάξη — женского в греческом. Также означает «порядок». Не путайте с ταξί — «такси», где ударение на последнем слоге.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'library',
    prompt: LocalizedText(
      en: 'The library / bookcase',
      ru: 'Библиотека / книжный шкаф',
    ),
    meaning: _nounMeaning,
    greek: 'η βιβλιοθήκη',
    pronunciation: LocalizedText(
      en: 'i viv-li-o-THI-ki',
      ru: 'и вив-ли-о-ТИ-ки',
    ),
    explanation: LocalizedText(
      en: 'A library or a bookcase. Accusative: την βιβλιοθήκη; genitive: της βιβλιοθήκης; plural: οι βιβλιοθήκες.',
      ru: 'Знакомый корень, как в «библиотека»; также означает книжный шкаф. В греческом женский род. Β звучит «в», θ — как th в think.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'map',
    prompt: LocalizedText(en: 'The map', ru: 'Карта (географическая)'),
    meaning: _nounMeaning,
    greek: 'ο χάρτης',
    pronunciation: LocalizedText(en: 'o KHAR-tis', ru: 'о ХАР-тис'),
    explanation: LocalizedText(
      en: 'Masculine: ο χάρτης. Accusative and genitive: τον / του χάρτη; plural: οι χάρτες. Compare το χαρτί, paper.',
      ru: '«Карта» женского рода, но χάρτης — мужского. Не путайте с χαρτί — «бумага»: другое окончание и ударение.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'paper',
    prompt: LocalizedText(
      en: 'The paper (material / sheet)',
      ru: 'Бумага / лист бумаги',
    ),
    meaning: _nounMeaning,
    greek: 'το χαρτί',
    pronunciation: LocalizedText(en: 'to khar-TI', ru: 'то хар-ТИ'),
    explanation: LocalizedText(
      en: 'Neuter. Accusative stays το χαρτί; genitive: του χαρτιού; plural: τα χαρτιά. A map is ο χάρτης.',
      ru: '«Бумага» женского рода, χαρτί — среднего. Карта — χάρτης, с ударением в начале.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'lesson',
    prompt: LocalizedText(
      en: 'The lesson / subject',
      ru: 'Урок / учебный предмет',
    ),
    meaning: _nounMeaning,
    greek: 'το μάθημα',
    pronunciation: LocalizedText(en: 'to MA-thi-ma', ru: 'то МА-ти-ма'),
    explanation: LocalizedText(
      en: 'Neuter in -μα, like πρόβλημα. Genitive: του μαθήματος; plural: τα μαθήματα. Related to μαθαίνω, I learn, and μαθητής, pupil.',
      ru: '«Урок» мужского рода, μάθημα — среднего. Сравните μαθαίνω — учусь, узнаю; μαθητής — ученик. Θ — как th в think.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'problem',
    prompt: LocalizedText(en: 'The problem', ru: 'Проблема'),
    meaning: _nounMeaning,
    greek: 'το πρόβλημα',
    pronunciation: LocalizedText(en: 'to PRO-vli-ma', ru: 'то ПРО-вли-ма'),
    explanation: LocalizedText(
      en: 'Neuter in -μα. Accusative stays το πρόβλημα; genitive: του προβλήματος; plural: τα προβλήματα. The stress moves in the longer forms.',
      ru: 'Узнаётся русское «проблема», но β читается «в», а греческое πρόβλημα — среднего рода.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'table',
    prompt: LocalizedText(en: 'The table (furniture)', ru: 'Стол'),
    meaning: _nounMeaning,
    greek: 'το τραπέζι',
    pronunciation: LocalizedText(en: 'to tra-PE-zi', ru: 'то тра-ПЭ-зи'),
    explanation: LocalizedText(
      en: 'Neuter; genitive: του τραπεζιού; plural: τα τραπέζια. Distinguish το τραπέζι, table, from η τράπεζα, bank.',
      ru: 'Можно запомнить через «трапеза»: едим за столом. Τραπέζι — среднего рода, в отличие от русского «стол». Не путайте с τράπεζα — «банк».',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'ball',
    prompt: LocalizedText(en: 'The ball (for playing)', ru: 'Мяч'),
    meaning: _nounMeaning,
    greek: 'η μπάλα',
    pronunciation: LocalizedText(en: 'i BA-la', ru: 'и БА-ла'),
    explanation: LocalizedText(
      en: 'Feminine. Initial μπ sounds /b/. Accusative: την μπάλα; genitive: της μπάλας; plural: οι μπάλες.',
      ru: '«Мяч» мужского рода, μπάλα — женского. Начальное μπ читается «б».',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'lighter',
    prompt: LocalizedText(en: 'The lighter', ru: 'Зажигалка'),
    meaning: _nounMeaning,
    greek: 'ο αναπτήρας',
    pronunciation: LocalizedText(en: 'o a-nap-TI-ras', ru: 'о а-нап-ТИ-рас'),
    explanation: LocalizedText(
      en: 'Masculine in -ας. Accusative and genitive: τον / του αναπτήρα; plural: οι αναπτήρες.',
      ru: '«Зажигалка» женского рода, αναπτήρας — мужского. Ударение на ή.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'cigarette',
    prompt: LocalizedText(en: 'The cigarette', ru: 'Сигарета'),
    meaning: _nounMeaning,
    greek: 'το τσιγάρο',
    pronunciation: LocalizedText(en: 'to tsi-GHA-ro', ru: 'то ци-ГА-ро'),
    explanation: LocalizedText(
      en: 'Neuter. Accusative stays το τσιγάρο; genitive: του τσιγάρου; plural: τα τσιγάρα.',
      ru: '«Сигарета» женского рода, τσιγάρο — среднего. Τσ звучит как «ц».',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'cheese-pie',
    prompt: LocalizedText(
      en: 'The cheese pie / cheese pastry',
      ru: 'Пирог / пирожок с сыром',
    ),
    meaning: _nounMeaning,
    greek: 'η τυρόπιτα',
    pronunciation: LocalizedText(en: 'i ti-RO-pi-ta', ru: 'и ти-РО-пи-та'),
    explanation: LocalizedText(
      en: 'Τυρί means cheese and πίτα means pie. Feminine: την τυρόπιτα; genitive: της τυρόπιτας; plural: οι τυρόπιτες.',
      ru: 'Τυρί — сыр, πίτα — пирог: τυρόπιτα — пирог или пирожок с сыром. В греческом женский род.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'chocolate',
    prompt: LocalizedText(
      en: 'The chocolate / chocolate bar',
      ru: 'Шоколад / шоколадка',
    ),
    meaning: _nounMeaning,
    greek: 'η σοκολάτα',
    pronunciation: LocalizedText(en: 'i so-ko-LA-ta', ru: 'и со-ко-ЛА-та'),
    explanation: LocalizedText(
      en: 'Feminine: την σοκολάτα; genitive: της σοκολάτας; plural: οι σοκολάτες.',
      ru: 'Легко узнать «шоколад», но греческое σοκολάτα женского рода. Запомнить род поможет русское «шоколадка».',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'ice-cream',
    prompt: LocalizedText(en: 'The ice cream', ru: 'Мороженое'),
    meaning: _nounMeaning,
    greek: 'το παγωτό',
    pronunciation: LocalizedText(en: 'to pa-gho-TO', ru: 'то па-го-ТО'),
    explanation: LocalizedText(
      en: 'Neuter. Accusative stays το παγωτό; genitive: του παγωτού; plural: τα παγωτά.',
      ru: 'Средний род, как русское «мороженое». Ударение на последнем слоге.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'cake',
    prompt: LocalizedText(en: 'The celebration cake', ru: 'Торт'),
    meaning: _nounMeaning,
    greek: 'η τούρτα',
    pronunciation: LocalizedText(en: 'i TUR-ta', ru: 'и ТУР-та'),
    explanation: LocalizedText(
      en: 'A cake such as a birthday cake. Feminine: την τούρτα; genitive: της τούρτας; plural: οι τούρτες.',
      ru: 'Похоже на «торт», но греческое τούρτα женского рода. Ου читается «у».',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'watermelon',
    prompt: LocalizedText(en: 'The watermelon', ru: 'Арбуз'),
    meaning: _nounMeaning,
    greek: 'το καρπούζι',
    pronunciation: LocalizedText(en: 'to kar-PU-zi', ru: 'то кар-ПУ-зи'),
    explanation: LocalizedText(
      en: 'Neuter. Accusative stays το καρπούζι; genitive: του καρπουζιού; plural: τα καρπούζια.',
      ru: '«Арбуз» мужского рода, καρπούζι — среднего. Ου читается «у», ударение на этом сочетании.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'taxi',
    prompt: LocalizedText(en: 'The taxi', ru: 'Такси'),
    meaning: _nounMeaning,
    greek: 'το ταξί',
    pronunciation: LocalizedText(en: 'to ta-KSI', ru: 'то та-КСИ'),
    explanation: LocalizedText(
      en: 'Neuter and indeclinable: το ταξί, του ταξί, τα ταξί. Unlike τάξη, class, it is stressed on the final syllable.',
      ru: 'Как русское «такси», среднего рода и не склоняется. Не путайте с τάξη — «класс»; в ταξί ударение в конце.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'larnaca',
    prompt: LocalizedText(
      en: 'Larnaca (with its article)',
      ru: 'Ларнака (с артиклем)',
    ),
    meaning: _nounMeaning,
    greek: 'η Λάρνακα',
    pronunciation: LocalizedText(en: 'i LAR-na-ka', ru: 'и ЛАР-на-ка'),
    explanation: LocalizedText(
      en: 'Feminine place name. In Larnaca: στην Λάρνακα; from Larnaca: από την Λάρνακα; genitive: της Λάρνακας.',
      ru: 'Λάρνακα — греческое название Ларнаки. Женский род, как в русском; ударение на первом слоге.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'nicosia',
    prompt: LocalizedText(
      en: 'Nicosia (with its article)',
      ru: 'Никосия (с артиклем)',
    ),
    meaning: _nounMeaning,
    greek: 'η Λευκωσία',
    pronunciation: LocalizedText(en: 'i lef-ko-SI-a', ru: 'и лэф-ко-СИ-а'),
    explanation: LocalizedText(
      en: 'Λευκωσία is the Greek name of Nicosia. Feminine: στην Λευκωσία, από την Λευκωσία; genitive: της Λευκωσίας. Here ευ sounds /ef/.',
      ru: 'Греческое название Никосии — Λευκωσία, женский род. Ευ перед κ читается «эф».',
    ),
    labels: [VocabularyLabel.noun],
  ),
];

const _caseMeaning = LocalizedText(
  en: 'Write only the requested noun phrase with its article.',
  ru: 'Напишите только нужную форму существительного с артиклем.',
);

const _casePractice = [
  VocabularyCard(
    id: 'pupil-accusative',
    prompt: LocalizedText(
      en: 'The pupil (male, direct object: I see whom?)',
      ru: 'Ученика (вижу кого? винительный)',
    ),
    meaning: _caseMeaning,
    greek: 'τον μαθητή',
    pronunciation: LocalizedText(en: 'ton ma-thi-TI', ru: 'тон ма-ти-ТИ'),
    explanation: LocalizedText(
      en: 'Ο μαθητής → τον μαθητή. Accusative singular changes the article and drops final -ς. Example: Βλέπω τον μαθητή.',
      ru: 'Как «ученик → вижу ученика»: ο μαθητής → τον μαθητή. Исчезает -ς, ο заменяется на τον. Полное предложение: Βλέπω τον μαθητή. В ответе нужна только форма τον μαθητή.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'pupil-genitive',
    prompt: LocalizedText(
      en: 'Of the pupil (male, possession: whose book?)',
      ru: 'Ученика (чья книга? родительный)',
    ),
    meaning: _caseMeaning,
    greek: 'του μαθητή',
    pronunciation: LocalizedText(en: 'tu ma-thi-TI', ru: 'ту ма-ти-ТИ'),
    explanation: LocalizedText(
      en: 'Το βιβλίο του μαθητή = the pupil’s book. The noun has the same form as the accusative; του distinguishes possession from τον.',
      ru: '«Книга ученика»: το βιβλίο του μαθητή. В русском «ученика» тоже может быть и винительным, и родительным. Здесь падеж различает артикль: τον μαθητή / του μαθητή.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'pupils',
    prompt: LocalizedText(
      en: 'The pupils (male or mixed group, subject)',
      ru: 'Ученики (мужчины или смешанная группа, кто?)',
    ),
    meaning: _caseMeaning,
    greek: 'οι μαθητές',
    pronunciation: LocalizedText(en: 'i ma-thi-TES', ru: 'и ма-ти-ТЭС'),
    explanation: LocalizedText(
      en: 'Nominative plural: ο μαθητής → οι μαθητές. The article οι sounds /i/. For an all-female group: οι μαθήτριες.',
      ru: 'Именительный множественного: ο μαθητής → οι μαθητές, «ученик → ученики». οι читается «и». Только ученицы — οι μαθήτριες.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'bag-accusative',
    prompt: LocalizedText(
      en: 'The bag (direct object: I see what?)',
      ru: 'Сумку (вижу что? винительный)',
    ),
    meaning: _caseMeaning,
    greek: 'την τσάντα',
    pronunciation: LocalizedText(en: 'tin TSAN-da', ru: 'тин ЦАН-да'),
    explanation: LocalizedText(
      en: 'Η τσάντα → την τσάντα. Only the article changes in the singular accusative. Example: Βλέπω την τσάντα.',
      ru: 'В русском «сумка → сумку», а в греческом само слово сохраняется: η τσάντα → την τσάντα. Падеж виден по артиклю. Пример: Βλέπω την τσάντα.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'bag-genitive',
    prompt: LocalizedText(
      en: 'Of the bag (genitive)',
      ru: 'Сумки (например, ручка сумки; родительный)',
    ),
    meaning: _caseMeaning,
    greek: 'της τσάντας',
    pronunciation: LocalizedText(en: 'tis TSAN-das', ru: 'тис ЦАН-дас'),
    explanation: LocalizedText(
      en: 'Genitive singular: η τσάντα → της τσάντας. Feminine nouns of this pattern add -ς and use της.',
      ru: '«Сумка → сумки» в родительном: η τσάντα → της τσάντας. Появляется -ς и артикль της. Не путайте с множественным οι τσάντες — «сумки» как подлежащее.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'bags',
    prompt: LocalizedText(
      en: 'The bags (subject, plural)',
      ru: 'Сумки (что? именительный множественного)',
    ),
    meaning: _caseMeaning,
    greek: 'οι τσάντες',
    pronunciation: LocalizedText(en: 'i TSAN-des', ru: 'и ЦАН-дэс'),
    explanation: LocalizedText(
      en: 'Nominative plural: η τσάντα → οι τσάντες. The feminine plural article οι is pronounced /i/.',
      ru: '«Сумка → сумки»: η τσάντα → οι τσάντες. Женский род во множественном использует οι. Винительный множественного — τις τσάντες, но здесь нужен именительный.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'problem-accusative',
    prompt: LocalizedText(
      en: 'The problem (direct object: I see what?)',
      ru: 'Проблему (вижу что? винительный)',
    ),
    meaning: _caseMeaning,
    greek: 'το πρόβλημα',
    pronunciation: LocalizedText(en: 'to PRO-vli-ma', ru: 'то ПРО-вли-ма'),
    explanation: LocalizedText(
      en: 'Neuter accusative and nominative are identical: το πρόβλημα. Example: Βλέπω το πρόβλημα.',
      ru: 'В русском «проблема → проблему», а средний род в греческом сохраняет и слово, и артикль: το πρόβλημα. Пример: Βλέπω το πρόβλημα. Это отдельная тренировка винительного.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'problem-genitive',
    prompt: LocalizedText(
      en: 'Of the problem (genitive)',
      ru: 'Проблемы (например, причина проблемы; родительный)',
    ),
    meaning: _caseMeaning,
    greek: 'του προβλήματος',
    pronunciation: LocalizedText(
      en: 'tu pro-VLI-ma-tos',
      ru: 'ту про-ВЛИ-ма-тос',
    ),
    explanation: LocalizedText(
      en: 'Neuter nouns in -μα form this genitive with -ματος. Πρόβλημα → προβλήματος: the stress also moves.',
      ru: '«Проблема → проблемы» в родительном: το πρόβλημα → του προβλήματος. У существительных этого типа -μα превращается в -ματος, ударение сдвигается: πρόβλημα → προβλήματος.',
    ),
    labels: [VocabularyLabel.noun],
  ),
  VocabularyCard(
    id: 'problems',
    prompt: LocalizedText(
      en: 'The problems (subject, plural)',
      ru: 'Проблемы (что? именительный множественного)',
    ),
    meaning: _caseMeaning,
    greek: 'τα προβλήματα',
    pronunciation: LocalizedText(
      en: 'ta pro-VLI-ma-ta',
      ru: 'та про-ВЛИ-ма-та',
    ),
    explanation: LocalizedText(
      en: 'Neuter plural: το πρόβλημα → τα προβλήματα. The ending is -ματα and the stress moves. The accusative plural has the same form.',
      ru: '«Проблема → проблемы»: το πρόβλημα → τα προβλήματα. Средний род во множественном: τα; окончание -ματα. Следите за ударением. Винительный множественного совпадает с именительным.',
    ),
    labels: [VocabularyLabel.noun],
  ),
];
