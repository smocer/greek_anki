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
  GreekLetterPair(
    'αι',
    'e',
    LocalizedText(en: 'Like ε.', zh: '与 ε 相同。', ru: 'Как ε.'),
    [
      PairExample(
        'pair-ai',
        'παιδί',
        'peˈði',
        LocalizedText(en: 'child', zh: '孩子', ru: 'ребёнок'),
      ),
    ],
  ),
  GreekLetterPair(
    'ει',
    'i',
    LocalizedText(en: 'Like ι.', zh: '与 ι 相同。', ru: 'Как ι.'),
    [
      PairExample(
        'pair-ei',
        'είμαι',
        'ˈime',
        LocalizedText(en: 'I am', zh: '我是', ru: 'быть — форма для «я»'),
      ),
    ],
  ),
  GreekLetterPair(
    'οι',
    'i',
    LocalizedText(en: 'Like ι.', zh: '与 ι 相同。', ru: 'Как ι.'),
    [
      PairExample(
        'pair-oi',
        'οίκος',
        'ˈikos',
        LocalizedText(en: 'house / household', zh: '房子／家庭', ru: 'дом'),
      ),
    ],
  ),
  GreekLetterPair(
    'υι',
    'i',
    LocalizedText(
      en: 'An uncommon spelling of /i/.',
      zh: '不常见的 /i/ 拼写。',
      ru: 'Редкое написание /i/.',
    ),
    [
      PairExample(
        'pair-yi',
        'υιός',
        'iˈos',
        LocalizedText(en: 'son (formal)', zh: '儿子（正式用语）', ru: 'сын (книжн.)'),
      ),
    ],
  ),
  GreekLetterPair(
    'ου',
    'u',
    LocalizedText(
      en: 'Like “oo” in “food”.',
      zh: '类似英语 food 中的 oo。',
      ru: 'Как русское «у».',
    ),
    [
      PairExample(
        'pair-ou',
        'πού',
        'pu',
        LocalizedText(en: 'where?', zh: '哪里？', ru: 'где?'),
      ),
    ],
  ),
  GreekLetterPair(
    'αυ',
    'av / af',
    LocalizedText(
      en: '/av/ before vowels and voiced consonants; /af/ before voiceless consonants.',
      zh: '在元音和浊辅音前读 /av/，在清辅音前读 /af/。',
      ru: '/av/ перед гласными и звонкими согласными; /af/ перед глухими согласными.',
    ),
    [
      PairExample(
        'pair-av',
        'αυλή',
        'aˈvli',
        LocalizedText(en: 'courtyard', zh: '庭院', ru: 'двор'),
      ),
      PairExample(
        'pair-af',
        'αυτό',
        'afˈto',
        LocalizedText(en: 'this', zh: '这个', ru: 'это'),
      ),
    ],
  ),
  GreekLetterPair(
    'ευ',
    'ev / ef',
    LocalizedText(
      en: '/ev/ before vowels and voiced consonants; /ef/ before voiceless consonants.',
      zh: '在元音和浊辅音前读 /ev/，在清辅音前读 /ef/。',
      ru: '/ev/ перед гласными и звонкими согласными; /ef/ перед глухими согласными.',
    ),
    [
      PairExample(
        'pair-ev',
        'Εύα',
        'ˈeva',
        LocalizedText(en: 'Eva (name)', zh: '伊娃（人名）', ru: 'Ева (имя)'),
      ),
      PairExample(
        'pair-ef',
        'ευχή',
        'efˈçi',
        LocalizedText(en: 'wish', zh: '愿望；祝愿', ru: 'пожелание'),
      ),
    ],
  ),
  GreekLetterPair(
    'ηυ',
    'iv / if',
    LocalizedText(
      en: 'Rare; the same voicing rule as αυ and ευ.',
      zh: '少见组合，清浊变化规则与 αυ、ευ 相同。',
      ru: 'Редкое сочетание; правило звонкости такое же, как у αυ и ευ.',
    ),
    [
      PairExample(
        'pair-iy',
        'ηύρα',
        'ˈivra',
        LocalizedText(
          en: 'I found (older form)',
          zh: '我找到了（旧式形式）',
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
      zh: '词首读 /b/；词中读 /b/ 或 /mb/，因说话者和词语而异。',
      ru: '/b/ в начале; /b/ или /mb/ внутри слова, в зависимости от слова и говорящего.',
    ),
    [
      PairExample(
        'pair-mp',
        'μπάλα',
        'ˈbala',
        LocalizedText(en: 'ball', zh: '球', ru: 'мяч'),
      ),
    ],
  ),
  GreekLetterPair(
    'ντ',
    'd / nd',
    LocalizedText(
      en: '/d/ at the start; /d/ or /nd/ inside words.',
      zh: '词首读 /d/；词中读 /d/ 或 /nd/。',
      ru: '/d/ в начале; /d/ или /nd/ внутри слова.',
    ),
    [
      PairExample(
        'pair-nt',
        'ντομάτα',
        'doˈmata',
        LocalizedText(en: 'tomato', zh: '番茄', ru: 'помидор'),
      ),
    ],
  ),
  GreekLetterPair(
    'γκ',
    'ɡ / ŋɡ',
    LocalizedText(
      en: '/ɡ/ at the start; may include /ŋ/ inside words. Softer before /e, i/.',
      zh: '词首读 /ɡ/；词中可能带 /ŋ/ 音。在 /e、i/ 前发音更柔和。',
      ru: '/ɡ/ в начале; внутри слова возможно /ŋɡ/. Смягчается перед /e, i/.',
    ),
    [
      PairExample(
        'pair-gk',
        'γκολ',
        'ɡol',
        LocalizedText(en: 'goal', zh: '进球', ru: 'гол'),
      ),
    ],
  ),
  GreekLetterPair(
    'γγ',
    'ŋɡ / ɡ',
    LocalizedText(
      en: 'Usually inside words; softer before /e, i/.',
      zh: '通常出现在词中，在 /e、i/ 前发音更柔和。',
      ru: 'Обычно внутри слова; смягчается перед /e, i/.',
    ),
    [
      PairExample(
        'pair-gg',
        'αγγούρι',
        'aŋˈɡuri',
        LocalizedText(en: 'cucumber', zh: '黄瓜', ru: 'огурец'),
      ),
    ],
  ),
  GreekLetterPair(
    'τσ',
    'ts',
    LocalizedText(
      en: 'One joined /ts/ sound.',
      zh: '连读为一个 /ts/ 音。',
      ru: 'Слитный звук /ts/, как «ц».',
    ),
    [
      PairExample(
        'pair-ts',
        'τσάι',
        'ˈtsai',
        LocalizedText(en: 'tea', zh: '茶', ru: 'чай'),
      ),
    ],
  ),
  GreekLetterPair(
    'τζ',
    'dz',
    LocalizedText(
      en: 'The voiced partner of /ts/.',
      zh: '与 /ts/ 对应的浊音。',
      ru: 'Звонкая пара к /ts/.',
    ),
    [
      PairExample(
        'pair-tz',
        'τζάμι',
        'ˈdzami',
        LocalizedText(en: 'windowpane', zh: '窗玻璃', ru: 'оконное стекло'),
      ),
    ],
  ),
];
