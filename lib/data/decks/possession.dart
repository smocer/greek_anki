import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const possessionDeck = VocabularyDeck(
  id: 'possession',
  title: LocalizedText(en: 'Whose is it?', ru: 'Чей?'),
  subtitle: LocalizedText(
    en: 'My, your, his, her, our, their',
    ru: 'Мой, твой, его, её, наш, ваш, их',
  ),
  note: LocalizedText(
    en: 'These short possessives follow the noun. Μου itself does not change for the gender of the owned thing.',
    ru: 'Краткое притяжательное местоимение стоит после существительного. Μου — «мой»; форма не меняется по роду или числу предмета.',
  ),
  cover: 'Μου',
  cards: [
    VocabularyCard(
      id: 'my-book',
      prompt: LocalizedText(en: 'My book', ru: 'Моя книга'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(en: 'to viv-LI-o mu', ru: 'то вив-ЛИ-о му'),
      explanation: LocalizedText(
        en: 'Μου means my here; it follows the noun.',
        ru: 'Порядок: артикль + существительное + μου. В русском «моя» перед «книга», здесь μου после βιβλίο.',
      ),
      greek: 'το βιβλίο μου',
    ),
    VocabularyCard(
      id: 'your-book',
      prompt: LocalizedText(en: 'Your book (informal)', ru: 'Твоя книга'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(en: 'to viv-LI-o su', ru: 'то вив-ЛИ-о су'),
      explanation: LocalizedText(
        en: 'Σου is the informal singular possessive.',
        ru: 'Σου — «твой»; форма не меняется по роду или числу предмета. Та же форма видна в γεια σου, но значение зависит от конструкции.',
      ),
      greek: 'το βιβλίο σου',
    ),
    VocabularyCard(
      id: 'his-book',
      prompt: LocalizedText(en: 'His book', ru: 'Его книга'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(en: 'to viv-LI-o tu', ru: 'то вив-ЛИ-о ту'),
      explanation: LocalizedText(
        en: 'Του refers to a masculine or neuter singular owner.',
        ru: 'Του здесь «его», относится к владельцу. Средний род самой книги обозначен артиклем το.',
      ),
      greek: 'το βιβλίο του',
    ),
    VocabularyCard(
      id: 'her-book',
      prompt: LocalizedText(en: 'Her book', ru: 'Её книга'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(
        en: 'to viv-LI-o tis',
        ru: 'то вив-ЛИ-о тис',
      ),
      explanation: LocalizedText(
        en: 'Της identifies a female owner, not the book’s gender.',
        ru: 'Της = «её»: женский род владельца, а не книги. Как «его/её» в русском.',
      ),
      greek: 'το βιβλίο της',
    ),
    VocabularyCard(
      id: 'our-book',
      prompt: LocalizedText(en: 'Our book', ru: 'Наша книга'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(
        en: 'to viv-LI-o mas',
        ru: 'то вив-ЛИ-о мас',
      ),
      explanation: LocalizedText(
        en: 'Μας is our regardless of the noun’s gender.',
        ru: 'Μας — «наш»; форма не меняется по роду или числу предмета.',
      ),
      greek: 'το βιβλίο μας',
    ),
    VocabularyCard(
      id: 'your-book-polite',
      prompt: LocalizedText(en: 'Your book (polite/plural)', ru: 'Ваша книга'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(
        en: 'to viv-LI-o sas',
        ru: 'то вив-ЛИ-о сас',
      ),
      explanation: LocalizedText(
        en: 'Σας means your here, for polite singular or plural.',
        ru: 'Σας здесь «ваш», не подлежащее «вы». Сравните Πώς σας λένε; — там «вас».',
      ),
      greek: 'το βιβλίο σας',
    ),
    VocabularyCard(
      id: 'their-book',
      prompt: LocalizedText(en: 'Their book', ru: 'Их книга'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(
        en: 'to viv-LI-o tus',
        ru: 'то вив-ЛИ-о тус',
      ),
      explanation: LocalizedText(
        en: 'Τους is their for owners of any gender.',
        ru: 'Τους как «их» не различает род владельцев: мужчин, женщин или смешанной группы.',
      ),
      greek: 'το βιβλίο τους',
    ),
    VocabularyCard(
      id: 'my-name',
      prompt: LocalizedText(en: 'My name', ru: 'Моё имя'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(en: 'to O-no-MA mu', ru: 'то О-но-МА му'),
      explanation: LocalizedText(
        en: 'A noun stressed on the third-last syllable gains another accent before this clitic.',
        ru: 'В όνομα ударение на третьем слоге от конца. Перед безударным μου добавляется второе: όνομά μου.',
      ),
      greek: 'το όνομά μου',
    ),
    VocabularyCard(
      id: 'your-name',
      prompt: LocalizedText(en: 'Your name (informal)', ru: 'Твоё имя'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(en: 'to O-no-MA su', ru: 'то О-но-МА су'),
      explanation: LocalizedText(
        en: 'The extra accent also appears before σου.',
        ru: 'Σου — на «ты»; пишем όνομά σου с дополнительным ударением. В сложном режиме нужны оба ударения.',
      ),
      greek: 'το όνομά σου',
    ),
    VocabularyCard(
      id: 'your-name-polite',
      prompt: LocalizedText(en: 'Your name (polite/plural)', ru: 'Ваше имя'),
      meaning: LocalizedText(
        en: 'Include the article and the possessive.',
        ru: 'С артиклем и притяжательным местоимением.',
      ),
      pronunciation: LocalizedText(en: 'to O-no-MA sas', ru: 'то О-но-МА сас'),
      explanation: LocalizedText(
        en: 'The same extra-accent rule applies before σας.',
        ru: 'Σας — на «Вы» или нескольким; дополнительное ударение: όνομά σας.',
      ),
      greek: 'το όνομά σας',
    ),
  ],
);
