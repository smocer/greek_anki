import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const natureGeographyDeck = VocabularyDeck(
  id: 'nature-geography',
  title: LocalizedText(en: 'Nature & geography', ru: 'Природа и география'),
  subtitle: LocalizedText(
    en: 'Sea, sky, sun and continents',
    ru: 'Море, небо, солнце и части света',
  ),
  cover: 'η θάλασσα',
  note: LocalizedText(
    en: 'Greek gender belongs to the noun, not to its translation. Compare ο ήλιος, η θάλασσα and ο ουρανός.',
    ru: 'Род определяется греческим словом: солнце → ο ήλιος, море → η θάλασσα, небо → ο ουρανός. Во всех трёх случаях род отличается от русского.',
  ),
  cards: [
    VocabularyCard(
      id: 'sea',
      prompt: LocalizedText(
        en: 'Sea (with the article)',
        ru: 'Море (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η θάλασσα',
      pronunciation: LocalizedText(en: 'i THA-la-sa', ru: 'и ТА-ла-са'),
      explanation: LocalizedText(
        en: 'Feminine: η θάλασσα → στην θάλασσα. Keep the double σ in the spelling.',
        ru: 'Море — средний род, η θάλασσα — женский. «На море / в море»: στην θάλασσα. Пишем две σ; θ — межзубный звук.',
      ),
    ),
    VocabularyCard(
      id: 'sun',
      prompt: LocalizedText(
        en: 'Sun (with the article)',
        ru: 'Солнце (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'ο ήλιος',
      pronunciation: LocalizedText(en: 'o I-li-os', ru: 'о И-ли-ос'),
      explanation: LocalizedText(
        en: 'Masculine: ο ήλιος → τον ήλιο. The stress is on ή.',
        ru: 'Солнце в русском среднего рода, ο ήλιος — мужского. «Вижу солнце»: βλέπω τον ήλιο; окончание -ς исчезает.',
      ),
    ),
    VocabularyCard(
      id: 'sky',
      prompt: LocalizedText(
        en: 'Sky (with the article)',
        ru: 'Небо (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'ο ουρανός',
      pronunciation: LocalizedText(en: 'o u-ra-NOS', ru: 'о у-ра-НОС'),
      explanation: LocalizedText(
        en: 'Masculine: ο ουρανός → τον ουρανό. Ου is one vowel sound, u.',
        ru: 'Небо — средний род, ο ουρανός — мужской. Ου читается «у», как в имени Уран. В винительном: τον ουρανό.',
      ),
    ),
    VocabularyCard(
      id: 'europe',
      prompt: LocalizedText(
        en: 'Europe (with the article)',
        ru: 'Европа (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Ευρώπη',
      pronunciation: LocalizedText(en: 'i ev-RO-pi', ru: 'и эв-РО-пи'),
      explanation: LocalizedText(
        en: 'Feminine: στην Ευρώπη means in Europe. Ευ is pronounced ev here.',
        ru: 'Женский род, как в русском. Ευ здесь читается «эв». «В Европе»: στην Ευρώπη; окончание -η сохраняется.',
      ),
    ),
    VocabularyCard(
      id: 'asia',
      prompt: LocalizedText(
        en: 'Asia (with the article)',
        ru: 'Азия (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Ασία',
      pronunciation: LocalizedText(en: 'i a-SI-a', ru: 'и а-СИ-а'),
      explanation: LocalizedText(
        en: 'Feminine: η Ασία → στην Ασία.',
        ru: 'Род совпадает с русским: η Ασία. Но ударение на -σί-, а согласная σ — «с». «В Азии»: στην Ασία.',
      ),
    ),
    VocabularyCard(
      id: 'america',
      prompt: LocalizedText(
        en: 'America (with the article)',
        ru: 'Америка (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Αμερική',
      pronunciation: LocalizedText(en: 'i a-me-ri-KI', ru: 'и а-мэ-ри-КИ'),
      explanation: LocalizedText(
        en: 'Αμερική can refer broadly to the Americas; it is also used informally for the USA. In America: στην Αμερική.',
        ru: 'Η Αμερική — Америка; в разговоре так называют и США. Ударение на последнем слоге. «В Америке»: στην Αμερική.',
      ),
    ),
    VocabularyCard(
      id: 'africa',
      prompt: LocalizedText(
        en: 'Africa (with the article)',
        ru: 'Африка (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η Αφρική',
      pronunciation: LocalizedText(en: 'i a-fri-KI', ru: 'и а-фри-КИ'),
      explanation: LocalizedText(
        en: 'Feminine, with final stress: στην Αφρική.',
        ru: 'Как «Африка», женский род, но ударение в конце: Αφρική. «В Африке»: στην Αφρική.',
      ),
    ),
  ],
);
