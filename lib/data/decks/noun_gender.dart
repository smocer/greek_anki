import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const nounGenderDeck = VocabularyDeck(
  id: 'noun-gender',
  title: LocalizedText(en: 'Noun gender: ο / η / το', ru: 'Род: ο / η / το'),
  subtitle: LocalizedText(
    en: 'Endings, names and exceptions',
    ru: 'Окончания, имена и исключения',
  ),
  cover: 'ο · η · το',
  note: LocalizedText(
    en: 'Add the nominative article to the given noun and write both words. Common endings are useful clues, but learn exceptions such as η Κύπρος and η οδός.',
    ru: 'Добавьте артикль именительного падежа к данному слову и напишите оба слова. Окончания помогают, но есть исключения: η Κύπρος, η οδός. Род не всегда совпадает с русским.',
  ),
  cards: [
    VocabularyCard(
      id: 'george',
      prompt: LocalizedText(
        en: 'Add the article: … Γιώργος',
        ru: 'Добавьте артикль: … Γιώργος',
      ),
      meaning: LocalizedText(
        en: 'George. Answer with the article and the whole noun.',
        ru: 'Георгий / Йоргос. Ответьте артиклем и целым существительным.',
      ),
      greek: 'ο Γιώργος',
      pronunciation: LocalizedText(en: 'o YOR-ghos', ru: 'о ЙОР-гос'),
      explanation: LocalizedText(
        en: 'A masculine name in -ος.',
        ru: 'Мужское имя на -ος, как Γιώργος: именительный с ο. В русском у имён артикля нет.',
      ),
    ),
    VocabularyCard(
      id: 'kostas',
      prompt: LocalizedText(
        en: 'Add the article: … Κώστας',
        ru: 'Добавьте артикль: … Κώστας',
      ),
      meaning: LocalizedText(
        en: 'Kostas. Answer with the article and the whole noun.',
        ru: 'Костас. Ответьте артиклем и целым существительным.',
      ),
      greek: 'ο Κώστας',
      pronunciation: LocalizedText(en: 'o KOS-tas', ru: 'о КОС-тас'),
      explanation: LocalizedText(
        en: 'A masculine name in -ας.',
        ru: 'Мужские имена бывают и на -ας: ο Κώστας. Как русское «Никита», окончание само по себе не делает имя женским.',
      ),
    ),
    VocabularyCard(
      id: 'john',
      prompt: LocalizedText(
        en: 'Add the article: … Γιάννης',
        ru: 'Добавьте артикль: … Γιάννης',
      ),
      meaning: LocalizedText(
        en: 'John / Yiannis. Answer with the article and the whole noun.',
        ru: 'Иоанн / Яннис. Ответьте артиклем и целым существительным.',
      ),
      greek: 'ο Γιάννης',
      pronunciation: LocalizedText(en: 'o YA-nis', ru: 'о Я-нис'),
      explanation: LocalizedText(
        en: 'A masculine name in -ης.',
        ru: 'Ещё одно мужское окончание: -ης. Учим ο Γιάννης; по-русски Яннис / Иоанн.',
      ),
    ),
    VocabularyCard(
      id: 'maria',
      prompt: LocalizedText(
        en: 'Add the article: … Μαρία',
        ru: 'Добавьте артикль: … Μαρία',
      ),
      meaning: LocalizedText(
        en: 'Maria. Answer with the article and the whole noun.',
        ru: 'Мария. Ответьте артиклем и целым существительным.',
      ),
      greek: 'η Μαρία',
      pronunciation: LocalizedText(en: 'i ma-RI-a', ru: 'и ма-РИ-а'),
      explanation: LocalizedText(
        en: 'A feminine name in -α.',
        ru: 'Μαρία — женское имя, как русское «Мария»; в именительном используется артикль η.',
      ),
    ),
    VocabularyCard(
      id: 'eleni',
      prompt: LocalizedText(
        en: 'Add the article: … Ελένη',
        ru: 'Добавьте артикль: … Ελένη',
      ),
      meaning: LocalizedText(
        en: 'Helen / Eleni. Answer with the article and the whole noun.',
        ru: 'Елена / Элени. Ответьте артиклем и целым существительным.',
      ),
      greek: 'η Ελένη',
      pronunciation: LocalizedText(en: 'i e-LE-ni', ru: 'и э-ЛЭ-ни'),
      explanation: LocalizedText(
        en: 'A feminine name in -η.',
        ru: 'Ελένη соответствует имени Елена. Женское имя на -η, артикль η.',
      ),
    ),
    VocabularyCard(
      id: 'train',
      prompt: LocalizedText(
        en: 'Add the article: … τρένο',
        ru: 'Добавьте артикль: … τρένο',
      ),
      meaning: LocalizedText(
        en: 'Train. Answer with the article and the whole noun.',
        ru: 'Поезд. Ответьте артиклем и целым существительным.',
      ),
      greek: 'το τρένο',
      pronunciation: LocalizedText(en: 'to TRE-no', ru: 'то ТРЭ-но'),
      explanation: LocalizedText(
        en: 'A neuter noun in -ο.',
        ru: 'Средний род на -ο: το τρένο. Русское «поезд» мужского рода, поэтому по переводу род не угадываем.',
      ),
    ),
    VocabularyCard(
      id: 'child',
      prompt: LocalizedText(
        en: 'Add the article: … παιδί',
        ru: 'Добавьте артикль: … παιδί',
      ),
      meaning: LocalizedText(
        en: 'Child. Answer with the article and the whole noun.',
        ru: 'Ребёнок. Ответьте артиклем и целым существительным.',
      ),
      greek: 'το παιδί',
      pronunciation: LocalizedText(en: 'to pe-DHI', ru: 'то пэ-ДИ'),
      explanation: LocalizedText(
        en: 'A neuter noun in -ί, regardless of whether the child is a boy or girl.',
        ru: 'Ребёнок — мужской род в русском; το παιδί — средний в греческом. Пол ребёнка не меняет род этого слова.',
      ),
    ),
    VocabularyCard(
      id: 'letter',
      prompt: LocalizedText(
        en: 'Add the article: … γράμμα',
        ru: 'Добавьте артикль: … γράμμα',
      ),
      meaning: LocalizedText(
        en: 'Letter. Answer with the article and the whole noun.',
        ru: 'Письмо / буква. Ответьте артиклем и целым существительным.',
      ),
      greek: 'το γράμμα',
      pronunciation: LocalizedText(en: 'to GHRA-ma', ru: 'то ГРА-ма'),
      explanation: LocalizedText(
        en: 'A neuter noun in -μα; not every word in -α is feminine.',
        ru: 'Существительные типа γράμμα на -μα — среднего рода. Род совпадает с «письмо», но не с «буква».',
      ),
    ),
    VocabularyCard(
      id: 'cyprus',
      prompt: LocalizedText(
        en: 'Add the article: … Κύπρος',
        ru: 'Добавьте артикль: … Κύπρος',
      ),
      meaning: LocalizedText(
        en: 'Cyprus. Answer with the article and the whole noun.',
        ru: 'Кипр. Ответьте артиклем и целым существительным.',
      ),
      greek: 'η Κύπρος',
      pronunciation: LocalizedText(en: 'i KI-pros', ru: 'и КИ-прос'),
      explanation: LocalizedText(
        en: 'A feminine place name in -ος: στην Κύπρο.',
        ru: 'Кипр в русском мужского рода, η Κύπρος — женского. -ος не всегда означает мужской род; «на Кипре»: στην Κύπρο.',
      ),
    ),
    VocabularyCard(
      id: 'paphos',
      prompt: LocalizedText(
        en: 'Add the article: … Πάφος',
        ru: 'Добавьте артикль: … Πάφος',
      ),
      meaning: LocalizedText(
        en: 'Paphos. Answer with the article and the whole noun.',
        ru: 'Пафос. Ответьте артиклем и целым существительным.',
      ),
      greek: 'η Πάφος',
      pronunciation: LocalizedText(en: 'i PA-fos', ru: 'и ПА-фос'),
      explanation: LocalizedText(
        en: 'A feminine place name in -ος: στην Πάφο.',
        ru: 'Пафос — мужской род в русском, η Πάφος — женский. В винительном исчезает -ς: στην Πάφο.',
      ),
    ),
    VocabularyCard(
      id: 'limassol',
      prompt: LocalizedText(
        en: 'Add the article: … Λεμεσός',
        ru: 'Добавьте артикль: … Λεμεσός',
      ),
      meaning: LocalizedText(
        en: 'Limassol. Answer with the article and the whole noun.',
        ru: 'Лимасол. Ответьте артиклем и целым существительным.',
      ),
      greek: 'η Λεμεσός',
      pronunciation: LocalizedText(en: 'i le-me-SOS', ru: 'и лэ-мэ-СОС'),
      explanation: LocalizedText(
        en: 'A feminine place name in -ος: στην Λεμεσό.',
        ru: 'Λεμεσός — греческое название Лимасола, женского рода. «В Лимасоле»: στην Λεμεσό; -ς исчезает.',
      ),
    ),
    VocabularyCard(
      id: 'street',
      prompt: LocalizedText(
        en: 'Add the article: … οδός',
        ru: 'Добавьте артикль: … οδός',
      ),
      meaning: LocalizedText(
        en: 'Street. Answer with the article and the whole noun.',
        ru: 'Улица. Ответьте артиклем и целым существительным.',
      ),
      greek: 'η οδός',
      pronunciation: LocalizedText(en: 'i o-DHOS', ru: 'и о-ДОС'),
      explanation: LocalizedText(
        en: 'A feminine common noun in -ός: την οδό.',
        ru: 'Не только названия городов бывают женского рода на -ος: η οδός — улица. В винительном: την οδό.',
      ),
    ),
    VocabularyCard(
      id: 'egypt',
      prompt: LocalizedText(
        en: 'Add the article: … Αίγυπτος',
        ru: 'Добавьте артикль: … Αίγυπτος',
      ),
      meaning: LocalizedText(
        en: 'Egypt. Answer with the article and the whole noun.',
        ru: 'Египет. Ответьте артиклем и целым существительным.',
      ),
      greek: 'η Αίγυπτος',
      pronunciation: LocalizedText(en: 'i E-yip-tos', ru: 'и Э-йип-тос'),
      explanation: LocalizedText(
        en: 'A feminine country name in -ος: από την Αίγυπτο.',
        ru: 'Египет — мужской род в русском, η Αίγυπτος — женский. «Из Египта»: από την Αίγυπτο.',
      ),
    ),
  ],
);
