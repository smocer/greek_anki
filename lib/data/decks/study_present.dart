import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const studyPresentDeck = VocabularyDeck(
  id: 'study-present',
  title: LocalizedText(
    en: 'To study at university: σπουδάζω',
    ru: 'Учиться в вузе: σπουδάζω',
  ),
  subtitle: LocalizedText(
    en: 'Six persons + everyday sentences',
    ru: 'Шесть лиц и фразы из жизни',
  ),
  note: LocalizedText(
    en: 'Present endings: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns can be omitted. Σπουδάζω normally refers to higher or specialist studies, not simply reading a lesson.',
    ru: 'Как в русском живу/живёшь/живём, лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение обычно можно опустить. Σπουδάζω — получать высшее или специальное образование; не обычное «читаю учебник» (διαβάζω) и не любое «учусь» (μαθαίνω).',
  ),
  cover: 'σπουδάζω',
  cards: [
    VocabularyCard(
      id: 'i',
      prompt: LocalizedText(en: 'I study at university', ru: 'Я учусь в вузе'),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σπουδάζω',
      pronunciation: LocalizedText(en: 'spu-DHA-zo', ru: 'спу-ДА-зо'),
      explanation: LocalizedText(
        en: 'First person singular. Σπουδάζω normally refers to higher or specialist studies, not simply reading a lesson.',
        ru: 'Первое лицо: я. Σπουδάζω — получать высшее или специальное образование; не обычное «читаю учебник» (διαβάζω) и не любое «учусь» (μαθαίνω).',
      ),
      acceptedAnswers: ['εγώ σπουδάζω'],
    ),
    VocabularyCard(
      id: 'you',
      prompt: LocalizedText(
        en: 'You (informal) study at university',
        ru: 'Ты учишься в вузе',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σπουδάζεις',
      pronunciation: LocalizedText(en: 'spu-DHA-zis', ru: 'спу-ДА-зис'),
      explanation: LocalizedText(
        en: 'Second person singular, informal. Σπουδάζω normally refers to higher or specialist studies, not simply reading a lesson.',
        ru: 'Второе лицо: ты. Σπουδάζω — получать высшее или специальное образование; не обычное «читаю учебник» (διαβάζω) и не любое «учусь» (μαθαίνω).',
      ),
      acceptedAnswers: ['εσύ σπουδάζεις'],
    ),
    VocabularyCard(
      id: 'he',
      prompt: LocalizedText(
        en: 'He studies at university',
        ru: 'Он учится в вузе',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σπουδάζει',
      pronunciation: LocalizedText(en: 'spu-DHA-zi', ru: 'спу-ДА-зи'),
      explanation: LocalizedText(
        en: 'Third person singular, also she/it. Σπουδάζω normally refers to higher or specialist studies, not simply reading a lesson.',
        ru: 'Третье лицо: он; та же форма для она/оно. Σπουδάζω — получать высшее или специальное образование; не обычное «читаю учебник» (διαβάζω) и не любое «учусь» (μαθαίνω).',
      ),
      acceptedAnswers: ['αυτός σπουδάζει'],
    ),
    VocabularyCard(
      id: 'we',
      prompt: LocalizedText(
        en: 'We study at university',
        ru: 'Мы учимся в вузе',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σπουδάζουμε',
      pronunciation: LocalizedText(en: 'spu-DHA-zu-me', ru: 'спу-ДА-зу-мэ'),
      explanation: LocalizedText(
        en: 'First person plural. Σπουδάζω normally refers to higher or specialist studies, not simply reading a lesson.',
        ru: 'Первое лицо множественного числа: мы. Σπουδάζω — получать высшее или специальное образование; не обычное «читаю учебник» (διαβάζω) и не любое «учусь» (μαθαίνω).',
      ),
      acceptedAnswers: ['εμείς σπουδάζουμε'],
    ),
    VocabularyCard(
      id: 'you-plural',
      prompt: LocalizedText(
        en: 'You (polite/plural) study at university',
        ru: 'Вы учитесь в вузе',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σπουδάζετε',
      pronunciation: LocalizedText(en: 'spu-DHA-ze-te', ru: 'спу-ДА-зэ-тэ'),
      explanation: LocalizedText(
        en: 'Second person plural or polite singular. Σπουδάζω normally refers to higher or specialist studies, not simply reading a lesson.',
        ru: 'Как русское вы/Вы: группа или вежливое обращение к одному. Σπουδάζω — получать высшее или специальное образование; не обычное «читаю учебник» (διαβάζω) и не любое «учусь» (μαθαίνω).',
      ),
      acceptedAnswers: ['εσείς σπουδάζετε'],
    ),
    VocabularyCard(
      id: 'they',
      prompt: LocalizedText(
        en: 'They study at university',
        ru: 'Они учатся в вузе',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'σπουδάζουν',
      pronunciation: LocalizedText(en: 'spu-DHA-zun', ru: 'спу-ДА-зун'),
      explanation: LocalizedText(
        en: 'Third person plural. Σπουδάζω normally refers to higher or specialist studies, not simply reading a lesson.',
        ru: 'Третье лицо множественного числа: они. Σπουδάζω — получать высшее или специальное образование; не обычное «читаю учебник» (διαβάζω) и не любое «учусь» (μαθαίνω).',
      ),
      alternatives: ['σπουδάζουνε'],
      acceptedAnswers: [
        'αυτοί σπουδάζουν',
        'αυτοί σπουδάζουνε',
        'αυτές σπουδάζουν',
        'αυτές σπουδάζουνε',
        'αυτά σπουδάζουν',
        'αυτά σπουδάζουνε',
      ],
    ),
    VocabularyCard(
      id: 'kostas-university',
      prompt: LocalizedText(
        en: 'Kostas studies at the University of Cyprus.',
        ru: 'Костас учится в Кипрском университете.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Ο Κώστας σπουδάζει στο Πανεπιστήμιο Κύπρου.',
      pronunciation: LocalizedText(
        en: 'o KOS-tas spu-DHA-zi sto pa-ne-pi-STI-mi-o KI-pru',
        ru: 'о КОС-тас спу-ДА-зи сто па-нэ-пи-СТИ-ми-о КИ-пру',
      ),
      explanation: LocalizedText(
        en: 'Κύπρου is genitive in the institution name; στο marks location.',
        ru: 'Στο + винительный для места; Κύπρου — родительный «Кипра» в названии, как «университет Кипра».',
      ),
    ),
    VocabularyCard(
      id: 'at-university',
      prompt: LocalizedText(
        en: 'I study at university.',
        ru: 'Я учусь в университете.',
      ),
      meaning: LocalizedText(
        en: 'Translate into Greek.',
        ru: 'Переведите на греческий.',
      ),
      greek: 'Σπουδάζω στο πανεπιστήμιο.',
      pronunciation: LocalizedText(
        en: 'spu-DHA-zo sto pa-ne-pi-STI-mi-o',
        ru: 'спу-ДА-зо сто па-нэ-пи-СТИ-ми-о',
      ),
      explanation: LocalizedText(
        en: 'Το πανεπιστήμιο is neuter; σε + το = στο.',
        ru: 'Университет в русском мужского рода, το πανεπιστήμιο — среднего: στο πανεπιστήμιο.',
      ),
      acceptedAnswers: ['Εγώ σπουδάζω στο πανεπιστήμιο.'],
    ),
  ],
);
