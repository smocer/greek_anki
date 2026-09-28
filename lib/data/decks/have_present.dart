import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const havePresentDeck = VocabularyDeck(
  id: 'have-present',
  title: LocalizedText(en: 'To have: έχω', ru: 'Иметь / у меня есть: έχω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Greek uses a conjugated have verb for possession.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Вместо русского «у меня/тебя есть» — глагол έχω/έχεις. Он меняется по лицам, как «имею/имеешь».',
  ),
  cover: 'έχω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I have', ru: 'У меня есть'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'έχω',
      pronunciation: LocalizedText(en: 'E-kho', ru: 'Э-хо'),
      explanation: LocalizedText(
        en: 'First person singular. Greek uses a conjugated have verb for possession.',
        ru: 'Первое лицо: я. Вместо русского «у меня/тебя есть» — глагол έχω/έχεις. Он меняется по лицам, как «имею/имеешь».',
      ),
      acceptedAnswers: ['εγώ έχω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) have', ru: 'У тебя есть'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'έχεις',
      pronunciation: LocalizedText(en: 'E-khis', ru: 'Э-хис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Greek uses a conjugated have verb for possession.',
        ru: 'Второе лицо: ты. Вместо русского «у меня/тебя есть» — глагол έχω/έχεις. Он меняется по лицам, как «имею/имеешь».',
      ),
      acceptedAnswers: ['εσύ έχεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He has', ru: 'У него есть'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'έχει',
      pronunciation: LocalizedText(en: 'E-khi', ru: 'Э-хи'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Greek uses a conjugated have verb for possession.',
        ru: 'Третье лицо: он; та же форма для она/оно. Вместо русского «у меня/тебя есть» — глагол έχω/έχεις. Он меняется по лицам, как «имею/имеешь».',
      ),
      acceptedAnswers: ['αυτός έχει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We have', ru: 'У нас есть'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'έχουμε',
      pronunciation: LocalizedText(en: 'E-khu-me', ru: 'Э-ху-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Greek uses a conjugated have verb for possession.',
        ru: 'Первое лицо множественного числа: мы. Вместо русского «у меня/тебя есть» — глагол έχω/έχεις. Он меняется по лицам, как «имею/имеешь».',
      ),
      acceptedAnswers: ['εμείς έχουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) have',
        ru: 'У Вас / у вас есть',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'έχετε',
      pronunciation: LocalizedText(en: 'E-khe-te', ru: 'Э-хэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Greek uses a conjugated have verb for possession.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Вместо русского «у меня/тебя есть» — глагол έχω/έχεις. Он меняется по лицам, как «имею/имеешь».',
      ),
      acceptedAnswers: ['εσείς έχετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They have', ru: 'У них есть'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'έχουν',
      pronunciation: LocalizedText(en: 'E-khun', ru: 'Э-хун'),
      explanation: LocalizedText(
        en: 'Third person plural. Greek uses a conjugated have verb for possession.',
        ru: 'Третье лицо множественного числа: они. Вместо русского «у меня/тебя есть» — глагол έχω/έχεις. Он меняется по лицам, как «имею/имеешь».',
      ),
      alternatives: ['έχουνε'],
      acceptedAnswers: [
        'αυτοί έχουν',
        'αυτοί έχουνε',
        'αυτές έχουν',
        'αυτές έχουνε',
        'αυτά έχουν',
        'αυτά έχουνε',
      ],
    ),
    VocabularyCard(
      id: 'have-phone',
      prompt: LocalizedText(
        en: 'Do you have a phone? (informal)',
        ru: 'У тебя есть телефон?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Έχεις τηλέφωνο;',
      pronunciation: LocalizedText(
        en: 'E-khis ti-LE-fo-no',
        ru: 'Э-хис ти-ЛЭ-фо-но',
      ),
      explanation: LocalizedText(
        en: 'A question can use the same word order as a statement.',
        ru: 'Греческий знак вопроса — ;. Τηλέφωνο легко узнать по русскому «телефон».',
      ),
    ),
    VocabularyCard(
      id: 'not-phone-yet',
      prompt: LocalizedText(
        en: 'We do not have your phone number yet. (informal)',
        ru: 'У нас ещё нет твоего номера телефона.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Δεν έχουμε το τηλέφωνό σου ακόμα.',
      pronunciation: LocalizedText(
        en: 'dhen E-khu-me to ti-LE-fo-NO su a-KO-ma',
        ru: 'дэн Э-ху-мэ то ти-ЛЭ-фо-НО су а-КО-ма',
      ),
      explanation: LocalizedText(
        en: 'Δεν negates the verb; τηλέφωνό gains a second accent before σου. Ακόμη is also correct.',
        ru: 'Вместо «нет» — δεν έχουμε «не имеем». В τηλέφωνό σου два ударения из-за безударного σου; ακόμα / ακόμη — «ещё».',
      ),
      alternatives: ['Δεν έχουμε το τηλέφωνό σου ακόμη.'],
      acceptedAnswers: [
        'Εμείς δεν έχουμε το τηλέφωνό σου ακόμα.',
        'Εμείς δεν έχουμε το τηλέφωνό σου ακόμη.',
      ],
    ),
  ],
);
