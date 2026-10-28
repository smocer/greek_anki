import 'package:flutter/widgets.dart';

import '../domain/app_language.dart';
import '../domain/curriculum.dart';
import '../domain/vocabulary_category.dart';

extension LocalizedContext on BuildContext {
  AppStrings get strings => AppStrings.of(this);
  String localize(LocalizedText text) => strings.text(text);
}

// The native Localizations widget notifies every screen when the locale changes.
// Keep interface copy here and learning content alongside its deck.
class AppStrings {
  const AppStrings(this.language);
  final AppLanguage language;

  static AppStrings of(BuildContext context) => AppStrings(
    AppLanguage.fromCode(Localizations.localeOf(context).languageCode),
  );

  String text(LocalizedText value) => value.resolve(language);
  String _pick(String en, String ru, String zh) =>
      text(LocalizedText(en: en, ru: ru, zh: zh));

  String get reference => _pick('Reference', 'Справочник', '参考资料');
  String get wordSearch => _pick('Word search', 'Поиск слов', '查找单词');
  String get greekWord => _pick('Greek word', 'Слово по-гречески', '希腊语单词');
  String get wordSearchHint => _pick(
    'Words, phrases and grammar · Full or partial words · Accents optional.',
    'Слова, фразы и грамматика · Слово или его часть · Ударения необязательны.',
    '搜索单词、短语和语法。输入单词或其中一部分；可不输入重音。',
  );
  String get clearSearch => _pick('Clear search', 'Очистить поиск', '清除搜索');
  String get noSearchResults =>
      _pick('No matching words', 'Слова не найдены', '没有匹配的单词');
  String searchResultCount(int count) =>
      _pick('Results: $count', 'Найдено: $count', '结果：$count');
  String get grammarTables =>
      _pick('Grammar tables', 'Грамматические таблицы', '语法表');
  String get practiceGroup => _pick('Practice group', 'Что учим', '练习分组');
  String get filters => _pick('Filters', 'Фильтры', '筛选');
  String get clearFilters => _pick('Clear filters', 'Сбросить', '清除筛选');
  String get applyFilters => _pick('Apply filters', 'Применить', '应用筛选');
  String get themeFilter => _pick('Theme', 'Тема', '主题');
  String get allThemes => _pick('All themes', 'Все темы', '全部主题');
  List<LearningTheme> get orderedThemes {
    final themes = List.of(LearningTheme.values);
    if (language == AppLanguage.chinese) {
      themes.sort((a, b) {
        final length = text(
          a.title,
        ).runes.length.compareTo(text(b.title).runes.length);
        return length == 0 ? a.index.compareTo(b.index) : length;
      });
    }
    return themes;
  }

  String get excludeThemes => _pick('Exclude themes', 'Исключить темы', '排除主题');
  String get excludeThemesHint => _pick(
    'Select one or more themes to leave out',
    'Выберите одну или несколько тем для исключения',
    '可多选，排除属于任一所选主题的词卡',
  );
  String get sessionSize => _pick(
    'Custom count: due cards first · All: every filtered card',
    'Укажите количество: сначала повторение · Все: все карточки фильтра',
    '自定义数量优先复习到期卡片 · 全部：练习当前筛选的所有词卡',
  );
  String get sessionCount =>
      _pick('Cards per session', 'Карточек за раз', '每轮词卡数量');
  String get allCards => _pick('All', 'Все', '全部');
  String get cardOrder => _pick('Card order', 'Порядок карточек', '词卡抽取顺序');
  String cardOrderTitle(CardOrder order) => switch (order) {
    CardOrder.random => _pick('Random', 'Случайный', '随机'),
    CardOrder.alphabet => _pick('Alphabetical', 'По алфавиту', '按字母表'),
    CardOrder.addedTime => _pick('Newest first', 'Сначала новые', '按时间（最新优先）'),
  };
  String get invalidSessionCount => _pick(
    'Enter a positive number',
    'Введите положительное число',
    '请输入大于 0 的整数',
  );
  String get headline =>
      _pick('Greek,\nby heart.', 'Греческий\nнаизусть.', '逆天希腊语的学习之旅');
  String get tagline => _pick(
    'A little practice. A lasting memory.',
    'Немного практики — надолго в памяти.',
    '为了东罗马！！！😡',
  );
  String get languageLabel =>
      _pick('Learning language', 'Язык обучения', '学习语言');
  String get alphabetTitle => _pick('Alphabets', 'Алфавит', '字母表');
  String get grammarTitle => _pick('Grammar', 'Грамматика', '语法');
  String get grammarIntro => _pick(
    'Modern Greek reference · Rules, examples and conjugation tables. Start with είμαι, then explore verbs, noun cases and prepositions.',
    'Справочник современного греческого · Правила, примеры и таблицы. Начните с είμαι, затем изучайте глаголы, падежи и предлоги.',
    '现代希腊语参考 · 规则、例句和变位表。从 είμαι 开始，再学习动词、名词的格和介词。',
  );
  String get grammarTableHint => _pick(
    'Swipe tables sideways to see all forms.',
    'Прокрутите таблицы вбок, чтобы увидеть все формы.',
    '左右滑动表格，查看所有形式。',
  );
  String get listen => _pick('Listen', 'Слушать', '听发音');
  String get playAudio => _pick('Play audio', 'Воспроизвести', '播放发音');
  String get previousCard => _pick('Previous', 'Предыдущая', '上一个');
  String get nextCard => _pick('Next', 'Следующая', '下一个');
  String get reviewCard =>
      _pick('Review previous cards', 'Просмотр карточек', '回看词卡');
  String get reviewHistoryHint => _pick(
    'Reviewing does not change your progress.',
    'Просмотр не изменяет прогресс.',
    '回看不会重复记录学习进度。',
  );
  String get letterPairs => _pick('Letter pairs', 'Сочетания', '字母组合');
  String get letterPairsIntro => _pick(
    'Two letters, a new sound. Listen to the example words. A diaeresis (ϊ, ϋ) separates vowel pairs: αϊ and οϊ are read separately.',
    'Две буквы — новое звучание. Слушайте примеры. Две точки (ϊ, ϋ) разделяют гласные: αϊ и οϊ читаются раздельно.',
    '两个字母，新的发音。请听例词。分音符（ϊ、ϋ）表示元音分开读：αϊ 和 οϊ 需分别发音。',
  );
  String get audioError => _pick(
    'Could not play audio. Please try again.',
    'Не удалось воспроизвести звук. Попробуйте ещё раз.',
    '无法播放音频，请重试。',
  );
  String get pauseStrokes => _pick('Pause', 'Пауза', '暂停');
  String get resumeStrokes => _pick('Continue', 'Продолжить', '继续');
  String get pronunciationHelp =>
      _pick('Pronunciation guide', 'О произношении', '发音指南');
  String get alphabetIntro => _pick(
    '24 letters · Tap a letter to learn how to write it.',
    '24 буквы · Нажмите на букву, чтобы увидеть, как её писать.',
    '24 个字母 · 点按字母学习书写。',
  );
  String get alphabetSound =>
      _pick('Sound in words (IPA)', 'Звук в словах (МФА)', '单词中的发音（国际音标）');
  String get alphabetName => _pick('Letter name', 'Название буквы', '字母名称');
  String get alphabetNotes => _pick(
    'Modern Greek pronunciation. CAPITALS mark stress in the reading guide. '
        'DH = th in “this”; TH = th in “think”; GH is a voiced, continuous sound. '
        'γ, κ and χ become softer before /e/ and /i/. '
        'Letter combinations can change the sound; σ can sound /z/ before voiced consonants. '
        'ς is the form of σ used at the end of a word.',
    'Современное греческое произношение. ЗАГЛАВНЫЕ обозначают ударение в подсказке. '
        'DH = th в английском “this”; TH = th в “think”; GH — звонкий щелевой звук. '
        'γ, κ и χ смягчаются перед /e/ и /i/. '
        'Сочетания букв могут менять звук; σ может звучать как /z/ перед звонкими согласными. '
        'ς — форма σ в конце слова.',
    '现代希腊语发音。发音提示中的大写字母表示重音。DH 类似英语 this 中的 th，TH 类似 think 中的 th，GH 是连续的浊擦音。γ、κ、χ 在 /e/、/i/ 前发音更柔和。字母组合会改变发音；σ 在浊辅音前可读作 /z/。ς 是 σ 的词尾形式。',
  );
  String get strokeOrder => _pick('Stroke order', 'Порядок штрихов', '笔顺');
  String get handwritingNote => _pick(
    'One suggested handwriting style. Follow the numbered starting points and the moving pen. Other handwriting styles are also valid.',
    'Один из вариантов написания. Следуйте номерам начала штрихов и движению пера. Возможны и другие варианты.',
    '这是一种手写方式。请跟随标号起点和笔尖移动练习，其他手写方式也可以。',
  );
  String get uppercase => _pick('Uppercase', 'Заглавная', '大写');
  String get lowercase => _pick('Lowercase', 'Строчная', '小写');
  String get finalSigma => _pick('Final ς', 'Конечная ς', '词尾 ς');
  String get replayStrokes => _pick('Replay', 'Повторить', '重播');
  String get nextStroke => _pick('Next stroke', 'Следующий штрих', '下一笔');
  String strokeProgress(int current, int total) => _pick(
    'Stroke $current / $total',
    'Штрих $current / $total',
    '第 $current / $total 笔',
  );
  String get languageSaveError => _pick(
    'Could not save the language. Please try again.',
    'Не удалось сохранить язык. Попробуйте ещё раз.',
    '无法保存语言设置，请重试。',
  );
  String get loadError => _pick(
    'Your progress could not be loaded.',
    'Не удалось загрузить прогресс.',
    '无法加载学习进度。',
  );
  String get tryAgain => _pick('Try again', 'Попробовать снова', '重试');
  String get yourDeck => _pick('Your deck', 'Ваша колода', '你的卡组');
  String get choosePractice =>
      _pick('Choose your practice', 'Выберите режим', '选择练习方式');
  String get flashcards => _pick('Flashcards', 'Карточки', '词卡');
  String get flashcardsDescription => _pick(
    'Think, flip, remember.',
    'Вспомните, откройте, запомните.',
    '翻来覆去,这还得熬多久~',
  );
  String get hardMode => _pick('Hard mode', 'Сложный режим', '默写模式');
  String get clockDrill => _pick('Clock drill', 'Тренировка часов', '时钟练习');
  String get clockDrillDescription => _pick(
    'Random times · Endless practice',
    'Случайное время · Без ограничений',
    '随机时间 · 无限练习',
  );
  String get clockQuestion =>
      _pick('What time is it?', 'Который час?', '现在几点？');
  String get clockInstructions => _pick(
    'Write the time in Greek, using 1–12. Accents count.',
    'Напишите время по-гречески, используя часы от 1 до 12. Ударения важны.',
    '用希腊语写出时间，小时使用 1–12。重音必须正确。',
  );
  String clockReading(String time) => _pick(
    'Analog clock showing $time',
    'Стрелочные часы показывают $time',
    '指针时钟显示 $time',
  );
  String get nextClock => _pick('Next clock', 'Следующие часы', '下一个时钟');
  String get hardDescription => _pick(
    'Write the answer in Greek.',
    'Напишите ответ по-гречески.',
    '用希腊键盘拼写',
  );
  String get offlineFooter => _pick(
    'Offline. At your pace. Progress saved.',
    'Без интернета. В своём темпе. Прогресс сохранён.',
    '离线学习，自定节奏，自动保存进度。',
  );
  String get browserFooter => _pick(
    'Your progress is saved in this browser.',
    'Ваш прогресс сохраняется в этом браузере.',
    '学习进度保存在此浏览器中。',
  );
  String get updateAvailable =>
      _pick('An update is ready', 'Доступно обновление', '有可用更新');
  String get updateNote => _pick(
    'Refresh to get the latest lessons. Your saved progress stays.',
    'Обновите страницу, чтобы получить новые уроки. Сохранённый прогресс останется.',
    '刷新即可获取最新课程，已保存的进度会保留。',
  );
  String get updateAction =>
      _pick('Refresh app', 'Обновить приложение', '刷新应用');
  String get homeScreenTitle =>
      _pick('Add to Home Screen', 'На главный экран', '添加到主屏幕');
  String get homeScreenHelp => _pick(
    'iPhone / iPad: open this link in Safari, tap Share, then Add to Home Screen.\n\n'
        'Android: open this link in Chrome, open the ⋮ menu, then Add to Home screen or Install app.\n\n'
        'Use the same browser or home-screen shortcut each time. Progress stays on this device; clearing website data removes it. Progress from the Android app does not transfer automatically.\n\n'
        'An internet connection is needed to open or update the app.',
    'iPhone / iPad: откройте ссылку в Safari, нажмите «Поделиться», затем «На экран Домой».\n\n'
        'Android: откройте ссылку в Chrome, нажмите ⋮, затем «Добавить на главный экран» или «Установить приложение».\n\n'
        'Занимайтесь в одном браузере или через один ярлык. Прогресс хранится на этом устройстве; очистка данных сайта удалит его. Прогресс из Android-приложения автоматически не переносится.\n\n'
        'Для открытия или обновления приложения нужен интернет.',
    'iPhone / iPad：在 Safari 中打开链接，点按“分享”，再选择“添加到主屏幕”。\n\nAndroid：在 Chrome 中打开链接，点按 ⋮ 菜单，再选择“添加到主屏幕”或“安装应用”。\n\n请始终使用同一浏览器或主屏幕快捷方式。进度保存在本设备；清除网站数据会删除进度。Android 应用中的进度不会自动转移。\n\n首次打开或更新应用需要联网。',
  );
  String get close => _pick('Close', 'Закрыть', '关闭');
  String get firstWords =>
      _pick('Current category', 'Текущая категория', '当前分类');
  String get chooseCategory =>
      _pick('Choose a category', 'Выбрать категорию', '选择分类');
  String get chooseLabel => _pick('Choose a label', 'Выбрать метку', '选择标签');
  String get chooseTopicLabel =>
      _pick('Choose a topic', 'Выбрать тему', '选择主题');
  String get useCategory =>
      _pick('Use this category', 'Выбрать эту категорию', '使用此分类');
  String get vocabularyPreview =>
      _pick('Vocabulary preview', 'Предпросмотр слов', '词库预览');
  String wordCount(int count) =>
      _pick('$count words', '$count слов', '$count 个词');
  String get additionPeriod => _pick('Added', 'Добавлено', '添加时间');
  String periodTitle(VocabularyPeriod period) => switch (period) {
    VocabularyPeriod.all => _pick('All weeks', 'Все недели', '全部时间'),
    VocabularyPeriod.thisWeek => _pick('This week', 'На этой неделе', '本周'),
    VocabularyPeriod.lastWeek => _pick('Last week', 'На прошлой неделе', '上周'),
    VocabularyPeriod.earlier => _pick('Earlier', 'Ранее', '更早'),
  };
  String get sourceExample => _pick('Source', 'Источник', '来源');
  String wordCategoryHint(int count) => _pick(
    'Words from sentences and vocabulary · Practice uses $count source cards.',
    'Слова из предложений и словаря · Для практики: $count исходных карточек.',
    '来自句子和词库的词语 · 使用 $count 张来源卡片练习。',
  );
  String get searchVocabulary => _pick(
    'Search words or translations',
    'Поиск слов или перевода',
    '搜索词语或释义',
  );
  String get noWords => _pick(
    'No matching words in this category',
    'В этой категории нет подходящих слов',
    '此分类中没有匹配的词语',
  );
  String get latestWeek =>
      _pick('Latest addition week', 'Последняя неделя добавления', '最近添加的一周');
  String get previousWeek => _pick(
    'Previous addition week',
    'Предыдущая неделя добавления',
    '前一次添加的一周',
  );
  String get olderWeeks =>
      _pick('Earlier / undated', 'Ранее / без даты', '更早／无日期');
  String get unknownWeek =>
      _pick('Addition date unknown', 'Дата добавления неизвестна', '添加日期未知');
  String weekOf(String date) => date == '2026-09-28'
      ? _pick(
          'Week of 9.28 and before',
          'Неделя с 28.09 и ранее',
          '9 月 28 日当周及更早',
        )
      : _pick('Week of $date', 'Неделя с $date', '$date 当周');
  String get categoryHint => _pick(
    'Newest additions first · Topic also includes phrases and sentences.',
    'Новые добавления сверху · В темах также есть фразы и предложения.',
    '最新添加的内容在前 · 主题也包含短语和句子。',
  );
  String get topics => _pick('Topics', 'Темы', '主题');
  String chooseTopic(int count) => _pick(
    'Choose a topic · $count',
    'Выбрать тему · $count',
    '选择主题 · $count',
  );
  String topicSummary(int topics, int cards) => _pick(
    '$topics short decks · $cards cards',
    '$topics небольшие колоды · $cards карточек',
    '$topics 个小卡组 · $cards 张卡片',
  );
  String get searchTopics =>
      _pick('Search topics or words', 'Поиск тем или слов', '搜索主题或词语');
  String get noTopics =>
      _pick('No matching topics', 'Подходящих тем нет', '没有匹配的主题');
  String get grammarConnection =>
      _pick('How it works', 'Как это устроено', '用法说明');
  String get browse => _pick('Browse', 'Все слова', '浏览词库');
  String get caughtUp => _pick(
    'All caught up · Practice again',
    'Всё повторили · Заниматься ещё',
    '已完成复习 · 再练一次',
  );
  String reviewStatus(int due, int learned, int total) => _pick(
    '$due to review · $learned/$total learned',
    'Повторить: $due · Выучено: $learned/$total',
    '待复习 $due 张 · 已学 $learned/$total 张',
  );
  String cardCount(int count) => _pick(
    '$count ${count == 1 ? 'card' : 'cards'}',
    '$count ${_russianPlural(count, 'карточка', 'карточки', 'карточек')}',
    '$count 张卡片',
  );
  String get browseIntro => _pick(
    'Read them once. Then try from memory.',
    'Сначала прочитайте. Затем попробуйте вспомнить.',
    '先读一遍，再试着回忆。',
  );
  String also(String alternatives) => _pick(
    'Also accepted: $alternatives',
    'Также верно: $alternatives',
    '也接受：$alternatives',
  );
  String get pronunciationNote => _pick(
    'Pronunciation is approximate. CAPITALS mark stress. DH is “th” in “this”; TH is “th” in “think”. KH is like “ch” in Scottish “loch”; GH is a softer, continuous g. Before front vowels Greek γ approaches y. Use the Greek spelling as your reference.',
    'Транскрипция — приблизительная подсказка, не точная фонетика. ЗАГЛАВНЫЕ — ударение. δ («д») и θ («т») произносятся с языком между зубами: δ звонко, θ глухо. γ («г») — щелевой звук, перед э/и ближе к «й»; χ перед э/и мягче русского «х». Сверяйтесь с греческим написанием.',
    '发音提示仅供参考，大写字母表示重音。DH 类似英语 this 中的 th，TH 类似 think 中的 th。KH 类似苏格兰语 loch 中的 ch；GH 是较柔和、连续的 g 音。γ 在前元音前接近 y 音。请以希腊语拼写和音频为准。',
  );
  String get backToDecks => _pick('Back to decks', 'К колодам', '返回卡组');
  String get sessionSaveError => _pick(
    'Could not save progress. Please retry before leaving.',
    'Не удалось сохранить прогресс. Повторите попытку перед выходом.',
    '无法保存进度，请重试后再退出。',
  );
  String get sessionLoadError => _pick(
    'Could not restore your session. Please try again.',
    'Не удалось восстановить занятие. Попробуйте ещё раз.',
    '无法恢复练习，请重试。',
  );
  String get letItSinkIn =>
      _pick('Let it sink in.', 'Запомните ответ.', '记住这个答案。');
  String get howDoYouSay =>
      _pick('How do you say it?', 'Как это по-гречески?', '用希腊语怎么说？');
  String get didYouRemember => _pick(
    'Did you remember the Greek answer?',
    'Удалось вспомнить греческий ответ?',
    '你记住希腊语答案了吗？',
  );
  String get sayBeforeFlip => _pick(
    'Say it in Greek before you flip.',
    'Скажите по-гречески, прежде чем открыть ответ.',
    '翻面前先用希腊语说出来。',
  );
  String get revealGreekAnswer =>
      _pick('Reveal Greek answer', 'Показать ответ по-гречески', '显示希腊语答案');
  String get revealAnswer => _pick('Reveal answer', 'Показать ответ', '显示答案');
  String get again => _pick('Again', 'Ещё раз', '再来一次');
  String get repeatSoon => _pick('Repeat soon', 'Скоро повторим', '稍后复习');
  String get gotIt => _pick('Got it', 'Помню', '记住了');
  String get savingProgress =>
      _pick('Saving your progress…', 'Сохраняем прогресс…', '正在保存进度…');
  String get missedCardsReturn => _pick(
    'Missed cards return until you remember them.',
    'Забытые карточки вернутся, пока вы их не запомните.',
    '忘记的卡片会再次出现，直到你记住为止。',
  );
  String get writeInGreek =>
      _pick('Write it in Greek', 'Напишите по-гречески', '用希腊语写出来');
  String get answerHint =>
      _pick('Your Greek answer', 'Ответ по-гречески', '你的希腊语答案');
  String get saving => _pick('Saving…', 'Сохраняем…', '正在保存…');
  String get continueLabel => _pick('Continue', 'Дальше', '继续');
  String get inputHelp => _pick(
    'Greek letters · Stress marks required · Punctuation optional',
    'Греческие буквы · Ударения обязательны · Пунктуация необязательна',
    '使用希腊字母 · 必须标重音 · 标点可省略',
  );
  String get phoneKeyboard =>
      _pick('Use phone keyboard', 'Клавиатура телефона', '使用手机键盘');
  String get greekKeyboard =>
      _pick('Use Greek keyboard', 'Греческая клавиатура', '使用希腊语键盘');
  String get checkAnswer => _pick('Check answer', 'Проверить', '检查答案');
  String get dontKnow => _pick('I don’t know yet', 'Пока не знаю', '还不知道');
  String get sessionReview => _pick('Quick review', 'Повторение', '快速复习');
  String progress(int completed, int total) => _pick(
    '$completed / $total remembered',
    '$completed / $total выучено',
    '已记住 $completed / $total 张',
  );
  String progressAccessibility(int completed, int total) => _pick(
    'Cards remembered: $completed of $total',
    'Выучено карточек: $completed из $total',
    '已记住 $completed 张，共 $total 张',
  );
  String get learningDirection =>
      _pick('English → Greek', 'Русский → Греческий', '中文 → 希腊语');
  String get tapToTurn =>
      _pick('Tap to turn over', 'Нажмите, чтобы открыть', '点按翻面');
  String get oneWordCloser =>
      _pick('A little more Greek.', 'Ещё немного греческого.', '又学会了一点希腊语。');
  String get exactlyRight => _pick('Exactly right.', 'Всё верно.', '完全正确。');
  String get incorrectAnswer =>
      _pick('Incorrect answer', 'Неверный ответ', '答案不正确');
  String get youllGetThis =>
      _pick('You’ll get this one.', 'Скоро запомните.', '你会记住的。');
  String get rememberSpelling =>
      _pick('Keep that spelling in mind.', 'Запомните написание.', '记住这个拼写。');
  String get lookClosely => _pick(
    'Look closely. This card will come back.',
    'Посмотрите внимательно. Эта карточка вернётся.',
    '仔细看看，这张卡片会再次出现。',
  );
  String get completionTagline => _pick(
    'A little more Greek, by heart.',
    'Ещё немного греческого наизусть.',
    '又用心记住了一点希腊语。',
  );
  String wordsRemembered(int count) => _pick(
    '$count cards remembered',
    'Выучено карточек: $count',
    '已记住 $count 张卡片',
  );
  String firstTry(int correct, int total) => _pick(
    '$correct of $total on the first try',
    '$correct из $total с первой попытки',
    '首次答对 $correct 张，共 $total 张',
  );
  String extraPractice(int count) => _pick(
    '$count extra ${count == 1 ? 'practice' : 'practices'}',
    'Дополнительных повторов: $count',
    '$count 次额外练习',
  );
  String get completionNote => _pick(
    'Progress saved. Come back tomorrow for a little more practice.',
    'Прогресс сохранён. Возвращайтесь завтра, чтобы ещё немного позаниматься.',
    '进度已保存，明天再来练一练。',
  );
  String get backToMyDeck =>
      _pick('Back to my deck', 'К моей колоде', '返回我的卡组');
  String get nextBatch => _pick('Next batch', 'Следующие карточки', '下一组');
  String get space => _pick('space', 'пробел', '空格');
  String get delete => _pick('Delete', 'Удалить', '删除');

  String _russianPlural(int count, String one, String few, String many) {
    if (count % 100 >= 11 && count % 100 <= 14) return many;
    return switch (count % 10) {
      1 => one,
      2 || 3 || 4 => few,
      _ => many,
    };
  }
}
