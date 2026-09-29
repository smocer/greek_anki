import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const seePresentDeck = VocabularyDeck(
  id: 'see-present',
  title: LocalizedText(en: 'Βλέπω — see', ru: 'Βλέπω — видеть'),
  subtitle: LocalizedText(
    en: 'First-person present',
    ru: 'Настоящее время, первое лицо',
  ),
  cover: 'βλέπω',
  note: LocalizedText(
    en: 'Βλέπω means I see; the person or thing seen takes the accusative.',
    ru: 'Βλέπω — «я вижу». Объект — в винительном: кого? что?',
  ),
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I see', ru: 'Я вижу'),
      meaning: LocalizedText(
        en: 'Use the first-person singular.',
        ru: 'Используйте форму первого лица единственного числа.',
      ),
      greek: 'βλέπω',
      pronunciation: LocalizedText(en: 'VLE-po', ru: 'ВЛЭ-по'),
      explanation: LocalizedText(
        en: 'The ending -ω marks the first person singular. A direct object uses the accusative: βλέπω την εικόνα.',
        ru: 'Это форма «я вижу», не инфинитив «видеть». После глагола — винительный: βλέπω την εικόνα, как «вижу картинку».',
      ),
      acceptedAnswers: ['εγώ βλέπω'],
    ),
  ],
);
