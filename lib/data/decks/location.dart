import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const locationDeck = VocabularyDeck(
  id: 'location',
  title: LocalizedText(en: 'Where? In / at / to', ru: 'Где? В / на / куда?'),
  subtitle: LocalizedText(
    en: 'Σε + article in useful phrases',
    ru: 'Σε с артиклем в полезных фразах',
  ),
  note: LocalizedText(
    en: 'Σε joins the definite article: σε + τον = στον, σε + την = στην, σε + το = στο. Both location and destination normally use the accusative after σε.',
    ru: 'Σε сливается с артиклем: στον / στην / στο. Для места и направления после σε обычно винительный; русское различие «в школе / в школу» напрямую не переносится.',
  ),
  cover: 'Στο',
  cards: [
    VocabularyCard(
      id: 'in-russia',
      prompt: LocalizedText(en: 'In Russia', ru: 'В России'),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'sti ro-SI-a', ru: 'сти ро-СИ-а'),
      explanation: LocalizedText(
        en: 'Σε + τη = στη; feminine before ρ.',
        ru: 'В русском «в России» — предложный. В греческом στη Ρωσία — винительный после σε.',
      ),
      greek: 'στη Ρωσία',
      alternatives: ['στην Ρωσία'],
    ),
    VocabularyCard(
      id: 'in-iraq',
      prompt: LocalizedText(en: 'In Iraq', ru: 'В Ираке'),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'sto i-RAK', ru: 'сто и-РАК'),
      explanation: LocalizedText(
        en: 'Σε + το = στο; Iraq is neuter.',
        ru: 'Το Ιράκ — средний род, поэтому στο, не στην. Имя страны остаётся неизменным.',
      ),
      greek: 'στο Ιράκ',
    ),
    VocabularyCard(
      id: 'in-cyprus',
      prompt: LocalizedText(en: 'In Cyprus', ru: 'На Кипре'),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'stin KI-pro', ru: 'стин КИ-про'),
      explanation: LocalizedText(
        en: 'Σε + την; Κύπρος becomes Κύπρο.',
        ru: 'Русское «на Кипре» → στην Κύπρο. Выбор предлога и падежа не совпадает слово в слово.',
      ),
      greek: 'στην Κύπρο',
    ),
    VocabularyCard(
      id: 'in-greece',
      prompt: LocalizedText(en: 'In Greece', ru: 'В Греции'),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'stin e-LA-dha', ru: 'стин э-ЛА-да'),
      explanation: LocalizedText(
        en: 'Keep ν before the vowel in Ελλάδα.',
        ru: 'Перед гласной в Ελλάδα сохраняем ν: στην Ελλάδα.',
      ),
      greek: 'στην Ελλάδα',
    ),
    VocabularyCard(
      id: 'in-canada',
      prompt: LocalizedText(en: 'In Canada', ru: 'В Канаде'),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'ston ka-na-DHA', ru: 'стон ка-на-ДА'),
      explanation: LocalizedText(
        en: 'Masculine σε + τον = στον; Καναδάς loses ς.',
        ru: 'В греческом Канада мужского рода: στον Καναδά. Окончание -ς исчезает в винительном.',
      ),
      greek: 'στον Καναδά',
    ),
    VocabularyCard(
      id: 'at-school',
      prompt: LocalizedText(
        en: 'At school (with the article)',
        ru: 'В школе (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'sto skho-LI-o', ru: 'сто схо-ЛИ-о'),
      explanation: LocalizedText(
        en: 'Το σχολείο is school, a neuter noun.',
        ru: 'Школа женского рода в русском, но το σχολείο среднего; σε + το = στο.',
      ),
      greek: 'στο σχολείο',
    ),
    VocabularyCard(
      id: 'in-class',
      prompt: LocalizedText(
        en: 'In the classroom (with the article)',
        ru: 'В классе (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'stin TA-ksi', ru: 'стин ТА-кси'),
      explanation: LocalizedText(
        en: 'Η τάξη is feminine; keep ν before τ.',
        ru: 'Η τάξη — женский род. Перед τ в артикле сохраняется ν.',
      ),
      greek: 'στην τάξη',
    ),
    VocabularyCard(
      id: 'in-book',
      prompt: LocalizedText(en: 'In the book', ru: 'В книге'),
      meaning: LocalizedText(
        en: 'Translate the location phrase with the article.',
        ru: 'Переведите выражение места с артиклем.',
      ),
      pronunciation: LocalizedText(en: 'sto viv-LI-o', ru: 'сто вив-ЛИ-о'),
      explanation: LocalizedText(
        en: 'Neuter accusative: σε + το βιβλίο.',
        ru: 'Русское «в книге» — предложный, греческое στο βιβλίο — винительный. Средний род не меняет форму существительного.',
      ),
      greek: 'στο βιβλίο',
    ),
    VocabularyCard(
      id: 'at-port',
      prompt: LocalizedText(en: 'At the port', ru: 'В порту'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στο λιμάνι',
      pronunciation: LocalizedText(en: 'sto li-MA-ni', ru: 'сто ли-МА-ни'),
      explanation: LocalizedText(
        en: 'το λιμάνι → στο λιμάνι. Σε joins the accusative article; the phrase describes location.',
        ru: 'Средний род, хотя «порт» в русском мужского рода. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'in-metro',
      prompt: LocalizedText(en: 'In the metro', ru: 'В метро'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στο μετρό',
      pronunciation: LocalizedText(en: 'sto me-TRO', ru: 'сто мэ-ТРО'),
      explanation: LocalizedText(
        en: 'το μετρό → στο μετρό. Σε joins the accusative article; the phrase describes location.',
        ru: 'Средний род и несклоняемое слово, как русское «метро». После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-stop',
      prompt: LocalizedText(en: 'At the bus stop', ru: 'На остановке'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στην στάση',
      pronunciation: LocalizedText(en: 'stin STA-si', ru: 'стин СТА-си'),
      explanation: LocalizedText(
        en: 'η στάση → στην στάση. Σε joins the accusative article; the phrase describes location.',
        ru: 'Женский род, как «остановка». Винительный артикль την с σε даёт στην. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
      alternatives: ['στη στάση'],
    ),
    VocabularyCard(
      id: 'in-square',
      prompt: LocalizedText(en: 'In the town square', ru: 'На площади'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στην πλατεία',
      pronunciation: LocalizedText(en: 'stin pla-TI-a', ru: 'стин пла-ТИ-а'),
      explanation: LocalizedText(
        en: 'η πλατεία → στην πλατεία. Σε joins the accusative article; the phrase describes location.',
        ru: 'Женский род. Русское «на» здесь передаётся предлогом σε. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-bakery',
      prompt: LocalizedText(en: 'At the bakery', ru: 'В пекарне'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στον φούρνο',
      pronunciation: LocalizedText(en: 'ston FUR-no', ru: 'стон ФУР-но'),
      explanation: LocalizedText(
        en: 'ο φούρνος → στον φούρνο. Σε joins the accusative article; the phrase describes location.',
        ru: 'Мужской винительный: φούρνος → φούρνο. Русская «пекарня» — женского рода. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-pharmacy',
      prompt: LocalizedText(en: 'At the pharmacy', ru: 'В аптеке'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στο φαρμακείο',
      pronunciation: LocalizedText(
        en: 'sto far-ma-KI-o',
        ru: 'сто фар-ма-КИ-о',
      ),
      explanation: LocalizedText(
        en: 'το φαρμακείο → στο φαρμακείο. Σε joins the accusative article; the phrase describes location.',
        ru: 'Средний род: το → στο. Русская «аптека» — женского рода. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-museum',
      prompt: LocalizedText(en: 'At the museum', ru: 'В музее'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στο μουσείο',
      pronunciation: LocalizedText(en: 'sto mu-SI-o', ru: 'сто му-СИ-о'),
      explanation: LocalizedText(
        en: 'το μουσείο → στο μουσείο. Σε joins the accusative article; the phrase describes location.',
        ru: 'Средний род, несмотря на мужской род русского «музей». После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-restaurant',
      prompt: LocalizedText(en: 'At the restaurant', ru: 'В ресторане'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στο εστιατόριο',
      pronunciation: LocalizedText(
        en: 'sto e-stia-TO-ri-o',
        ru: 'сто э-стья-ТО-ри-о',
      ),
      explanation: LocalizedText(
        en: 'το εστιατόριο → στο εστιατόριο. Σε joins the accusative article; the phrase describes location.',
        ru: 'Средний род: το + σε → στο, существительное не меняется. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-hotel',
      prompt: LocalizedText(en: 'At the hotel', ru: 'В отеле'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στο ξενοδοχείο',
      pronunciation: LocalizedText(
        en: 'sto kse-no-dho-KHI-o',
        ru: 'сто ксэ-но-до-ХИ-о',
      ),
      explanation: LocalizedText(
        en: 'το ξενοδοχείο → στο ξενοδοχείο. Σε joins the accusative article; the phrase describes location.',
        ru: 'В русском «в отеле» — предложный, в греческом — винительный после σε. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-sea',
      prompt: LocalizedText(en: 'At the sea / seaside', ru: 'На море'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στην θάλασσα',
      pronunciation: LocalizedText(en: 'stin THA-la-sa', ru: 'стин ТА-ла-са'),
      explanation: LocalizedText(
        en: 'η θάλασσα → στην θάλασσα. Σε joins the accusative article; the phrase describes location.',
        ru: 'Море — средний род, η θάλασσα — женский. Поэтому στην, не στο. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
      alternatives: ['στη θάλασσα'],
    ),
    VocabularyCard(
      id: 'at-hospital',
      prompt: LocalizedText(en: 'At the hospital', ru: 'В больнице'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στο νοσοκομείο',
      pronunciation: LocalizedText(
        en: 'sto no-so-ko-MI-o',
        ru: 'сто но-со-ко-МИ-о',
      ),
      explanation: LocalizedText(
        en: 'το νοσοκομείο → στο νοσοκομείο. Σε joins the accusative article; the phrase describes location.',
        ru: 'Греческий средний род: στο νοσοκομείο. Род русского слова «больница» здесь не помогает. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
    VocabularyCard(
      id: 'at-cinema',
      prompt: LocalizedText(en: 'At the cinema', ru: 'В кинотеатре'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'στον κινηματογράφο',
      pronunciation: LocalizedText(
        en: 'ston ki-ni-ma-TO-ghra-fo',
        ru: 'стон ки-ни-ма-ТО-гра-фо',
      ),
      explanation: LocalizedText(
        en: 'ο κινηματογράφος → στον κινηματογράφο. Σε joins the accusative article; the phrase describes location.',
        ru: 'Мужской род: ο → στον; в винительном κινηματογράφος теряет -ς. После σε используем винительный, даже когда отвечаем на «где?».',
      ),
    ),
  ],
);
