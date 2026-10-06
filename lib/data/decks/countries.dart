import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const countriesDeck = VocabularyDeck(
  id: 'countries',
  title: LocalizedText(en: 'Countries & gender', ru: 'Страны и род'),
  subtitle: LocalizedText(
    en: 'Country names with their articles',
    ru: 'Названия стран с артиклями',
  ),
  note: LocalizedText(
    en: 'Learn each name with its article. Greek grammatical gender does not always match Russian.',
    ru: 'Учите страну вместе с артиклем: род греческого названия может отличаться от русского.',
  ),
  cover: 'Κόσμος',
  cards: [
    VocabularyCard(
      id: 'russia',
      prompt: LocalizedText(en: 'Russia', ru: 'Россия'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i ro-SI-a', ru: 'и ро-СИ-а'),
      explanation: LocalizedText(
        en: 'Feminine: η Ρωσία.',
        ru: 'Ρωσία — женского рода, как русское «Россия». Артикль η помогает запомнить греческий род.',
      ),
      greek: 'η Ρωσία',
    ),
    VocabularyCard(
      id: 'iraq',
      prompt: LocalizedText(en: 'Iraq', ru: 'Ирак'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to i-RAK', ru: 'то и-РАК'),
      explanation: LocalizedText(
        en: 'Neuter and indeclinable; the article shows its case.',
        ru: 'В русском Ирак мужского рода, в греческом το Ιράκ — среднего и не склоняется.',
      ),
      greek: 'το Ιράκ',
    ),
    VocabularyCard(
      id: 'greece',
      prompt: LocalizedText(en: 'Greece', ru: 'Греция'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i e-LA-dha', ru: 'и э-ЛА-да'),
      explanation: LocalizedText(
        en: 'Feminine; the Greek country name is Ελλάδα.',
        ru: 'Женский род. Ελλάδα — Греция, родственное слово Ελληνικά — греческий язык.',
      ),
      greek: 'η Ελλάδα',
    ),
    VocabularyCard(
      id: 'cyprus',
      prompt: LocalizedText(en: 'Cyprus', ru: 'Кипр'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i KI-pros', ru: 'и КИ-прос'),
      explanation: LocalizedText(
        en: 'Feminine despite the ending -ος.',
        ru: 'Кипр в русском мужского рода, но η Κύπρος — женского. Окончание -ος само по себе род не гарантирует.',
      ),
      greek: 'η Κύπρος',
    ),
    VocabularyCard(
      id: 'ukraine',
      prompt: LocalizedText(en: 'Ukraine', ru: 'Украина'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i u-kra-NI-a', ru: 'и у-кра-НИ-а'),
      explanation: LocalizedText(
        en: 'Feminine; ου is one /u/ sound.',
        ru: 'Женский род; ου читается «у», а не «оу».',
      ),
      greek: 'η Ουκρανία',
    ),
    VocabularyCard(
      id: 'canada',
      prompt: LocalizedText(en: 'Canada', ru: 'Канада'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'o ka-na-DHAS', ru: 'о ка-на-ДАС'),
      explanation: LocalizedText(
        en: 'Masculine: ο Καναδάς.',
        ru: 'В русском Канада женского рода, в греческом ο Καναδάς — мужского.',
      ),
      greek: 'ο Καναδάς',
    ),
    VocabularyCard(
      id: 'england',
      prompt: LocalizedText(en: 'England', ru: 'Англия'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i an-GLI-a', ru: 'и ан-ГЛИ-а'),
      explanation: LocalizedText(
        en: 'Feminine; γγ here is pronounced /ng/.',
        ru: 'Женский род; γγ звучит примерно как «нг», не как два отдельных «г».',
      ),
      greek: 'η Αγγλία',
    ),
    VocabularyCard(
      id: 'germany',
      prompt: LocalizedText(en: 'Germany', ru: 'Германия'),
      meaning: LocalizedText(
        en: 'Include the nominative article.',
        ru: 'С артиклем в именительном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i yer-ma-NI-a', ru: 'и йер-ма-НИ-а'),
      explanation: LocalizedText(
        en: 'Feminine. Γ before ε has a softer sound.',
        ru: 'Как в «Германия», женский род; γ перед ε звучит близко к «й», не к твёрдому «г».',
      ),
      greek: 'η Γερμανία',
    ),
    VocabularyCard(
      id: 'lebanon',
      prompt: LocalizedText(
        en: 'Lebanon (with the article)',
        ru: 'Ливан (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'ο Λίβανος',
      pronunciation: LocalizedText(en: 'o LI-va-nos', ru: 'о ЛИ-ва-нос'),
      explanation: LocalizedText(
        en: 'Masculine -ος loses final ς in the accusative.',
        ru: 'Ливан и Λίβανος — мужского рода. Ο Λίβανος → τον Λίβανο: убираем -ς.',
      ),
    ),
    VocabularyCard(
      id: 'france',
      prompt: LocalizedText(
        en: 'France (with the article)',
        ru: 'Франция (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Γαλλία',
      pronunciation: LocalizedText(en: 'i gha-LI-a', ru: 'и га-ЛИ-а'),
      explanation: LocalizedText(
        en: 'Feminine: η Γαλλία → την Γαλλία; the noun keeps its form.',
        ru: 'Женский род, как в русском. Но «Франция → из Франции», а Γαλλία после από не меняется.',
      ),
    ),
    VocabularyCard(
      id: 'argentina',
      prompt: LocalizedText(
        en: 'Argentina (with the article)',
        ru: 'Аргентина (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Αργεντινή',
      pronunciation: LocalizedText(en: 'i ar-yen-di-NI', ru: 'и ар-йэн-ди-НИ'),
      explanation: LocalizedText(
        en: 'Feminine, with final stress: η Αργεντινή → την Αργεντινή.',
        ru: 'Женский род, как «Аргентина». В греческом ударение в конце: Αργεντινή; после από меняется артикль.',
      ),
    ),
    VocabularyCard(
      id: 'morocco',
      prompt: LocalizedText(
        en: 'Morocco (with the article)',
        ru: 'Марокко (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το Μαρόκο',
      pronunciation: LocalizedText(en: 'to ma-RO-ko', ru: 'то ма-РО-ко'),
      explanation: LocalizedText(
        en: 'Neuter and indeclinable: το Μαρόκο remains the same after από.',
        ru: 'Как русское название «Марокко», греческое Μαρόκο не склоняется. Средний род: το Μαρόκο, από το Μαρόκο.',
      ),
    ),
    VocabularyCard(
      id: 'burundi',
      prompt: LocalizedText(
        en: 'Burundi (with the article)',
        ru: 'Бурунди (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το Μπουρούντι',
      pronunciation: LocalizedText(en: 'to bu-RUN-di', ru: 'то бу-РУН-ди'),
      explanation: LocalizedText(
        en: 'Neuter and indeclinable. Initial μπ represents b.',
        ru: 'Το Μπουρούντι — средний род, слово не склоняется. Μπ в начале передаёт «б». После από: το Μπουρούντι.',
      ),
    ),
    VocabularyCard(
      id: 'afghanistan',
      prompt: LocalizedText(
        en: 'Afghanistan (with the article)',
        ru: 'Афганистан (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το Αφγανιστάν',
      pronunciation: LocalizedText(
        en: 'to af-gha-ni-STAN',
        ru: 'то аф-га-ни-СТАН',
      ),
      explanation: LocalizedText(
        en: 'Neuter and indeclinable despite the final consonant.',
        ru: 'Афганистан в русском мужского рода, в греческом среднего: το Αφγανιστάν. Слово не склоняется.',
      ),
    ),
    VocabularyCard(
      id: 'israel',
      prompt: LocalizedText(
        en: 'Israel (with the article)',
        ru: 'Израиль (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το Ισραήλ',
      pronunciation: LocalizedText(en: 'to iz-ra-IL', ru: 'то из-ра-ИЛ'),
      explanation: LocalizedText(
        en: 'Neuter and indeclinable: το Ισραήλ.',
        ru: 'Израиль в русском мужского рода, το Ισραήλ — среднего. В «из Израиля» греческое название не меняется: από το Ισραήλ.',
      ),
    ),
    VocabularyCard(
      id: 'egypt',
      prompt: LocalizedText(
        en: 'Egypt (with the article)',
        ru: 'Египет (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Αίγυπτος',
      pronunciation: LocalizedText(en: 'i E-yip-tos', ru: 'и Э-йип-тос'),
      explanation: LocalizedText(
        en: 'Feminine despite -ος: η Αίγυπτος → την Αίγυπτο.',
        ru: 'Египет в русском мужского рода, η Αίγυπτος — женского. В винительном убираем -ς: την Αίγυπτο.',
      ),
    ),
    VocabularyCard(
      id: 'usa',
      prompt: LocalizedText(
        en: 'USA (use the Greek abbreviation) (with the article)',
        ru: 'США (греческая аббревиатура) (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'οι ΗΠΑ',
      pronunciation: LocalizedText(
        en: 'i I-ta pi AL-fa',
        ru: 'и И-та пи АЛ-фа',
      ),
      explanation: LocalizedText(
        en: 'ΗΠΑ abbreviates Ηνωμένες Πολιτείες Αμερικής. Feminine plural: οι → τις; the pronunciation guide spells out the letters.',
        ru: 'ΗΠΑ — Ηνωμένες Πολιτείες Αμερικής, США. Женский род, множественное число: οι → τις. В подсказке произношения названы буквы Η, Π, Α.',
      ),
    ),
    VocabularyCard(
      id: 'italy',
      prompt: LocalizedText(
        en: 'Italy (with the article)',
        ru: 'Италия (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Ιταλία',
      pronunciation: LocalizedText(en: 'i i-ta-LI-a', ru: 'и и-та-ЛИ-а'),
      explanation: LocalizedText(
        en: 'Feminine: η Ιταλία → την Ιταλία.',
        ru: 'Женский род, как в русском, но ударение на -λί-: Ιταλία. «Из Италии»: από την Ιταλία.',
      ),
    ),
    VocabularyCard(
      id: 'china',
      prompt: LocalizedText(
        en: 'China (with the article)',
        ru: 'Китай (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Κίνα',
      pronunciation: LocalizedText(en: 'i KI-na', ru: 'и КИ-на'),
      explanation: LocalizedText(
        en: 'China is feminine in Greek: η Κίνα.',
        ru: 'Китай в русском мужского рода, η Κίνα — женского. «Из Китая»: από την Κίνα; существительное не меняет форму.',
      ),
    ),
    VocabularyCard(
      id: 'denmark',
      prompt: LocalizedText(
        en: 'Denmark (with the article)',
        ru: 'Дания (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Δανία',
      pronunciation: LocalizedText(en: 'i dha-NI-a', ru: 'и да-НИ-а'),
      explanation: LocalizedText(
        en: 'Feminine with stress on -νί-: η Δανία → την Δανία.',
        ru: 'Род совпадает с русским, ударение — нет: Δανία, на -νί-. После από винительный, хотя русское «из Дании» — родительный.',
      ),
    ),
    VocabularyCard(
      id: 'bulgaria',
      prompt: LocalizedText(
        en: 'Bulgaria (with the article)',
        ru: 'Болгария (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Βουλγαρία',
      pronunciation: LocalizedText(en: 'i vul-gha-RI-a', ru: 'и вул-га-РИ-а'),
      explanation: LocalizedText(
        en: 'Feminine: η Βουλγαρία → την Βουλγαρία. Β is pronounced v.',
        ru: 'Женский род, как в русском. Но β читается «в», ου — «у»: Βουλγαρία. «Из Болгарии»: από την Βουλγαρία.',
      ),
    ),
  ],
);
