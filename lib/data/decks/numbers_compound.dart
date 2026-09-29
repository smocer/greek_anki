import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const numbersCompoundDeck = VocabularyDeck(
  id: 'numbers-compound',
  title: LocalizedText(en: 'Compound numbers', ru: 'Составные числа'),
  subtitle: LocalizedText(
    en: 'Units, addresses and 101',
    ru: 'Единицы, адреса и 101',
  ),
  note: LocalizedText(
    en: 'From 21, tens and units are separate words. These are counting forms; one, three and four can change with noun gender.',
    ru: 'От 21 десятки и единицы пишутся раздельно, как в русском. Здесь формы для счёта; «один», «три», «четыре» могут меняться по роду существительного.',
  ),
  cover: '21–101',
  cards: [
    VocabularyCard(
      id: 'number-21',
      prompt: LocalizedText(en: '21', ru: '21'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'είκοσι ένα',
      pronunciation: LocalizedText(en: 'I-ko-si E-na', ru: 'И-ко-си Э-на'),
      explanation: LocalizedText(
        en: 'Twenty + one; use two words with their own accents.',
        ru: 'Как «двадцать один»: два слова. В греческом при счёте ένα — средний род.',
      ),
    ),
    VocabularyCard(
      id: 'number-23',
      prompt: LocalizedText(en: '23', ru: '23'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'είκοσι τρία',
      pronunciation: LocalizedText(en: 'I-ko-si TRI-a', ru: 'И-ко-си ТРИ-а'),
      explanation: LocalizedText(
        en: 'The address examples use 23, twenty-three.',
        ru: 'Как «двадцать три»: είκοσι + τρία, без союза και.',
      ),
    ),
    VocabularyCard(
      id: 'number-28',
      prompt: LocalizedText(en: '28', ru: '28'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'είκοσι οκτώ',
      pronunciation: LocalizedText(en: 'I-ko-si ok-TO', ru: 'И-ко-си ок-ТО'),
      explanation: LocalizedText(
        en: 'Write the tens and units separately, with both stress marks. Also accepted: είκοσι οχτώ.',
        ru: 'Как в русском, десятки и единицы пишутся раздельно. У каждого слова своё ударение. Также принимается: είκοσι οχτώ.',
      ),
      alternatives: ['είκοσι οχτώ'],
    ),
    VocabularyCard(
      id: 'number-29',
      prompt: LocalizedText(en: '29', ru: '29'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'είκοσι εννέα',
      pronunciation: LocalizedText(en: 'I-ko-si e-NE-a', ru: 'И-ко-си э-НЭ-а'),
      explanation: LocalizedText(
        en: 'Εννιά is also a correct form of nine.',
        ru: 'Можно сказать εννέα или εννιά; обе формы принимаются.',
      ),
      alternatives: ['είκοσι εννιά'],
    ),
    VocabularyCard(
      id: 'number-32',
      prompt: LocalizedText(en: '32', ru: '32'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τριάντα δύο',
      pronunciation: LocalizedText(en: 'tri-AN-da DHI-o', ru: 'три-АН-да ДИ-о'),
      explanation: LocalizedText(
        en: 'Thirty + two. Each word retains its accent.',
        ru: 'Как «тридцать два», без союза; ударение есть у каждого слова.',
      ),
    ),
    VocabularyCard(
      id: 'number-39',
      prompt: LocalizedText(en: '39', ru: '39'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τριάντα εννέα',
      pronunciation: LocalizedText(
        en: 'tri-AN-da e-NE-a',
        ru: 'три-АН-да э-НЭ-а',
      ),
      explanation: LocalizedText(
        en: 'Write the tens and units separately, with both stress marks. Also accepted: τριάντα εννιά.',
        ru: 'Как в русском, десятки и единицы пишутся раздельно. У каждого слова своё ударение. Также принимается: τριάντα εννιά.',
      ),
      alternatives: ['τριάντα εννιά'],
    ),
    VocabularyCard(
      id: 'number-43',
      prompt: LocalizedText(en: '43', ru: '43'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σαράντα τρία',
      pronunciation: LocalizedText(
        en: 'sa-RAN-da TRI-a',
        ru: 'са-РАН-да ТРИ-а',
      ),
      explanation: LocalizedText(
        en: 'Forty + three, in the counting form.',
        ru: 'Τρία — форма для счёта и среднего рода; с мужским/женским будет τρεις.',
      ),
    ),
    VocabularyCard(
      id: 'number-47',
      prompt: LocalizedText(en: '47', ru: '47'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σαράντα εφτά',
      pronunciation: LocalizedText(
        en: 'sa-RAN-da ef-TA',
        ru: 'са-РАН-да эф-ТА',
      ),
      explanation: LocalizedText(
        en: 'Write the tens and units separately, with both stress marks. Also accepted: σαράντα επτά.',
        ru: 'Как в русском, десятки и единицы пишутся раздельно. У каждого слова своё ударение. Также принимается: σαράντα επτά.',
      ),
      alternatives: ['σαράντα επτά'],
    ),
    VocabularyCard(
      id: 'number-49',
      prompt: LocalizedText(en: '49', ru: '49'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σαράντα εννέα',
      pronunciation: LocalizedText(
        en: 'sa-RAN-da e-NE-a',
        ru: 'са-РАН-да э-НЭ-а',
      ),
      explanation: LocalizedText(
        en: 'Write the tens and units separately, with both stress marks. Also accepted: σαράντα εννιά.',
        ru: 'Как в русском, десятки и единицы пишутся раздельно. У каждого слова своё ударение. Также принимается: σαράντα εννιά.',
      ),
      alternatives: ['σαράντα εννιά'],
    ),
    VocabularyCard(
      id: 'number-54',
      prompt: LocalizedText(en: '54', ru: '54'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πενήντα τέσσερα',
      pronunciation: LocalizedText(
        en: 'pe-NIN-da TE-se-ra',
        ru: 'пэ-НИН-да ТЭ-сэ-ра',
      ),
      explanation: LocalizedText(
        en: 'Fifty + four, in the counting form.',
        ru: 'Τέσσερα — для счёта и среднего рода; с мужским/женским — τέσσερις.',
      ),
    ),
    VocabularyCard(
      id: 'number-65',
      prompt: LocalizedText(en: '65', ru: '65'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'εξήντα πέντε',
      pronunciation: LocalizedText(
        en: 'e-KSIN-da PEN-de',
        ru: 'э-КСИН-да ПЭН-дэ',
      ),
      explanation: LocalizedText(
        en: 'Sixty + five; five does not change with noun gender.',
        ru: 'Πέντε не меняется по роду существительного: в этом проще, чем один/три/четыре.',
      ),
    ),
    VocabularyCard(
      id: 'number-76',
      prompt: LocalizedText(en: '76', ru: '76'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'εβδομήντα έξι',
      pronunciation: LocalizedText(
        en: 'ev-dho-MIN-da E-ksi',
        ru: 'эв-до-МИН-да Э-кси',
      ),
      explanation: LocalizedText(
        en: 'Seventy + six; ξ represents /ks/.',
        ru: 'Пишем раздельно и сохраняем ударение έξι, как в карточке 6.',
      ),
    ),
    VocabularyCard(
      id: 'number-77',
      prompt: LocalizedText(en: '77', ru: '77'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'εβδομήντα εφτά',
      pronunciation: LocalizedText(
        en: 'ev-dho-MIN-da ef-TA',
        ru: 'эв-до-МИН-да эф-ТА',
      ),
      explanation: LocalizedText(
        en: 'Write the tens and units separately, with both stress marks. Also accepted: εβδομήντα επτά.',
        ru: 'Как в русском, десятки и единицы пишутся раздельно. У каждого слова своё ударение. Также принимается: εβδομήντα επτά.',
      ),
      alternatives: ['εβδομήντα επτά'],
    ),
    VocabularyCard(
      id: 'number-87',
      prompt: LocalizedText(en: '87', ru: '87'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ογδόντα εφτά',
      pronunciation: LocalizedText(
        en: 'ogh-DHON-da ef-TA',
        ru: 'ог-ДОН-да эф-ТА',
      ),
      explanation: LocalizedText(
        en: 'The everyday εφτά is first; επτά is equally correct.',
        ru: 'Основной вариант 7 — εφτά; επτά также принимается внутри составного числа.',
      ),
      alternatives: ['ογδόντα επτά'],
    ),
    VocabularyCard(
      id: 'number-89',
      prompt: LocalizedText(en: '89', ru: '89'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ογδόντα εννέα',
      pronunciation: LocalizedText(
        en: 'ogh-DHON-da e-NE-a',
        ru: 'ог-ДОН-да э-НЭ-а',
      ),
      explanation: LocalizedText(
        en: 'Write the tens and units separately, with both stress marks. Also accepted: ογδόντα εννιά.',
        ru: 'Как в русском, десятки и единицы пишутся раздельно. У каждого слова своё ударение. Также принимается: ογδόντα εννιά.',
      ),
      alternatives: ['ογδόντα εννιά'],
    ),
    VocabularyCard(
      id: 'number-98',
      prompt: LocalizedText(en: '98', ru: '98'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ενενήντα οκτώ',
      pronunciation: LocalizedText(
        en: 'e-ne-NIN-da ok-TO',
        ru: 'э-нэ-НИН-да ок-ТО',
      ),
      explanation: LocalizedText(
        en: 'Οχτώ is another correct spelling of eight.',
        ru: 'Как у 8, оба варианта правильны: οκτώ и οχτώ.',
      ),
      alternatives: ['ενενήντα οχτώ'],
    ),
    VocabularyCard(
      id: 'number-101',
      prompt: LocalizedText(en: '101', ru: '101'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'εκατόν ένα',
      pronunciation: LocalizedText(en: 'e-ka-TON E-na', ru: 'э-ка-ТОН Э-на'),
      explanation: LocalizedText(
        en: 'Εκατό gains ν before another number.',
        ru: 'Сравните εκατό «сто» и εκατόν ένα «сто один»: перед следующим числом добавляется ν.',
      ),
    ),
  ],
);
