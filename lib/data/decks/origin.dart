import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const originDeck = VocabularyDeck(
  id: 'origin',
  title: LocalizedText(en: 'Where are you from?', ru: 'Откуда вы?'),
  subtitle: LocalizedText(
    en: 'From a country: από + accusative',
    ru: 'Из страны: από + винительный',
  ),
  note: LocalizedText(
    en: 'For origin, από takes the accusative: η → τη(ν), ο → τον, το → το. Feminine την loses ν before many consonants, including ρ and γ.',
    ru: 'Для происхождения: από + винительный, в отличие от русского «из + родительный». Перед ρ и γ женский артикль обычно τη; перед гласной и κ — την.',
  ),
  cover: 'Από πού;',
  cards: [
    VocabularyCard(
      id: 'ask-origin',
      prompt: LocalizedText(
        en: 'Where are you from? (informal)',
        ru: 'Откуда ты?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'a-PO pu I-se', ru: 'а-ПО пу И-сэ'),
      explanation: LocalizedText(
        en: 'Πού is “where”; από πού is “from where.”',
        ru: 'Είσαι — «ты есть». Русское «ты» не заменяет греческую связку: она нужна.',
      ),
      greek: 'Από πού είσαι;',
    ),
    VocabularyCard(
      id: 'ask-origin-polite',
      prompt: LocalizedText(
        en: 'Where are you from? (polite/plural)',
        ru: 'Откуда Вы / вы?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'a-PO pu I-ste', ru: 'а-ПО пу И-стэ'),
      explanation: LocalizedText(
        en: 'Είστε replaces είσαι for polite singular or plural.',
        ru: 'Как ты/Вы: είσαι → είστε. Всё остальное в вопросе остаётся тем же.',
      ),
      greek: 'Από πού είστε;',
    ),
    VocabularyCard(
      id: 'from-russia',
      prompt: LocalizedText(en: 'From Russia', ru: 'Из России'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-PO ti ro-SI-a',
        ru: 'а-ПО ти ро-СИ-а',
      ),
      explanation: LocalizedText(
        en: 'Ρωσία is accusative; feminine την normally loses ν before ρ.',
        ru: '«Из России» — родительный в русском; από τη Ρωσία — винительный в греческом. Перед ρ обычно τη; учебный вариант την тоже принимается.',
      ),
      greek: 'από τη Ρωσία',
      alternatives: ['από την Ρωσία'],
    ),
    VocabularyCard(
      id: 'from-iraq',
      prompt: LocalizedText(en: 'From Iraq', ru: 'Из Ирака'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'a-PO to i-RAK', ru: 'а-ПО то и-РАК'),
      explanation: LocalizedText(
        en: 'Ιράκ does not change; neuter accusative is το.',
        ru: 'Το — средний род, винительный совпадает с именительным. Ιράκ не склоняется, в отличие от русского «Ирака».',
      ),
      greek: 'από το Ιράκ',
    ),
    VocabularyCard(
      id: 'from-greece',
      prompt: LocalizedText(en: 'From Greece', ru: 'Из Греции'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-PO tin e-LA-dha',
        ru: 'а-ПО тин э-ЛА-да',
      ),
      explanation: LocalizedText(
        en: 'Keep ν before the vowel in Ελλάδα.',
        ru: 'Перед гласной сохраняем ν: την Ελλάδα. Женское существительное здесь внешне не меняется.',
      ),
      greek: 'από την Ελλάδα',
    ),
    VocabularyCard(
      id: 'from-cyprus',
      prompt: LocalizedText(en: 'From Cyprus', ru: 'С Кипра'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-PO tin KI-pro',
        ru: 'а-ПО тин КИ-про',
      ),
      explanation: LocalizedText(
        en: 'Η Κύπρος → την Κύπρο: both article and noun change.',
        ru: 'Η Κύπρος → την Κύπρο: -ς исчезает. В русском «с Кипра» — родительный, здесь винительный.',
      ),
      greek: 'από την Κύπρο',
    ),
    VocabularyCard(
      id: 'from-ukraine',
      prompt: LocalizedText(en: 'From Ukraine', ru: 'Из Украины'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-PO tin u-kra-NI-a',
        ru: 'а-ПО тин у-кра-НИ-а',
      ),
      explanation: LocalizedText(
        en: 'Keep ν before the vowel sound /u/.',
        ru: 'Перед ου («у») сохраняется ν: την Ουκρανία.',
      ),
      greek: 'από την Ουκρανία',
    ),
    VocabularyCard(
      id: 'from-canada',
      prompt: LocalizedText(en: 'From Canada', ru: 'Из Канады'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-PO ton ka-na-DHA',
        ru: 'а-ПО тон ка-на-ДА',
      ),
      explanation: LocalizedText(
        en: 'Ο Καναδάς → τον Καναδά: masculine accusative.',
        ru: 'Мужской род: ο → τον, Καναδάς → Καναδά. Греческий род не совпадает с русским.',
      ),
      greek: 'από τον Καναδά',
    ),
    VocabularyCard(
      id: 'from-england',
      prompt: LocalizedText(en: 'From England', ru: 'Из Англии'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-PO tin an-GLI-a',
        ru: 'а-ПО тин ан-ГЛИ-а',
      ),
      explanation: LocalizedText(
        en: 'Feminine accusative; keep ν before α.',
        ru: 'Η → την, потому что после από нужен винительный; перед α сохраняем ν.',
      ),
      greek: 'από την Αγγλία',
    ),
    VocabularyCard(
      id: 'from-germany',
      prompt: LocalizedText(en: 'From Germany', ru: 'Из Германии'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'a-PO ti yer-ma-NI-a',
        ru: 'а-ПО ти йер-ма-НИ-а',
      ),
      explanation: LocalizedText(
        en: 'Feminine τη normally has no final ν before γ.',
        ru: 'Перед γ в женском артикле обычно нет ν: τη Γερμανία. Вариант την принимается.',
      ),
      greek: 'από τη Γερμανία',
      alternatives: ['από την Γερμανία'],
    ),
    VocabularyCard(
      id: 'i-from-russia',
      prompt: LocalizedText(en: 'I am from Russia.', ru: 'Я из России.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'I-me a-PO ti ro-SI-a',
        ru: 'И-мэ а-ПО ти ро-СИ-а',
      ),
      explanation: LocalizedText(
        en: 'Combine the present copula with από + accusative.',
        ru: 'В русском «есть» опущено. В греческом είμαι обязательно; артикль τη тоже часть конструкции.',
      ),
      greek: 'Είμαι από τη Ρωσία.',
      alternatives: ['Είμαι από την Ρωσία.'],
      acceptedAnswers: ['Εγώ είμαι από τη Ρωσία.', 'Εγώ είμαι από την Ρωσία.'],
    ),
    VocabularyCard(
      id: 'i-from-iraq',
      prompt: LocalizedText(en: 'I am from Iraq.', ru: 'Я из Ирака.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'I-me a-PO to i-RAK',
        ru: 'И-мэ а-ПО то и-РАК',
      ),
      explanation: LocalizedText(
        en: 'Use το for Iraq, not the feminine τη(ν).',
        ru: 'Запоминаем страну с родом: το Ιράκ → από το Ιράκ. Нельзя подставить την по аналогии с Россией.',
      ),
      greek: 'Είμαι από το Ιράκ.',

      acceptedAnswers: ['Εγώ είμαι από το Ιράκ.'],
    ),
    VocabularyCard(
      id: 'i-from-cyprus',
      prompt: LocalizedText(en: 'I am from Cyprus.', ru: 'Я с Кипра.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(
        en: 'I-me a-PO tin KI-pro',
        ru: 'И-мэ а-ПО тин КИ-про',
      ),
      explanation: LocalizedText(
        en: 'Κύπρος loses its final ς in the accusative.',
        ru: 'И связка είμαι, и падеж Κύπρο важны. Базовая форма η Κύπρος после από не подходит.',
      ),
      greek: 'Είμαι από την Κύπρο.',

      acceptedAnswers: ['Εγώ είμαι από την Κύπρο.'],
    ),
  ],
);
