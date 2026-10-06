import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const addressesNearbyDeck = VocabularyDeck(
  id: 'addresses-nearby',
  title: LocalizedText(en: 'Addresses & nearby places', ru: 'Адреса и «рядом»'),
  subtitle: LocalizedText(
    en: 'Where exactly? Near what?',
    ru: 'Где именно? Рядом с чем?',
  ),
  note: LocalizedText(
    en: 'Κοντά σε uses the accusative, unlike Russian рядом с + instrumental. Address numbers are written out for the built-in Greek keyboard.',
    ru: 'Κοντά σε — «рядом с», но после σε винительный, а после русского «с» — творительный. Номера домов пишем словами для греческой клавиатуры.',
  ),
  cover: 'Πού;',
  cards: [
    VocabularyCard(
      id: 'ask-live-polite',
      prompt: LocalizedText(
        en: 'Where do you live? (polite/plural)',
        ru: 'Где Вы живёте?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πού μένετε;',
      pronunciation: LocalizedText(en: 'pu ME-ne-te', ru: 'пу МЭ-нэ-тэ'),
      explanation: LocalizedText(
        en: 'Use μένετε for polite singular or plural.',
        ru: 'Как «Вы живёте»: та же форма для группы и для одного человека на Вы.',
      ),
      acceptedAnswers: ['Εσείς πού μένετε;', 'Πού μένετε εσείς;'],
    ),
    VocabularyCard(
      id: 'where-exactly',
      prompt: LocalizedText(en: 'Where exactly?', ru: 'Где именно?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Πού ακριβώς;',
      pronunciation: LocalizedText(en: 'pu a-kri-VOS', ru: 'пу а-кри-ВОС'),
      explanation: LocalizedText(
        en: 'Ακριβώς adds precisely/exactly to the question.',
        ru: 'Ακριβώς — «точно, именно». Оба слова требуют ударения, в том числе односложное πού.',
      ),
    ),
    VocabularyCard(
      id: 'near',
      prompt: LocalizedText(en: 'Near / nearby', ru: 'Рядом / близко'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κοντά',
      pronunciation: LocalizedText(en: 'kon-DA', ru: 'кон-ДА'),
      explanation: LocalizedText(
        en: 'Κοντά can stand alone; add σε before the nearby place.',
        ru: 'Как «рядом» без дополнения; «рядом с чем?» — κοντά σε + винительный.',
      ),
    ),
    VocabularyCard(
      id: 'near-what',
      prompt: LocalizedText(en: 'Near what?', ru: 'Рядом с чем?'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Κοντά σε τι;',
      pronunciation: LocalizedText(en: 'kon-DA se ti', ru: 'кон-ДА сэ ти'),
      explanation: LocalizedText(
        en: 'Τι does not change form after σε.',
        ru: 'По-русски «с чем» — творительный; τι не меняется, а предлог — σε.',
      ),
    ),
    VocabularyCard(
      id: 'near-here',
      prompt: LocalizedText(
        en: 'Do you live near here? (informal)',
        ru: 'Ты живёшь здесь поблизости?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένεις εδώ κοντά;',
      pronunciation: LocalizedText(
        en: 'ME-nis e-DHO kon-DA',
        ru: 'МЭ-нис э-ДО кон-ДА',
      ),
      explanation: LocalizedText(
        en: 'Εδώ κοντά means near here, without an article.',
        ru: 'Εδώ κοντά — «здесь поблизости»; перед наречием εδώ предлог не нужен.',
      ),
      acceptedAnswers: ['Μένεις κοντά εδώ;'],
    ),
    VocabularyCard(
      id: 'near-home',
      prompt: LocalizedText(en: 'Near the house', ru: 'Рядом с домом'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'κοντά στο σπίτι',
      pronunciation: LocalizedText(
        en: 'kon-DA sto SPI-ti',
        ru: 'кон-ДА сто СПИ-ти',
      ),
      explanation: LocalizedText(
        en: 'Σε + το becomes στο; σπίτι is neuter.',
        ru: '«С домом» — русский творительный; στο σπίτι — греческий винительный. Το σπίτι среднего рода.',
      ),
    ),
    VocabularyCard(
      id: 'far',
      prompt: LocalizedText(en: 'Far / far away', ru: 'Далеко'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'μακριά',
      pronunciation: LocalizedText(en: 'ma-kri-A', ru: 'ма-кри-А'),
      explanation: LocalizedText(
        en: 'Μακριά contrasts with κοντά.',
        ru: 'Противоположность κοντά «близко». Это наречие, как русское «далеко».',
      ),
    ),
    VocabularyCard(
      id: 'street',
      prompt: LocalizedText(
        en: 'The street / road (with article)',
        ru: 'Улица / дорога (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ο δρόμος',
      pronunciation: LocalizedText(en: 'o DHRO-mos', ru: 'о ДРО-мос'),
      explanation: LocalizedText(
        en: 'Δρόμος is masculine; στον δρόμο means in/on the street.',
        ru: 'В русском «улица/дорога» женского рода, ο δρόμος — мужского. Сравните στον δρόμο «на улице».',
      ),
    ),
    VocabularyCard(
      id: 'address',
      prompt: LocalizedText(
        en: 'The address (with article)',
        ru: 'Адрес (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'η διεύθυνση',
      pronunciation: LocalizedText(
        en: 'i dhi-EF-thin-si',
        ru: 'и ди-ЭФ-тин-си',
      ),
      explanation: LocalizedText(
        en: 'Διεύθυνση is feminine; ευ before θ sounds /ef/.',
        ru: 'Русский «адрес» мужского рода, η διεύθυνση женского. Ευ перед θ читается «эф».',
      ),
    ),
    VocabularyCard(
      id: 'cycladon-address',
      prompt: LocalizedText(
        en: 'I live at 29 Kykladon Street. (number in words)',
        ru: 'Я живу на улице Кикладон, 29. (число словами)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω Κυκλάδων είκοσι εννέα.',
      pronunciation: LocalizedText(
        en: 'ME-no ki-KLA-dhon I-ko-si e-NE-a',
        ru: 'МЭ-но ки-КЛА-дон И-ко-си э-НЭ-а',
      ),
      explanation: LocalizedText(
        en: 'A short address can omit οδός and the preposition. Κυκλάδων is the fixed street name.',
        ru: 'В коротком адресе говорят «Μένω Κυκλάδων…» без предлога. Κυκλάδων уже форма родительного множественного «Киклад» в названии улицы.',
      ),
      alternatives: ['Μένω Κυκλάδων είκοσι εννιά.'],
      acceptedAnswers: [
        'Μένω στην οδό Κυκλάδων είκοσι εννέα.',
        'Μένω στην οδό Κυκλάδων είκοσι εννιά.',
      ],
    ),
    VocabularyCard(
      id: 'mouson-address',
      prompt: LocalizedText(
        en: 'I live at 23 Mouson Street. (number in words)',
        ru: 'Я живу на улице Мусон, 23. (число словами)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω Μουσών είκοσι τρία.',
      pronunciation: LocalizedText(
        en: 'ME-no mu-SON I-ko-si TRI-a',
        ru: 'МЭ-но му-СОН И-ко-си ТРИ-а',
      ),
      explanation: LocalizedText(
        en: 'Μουσών is a street name meaning of the Muses.',
        ru: 'Μουσών — «Муз», родительный множественного в названии улицы. Номер дома — είκοσι τρία.',
      ),
      acceptedAnswers: ['Μένω στην οδό Μουσών είκοσι τρία.'],
    ),
    VocabularyCard(
      id: 'pontou-address',
      prompt: LocalizedText(
        en: 'I live at 16 Pontou Street. (number in words)',
        ru: 'Я живу на улице Понту, 16. (число словами)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω Πόντου δεκαέξι.',
      pronunciation: LocalizedText(
        en: 'ME-no PON-du dhe-ka-E-ksi',
        ru: 'МЭ-но ПОН-ду дэ-ка-Э-кси',
      ),
      explanation: LocalizedText(
        en: 'Both δεκαέξι and δεκάξι are standard forms of sixteen.',
        ru: '16 можно написать δεκαέξι или δεκάξι; ударение должно соответствовать выбранному варианту.',
      ),
      alternatives: ['Μένω Πόντου δεκάξι.'],
      acceptedAnswers: [
        'Μένω στην οδό Πόντου δεκαέξι.',
        'Μένω στην οδό Πόντου δεκάξι.',
      ],
    ),
    VocabularyCard(
      id: 'kefallinias-address',
      prompt: LocalizedText(
        en: 'I live at 23 Kefallinias Street. (number in words)',
        ru: 'Я живу на улице Кефаллиниас, 23. (число словами)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Μένω Κεφαλληνίας είκοσι τρία.',
      pronunciation: LocalizedText(
        en: 'ME-no ke-fa-li-NI-as I-ko-si TRI-a',
        ru: 'МЭ-но кэ-фа-ли-НИ-ас И-ко-си ТРИ-а',
      ),
      explanation: LocalizedText(
        en: 'Keep the street spelling Κεφαλληνίας from the lesson.',
        ru: 'В названии улицы из урока пишется Κεφαλληνίας. Это название, а не новая форма числительного.',
      ),
      acceptedAnswers: ['Μένω στην οδό Κεφαλληνίας είκοσι τρία.'],
    ),
  ],
);
