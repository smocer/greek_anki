import '../domain/app_language.dart';

// References: Greek Ministry of Education spelling dictionary and the
// Centre for the Greek Language's pronunciation guide (see docs/grammar.md).
class PairExample {
  const PairExample(this.id, this.word, this.ipa, this.meaning);
  final String id, word, ipa;
  final LocalizedText meaning;
  String get audioAsset => 'audio/greek/$id.mp3';
}

class GreekLetterPair {
  const GreekLetterPair(this.letters, this.ipa, this.rule, this.examples);
  final String letters, ipa;
  final LocalizedText rule;
  final List<PairExample> examples;
}

const greekLetterPairs = [
  GreekLetterPair('αι', 'e', LocalizedText(en: 'Like ε.', ru: 'Как ε.'), [
    PairExample(
      'pair-ai',
      'παιδί',
      'peˈði',
      LocalizedText(en: 'child', ru: 'ребёнок'),
    ),
  ]),
  GreekLetterPair('ει', 'i', LocalizedText(en: 'Like ι.', ru: 'Как ι.'), [
    PairExample(
      'pair-ei',
      'είμαι',
      'ˈime',
      LocalizedText(en: 'I am', ru: 'быть — форма для «я»'),
    ),
  ]),
  GreekLetterPair('οι', 'i', LocalizedText(en: 'Like ι.', ru: 'Как ι.'), [
    PairExample(
      'pair-oi',
      'οίκος',
      'ˈikos',
      LocalizedText(en: 'house / household', ru: 'дом'),
    ),
  ]),
  GreekLetterPair(
    'υι',
    'i',
    LocalizedText(
      en: 'An uncommon spelling of /i/.',
      ru: 'Редкое написание /i/.',
    ),
    [
      PairExample(
        'pair-yi',
        'υιός',
        'iˈos',
        LocalizedText(en: 'son (formal)', ru: 'сын (книжн.)'),
      ),
    ],
  ),
  GreekLetterPair(
    'ου',
    'u',
    LocalizedText(en: 'Like “oo” in “food”.', ru: 'Как русское «у».'),
    [
      PairExample(
        'pair-ou',
        'πού',
        'pu',
        LocalizedText(en: 'where?', ru: 'где?'),
      ),
    ],
  ),
  GreekLetterPair(
    'αυ',
    'av / af',
    LocalizedText(
      en: '/av/ before vowels and voiced consonants; /af/ before voiceless consonants.',
      ru: '/av/ перед гласными и звонкими согласными; /af/ перед глухими согласными.',
    ),
    [
      PairExample(
        'pair-av',
        'αυλή',
        'aˈvli',
        LocalizedText(en: 'courtyard', ru: 'двор'),
      ),
      PairExample(
        'pair-af',
        'αυτό',
        'afˈto',
        LocalizedText(en: 'this', ru: 'это'),
      ),
    ],
  ),
  GreekLetterPair(
    'ευ',
    'ev / ef',
    LocalizedText(
      en: '/ev/ before vowels and voiced consonants; /ef/ before voiceless consonants.',
      ru: '/ev/ перед гласными и звонкими согласными; /ef/ перед глухими согласными.',
    ),
    [
      PairExample(
        'pair-ev',
        'Εύα',
        'ˈeva',
        LocalizedText(en: 'Eva (name)', ru: 'Ева (имя)'),
      ),
      PairExample(
        'pair-ef',
        'ευχή',
        'efˈçi',
        LocalizedText(en: 'wish', ru: 'пожелание'),
      ),
    ],
  ),
  GreekLetterPair(
    'ηυ',
    'iv / if',
    LocalizedText(
      en: 'Rare; the same voicing rule as αυ and ευ.',
      ru: 'Редкое сочетание; правило звонкости такое же, как у αυ и ευ.',
    ),
    [
      PairExample(
        'pair-iy',
        'ηύρα',
        'ˈivra',
        LocalizedText(
          en: 'I found (older form)',
          ru: 'я нашёл (старое написание)',
        ),
      ),
    ],
  ),
  GreekLetterPair(
    'μπ',
    'b / mb',
    LocalizedText(
      en: '/b/ at the start; /b/ or /mb/ inside words, depending on speaker and word.',
      ru: '/b/ в начале; /b/ или /mb/ внутри слова, в зависимости от слова и говорящего.',
    ),
    [
      PairExample(
        'pair-mp',
        'μπάλα',
        'ˈbala',
        LocalizedText(en: 'ball', ru: 'мяч'),
      ),
    ],
  ),
  GreekLetterPair(
    'ντ',
    'd / nd',
    LocalizedText(
      en: '/d/ at the start; /d/ or /nd/ inside words.',
      ru: '/d/ в начале; /d/ или /nd/ внутри слова.',
    ),
    [
      PairExample(
        'pair-nt',
        'ντομάτα',
        'doˈmata',
        LocalizedText(en: 'tomato', ru: 'помидор'),
      ),
    ],
  ),
  GreekLetterPair(
    'γκ',
    'ɡ / ŋɡ',
    LocalizedText(
      en: '/ɡ/ at the start; may include /ŋ/ inside words. Softer before /e, i/.',
      ru: '/ɡ/ в начале; внутри слова возможно /ŋɡ/. Смягчается перед /e, i/.',
    ),
    [
      PairExample(
        'pair-gk',
        'γκολ',
        'ɡol',
        LocalizedText(en: 'goal', ru: 'гол'),
      ),
    ],
  ),
  GreekLetterPair(
    'γγ',
    'ŋɡ / ɡ',
    LocalizedText(
      en: 'Usually inside words; softer before /e, i/.',
      ru: 'Обычно внутри слова; смягчается перед /e, i/.',
    ),
    [
      PairExample(
        'pair-gg',
        'αγγούρι',
        'aŋˈɡuri',
        LocalizedText(en: 'cucumber', ru: 'огурец'),
      ),
    ],
  ),
  GreekLetterPair(
    'τσ',
    'ts',
    LocalizedText(
      en: 'One joined /ts/ sound.',
      ru: 'Слитный звук /ts/, как «ц».',
    ),
    [
      PairExample(
        'pair-ts',
        'τσάι',
        'ˈtsai',
        LocalizedText(en: 'tea', ru: 'чай'),
      ),
    ],
  ),
  GreekLetterPair(
    'τζ',
    'dz',
    LocalizedText(
      en: 'The voiced partner of /ts/.',
      ru: 'Звонкая пара к /ts/.',
    ),
    [
      PairExample(
        'pair-tz',
        'τζάμι',
        'ˈdzami',
        LocalizedText(en: 'windowpane', ru: 'оконное стекло'),
      ),
    ],
  ),
];
