import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const articlesCasesDeck = VocabularyDeck(
  id: 'articles-cases',
  title: LocalizedText(en: 'Articles & basic cases', ru: 'Артикли и падежи'),
  subtitle: LocalizedText(
    en: 'Subject, object and possession',
    ru: 'Кто? Кого? Чей?',
  ),
  note: LocalizedText(
    en: 'The prompts specify the case. Enter only the requested noun phrase, including its article. Nominative names a subject; accusative often marks an object; genitive can express possession.',
    ru: 'Вводите только словосочетание с артиклем в указанном падеже. Именительный — подлежащее, винительный — объект, родительный — в том числе принадлежность. Не все употребления совпадают с русскими.',
  ),
  cover: 'ο → τον',
  cards: [
    VocabularyCard(
      id: 'friend-nom',
      prompt: LocalizedText(
        en: 'The male friend (subject)',
        ru: 'Друг (кто? именительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'o FI-los', ru: 'о ФИ-лос'),
      explanation: LocalizedText(
        en: 'Masculine nominative singular: ο + φίλος.',
        ru: 'Ο φίλος — именительный: «друг». В отличие от русского меняется и артикль.',
      ),
      greek: 'ο φίλος',
    ),
    VocabularyCard(
      id: 'friend-acc',
      prompt: LocalizedText(
        en: 'The male friend (object)',
        ru: 'Друга (вижу кого? винительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'ton FI-lo', ru: 'тон ФИ-ло'),
      explanation: LocalizedText(
        en: 'Masculine accusative: ο → τον, φίλος → φίλο.',
        ru: 'Как «друг → друга», меняется форма. Но греческий винительный — τον φίλο, без -ς.',
      ),
      greek: 'τον φίλο',
    ),
    VocabularyCard(
      id: 'friend-gen',
      prompt: LocalizedText(
        en: 'Of the male friend (possession)',
        ru: 'Друга (чья книга? родительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'tu FI-lu', ru: 'ту ФИ-лу'),
      explanation: LocalizedText(
        en: 'Masculine genitive singular: του φίλου.',
        ru: '«Книга друга»: το βιβλίο του φίλου. Родительный: του и окончание -ου.',
      ),
      greek: 'του φίλου',
    ),
    VocabularyCard(
      id: 'female-friend-nom',
      prompt: LocalizedText(
        en: 'The female friend (subject)',
        ru: 'Подруга (кто? именительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i FI-li', ru: 'и ФИ-ли'),
      explanation: LocalizedText(
        en: 'Feminine nominative singular.',
        ru: 'Женский род: η φίλη. Φίλος / φίλη — друг / подруга.',
      ),
      greek: 'η φίλη',
    ),
    VocabularyCard(
      id: 'female-friend-acc',
      prompt: LocalizedText(
        en: 'The female friend (object)',
        ru: 'Подругу (вижу кого? винительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'ti FI-li', ru: 'ти ФИ-ли'),
      explanation: LocalizedText(
        en: 'The feminine noun stays φίλη; the article marks the accusative.',
        ru: 'В русском «подруга → подругу», здесь существительное не меняется: η → τη. Перед φ обычно без ν.',
      ),
      greek: 'τη φίλη',
      alternatives: ['την φίλη'],
    ),
    VocabularyCard(
      id: 'female-friend-gen',
      prompt: LocalizedText(
        en: 'Of the female friend (possession)',
        ru: 'Подруги (чья книга? родительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'tis FI-lis', ru: 'тис ФИ-лис'),
      explanation: LocalizedText(
        en: 'Feminine genitive adds ς: της φίλης.',
        ru: 'Родительный: της φίλης. Здесь -ς появляется, а не исчезает, как у мужского винительного.',
      ),
      greek: 'της φίλης',
    ),
    VocabularyCard(
      id: 'book-nom',
      prompt: LocalizedText(
        en: 'The book (subject)',
        ru: 'Книга (что? именительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to viv-LI-o', ru: 'то вив-ЛИ-о'),
      explanation: LocalizedText(
        en: 'Neuter nominative singular.',
        ru: 'Το βιβλίο — средний род, хотя «книга» в русском женского рода.',
      ),
      greek: 'το βιβλίο',
    ),
    VocabularyCard(
      id: 'book-acc',
      prompt: LocalizedText(
        en: 'The book (object)',
        ru: 'Книгу (вижу что? винительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'to viv-LI-o', ru: 'то вив-ЛИ-о'),
      explanation: LocalizedText(
        en: 'Neuter nominative and accusative are identical here.',
        ru: 'У среднего рода именительный и винительный совпадают. В русском «книга → книгу», в греческом το βιβλίο → το βιβλίο.',
      ),
      greek: 'το βιβλίο',
    ),
    VocabularyCard(
      id: 'book-gen',
      prompt: LocalizedText(
        en: 'Of the book',
        ru: 'Книги (страница чего? родительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'tu viv-LI-u', ru: 'ту вив-ЛИ-у'),
      explanation: LocalizedText(
        en: 'The genitive is του βιβλίου.',
        ru: '«Страница книги»: η σελίδα του βιβλίου. Родительный среднего рода тоже с του.',
      ),
      greek: 'του βιβλίου',
    ),
    VocabularyCard(
      id: 'friends-nom',
      prompt: LocalizedText(
        en: 'The male friends (subject)',
        ru: 'Друзья (кто? именительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'i FI-li', ru: 'и ФИ-ли'),
      explanation: LocalizedText(
        en: 'Masculine nominative plural: οι φίλοι.',
        ru: 'Множественное число: ο φίλος → οι φίλοι. Οι читается «и».',
      ),
      greek: 'οι φίλοι',
    ),
    VocabularyCard(
      id: 'friends-acc',
      prompt: LocalizedText(
        en: 'The male friends (object)',
        ru: 'Друзей (вижу кого? винительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'tus FI-lus', ru: 'тус ФИ-лус'),
      explanation: LocalizedText(
        en: 'Masculine accusative plural: τους φίλους.',
        ru: 'Винительный множественного: τους φίλους. Учим артикль вместе с окончанием -ους.',
      ),
      greek: 'τους φίλους',
    ),
    VocabularyCard(
      id: 'books-plural',
      prompt: LocalizedText(
        en: 'The books (subject or object)',
        ru: 'Книги (мн. число, именительный / винительный)',
      ),
      meaning: LocalizedText(
        en: 'Include the article; use the requested case.',
        ru: 'С артиклем, в указанном падеже.',
      ),
      pronunciation: LocalizedText(en: 'ta viv-LI-a', ru: 'та вив-ЛИ-а'),
      explanation: LocalizedText(
        en: 'Neuter plural: τα βιβλία, same for subject and object.',
        ru: 'Το βιβλίο → τα βιβλία. У среднего рода оба падежа совпадают и во множественном числе.',
      ),
      greek: 'τα βιβλία',
    ),
  ],
);
