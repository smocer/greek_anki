import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const wantPresentDeck = VocabularyDeck(
  id: 'want-present',
  title: LocalizedText(en: 'To want: θέλω', ru: 'Хотеть: θέλω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Θέλω follows the regular present endings. Θ is the sound in English thin.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Русское «хотеть» меняет основу, а θέλω сохраняет θελ-. Θ — межзубный звук; «т» в подсказке лишь приближение.',
  ),
  cover: 'θέλω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I want', ru: 'Я хочу'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'θέλω',
      pronunciation: LocalizedText(en: 'THE-lo', ru: 'ТЭ-ло'),
      explanation: LocalizedText(
        en: 'First person singular. Θέλω follows the regular present endings. Θ is the sound in English thin.',
        ru: 'Первое лицо: я. Русское «хотеть» меняет основу, а θέλω сохраняет θελ-. Θ — межзубный звук; «т» в подсказке лишь приближение.',
      ),
      acceptedAnswers: ['εγώ θέλω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) want', ru: 'Ты хочешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'θέλεις',
      pronunciation: LocalizedText(en: 'THE-lis', ru: 'ТЭ-лис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Θέλω follows the regular present endings. Θ is the sound in English thin.',
        ru: 'Второе лицо: ты. Русское «хотеть» меняет основу, а θέλω сохраняет θελ-. Θ — межзубный звук; «т» в подсказке лишь приближение.',
      ),
      acceptedAnswers: ['εσύ θέλεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He wants', ru: 'Он хочет'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'θέλει',
      pronunciation: LocalizedText(en: 'THE-li', ru: 'ТЭ-ли'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Θέλω follows the regular present endings. Θ is the sound in English thin.',
        ru: 'Третье лицо: он; та же форма для она/оно. Русское «хотеть» меняет основу, а θέλω сохраняет θελ-. Θ — межзубный звук; «т» в подсказке лишь приближение.',
      ),
      acceptedAnswers: ['αυτός θέλει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We want', ru: 'Мы хотим'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'θέλουμε',
      pronunciation: LocalizedText(en: 'THE-lu-me', ru: 'ТЭ-лу-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Θέλω follows the regular present endings. Θ is the sound in English thin.',
        ru: 'Первое лицо множественного числа: мы. Русское «хотеть» меняет основу, а θέλω сохраняет θελ-. Θ — межзубный звук; «т» в подсказке лишь приближение.',
      ),
      acceptedAnswers: ['εμείς θέλουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) want',
        ru: 'Вы / вы хотите',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'θέλετε',
      pronunciation: LocalizedText(en: 'THE-le-te', ru: 'ТЭ-лэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Θέλω follows the regular present endings. Θ is the sound in English thin.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Русское «хотеть» меняет основу, а θέλω сохраняет θελ-. Θ — межзубный звук; «т» в подсказке лишь приближение.',
      ),
      acceptedAnswers: ['εσείς θέλετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They want', ru: 'Они хотят'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'θέλουν',
      pronunciation: LocalizedText(en: 'THE-lun', ru: 'ТЭ-лун'),
      explanation: LocalizedText(
        en: 'Third person plural. Θέλω follows the regular present endings. Θ is the sound in English thin.',
        ru: 'Третье лицо множественного числа: они. Русское «хотеть» меняет основу, а θέλω сохраняет θελ-. Θ — межзубный звук; «т» в подсказке лишь приближение.',
      ),
      alternatives: ['θέλουνε'],
      acceptedAnswers: [
        'αυτοί θέλουν',
        'αυτοί θέλουνε',
        'αυτές θέλουν',
        'αυτές θέλουνε',
        'αυτά θέλουν',
        'αυτά θέλουνε',
      ],
    ),
    VocabularyCard(
      id: 'children-want',
      prompt: LocalizedText(
        en: 'What do you want here, kids?',
        ru: 'Что вы хотите здесь, ребята?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Τι θέλετε εδώ, παιδιά;',
      pronunciation: LocalizedText(
        en: 'ti THE-le-te e-DHO pe-DHYA',
        ru: 'ти ТЭ-лэ-тэ э-ДО пэ-ДЬЯ',
      ),
      explanation: LocalizedText(
        en: 'Addressing several children requires θέλετε, not θέλεις.',
        ru: 'Παιδιά — обращение к группе, поэтому θέλετε «вы хотите». Τι без ударения.',
      ),
    ),
    VocabularyCard(
      id: 'want-book',
      prompt: LocalizedText(en: 'I want a book.', ru: 'Я хочу книгу.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Θέλω ένα βιβλίο.',
      pronunciation: LocalizedText(
        en: 'THE-lo E-na viv-LI-o',
        ru: 'ТЭ-ло Э-на вив-ЛИ-о',
      ),
      explanation: LocalizedText(
        en: 'Ένα is the neuter indefinite article here.',
        ru: '«Хочу что?» — винительный. Το βιβλίο среднего рода, поэтому ένα, хотя «книга» по-русски женского.',
      ),
      acceptedAnswers: ['Εγώ θέλω ένα βιβλίο.'],
    ),
  ],
);
