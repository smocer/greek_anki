import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const writePresentDeck = VocabularyDeck(
  id: 'write-present',
  title: LocalizedText(en: 'To write: γράφω', ru: 'Писать: γράφω'),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. The γραφ- root also appears in photograph and graphic.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Корень γραφ- знаком по «графика», «фотография». Γ перед ρ — щелевой звук, не точное русское «г».',
  ),
  cover: 'γράφω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I write', ru: 'Я пишу'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'γράφω',
      pronunciation: LocalizedText(en: 'GHRA-fo', ru: 'ГРА-фо'),
      explanation: LocalizedText(
        en: 'First person singular. The γραφ- root also appears in photograph and graphic.',
        ru: 'Первое лицо: я. Корень γραφ- знаком по «графика», «фотография». Γ перед ρ — щелевой звук, не точное русское «г».',
      ),
      acceptedAnswers: ['εγώ γράφω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(en: 'You (informal) write', ru: 'Ты пишешь'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'γράφεις',
      pronunciation: LocalizedText(en: 'GHRA-fis', ru: 'ГРА-фис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. The γραφ- root also appears in photograph and graphic.',
        ru: 'Второе лицо: ты. Корень γραφ- знаком по «графика», «фотография». Γ перед ρ — щелевой звук, не точное русское «г».',
      ),
      acceptedAnswers: ['εσύ γράφεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(en: 'He writes', ru: 'Он пишет'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'γράφει',
      pronunciation: LocalizedText(en: 'GHRA-fi', ru: 'ГРА-фи'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. The γραφ- root also appears in photograph and graphic.',
        ru: 'Третье лицо: он; та же форма для она/оно. Корень γραφ- знаком по «графика», «фотография». Γ перед ρ — щелевой звук, не точное русское «г».',
      ),
      acceptedAnswers: ['αυτός γράφει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(en: 'We write', ru: 'Мы пишем'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'γράφουμε',
      pronunciation: LocalizedText(en: 'GHRA-fu-me', ru: 'ГРА-фу-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. The γραφ- root also appears in photograph and graphic.',
        ru: 'Первое лицо множественного числа: мы. Корень γραφ- знаком по «графика», «фотография». Γ перед ρ — щелевой звук, не точное русское «г».',
      ),
      acceptedAnswers: ['εμείς γράφουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) write',
        ru: 'Вы / вы пишете',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'γράφετε',
      pronunciation: LocalizedText(en: 'GHRA-fe-te', ru: 'ГРА-фэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. The γραφ- root also appears in photograph and graphic.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Корень γραφ- знаком по «графика», «фотография». Γ перед ρ — щелевой звук, не точное русское «г».',
      ),
      acceptedAnswers: ['εσείς γράφετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(en: 'They write', ru: 'Они пишут'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'γράφουν',
      pronunciation: LocalizedText(en: 'GHRA-fun', ru: 'ГРА-фун'),
      explanation: LocalizedText(
        en: 'Third person plural. The γραφ- root also appears in photograph and graphic.',
        ru: 'Третье лицо множественного числа: они. Корень γραφ- знаком по «графика», «фотография». Γ перед ρ — щелевой звук, не точное русское «г».',
      ),
      alternatives: ['γράφουνε'],
      acceptedAnswers: [
        'αυτοί γράφουν',
        'αυτοί γράφουνε',
        'αυτές γράφουν',
        'αυτές γράφουνε',
        'αυτά γράφουν',
        'αυτά γράφουνε',
      ],
    ),
    VocabularyCard(
      id: 'write-mum',
      prompt: LocalizedText(
        en: 'Do you write to your mum? (plural/polite)',
        ru: 'Вы пишете своей маме?',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Γράφετε στη μαμά σας;',
      pronunciation: LocalizedText(
        en: 'GHRA-fe-te sti ma-MA sas',
        ru: 'ГРА-фэ-тэ сти ма-МА сас',
      ),
      explanation: LocalizedText(
        en: 'The recipient uses σε + accusative; σας marks your (plural/polite).',
        ru: 'Русское «кому? маме» — дательный; греческое στη μαμά — σε + винительный. Σας — «вашей».',
      ),
      alternatives: ['Γράφετε στην μαμά σας;'],
    ),
    VocabularyCard(
      id: 'write-name',
      prompt: LocalizedText(en: 'I write my name.', ru: 'Я пишу своё имя.'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Γράφω το όνομά μου.',
      pronunciation: LocalizedText(
        en: 'GHRA-fo to O-no-MA mu',
        ru: 'ГРА-фо то О-но-МА му',
      ),
      explanation: LocalizedText(
        en: 'Όνομά has an extra accent before the unstressed possessive μου.',
        ru: 'Как в «своё имя», но с μου после слова. Το όνομά μου требует двух ударений.',
      ),
      acceptedAnswers: ['Εγώ γράφω το όνομά μου.'],
    ),
  ],
);
