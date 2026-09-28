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
  ],
);
