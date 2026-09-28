import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const classroomObjectsDeck = VocabularyDeck(
  id: 'classroom-objects',
  title: LocalizedText(en: 'In the classroom', ru: 'Предметы на уроке'),
  subtitle: LocalizedText(
    en: 'Books, pages and exercises',
    ru: 'Книги, страницы и упражнения',
  ),
  note: LocalizedText(
    en: 'Always learn a noun with its article. Grammatical gender may differ from Russian; β sounds /v/.',
    ru: 'Учите существительное с артиклем. Το βιβλίο — средний род, хотя «книга» — женский; β читается «в».',
  ),
  cover: 'Βιβλίο',
  cards: [
    VocabularyCard(
      id: 'book',
      prompt: LocalizedText(en: 'The book', ru: 'Книга'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to viv-LI-o', ru: 'то вив-ЛИ-о'),
      explanation: LocalizedText(
        en: 'Βιβλίο shares a Greek root with “bibliography.”',
        ru: 'Узнаётся основа «библиотека», но в современном греческом β — «в»: вив-ЛИ-о.',
      ),
      greek: 'το βιβλίο',
    ),
    VocabularyCard(
      id: 'page',
      prompt: LocalizedText(en: 'The page', ru: 'Страница'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i se-LI-dha', ru: 'и сэ-ЛИ-да'),
      explanation: LocalizedText(
        en: 'Feminine; plural οι σελίδες.',
        ru: 'Женский род, как «страница». Множественное: οι σελίδες.',
      ),
      greek: 'η σελίδα',
    ),
    VocabularyCard(
      id: 'exercise',
      prompt: LocalizedText(en: 'The exercise', ru: 'Упражнение'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i A-ski-si', ru: 'и А-ски-си'),
      explanation: LocalizedText(
        en: 'Feminine, though Russian упражнение is neuter.',
        ru: 'Η άσκηση — женский род. Вспомните «аскеза»: исторически связано с упражнением, тренировкой.',
      ),
      greek: 'η άσκηση',
    ),
    VocabularyCard(
      id: 'example',
      prompt: LocalizedText(en: 'The example', ru: 'Пример'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(
        en: 'to pa-RA-dhigh-ma',
        ru: 'то па-РА-диг-ма',
      ),
      explanation: LocalizedText(
        en: 'Neuter; the γ before μ is a fricative sound.',
        ru: 'Средний род, хотя «пример» мужского. Можно связать с «парадигма», но здесь значение — «пример».',
      ),
      greek: 'το παράδειγμα',
    ),
    VocabularyCard(
      id: 'number',
      prompt: LocalizedText(en: 'The number', ru: 'Число / номер'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'o a-rith-MOS', ru: 'о а-рит-МОС'),
      explanation: LocalizedText(
        en: 'Masculine; θ is the unvoiced sound in English “think.”',
        ru: 'Мужской род. Корень знаком по «арифметика»; θ — межзубный глухой звук, не русское «т».',
      ),
      greek: 'ο αριθμός',
    ),
    VocabularyCard(
      id: 'break',
      prompt: LocalizedText(en: 'The break / recess', ru: 'Перерыв / перемена'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to DHYA-li-ma', ru: 'то ДЬЯ-ли-ма'),
      explanation: LocalizedText(
        en: 'Spell with ει and double μ: διάλειμμα.',
        ru: 'Средний род; запомните ει и две μ. Не путайте с «дилемма»: по-гречески это другое слово, δίλημμα.',
      ),
      greek: 'το διάλειμμα',
    ),
    VocabularyCard(
      id: 'notebook',
      prompt: LocalizedText(en: 'The notebook', ru: 'Тетрадь'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to te-TRA-dhi-o', ru: 'то тэ-ТРА-ди-о'),
      explanation: LocalizedText(
        en: 'Neuter; a useful link with Russian тетрадь.',
        ru: '«Тетрадь» исторически связано с греческим корнем; но το τετράδιο — среднего рода.',
      ),
      greek: 'το τετράδιο',
    ),
    VocabularyCard(
      id: 'pencil',
      prompt: LocalizedText(en: 'The pencil', ru: 'Карандаш'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to mo-LI-vi', ru: 'то мо-ЛИ-ви'),
      explanation: LocalizedText(
        en: 'Neuter; β sounds /v/.',
        ru: 'Средний род: το μολύβι. Не переносите мужской род русского «карандаш».',
      ),
      greek: 'το μολύβι',
    ),
    VocabularyCard(
      id: 'pen',
      prompt: LocalizedText(en: 'The pen', ru: 'Ручка'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to sti-LO', ru: 'то сти-ЛО'),
      explanation: LocalizedText(
        en: 'Neuter, indeclinable: το στυλό / τα στυλό.',
        ru: 'Хотя русская «ручка» женского рода, το στυλό — среднего. Само слово не склоняется.',
      ),
      greek: 'το στυλό',
    ),
    VocabularyCard(
      id: 'board',
      prompt: LocalizedText(en: 'The board', ru: 'Доска (в классе)'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'o PI-na-kas', ru: 'о ПИ-на-кас'),
      explanation: LocalizedText(
        en: 'Masculine; accusative τον πίνακα.',
        ru: 'В греческом мужской род: ο πίνακας. Винительный — τον πίνακα, без -ς.',
      ),
      greek: 'ο πίνακας',
    ),
    VocabularyCard(
      id: 'child',
      prompt: LocalizedText(en: 'The child', ru: 'Ребёнок'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to pe-DHI', ru: 'то пэ-ДИ'),
      explanation: LocalizedText(
        en: 'Neuter regardless of the child’s actual sex.',
        ru: 'Грамматически средний род независимо от пола ребёнка; αι читается «э».',
      ),
      greek: 'το παιδί',
    ),
    VocabularyCard(
      id: 'children',
      prompt: LocalizedText(
        en: 'The children (as a subject)',
        ru: 'Дети (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'ta pe-DHYA', ru: 'та пэ-ДЬЯ'),
      explanation: LocalizedText(
        en: 'Plural of το παιδί. Compare the address Παιδιά! without article.',
        ru: 'Το παιδί → τα παιδιά. Когда обращаемся «ребята!», артикль τα убираем.',
      ),
      greek: 'τα παιδιά',
    ),
  ],
);
