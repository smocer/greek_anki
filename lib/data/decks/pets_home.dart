import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const petsHomeDeck = VocabularyDeck(
  id: 'pets-home',
  title: LocalizedText(en: 'Pets & home', ru: 'Питомцы и дом'),
  subtitle: LocalizedText(
    en: 'Nouns, objects and possession',
    ru: 'Слова, дополнения и принадлежность',
  ),
  note: LocalizedText(
    en: 'Study each noun with its gender, then its case forms. A cat can be η γάτα (generic/female) or ο γάτος (male).',
    ru: 'Как «кот/кошка», различаем ο γάτος и η γάτα. Артикль учим вместе со словом, затем сравниваем падежи с русскими.',
  ),
  cover: 'Σπίτι',
  cards: [
    VocabularyCard(
      id: 'dog',
      prompt: LocalizedText(
        en: 'The dog (masculine, subject)',
        ru: 'Собака / пёс (мужской род, кто?)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ο σκύλος',
      pronunciation: LocalizedText(en: 'o SKI-los', ru: 'о СКИ-лос'),
      explanation: LocalizedText(
        en: 'Σκύλος is masculine, even when translated as dog without specifying sex.',
        ru: 'Русское «собака» женского рода, греческое ο σκύλος — мужского. Как русское «пёс».',
      ),
    ),
    VocabularyCard(
      id: 'dog-object',
      prompt: LocalizedText(
        en: 'The dog (masculine, direct object)',
        ru: 'Пса (вижу кого?)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τον σκύλο',
      pronunciation: LocalizedText(en: 'ton SKI-lo', ru: 'тон СКИ-ло'),
      explanation: LocalizedText(
        en: 'Accusative: ο σκύλος → τον σκύλο.',
        ru: 'Как «вижу пса»: винительный; -ς исчезает, артикль становится τον.',
      ),
    ),
    VocabularyCard(
      id: 'dog-genitive',
      prompt: LocalizedText(
        en: 'Of the dog (masculine)',
        ru: 'Пса (дом кого? родительный)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'του σκύλου',
      pronunciation: LocalizedText(en: 'tu SKI-lu', ru: 'ту СКИ-лу'),
      explanation: LocalizedText(
        en: 'Genitive changes -ος to -ου.',
        ru: 'Το σπίτι του σκύλου — «дом пса»: родительный. Του σκύλου отличается от винительного τον σκύλο.',
      ),
    ),
    VocabularyCard(
      id: 'dogs',
      prompt: LocalizedText(
        en: 'The dogs (subject)',
        ru: 'Собаки / псы (кто?)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'οι σκύλοι',
      pronunciation: LocalizedText(en: 'i SKI-li', ru: 'и СКИ-ли'),
      explanation: LocalizedText(
        en: 'Masculine nominative plural: οι σκύλοι.',
        ru: 'Как «пёс → псы»: ο σκύλος → οι σκύλοι. Окончание -οι произносится «и».',
      ),
    ),
    VocabularyCard(
      id: 'male-cat',
      prompt: LocalizedText(
        en: 'The male cat (with article)',
        ru: 'Кот (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ο γάτος',
      pronunciation: LocalizedText(en: 'o GHA-tos', ru: 'о ГА-тос'),
      explanation: LocalizedText(
        en: 'Ο γάτος specifies a male cat.',
        ru: 'Как русское «кот», в отличие от «кошка»: ο γάτος / η γάτα.',
      ),
    ),
    VocabularyCard(
      id: 'cat',
      prompt: LocalizedText(
        en: 'The cat (feminine, with article)',
        ru: 'Кошка (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'η γάτα',
      pronunciation: LocalizedText(en: 'i GHA-ta', ru: 'и ГА-та'),
      explanation: LocalizedText(
        en: 'Η γάτα can mean a female cat or a cat generically.',
        ru: 'Как русское «кошка», это и самка, и общее название животного. Род здесь совпадает.',
      ),
    ),
    VocabularyCard(
      id: 'cat-object',
      prompt: LocalizedText(
        en: 'The cat (feminine, direct object)',
        ru: 'Кошку (вижу кого?)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τη γάτα',
      pronunciation: LocalizedText(en: 'ti GHA-ta', ru: 'ти ГА-та'),
      explanation: LocalizedText(
        en: 'Feminine accusative: η → τη; the noun stays γάτα.',
        ru: 'В русском кошка → кошку, в греческом меняется только артикль: η γάτα → τη γάτα.',
      ),
      alternatives: ['την γάτα'],
    ),
    VocabularyCard(
      id: 'house',
      prompt: LocalizedText(
        en: 'The house / home (with article)',
        ru: 'Дом (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το σπίτι',
      pronunciation: LocalizedText(en: 'to SPI-ti', ru: 'то СПИ-ти'),
      explanation: LocalizedText(
        en: 'Σπίτι is neuter, unlike masculine Russian дом.',
        ru: 'Το σπίτι среднего рода. Русский перевод «дом» мужского рода не подсказывает артикль.',
      ),
    ),
    VocabularyCard(
      id: 'house-genitive',
      prompt: LocalizedText(en: 'Of the house', ru: 'Дома (чего? родительный)'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'του σπιτιού',
      pronunciation: LocalizedText(en: 'tu spi-TYU', ru: 'ту спи-ТЬЮ'),
      explanation: LocalizedText(
        en: 'Neuter -ι often becomes -ιού in the genitive, with shifted stress.',
        ru: 'Η πόρτα του σπιτιού — «дверь дома». Родительный: του σπιτιού. В отличие от το σπίτι ударение переходит на конец.',
      ),
    ),
    VocabularyCard(
      id: 'houses',
      prompt: LocalizedText(
        en: 'The houses (with article)',
        ru: 'Дома́ (с артиклем, множественное)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τα σπίτια',
      pronunciation: LocalizedText(en: 'ta SPI-tya', ru: 'та СПИ-тья'),
      explanation: LocalizedText(
        en: 'Neuter plural uses τα and the ending -ια.',
        ru: '«Дом → дома»: το σπίτι → τα σπίτια. Именительный и винительный здесь совпадают.',
      ),
    ),
    VocabularyCard(
      id: 'have-dog',
      prompt: LocalizedText(
        en: 'I have a dog. (masculine)',
        ru: 'У меня есть пёс.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Έχω έναν σκύλο.',
      pronunciation: LocalizedText(
        en: 'E-kho E-nan SKI-lo',
        ru: 'Э-хо Э-нан СКИ-ло',
      ),
      explanation: LocalizedText(
        en: 'The masculine indefinite article is accusative έναν before the object.',
        ru: 'Вместо русского «у меня есть» — έχω; объект в винительном: έναν σκύλο, не ένας σκύλος.',
      ),
      acceptedAnswers: ['Εγώ έχω έναν σκύλο.'],
    ),
  ],
);
