import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const namesVocativeDeck = VocabularyDeck(
  id: 'names-vocative',
  title: LocalizedText(
    en: 'Greek names & calling someone',
    ru: 'Имена и обращение',
  ),
  subtitle: LocalizedText(
    en: 'Name a person, then address them',
    ru: 'Назвать человека и обратиться к нему',
  ),
  note: LocalizedText(
    en: 'Vocative is used to address someone and has no article. Learn each name’s actual form; syllable count is not a reliable universal rule.',
    ru: 'Звательный падеж — для обращения, без артикля. В русском есть разговорное «Маш!», но греческие формы — часть грамматики. Число слогов не даёт универсального правила.',
  ),
  cover: 'Γιώργο!',
  cards: [
    VocabularyCard(
      id: 'george-name',
      prompt: LocalizedText(
        en: 'George (as a subject)',
        ru: 'Йоргос (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'o YOR-ghos', ru: 'о ЙОР-гос'),
      explanation: LocalizedText(
        en: 'Greek Γιώργος corresponds to George / Георгий.',
        ru: 'Имя соответствует Георгию. Для называния человека — ο Γιώργος; при обращении форма другая.',
      ),
      greek: 'ο Γιώργος',
    ),
    VocabularyCard(
      id: 'george-call',
      prompt: LocalizedText(
        en: 'George! (call to him)',
        ru: 'Йоргос! (обращение)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'YOR-gho', ru: 'ЙОР-го'),
      explanation: LocalizedText(
        en: 'Vocative: drop final ς and the article.',
        ru: 'Ο Γιώργος → Γιώργο! Артикль при обращении не используется.',
      ),
      greek: 'Γιώργο!',
    ),
    VocabularyCard(
      id: 'peter-name',
      prompt: LocalizedText(
        en: 'Peter (as a subject)',
        ru: 'Петрос (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'o PE-tros', ru: 'о ПЭ-трос'),
      explanation: LocalizedText(
        en: 'The Greek counterpart of Peter / Пётр.',
        ru: 'Пётр и Πέτρος — формы одного имени; запомните греческое написание и артикль.',
      ),
      greek: 'ο Πέτρος',
    ),
    VocabularyCard(
      id: 'peter-call',
      prompt: LocalizedText(
        en: 'Peter! (call to him)',
        ru: 'Петрос! (обращение)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'PE-tro', ru: 'ПЭ-тро'),
      explanation: LocalizedText(
        en: 'This name has vocative Πέτρο, not Πέτρε in the form studied here.',
        ru: 'В изучаемом обычном обращении — Πέτρο! Не применяйте механически правило -ος → -ε.',
      ),
      greek: 'Πέτρο!',
    ),
    VocabularyCard(
      id: 'john-name',
      prompt: LocalizedText(
        en: 'John (as a subject)',
        ru: 'Яннис (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'o YA-nis', ru: 'о Я-нис'),
      explanation: LocalizedText(
        en: 'Γιάννης corresponds to John / Иван through the name Иоанн.',
        ru: 'Γιάννης — родственник имени Иван через Иоанн. Две ν пишутся, но не удлиняются в обычной речи.',
      ),
      greek: 'ο Γιάννης',
    ),
    VocabularyCard(
      id: 'john-call',
      prompt: LocalizedText(
        en: 'John! (call to him)',
        ru: 'Яннис! (обращение)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'YA-ni', ru: 'Я-ни'),
      explanation: LocalizedText(
        en: 'Names ending in -ης commonly lose ς in direct address.',
        ru: 'Ο Γιάννης → Γιάννη! Сравните словарную форму и форму обращения, без артикля.',
      ),
      greek: 'Γιάννη!',
    ),
    VocabularyCard(
      id: 'constantine-name',
      prompt: LocalizedText(
        en: 'Constantine (as a subject)',
        ru: 'Константинос (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(
        en: 'o kon-stan-DI-nos',
        ru: 'о кон-стан-ДИ-нос',
      ),
      explanation: LocalizedText(
        en: 'The counterpart of Constantine / Константин.',
        ru: 'Знакомое имя Константин помогает запомнить основу; греческое ударение на τί.',
      ),
      greek: 'ο Κωνσταντίνος',
    ),
    VocabularyCard(
      id: 'constantine-call',
      prompt: LocalizedText(
        en: 'Constantine! (call to him)',
        ru: 'Константинос! (обращение)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'kon-stan-DI-ne', ru: 'кон-стан-ДИ-нэ'),
      explanation: LocalizedText(
        en: 'The vocative ends in -ε.',
        ru: 'Κωνσταντίνος → Κωνσταντίνε! Окончание -ε и отсутствие артикля отмечают обращение.',
      ),
      greek: 'Κωνσταντίνε!',
    ),
    VocabularyCard(
      id: 'alexander-name',
      prompt: LocalizedText(
        en: 'Alexander (as a subject)',
        ru: 'Александрос (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(
        en: 'o a-LE-ksan-dhros',
        ru: 'о а-ЛЭ-ксан-дрос',
      ),
      explanation: LocalizedText(
        en: 'Related to Russian Александр, with different stress.',
        ru: 'Александр помогает запомнить имя, но ударение греческое: Αλέξανδρος.',
      ),
      greek: 'ο Αλέξανδρος',
    ),
    VocabularyCard(
      id: 'alexander-call',
      prompt: LocalizedText(
        en: 'Alexander! (call to him)',
        ru: 'Александрос! (обращение)',
      ),
      meaning: LocalizedText(
        en: 'Use the case requested in the prompt.',
        ru: 'Используйте форму, указанную в задании.',
      ),
      pronunciation: LocalizedText(en: 'a-LE-ksan-dhre', ru: 'а-ЛЭ-ксан-дрэ'),
      explanation: LocalizedText(
        en: 'Vocative Αλέξανδρε keeps the same stressed syllable.',
        ru: 'Αλέξανδρος → Αλέξανδρε! Учим конкретную форму, а не правило по числу слогов.',
      ),
      greek: 'Αλέξανδρε!',
    ),
  ],
);
