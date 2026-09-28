import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const formsOfAddressDeck = VocabularyDeck(
  id: 'forms-of-address',
  title: LocalizedText(en: 'Forms of address', ru: 'Как обратиться к человеку'),
  subtitle: LocalizedText(
    en: 'Sir, madam, friend, everyone',
    ru: 'Господин, госпожа, друг, ребята',
  ),
  note: LocalizedText(
    en: 'Compare the nominative article with the article-free vocative. Κυρία and φίλη keep their noun form in direct address.',
    ru: 'В именительном есть артикль, при обращении его нет. У κυρία и φίλη само существительное внешне не меняется.',
  ),
  cover: 'Κύριε',
  cards: [
    VocabularyCard(
      id: 'sir-noun',
      prompt: LocalizedText(
        en: 'The gentleman / Mr (subject)',
        ru: 'Господин (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'o KI-ri-os', ru: 'о КИ-ри-ос'),
      explanation: LocalizedText(
        en: 'Use κύριος when naming or talking about the man.',
        ru: 'Когда говорим о человеке — ο κύριος, не κύριε.',
      ),
      greek: 'ο κύριος',
    ),
    VocabularyCard(
      id: 'sir-address',
      prompt: LocalizedText(en: 'Sir! (address)', ru: 'Господин! (обращение)'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'KI-ri-e', ru: 'КИ-ри-э'),
      explanation: LocalizedText(
        en: 'The vocative of κύριος is κύριε.',
        ru: 'Κύριε — именно обращение. Как отдельный звательный падеж, которого обычно нет в современном русском.',
      ),
      greek: 'Κύριε!',
    ),
    VocabularyCard(
      id: 'madam-noun',
      prompt: LocalizedText(
        en: 'The lady / Ms (subject)',
        ru: 'Госпожа (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'i ki-RI-a', ru: 'и ки-РИ-а'),
      explanation: LocalizedText(
        en: 'Feminine nominative; note stress on ρί.',
        ru: 'Κυρία — женский род; ударение отличается от κύριος: κυ-ΡΙ-а.',
      ),
      greek: 'η κυρία',
    ),
    VocabularyCard(
      id: 'madam-address',
      prompt: LocalizedText(en: 'Madam! (address)', ru: 'Госпожа! (обращение)'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'ki-RI-a', ru: 'ки-РИ-а'),
      explanation: LocalizedText(
        en: 'The noun stays κυρία; omit η when addressing her.',
        ru: 'Форма κυρία не меняется, но артикль η убираем. Не все падежи имеют разные окончания.',
      ),
      greek: 'Κυρία!',
    ),
    VocabularyCard(
      id: 'friend-noun',
      prompt: LocalizedText(
        en: 'The male friend (subject)',
        ru: 'Друг (именительный, с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'o FI-los', ru: 'о ФИ-лос'),
      explanation: LocalizedText(
        en: 'Masculine noun: ο φίλος.',
        ru: 'Φίλος — друг; тот же корень можно узнать в «филантроп», но русское слово «друг» другое.',
      ),
      greek: 'ο φίλος',
    ),
    VocabularyCard(
      id: 'friend-address',
      prompt: LocalizedText(
        en: 'Friend! (address a man)',
        ru: 'Друг! (обращение к мужчине)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'FI-le', ru: 'ФИ-лэ'),
      explanation: LocalizedText(
        en: 'Ordinary masculine φίλος has vocative φίλε.',
        ru: 'Ο φίλος → φίλε! Здесь -ος → -ε, в отличие от имени Γιώργος → Γιώργο.',
      ),
      greek: 'Φίλε!',
    ),
    VocabularyCard(
      id: 'female-friend-address',
      prompt: LocalizedText(
        en: 'Friend! (address a woman)',
        ru: 'Подруга! (обращение к женщине)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'FI-li', ru: 'ФИ-ли'),
      explanation: LocalizedText(
        en: 'Η φίλη → φίλη: remove the article.',
        ru: 'В женской форме φίλη окончание при обращении сохраняется; артикль отсутствует.',
      ),
      greek: 'Φίλη!',
    ),
    VocabularyCard(
      id: 'guys-address',
      prompt: LocalizedText(
        en: 'Guys! / children! (address a group)',
        ru: 'Ребята! / дети! (обращение)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      pronunciation: LocalizedText(en: 'pe-DHYA', ru: 'пэ-ДЬЯ'),
      explanation: LocalizedText(
        en: 'Also used informally to address a group of adults.',
        ru: 'Παιδιά — и «дети», и разговорное «ребята!» взрослым, как в русском. При обращении без τα.',
      ),
      greek: 'Παιδιά!',
    ),
  ],
);
