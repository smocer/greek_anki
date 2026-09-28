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
        ru: 'Женский род, как «Россия». Но артикль η — отдельное обязательное для этой карточки слово.',
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
  ],
);
