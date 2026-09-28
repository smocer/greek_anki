import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const diminutivesDeck = VocabularyDeck(
  id: 'diminutives',
  title: LocalizedText(en: 'Small things: -άκι', ru: 'Уменьшительные: -άκι'),
  subtitle: LocalizedText(
    en: 'A little dog, house or child',
    ru: 'Собачка, домик, ребёночек',
  ),
  note: LocalizedText(
    en: 'The suffix -άκι often adds smallness or affection and creates a neuter noun. Learn the whole form, not a rule of adding άκι to any word.',
    ru: 'Сравните русские -ик, -очк-, -ёнок: -άκι часто передаёт размер или ласку. Получается средний род с το; суффикс не просто дописывается к любому слову.',
  ),
  cover: '-άκι',
  cards: [
    VocabularyCard(
      id: 'little-dog',
      prompt: LocalizedText(
        en: 'The little dog / doggy (with article)',
        ru: 'Собачка / пёсик (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το σκυλάκι',
      pronunciation: LocalizedText(en: 'to ski-LA-ki', ru: 'то ски-ЛА-ки'),
      explanation: LocalizedText(
        en: 'Σκύλος → σκυλάκι; the diminutive is neuter.',
        ru: 'Как «пёс → пёсик», но род меняется: ο σκύλος → το σκυλάκι. Ударение на ά.',
      ),
    ),
    VocabularyCard(
      id: 'little-cat',
      prompt: LocalizedText(
        en: 'The kitten / little cat (with article)',
        ru: 'Котёнок / кошечка (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το γατάκι',
      pronunciation: LocalizedText(en: 'to gha-TA-ki', ru: 'то га-ТА-ки'),
      explanation: LocalizedText(
        en: 'Γάτα → γατάκι; both small size and affection are possible.',
        ru: 'Как «кошка → кошечка/котёнок»: η γάτα → το γατάκι. Маленькое животное не обязательно только детёныш.',
      ),
    ),
    VocabularyCard(
      id: 'little-house',
      prompt: LocalizedText(
        en: 'The little house (with article)',
        ru: 'Домик (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το σπιτάκι',
      pronunciation: LocalizedText(en: 'to spi-TA-ki', ru: 'то спи-ТА-ки'),
      explanation: LocalizedText(
        en: 'Σπίτι → σπιτάκι; stress moves to the suffix.',
        ru: 'Как «дом → домик». Не пишем σπιτιάκι: учим целую форму σπιτάκι.',
      ),
    ),
    VocabularyCard(
      id: 'little-child',
      prompt: LocalizedText(
        en: 'The little child (with article)',
        ru: 'Ребёночек / малыш (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το παιδάκι',
      pronunciation: LocalizedText(en: 'to pe-DHA-ki', ru: 'то пэ-ДА-ки'),
      explanation: LocalizedText(
        en: 'Παιδί → παιδάκι; a warm or size-related diminutive.',
        ru: 'Как «ребёнок → ребёночек». Παιδί и παιδάκι оба среднего рода независимо от пола ребёнка.',
      ),
    ),
    VocabularyCard(
      id: 'little-water',
      prompt: LocalizedText(
        en: 'Water (diminutive noun with article)',
        ru: 'Водичка (уменьшительное, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το νεράκι',
      pronunciation: LocalizedText(en: 'to ne-RA-ki', ru: 'то нэ-РА-ки'),
      explanation: LocalizedText(
        en: 'Νερό → νεράκι; often a friendly way to refer to water.',
        ru: 'Как русское «водичка»: ласковый оттенок, не обязательно буквально маленький объём.',
      ),
    ),
    VocabularyCard(
      id: 'little-coffee',
      prompt: LocalizedText(
        en: 'Coffee (diminutive noun with article)',
        ru: 'Кофеёк (уменьшительное, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'το καφεδάκι',
      pronunciation: LocalizedText(en: 'to ka-fe-DHA-ki', ru: 'то ка-фэ-ДА-ки'),
      explanation: LocalizedText(
        en: 'Καφές → καφεδάκι; note the δ in the derived form.',
        ru: 'Как «кофе → кофеёк». Ο καφές становится το καφεδάκι; перед -άκι появляется δ, поэтому учим форму целиком.',
      ),
    ),
  ],
);
