import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const numbersTensDeck = VocabularyDeck(
  id: 'numbers-tens',
  title: LocalizedText(en: 'Tens to 100', ru: 'Десятки до 100'),
  subtitle: LocalizedText(
    en: 'Build larger numbers',
    ru: 'Основа для больших чисел',
  ),
  note: LocalizedText(
    en: 'Learn the tens, then add a separate word for the units. Use εκατό alone and εκατόν before another number.',
    ru: 'Как «сорок три»: десятки и единицы пишутся отдельно. 100 само по себе — εκατό; перед следующим числом — εκατόν.',
  ),
  cover: '30–100',
  cards: [
    VocabularyCard(
      id: 'number-30',
      prompt: LocalizedText(en: '30', ru: '30'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τριάντα',
      pronunciation: LocalizedText(en: 'tri-AN-da', ru: 'три-АН-да'),
      explanation: LocalizedText(
        en: 'Thirty; the τρι- part recalls τρία, three.',
        ru: 'Τρι- напоминает τρία «три», как «три» в «тридцать».',
      ),
    ),
    VocabularyCard(
      id: 'number-40',
      prompt: LocalizedText(en: '40', ru: '40'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σαράντα',
      pronunciation: LocalizedText(en: 'sa-RAN-da', ru: 'са-РАН-да'),
      explanation: LocalizedText(
        en: 'Forty is σαράντα; learn it as a whole word.',
        ru: 'Как русское «сорок», эту форму проще запомнить целиком.',
      ),
    ),
    VocabularyCard(
      id: 'number-50',
      prompt: LocalizedText(en: '50', ru: '50'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'πενήντα',
      pronunciation: LocalizedText(en: 'pe-NIN-da', ru: 'пэ-НИН-да'),
      explanation: LocalizedText(
        en: 'Fifty; compare πέντε, five.',
        ru: 'Сравните πέντε «пять» и πενήντα «пятьдесят». Ударение меняет место.',
      ),
    ),
    VocabularyCard(
      id: 'number-60',
      prompt: LocalizedText(en: '60', ru: '60'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'εξήντα',
      pronunciation: LocalizedText(en: 'e-KSIN-da', ru: 'э-КСИН-да'),
      explanation: LocalizedText(
        en: 'Sixty; ξ is /ks/.',
        ru: 'Сравните έξι «шесть» и εξήντα «шестьдесят»; ξ читается «кс».',
      ),
    ),
    VocabularyCard(
      id: 'number-70',
      prompt: LocalizedText(en: '70', ru: '70'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'εβδομήντα',
      pronunciation: LocalizedText(en: 'ev-dho-MIN-da', ru: 'эв-до-МИН-да'),
      explanation: LocalizedText(
        en: 'Seventy uses εβδομ-, not the everyday εφτ- stem.',
        ru: 'Для 70 отдельная основа εβδομ-. Нельзя просто присоединить окончание к εφτά.',
      ),
    ),
    VocabularyCard(
      id: 'number-80',
      prompt: LocalizedText(en: '80', ru: '80'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ογδόντα',
      pronunciation: LocalizedText(en: 'ogh-DHON-da', ru: 'ог-ДОН-да'),
      explanation: LocalizedText(
        en: 'Eighty is written with γδ, although eight is οκτώ/οχτώ.',
        ru: '80 — ογδόντα: обратите внимание на γδ, а не κτ или χτ как в числе 8.',
      ),
    ),
    VocabularyCard(
      id: 'number-90',
      prompt: LocalizedText(en: '90', ru: '90'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ενενήντα',
      pronunciation: LocalizedText(en: 'e-ne-NIN-da', ru: 'э-нэ-НИН-да'),
      explanation: LocalizedText(
        en: 'Ninety has single ν at each position, unlike εννέα.',
        ru: 'В ενενήντα нет удвоенного ν, хотя в εννέα «девять» есть νν.',
      ),
    ),
    VocabularyCard(
      id: 'number-100',
      prompt: LocalizedText(en: '100', ru: '100'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'εκατό',
      pronunciation: LocalizedText(en: 'e-ka-TO', ru: 'э-ка-ТО'),
      explanation: LocalizedText(
        en: 'Use εκατό for exactly one hundred; compare εκατόν ένα, 101.',
        ru: 'Ровно «сто» — εκατό. Перед единицами появляется ν: εκατόν ένα.',
      ),
    ),
  ],
);
