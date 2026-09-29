import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const cultureDiningDeck = VocabularyDeck(
  id: 'culture-dining',
  title: LocalizedText(en: 'Culture & eating out', ru: 'Культура и рестораны'),
  subtitle: LocalizedText(
    en: 'Cinema, theatre, museums and food',
    ru: 'Кино, театр, музей и еда',
  ),
  cover: 'το θέατρο',
  note: LocalizedText(
    en: 'Familiar words can still have unfamiliar grammatical genders. Learn the article with every place.',
    ru: 'Знакомые корни помогают, но род может отличаться: театр → το θέατρο, музей → το μουσείο. Учите артикль вместе со словом.',
  ),
  cards: [
    VocabularyCard(
      id: 'cinema',
      prompt: LocalizedText(
        en: 'Cinema (with the article)',
        ru: 'Кинотеатр (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'ο κινηματογράφος',
      pronunciation: LocalizedText(
        en: 'o ki-ni-ma-TO-ghra-fos',
        ru: 'о ки-ни-ма-ТО-гра-фос',
      ),
      explanation: LocalizedText(
        en: 'Masculine: ο κινηματογράφος → στον κινηματογράφο.',
        ru: 'Узнаваемое «кинематограф»! В обоих языках мужской род. В винительном у греческого слова убираем -ς: στον κινηματογράφο.',
      ),
    ),
    VocabularyCard(
      id: 'museum',
      prompt: LocalizedText(
        en: 'Museum (with the article)',
        ru: 'Музей (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το μουσείο',
      pronunciation: LocalizedText(en: 'to mu-SI-o', ru: 'то му-СИ-о'),
      explanation: LocalizedText(
        en: 'Neuter: το μουσείο → στο μουσείο.',
        ru: 'Созвучно «музей», но в греческом средний род. «В музее»: στο μουσείο; ου читается «у», ει — «и».',
      ),
    ),
    VocabularyCard(
      id: 'theatre',
      prompt: LocalizedText(
        en: 'Theatre (with the article)',
        ru: 'Театр (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το θέατρο',
      pronunciation: LocalizedText(en: 'to THE-a-tro', ru: 'то ТЭ-а-тро'),
      explanation: LocalizedText(
        en: 'Neuter: στο θέατρο. Θ is the sound in English thin.',
        ru: 'Корень тот же, что в «театр», но род средний. Θ — межзубный звук, не обычное русское «т». В театре: στο θέατρο.',
      ),
    ),
    VocabularyCard(
      id: 'restaurant',
      prompt: LocalizedText(
        en: 'Restaurant (with the article)',
        ru: 'Ресторан (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το εστιατόριο',
      pronunciation: LocalizedText(
        en: 'to e-stia-TO-ri-o',
        ru: 'то э-стья-ТО-ри-о',
      ),
      explanation: LocalizedText(
        en: 'Neuter: το εστιατόριο → στο εστιατόριο.',
        ru: '«Ресторан» в русском мужского рода, το εστιατόριο — среднего. «В ресторане»: στο εστιατόριο.',
      ),
    ),
    VocabularyCard(
      id: 'tavern',
      prompt: LocalizedText(
        en: 'Tavern / traditional restaurant (with the article)',
        ru: 'Таверна (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η ταβέρνα',
      pronunciation: LocalizedText(en: 'i ta-VER-na', ru: 'и та-ВЭР-на'),
      explanation: LocalizedText(
        en: 'A traditional eating place. Feminine: η ταβέρνα → στην ταβέρνα.',
        ru: 'Как русская «таверна», η ταβέρνα — женского рода. Это традиционный ресторан. «В таверне»: στην ταβέρνα.',
      ),
    ),
  ],
);
