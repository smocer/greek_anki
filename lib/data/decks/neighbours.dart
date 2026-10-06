import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const neighboursDeck = VocabularyDeck(
  id: 'neighbours',
  title: LocalizedText(en: 'Neighbours & noun cases', ru: 'Соседи и падежи'),
  subtitle: LocalizedText(
    en: 'One neighbour, several neighbours',
    ru: 'Один сосед, несколько соседей',
  ),
  note: LocalizedText(
    en: 'Learn the article with the noun. Masculine γείτονας changes by case and number; the feminine word is γειτόνισσα.',
    ru: 'Как сосед/соседа/соседи: учим формы по падежам и числам. В греческом меняется и артикль; «соседка» — γειτόνισσα.',
  ),
  cover: 'Γείτονες',
  cards: [
    VocabularyCard(
      id: 'neighbour-subject',
      prompt: LocalizedText(
        en: 'The neighbour (male, subject)',
        ru: 'Сосед (кто? мужской род)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ο γείτονας',
      pronunciation: LocalizedText(en: 'o YI-to-nas', ru: 'о ЙИ-то-нас'),
      explanation: LocalizedText(
        en: 'Nominative singular, the subject form.',
        ru: 'Именительный «кто? сосед»: ο γείτονας. Γεί звучит примерно «йи», не «гей».',
      ),
    ),
    VocabularyCard(
      id: 'neighbour-object',
      prompt: LocalizedText(
        en: 'The neighbour (male, direct object)',
        ru: 'Соседа (вижу кого?)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τον γείτονα',
      pronunciation: LocalizedText(en: 'ton YI-to-na', ru: 'тон ЙИ-то-на'),
      explanation: LocalizedText(
        en: 'Accusative singular: ο → τον, γείτονας → γείτονα.',
        ru: 'Как «вижу соседа»: винительный; артикль τον, а конечное -ς исчезает.',
      ),
    ),
    VocabularyCard(
      id: 'neighbour-possession',
      prompt: LocalizedText(
        en: 'Of the neighbour (male)',
        ru: 'Соседа (дом кого? родительный)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'του γείτονα',
      pronunciation: LocalizedText(en: 'tu YI-to-na', ru: 'ту ЙИ-то-на'),
      explanation: LocalizedText(
        en: 'Genitive singular has the same noun ending as the accusative, but a different article.',
        ru: 'Το σπίτι του γείτονα — «дом соседа». Родительный: του γείτονα. Формы существительного совпали, артикли τον/του различаются.',
      ),
    ),
    VocabularyCard(
      id: 'neighbours-subject',
      prompt: LocalizedText(
        en: 'The neighbours (male/mixed, subject)',
        ru: 'Соседи (кто? мужчины или смешанная группа)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'οι γείτονες',
      pronunciation: LocalizedText(en: 'i YI-to-nes', ru: 'и ЙИ-то-нэс'),
      explanation: LocalizedText(
        en: 'Nominative plural: οι γείτονες.',
        ru: 'Именительный множественного: «соседи». Οι произносится «и», как η, но пишется иначе.',
      ),
    ),
    VocabularyCard(
      id: 'neighbours-object',
      prompt: LocalizedText(
        en: 'The neighbours (male/mixed, direct object)',
        ru: 'Соседей (вижу кого?)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'τους γείτονες',
      pronunciation: LocalizedText(en: 'tus YI-to-nes', ru: 'тус ЙИ-то-нэс'),
      explanation: LocalizedText(
        en: 'Accusative plural changes οι to τους.',
        ru: 'Как «вижу соседей»: τους γείτονες. Меняется артикль, а γείτονες остаётся.',
      ),
    ),
    VocabularyCard(
      id: 'female-neighbour',
      prompt: LocalizedText(
        en: 'The neighbour (female, with article)',
        ru: 'Соседка (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'η γειτόνισσα',
      pronunciation: LocalizedText(en: 'i yi-TO-ni-sa', ru: 'и йи-ТО-ни-са'),
      explanation: LocalizedText(
        en: 'The feminine noun is γειτόνισσα, with stress on τό.',
        ru: 'Как «сосед → соседка»: отдельная форма γειτόνισσα, с удвоенным σσ.',
      ),
    ),
    VocabularyCard(
      id: 'female-neighbours',
      prompt: LocalizedText(
        en: 'The neighbours (all female, subject)',
        ru: 'Соседки (кто? только женщины)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'οι γειτόνισσες',
      pronunciation: LocalizedText(en: 'i yi-TO-ni-ses', ru: 'и йи-ТО-ни-сэс'),
      explanation: LocalizedText(
        en: 'Feminine nominative plural also uses οι.',
        ru: 'Οι — артикль множественного и мужского, и женского рода. «Соседки» — γειτόνισσες.',
      ),
    ),
    VocabularyCard(
      id: 'we-neighbours',
      prompt: LocalizedText(
        en: 'We are neighbours. (male/mixed)',
        ru: 'Мы соседи. (мужчины или смешанная группа)',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Είμαστε γείτονες.',
      pronunciation: LocalizedText(
        en: 'I-ma-ste YI-to-nes',
        ru: 'И-ма-стэ ЙИ-то-нэс',
      ),
      explanation: LocalizedText(
        en: 'Use είμαστε, not μένουμε, to say what we are.',
        ru: 'В русском «мы соседи» без «есть»; в греческом нужен είμαστε. Μένουμε означает «живём».',
      ),
      acceptedAnswers: ['Εμείς είμαστε γείτονες.'],
    ),
  ],
);
