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
    ru: 'Для происхождения: από + винительный, в отличие от русского «из + родительный». Артикли: ο → τον, η → την, το → το.',
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
        ru: 'В «Откуда ты?» по-русски нет глагола, а по-гречески нужен είσαι — форма «быть» для «ты».',
      ),
      greek: 'Από πού είσαι;',
    ),
    VocabularyCard(
      id: 'ask-origin-polite',
      prompt: LocalizedText(
        en: 'Where are you from? (polite/plural)',
        ru: 'Откуда Вы?',
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
        ru: '«Из России» — родительный в русском; από την Ρωσία — винительный в греческом. Род слова не меняется; η становится την.',
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
        ru: 'Η Ελλάδα → από την Ελλάδα. После από нужен винительный; само название страны сохраняет форму.',
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
        ru: 'Η Ουκρανία → από την Ουκρανία. У страны женский род; после από нужен винительный.',
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
        ru: 'Η Αγγλία → από την Αγγλία. После από нужен винительный: η заменяется на την.',
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
        ru: 'Η Γερμανία → από την Γερμανία. Как «из Германии», но в греческом после από нужен винительный.',
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
        ru: 'В «Я из России» по-русски нет глагола. По-гречески нужен είμαι: είμαι από την Ρωσία.',
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
    VocabularyCard(
      id: 'from-lebanon',
      prompt: LocalizedText(en: 'From Lebanon', ru: 'Из Ливана'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από τον Λίβανο',
      pronunciation: LocalizedText(
        en: 'a-PO ton LI-va-no',
        ru: 'а-ПО тон ЛИ-ва-но',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Masculine -ος loses final ς in the accusative.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Ливан и Λίβανος — мужского рода. Ο Λίβανος → τον Λίβανο: убираем -ς.',
      ),
    ),
    VocabularyCard(
      id: 'from-france',
      prompt: LocalizedText(en: 'From France', ru: 'Из Франции'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από την Γαλλία',
      pronunciation: LocalizedText(
        en: 'a-PO tin gha-LI-a',
        ru: 'а-ПО тин га-ЛИ-а',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Feminine: η Γαλλία → την Γαλλία; the noun keeps its form.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Женский род, как в русском. Но «Франция → из Франции», а Γαλλία после από не меняется.',
      ),
      alternatives: ['από τη Γαλλία'],
    ),
    VocabularyCard(
      id: 'from-argentina',
      prompt: LocalizedText(en: 'From Argentina', ru: 'Из Аргентины'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από την Αργεντινή',
      pronunciation: LocalizedText(
        en: 'a-PO tin ar-yen-di-NI',
        ru: 'а-ПО тин ар-йэн-ди-НИ',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Feminine, with final stress: η Αργεντινή → την Αργεντινή.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Женский род, как «Аргентина». В греческом ударение в конце: Αργεντινή; после από меняется артикль.',
      ),
    ),
    VocabularyCard(
      id: 'from-morocco',
      prompt: LocalizedText(en: 'From Morocco', ru: 'Из Марокко'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από το Μαρόκο',
      pronunciation: LocalizedText(
        en: 'a-PO to ma-RO-ko',
        ru: 'а-ПО то ма-РО-ко',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Neuter and indeclinable: το Μαρόκο remains the same after από.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Как русское название «Марокко», греческое Μαρόκο не склоняется. Средний род: το Μαρόκο, από το Μαρόκο.',
      ),
    ),
    VocabularyCard(
      id: 'from-burundi',
      prompt: LocalizedText(en: 'From Burundi', ru: 'Из Бурунди'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από το Μπουρούντι',
      pronunciation: LocalizedText(
        en: 'a-PO to bu-RUN-di',
        ru: 'а-ПО то бу-РУН-ди',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Neuter and indeclinable. Initial μπ represents b.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Το Μπουρούντι — средний род, слово не склоняется. Μπ в начале передаёт «б». После από: το Μπουρούντι.',
      ),
    ),
    VocabularyCard(
      id: 'from-afghanistan',
      prompt: LocalizedText(en: 'From Afghanistan', ru: 'Из Афганистана'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από το Αφγανιστάν',
      pronunciation: LocalizedText(
        en: 'a-PO to af-gha-ni-STAN',
        ru: 'а-ПО то аф-га-ни-СТАН',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Neuter and indeclinable despite the final consonant.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Афганистан в русском мужского рода, в греческом среднего: το Αφγανιστάν. Слово не склоняется.',
      ),
    ),
    VocabularyCard(
      id: 'from-israel',
      prompt: LocalizedText(en: 'From Israel', ru: 'Из Израиля'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από το Ισραήλ',
      pronunciation: LocalizedText(
        en: 'a-PO to iz-ra-IL',
        ru: 'а-ПО то из-ра-ИЛ',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Neuter and indeclinable: το Ισραήλ.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Израиль в русском мужского рода, το Ισραήλ — среднего. В «из Израиля» греческое название не меняется: από το Ισραήλ.',
      ),
    ),
    VocabularyCard(
      id: 'from-egypt',
      prompt: LocalizedText(en: 'From Egypt', ru: 'Из Египта'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από την Αίγυπτο',
      pronunciation: LocalizedText(
        en: 'a-PO tin E-yip-to',
        ru: 'а-ПО тин Э-йип-то',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Feminine despite -ος: η Αίγυπτος → την Αίγυπτο.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Египет в русском мужского рода, η Αίγυπτος — женского. В винительном убираем -ς: την Αίγυπτο.',
      ),
    ),
    VocabularyCard(
      id: 'from-usa',
      prompt: LocalizedText(
        en: 'From USA (use the Greek abbreviation)',
        ru: 'Из США (греческая аббревиатура)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από τις ΗΠΑ',
      pronunciation: LocalizedText(
        en: 'a-PO tis I-ta pi AL-fa',
        ru: 'а-ПО тис И-та пи АЛ-фа',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. ΗΠΑ abbreviates Ηνωμένες Πολιτείες Αμερικής. Feminine plural: οι → τις; the pronunciation guide spells out the letters.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. ΗΠΑ — Ηνωμένες Πολιτείες Αμερικής, США. Женский род, множественное число: οι → τις. В подсказке произношения названы буквы Η, Π, Α.',
      ),
    ),
    VocabularyCard(
      id: 'from-italy',
      prompt: LocalizedText(en: 'From Italy', ru: 'Из Италии'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από την Ιταλία',
      pronunciation: LocalizedText(
        en: 'a-PO tin i-ta-LI-a',
        ru: 'а-ПО тин и-та-ЛИ-а',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Feminine: η Ιταλία → την Ιταλία.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Женский род, как в русском, но ударение на -λί-: Ιταλία. «Из Италии»: από την Ιταλία.',
      ),
    ),
    VocabularyCard(
      id: 'from-china',
      prompt: LocalizedText(en: 'From China', ru: 'Из Китая'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από την Κίνα',
      pronunciation: LocalizedText(en: 'a-PO tin KI-na', ru: 'а-ПО тин КИ-на'),
      explanation: LocalizedText(
        en: 'Από takes the accusative. China is feminine in Greek: η Κίνα.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Китай в русском мужского рода, η Κίνα — женского. «Из Китая»: από την Κίνα; существительное не меняет форму.',
      ),
    ),
    VocabularyCard(
      id: 'from-denmark',
      prompt: LocalizedText(en: 'From Denmark', ru: 'Из Дании'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από την Δανία',
      pronunciation: LocalizedText(
        en: 'a-PO tin dha-NI-a',
        ru: 'а-ПО тин да-НИ-а',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Feminine with stress on -νί-: η Δανία → την Δανία.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Род совпадает с русским, ударение — нет: Δανία, на -νί-. После από винительный, хотя русское «из Дании» — родительный.',
      ),
      alternatives: ['από τη Δανία'],
    ),
    VocabularyCard(
      id: 'from-bulgaria',
      prompt: LocalizedText(en: 'From Bulgaria', ru: 'Из Болгарии'),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'από την Βουλγαρία',
      pronunciation: LocalizedText(
        en: 'a-PO tin vul-gha-RI-a',
        ru: 'а-ПО тин вул-га-РИ-а',
      ),
      explanation: LocalizedText(
        en: 'Από takes the accusative. Feminine: η Βουλγαρία → την Βουλγαρία. Β is pronounced v.',
        ru: 'В русском «из» требует родительного, в греческом από — винительного. Женский род, как в русском. Но β читается «в», ου — «у»: Βουλγαρία. «Из Болгарии»: από την Βουλγαρία.',
      ),
      alternatives: ['από τη Βουλγαρία'],
    ),
  ],
);
