import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const openPresentDeck = VocabularyDeck(
  id: 'open-present',
  title: LocalizedText(en: 'To open: ανοίγω', ru: 'Открывать: ανοίγω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Ανοίγω can mean open something or open for business.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Ανοίγω — открывать что-то; о банке или магазине — открываться. Οι читается «и».',
  ),
  cover: 'ανοίγω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I open', ru: 'Я открываю'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ανοίγω',
      pronunciation: LocalizedText(en: 'a-NI-gho', ru: 'а-НИ-го'),
      explanation: LocalizedText(
        en: 'First person singular. Ανοίγω can mean open something or open for business.',
        ru: 'Первое лицо: я. Ανοίγω — открывать что-то; о банке или магазине — открываться. Οι читается «и».',
      ),
      acceptedAnswers: ['εγώ ανοίγω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) open', ru: 'Ты открываешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ανοίγεις',
      pronunciation: LocalizedText(en: 'a-NI-yis', ru: 'а-НИ-йис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Ανοίγω can mean open something or open for business.',
        ru: 'Второе лицо: ты. Ανοίγω — открывать что-то; о банке или магазине — открываться. Οι читается «и».',
      ),
      acceptedAnswers: ['εσύ ανοίγεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He opens', ru: 'Он открывает'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ανοίγει',
      pronunciation: LocalizedText(en: 'a-NI-yi', ru: 'а-НИ-йи'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Ανοίγω can mean open something or open for business.',
        ru: 'Третье лицо: он; та же форма для она/оно. Ανοίγω — открывать что-то; о банке или магазине — открываться. Οι читается «и».',
      ),
      acceptedAnswers: ['αυτός ανοίγει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We open', ru: 'Мы открываем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ανοίγουμε',
      pronunciation: LocalizedText(en: 'a-NI-ghu-me', ru: 'а-НИ-гу-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Ανοίγω can mean open something or open for business.',
        ru: 'Первое лицо множественного числа: мы. Ανοίγω — открывать что-то; о банке или магазине — открываться. Οι читается «и».',
      ),
      acceptedAnswers: ['εμείς ανοίγουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) open',
        ru: 'Вы открываете',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ανοίγετε',
      pronunciation: LocalizedText(en: 'a-NI-ye-te', ru: 'а-НИ-йэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Ανοίγω can mean open something or open for business.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Ανοίγω — открывать что-то; о банке или магазине — открываться. Οι читается «и».',
      ),
      acceptedAnswers: ['εσείς ανοίγετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They open', ru: 'Они открывают'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'ανοίγουν',
      pronunciation: LocalizedText(en: 'a-NI-ghun', ru: 'а-НИ-гун'),
      explanation: LocalizedText(
        en: 'Third person plural. Ανοίγω can mean open something or open for business.',
        ru: 'Третье лицо множественного числа: они. Ανοίγω — открывать что-то; о банке или магазине — открываться. Οι читается «и».',
      ),
      alternatives: ['ανοίγουνε'],
      acceptedAnswers: [
        'αυτοί ανοίγουν',
        'αυτοί ανοίγουνε',
        'αυτές ανοίγουν',
        'αυτές ανοίγουνε',
        'αυτά ανοίγουν',
        'αυτά ανοίγουνε',
      ],
    ),
    VocabularyCard(
      id: 'open-books',
      prompt: LocalizedText(
        en: 'We open our books.',
        ru: 'Мы открываем свои книги.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ανοίγουμε τα βιβλία μας.',
      pronunciation: LocalizedText(
        en: 'a-NI-ghu-me ta viv-LI-a mas',
        ru: 'а-НИ-гу-мэ та вив-ЛИ-а мас',
      ),
      explanation: LocalizedText(
        en: 'The plural object is τα βιβλία; μας follows it.',
        ru: '«Открываем что?» — винительный; у среднего рода τα βιβλία совпадает с именительным. Μας — «наши/свои».',
      ),
      acceptedAnswers: ['Εμείς ανοίγουμε τα βιβλία μας.'],
    ),
    VocabularyCard(
      id: 'bank-opens',
      prompt: LocalizedText(
        en: 'The bank opens at nine.',
        ru: 'Банк открывается в девять.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Η τράπεζα ανοίγει στις εννέα.',
      pronunciation: LocalizedText(
        en: 'i TRA-pe-za a-NI-yi stis e-NE-a',
        ru: 'и ТРА-пэ-за а-НИ-йи стис э-НЭ-а',
      ),
      explanation: LocalizedText(
        en: 'Στις introduces the hour; τράπεζα is feminine.',
        ru: 'Банк по-гречески женского рода: η τράπεζα. «В девять» → στις εννέα, подразумевается ώρες «часы».',
      ),
      alternatives: ['Η τράπεζα ανοίγει στις εννιά.'],
    ),
  ],
);
