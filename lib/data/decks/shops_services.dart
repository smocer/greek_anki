import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const shopsServicesDeck = VocabularyDeck(
  id: 'shops-services',
  title: LocalizedText(en: 'Shops & services', ru: 'Магазины и учреждения'),
  subtitle: LocalizedText(
    en: 'Useful places in town',
    ru: 'Полезные места в городе',
  ),
  cover: 'ο φούρνος',
  note: LocalizedText(
    en: 'Name the place with its article. Compare ο φούρνος → στον φούρνο with το μαγαζί → στο μαγαζί.',
    ru: 'Название места учим с артиклем. Сравните ο φούρνος → στον φούρνο и το μαγαζί → στο μαγαζί: после σε нужен винительный.',
  ),
  cards: [
    VocabularyCard(
      id: 'school',
      prompt: LocalizedText(
        en: 'School (with the article)',
        ru: 'Школа (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το σχολείο',
      pronunciation: LocalizedText(en: 'to skho-LI-o', ru: 'то схо-ЛИ-о'),
      explanation: LocalizedText(
        en: 'Neuter: το σχολείο → στο σχολείο (at school).',
        ru: 'Школа — женский род, но το σχολείο — средний. «В школе»: στο σχολείο; после σε — винительный.',
      ),
    ),
    VocabularyCard(
      id: 'pharmacy',
      prompt: LocalizedText(
        en: 'Pharmacy (with the article)',
        ru: 'Аптека (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το φαρμακείο',
      pronunciation: LocalizedText(en: 'to far-ma-KI-o', ru: 'то фар-ма-КИ-о'),
      explanation: LocalizedText(
        en: 'Neuter: στο φαρμακείο means at the pharmacy.',
        ru: 'Связь с «фармацевт» помогает запомнить φαρμακείο. Аптека — женский род, το φαρμακείο — средний.',
      ),
    ),
    VocabularyCard(
      id: 'kiosk',
      prompt: LocalizedText(
        en: 'Kiosk / street newsstand (with the article)',
        ru: 'Киоск (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το περίπτερο',
      pronunciation: LocalizedText(
        en: 'to pe-RIP-te-ro',
        ru: 'то пэ-РИП-тэ-ро',
      ),
      explanation: LocalizedText(
        en: 'A small street kiosk, often selling newspapers and everyday items. At the kiosk: στο περίπτερο.',
        ru: 'Киоск — мужской род, το περίπτερο — средний. Ударение на -ρί-: στο περίπτερο — «в киоске / у киоска».',
      ),
    ),
    VocabularyCard(
      id: 'hospital',
      prompt: LocalizedText(
        en: 'Hospital (with the article)',
        ru: 'Больница (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το νοσοκομείο',
      pronunciation: LocalizedText(
        en: 'to no-so-ko-MI-o',
        ru: 'то но-со-ко-МИ-о',
      ),
      explanation: LocalizedText(
        en: 'Neuter: το νοσοκομείο → στο νοσοκομείο.',
        ru: 'В русском «больница» женского рода, здесь средний: το νοσοκομείο. «В больнице»: στο νοσοκομείο.',
      ),
    ),
    VocabularyCard(
      id: 'bakery',
      prompt: LocalizedText(
        en: 'Bakery (with the article)',
        ru: 'Пекарня (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'ο φούρνος',
      pronunciation: LocalizedText(en: 'o FUR-nos', ru: 'о ФУР-нос'),
      explanation: LocalizedText(
        en: 'Φούρνος can mean a bakery or an oven. Masculine accusative: στον φούρνο.',
        ru: 'Φούρνος — пекарня или духовка. Греческий мужской род: ο φούρνος → στον φούρνο; -ς исчезает в винительном.',
      ),
    ),
    VocabularyCard(
      id: 'shop',
      prompt: LocalizedText(
        en: 'Shop (with the article)',
        ru: 'Магазин (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το μαγαζί',
      pronunciation: LocalizedText(en: 'to ma-gha-ZI', ru: 'то ма-га-ЗИ'),
      explanation: LocalizedText(
        en: 'Neuter, with stress on the last syllable: στο μαγαζί.',
        ru: 'Созвучно «магазин», но το μαγαζί — среднего рода. «В магазине»: στο μαγαζί. Ударение на последнем слоге.',
      ),
    ),
    VocabularyCard(
      id: 'hotel',
      prompt: LocalizedText(
        en: 'Hotel (with the article)',
        ru: 'Гостиница / отель (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το ξενοδοχείο',
      pronunciation: LocalizedText(
        en: 'to kse-no-dho-KHI-o',
        ru: 'то ксэ-но-до-ХИ-о',
      ),
      explanation: LocalizedText(
        en: 'Neuter: το ξενοδοχείο → στο ξενοδοχείο. Ξ sounds like ks.',
        ru: 'Το ξενοδοχείο — средний род; ни род «гостиницы», ни род «отеля» не подходят. Ξ читается «кс». В отеле: στο ξενοδοχείο.',
      ),
    ),
  ],
);
