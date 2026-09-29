import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';

const transportStreetsDeck = VocabularyDeck(
  id: 'transport-streets',
  title: LocalizedText(en: 'Transport & streets', ru: 'Транспорт и улицы'),
  subtitle: LocalizedText(en: 'Getting around town', ru: 'Город и транспорт'),
  cover: 'το μετρό',
  note: LocalizedText(
    en: 'Learn each noun with its article. Gender does not necessarily match your own language. Location phrases use σε + accusative.',
    ru: 'Учите существительное с артиклем: род не всегда совпадает с русским. Для «в / на» используем σε + винительный.',
  ),
  cards: [
    VocabularyCard(
      id: 'port',
      prompt: LocalizedText(
        en: 'Port / harbour (with the article)',
        ru: 'Порт / гавань (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το λιμάνι',
      pronunciation: LocalizedText(en: 'to li-MA-ni', ru: 'то ли-МА-ни'),
      explanation: LocalizedText(
        en: 'Neuter: το λιμάνι → στο λιμάνι (at the port).',
        ru: 'Порт — мужского рода в русском, но το λιμάνι — среднего. «В порту»: στο λιμάνι, винительный после σε.',
      ),
    ),
    VocabularyCard(
      id: 'metro',
      prompt: LocalizedText(
        en: 'Metro / underground (with the article)',
        ru: 'Метро (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το μετρό',
      pronunciation: LocalizedText(en: 'to me-TRO', ru: 'то мэ-ТРО'),
      explanation: LocalizedText(
        en: 'An indeclinable neuter noun: το μετρό → στο μετρό.',
        ru: 'Как русское «метро», слово среднего рода и не склоняется. Το μετρό → στο μετρό.',
      ),
    ),
    VocabularyCard(
      id: 'bus',
      prompt: LocalizedText(
        en: 'Bus (with the article)',
        ru: 'Автобус (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το λεωφορείο',
      pronunciation: LocalizedText(
        en: 'to le-o-fo-RI-o',
        ru: 'то лэ-о-фо-РИ-о',
      ),
      explanation: LocalizedText(
        en: 'Neuter; στο λεωφορείο means on the bus.',
        ru: 'Автобус в русском мужского рода, το λεωφορείο — среднего. «В автобусе»: στο λεωφορείο.',
      ),
    ),
    VocabularyCard(
      id: 'train',
      prompt: LocalizedText(
        en: 'Train (with the article)',
        ru: 'Поезд (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'το τρένο',
      pronunciation: LocalizedText(en: 'to TRE-no', ru: 'то ТРЭ-но'),
      explanation: LocalizedText(
        en: 'Neuter: το τρένο → στο τρένο. The noun stays the same in the accusative.',
        ru: 'Поезд — мужской род, но το τρένο — средний. «В поезде»: στο τρένο; форма существительного не меняется.',
      ),
    ),
    VocabularyCard(
      id: 'stop',
      prompt: LocalizedText(
        en: 'Bus stop (with the article)',
        ru: 'Автобусная остановка (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η στάση',
      pronunciation: LocalizedText(en: 'i STA-si', ru: 'и СТА-си'),
      explanation: LocalizedText(
        en: 'Feminine: η στάση → στην στάση (at the stop). A bus stop is also η στάση του λεωφορείου.',
        ru: 'Как «остановка», η στάση — женского рода. «На остановке»: στην στάση; меняется артикль, а не окончание существительного.',
      ),
    ),
    VocabularyCard(
      id: 'square',
      prompt: LocalizedText(
        en: 'Town square (with the article)',
        ru: 'Городская площадь (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η πλατεία',
      pronunciation: LocalizedText(en: 'i pla-TI-a', ru: 'и пла-ТИ-а'),
      explanation: LocalizedText(
        en: 'Feminine: η πλατεία → στην πλατεία (in the square).',
        ru: 'Площадь и η πλατεία — женского рода. Русскому «на площади» соответствует στην πλατεία: здесь σε передаёт «на».',
      ),
    ),
    VocabularyCard(
      id: 'street',
      prompt: LocalizedText(
        en: 'Street (the word used in street names) (with the article)',
        ru: 'Улица (слово в названиях улиц) (с артиклем)',
      ),
      meaning: LocalizedText(
        en: 'Include the article where shown in the phrase.',
        ru: 'Используйте артикль, если он входит в выражение.',
      ),
      greek: 'η οδός',
      pronunciation: LocalizedText(en: 'i o-DHOS', ru: 'и о-ДОС'),
      explanation: LocalizedText(
        en: 'Οδός is feminine despite -ος: η οδός → στην οδό. Ο δρόμος is another word for road or street.',
        ru: 'Η οδός — женский род, как «улица», несмотря на -ος. В винительном: την οδό. Сравните ο δρόμος — дорога, улица, мужской род.',
      ),
    ),
  ],
);
