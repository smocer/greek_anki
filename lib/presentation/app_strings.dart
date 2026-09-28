import 'package:flutter/widgets.dart';

import '../domain/app_language.dart';

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
  String _pick(String en, String ru) => text(LocalizedText(en: en, ru: ru));

  String get headline => _pick('Greek,\nby heart.', 'Греческий\nнаизусть.');
  String get tagline => _pick(
    'A little practice. A lasting memory.',
    'Немного практики — надолго в памяти.',
  );
  String get languageLabel => _pick('Learning language', 'Язык обучения');
  String get languageSaveError => _pick(
    'Could not save the language. Please try again.',
    'Не удалось сохранить язык. Попробуйте ещё раз.',
  );
  String get loadError => _pick(
    'Your progress could not be loaded.',
    'Не удалось загрузить прогресс.',
  );
  String get tryAgain => _pick('Try again', 'Попробовать снова');
  String get yourDeck => _pick('Your deck', 'Ваша колода');
  String get choosePractice => _pick('Choose your practice', 'Выберите режим');
  String get flashcards => _pick('Flashcards', 'Карточки');
  String get flashcardsDescription =>
      _pick('Think, flip, remember.', 'Вспомните, откройте, запомните.');
  String get hardMode => _pick('Hard mode', 'Сложный режим');
  String get hardDescription =>
      _pick('Write the answer in Greek.', 'Напишите ответ по-гречески.');
  String get offlineFooter => _pick(
    'Offline. At your pace. Progress saved.',
    'Без интернета. В своём темпе. Прогресс сохранён.',
  );
  String get browserFooter => _pick(
    'Your progress is saved in this browser.',
    'Ваш прогресс сохраняется в этом браузере.',
  );
  String get updateAvailable =>
      _pick('An update is ready', 'Доступно обновление');
  String get updateNote => _pick(
    'Refresh to get the latest lessons. Your saved progress stays.',
    'Обновите страницу, чтобы получить новые уроки. Сохранённый прогресс останется.',
  );
  String get updateAction => _pick('Refresh app', 'Обновить приложение');
  String get homeScreenTitle => _pick('Add to Home Screen', 'На главный экран');
  String get homeScreenHelp => _pick(
    'iPhone / iPad: open this link in Safari, tap Share, then Add to Home Screen.\n\n'
        'Android: open this link in Chrome, open the ⋮ menu, then Add to Home screen or Install app.\n\n'
        'Use the same browser or home-screen shortcut each time. Progress stays on this device; clearing website data removes it. Progress from the Android app does not transfer automatically.\n\n'
        'An internet connection is needed to open or update the app.',
    'iPhone / iPad: откройте ссылку в Safari, нажмите «Поделиться», затем «На экран Домой».\n\n'
        'Android: откройте ссылку в Chrome, нажмите ⋮, затем «Добавить на главный экран» или «Установить приложение».\n\n'
        'Занимайтесь в одном браузере или через один ярлык. Прогресс хранится на этом устройстве; очистка данных сайта удалит его. Прогресс из Android-приложения автоматически не переносится.\n\n'
        'Для открытия или обновления приложения нужен интернет.',
  );
  String get close => _pick('Close', 'Закрыть');
  String get firstWords => _pick('Current topic', 'Текущая тема');
  String get topics => _pick('Topics', 'Темы');
  String chooseTopic(int count) =>
      _pick('Choose a topic · $count', 'Выбрать тему · $count');
  String topicSummary(int topics, int cards) => _pick(
    '$topics short decks · $cards cards',
    '$topics небольшие колоды · $cards карточек',
  );
  String get searchTopics =>
      _pick('Search topics or words', 'Поиск тем или слов');
  String get noTopics => _pick('No matching topics', 'Подходящих тем нет');
  String get grammarConnection => _pick('How it works', 'Как это устроено');
  String get browse => _pick('Browse', 'Все слова');
  String get caughtUp =>
      _pick('All caught up · Practice again', 'Всё повторили · Заниматься ещё');
  String reviewStatus(int due, int learned, int total) => _pick(
    '$due to review · $learned/$total learned',
    'Повторить: $due · Выучено: $learned/$total',
  );
  String cardCount(int count) => _pick(
    '$count ${count == 1 ? 'card' : 'cards'}',
    '$count ${_russianPlural(count, 'карточка', 'карточки', 'карточек')}',
  );
  String get browseIntro => _pick(
    'Read them once. Then try from memory.',
    'Сначала прочитайте. Затем попробуйте вспомнить.',
  );
  String also(String alternatives) =>
      _pick('Also accepted: $alternatives', 'Также верно: $alternatives');
  String get pronunciationNote => _pick(
    'Pronunciation is approximate. CAPITALS mark stress. DH is “th” in “this”; TH is “th” in “think”. KH is like “ch” in Scottish “loch”; GH is a softer, continuous g. Before front vowels Greek γ approaches y. Use the Greek spelling as your reference.',
    'Транскрипция — приблизительная подсказка, не точная фонетика. ЗАГЛАВНЫЕ — ударение. δ («д») и θ («т») произносятся с языком между зубами: δ звонко, θ глухо. γ («г») — щелевой звук, перед э/и ближе к «й»; χ перед э/и мягче русского «х». Сверяйтесь с греческим написанием.',
  );
  String get answerSaveError => _pick(
    'Could not save this answer. Please try again.',
    'Не удалось сохранить ответ. Попробуйте ещё раз.',
  );
  String get backToDecks => _pick('Back to decks', 'К колодам');
  String get letItSinkIn => _pick('Let it sink in.', 'Запомните ответ.');
  String get howDoYouSay => _pick('How do you say it?', 'Как это по-гречески?');
  String get didYouRemember => _pick(
    'Did you remember the Greek answer?',
    'Удалось вспомнить греческий ответ?',
  );
  String get sayBeforeFlip => _pick(
    'Say it in Greek before you flip.',
    'Скажите по-гречески, прежде чем открыть ответ.',
  );
  String get revealGreekAnswer =>
      _pick('Reveal Greek answer', 'Показать ответ по-гречески');
  String get revealAnswer => _pick('Reveal answer', 'Показать ответ');
  String get again => _pick('Again', 'Ещё раз');
  String get repeatSoon => _pick('Repeat soon', 'Скоро повторим');
  String get gotIt => _pick('Got it', 'Помню');
  String get savingProgress =>
      _pick('Saving your progress…', 'Сохраняем прогресс…');
  String get missedCardsReturn => _pick(
    'Missed cards return until you remember them.',
    'Забытые карточки вернутся, пока вы их не запомните.',
  );
  String get writeInGreek => _pick('Write it in Greek', 'Напишите по-гречески');
  String get answerHint => _pick('Your Greek answer', 'Ответ по-гречески');
  String get saving => _pick('Saving…', 'Сохраняем…');
  String get continueLabel => _pick('Continue', 'Дальше');
  String get inputHelp => _pick(
    'Greek letters · Stress marks required · Punctuation optional',
    'Греческие буквы · Ударения обязательны · Пунктуация необязательна',
  );
  String get phoneKeyboard =>
      _pick('Use phone keyboard', 'Клавиатура телефона');
  String get greekKeyboard =>
      _pick('Use Greek keyboard', 'Греческая клавиатура');
  String get checkAnswer => _pick('Check answer', 'Проверить');
  String get dontKnow => _pick('I don’t know yet', 'Пока не знаю');
  String progress(int completed, int total) =>
      _pick('$completed / $total remembered', '$completed / $total выучено');
  String progressAccessibility(int completed, int total) => _pick(
    'Cards remembered: $completed of $total',
    'Выучено карточек: $completed из $total',
  );
  String get learningDirection =>
      _pick('English → Greek', 'Русский → Греческий');
  String get tapToTurn => _pick('Tap to turn over', 'Нажмите, чтобы открыть');
  String get oneWordCloser =>
      _pick('A little more Greek.', 'Ещё немного греческого.');
  String get exactlyRight => _pick('Exactly right.', 'Всё верно.');
  String get incorrectAnswer => _pick('Incorrect answer', 'Неверный ответ');
  String get youllGetThis => _pick('You’ll get this one.', 'Скоро запомните.');
  String get rememberSpelling =>
      _pick('Keep that spelling in mind.', 'Запомните написание.');
  String get lookClosely => _pick(
    'Look closely. This card will come back.',
    'Посмотрите внимательно. Эта карточка вернётся.',
  );
  String get completionTagline => _pick(
    'A little more Greek, by heart.',
    'Ещё немного греческого наизусть.',
  );
  String wordsRemembered(int count) =>
      _pick('$count cards remembered', 'Выучено карточек: $count');
  String firstTry(int correct, int total) => _pick(
    '$correct of $total on the first try',
    '$correct из $total с первой попытки',
  );
  String extraPractice(int count) => _pick(
    '$count extra ${count == 1 ? 'practice' : 'practices'}',
    'Дополнительных повторов: $count',
  );
  String get completionNote => _pick(
    'Progress saved. Come back tomorrow for a little more practice.',
    'Прогресс сохранён. Возвращайтесь завтра, чтобы ещё немного позаниматься.',
  );
  String get backToMyDeck => _pick('Back to my deck', 'К моей колоде');
  String get practiceAllAgain =>
      _pick('Practice all again', 'Повторить все карточки');
  String get space => _pick('space', 'пробел');
  String get delete => _pick('Delete', 'Удалить');

  String _russianPlural(int count, String one, String few, String many) {
    if (count % 100 >= 11 && count % 100 <= 14) return many;
    return switch (count % 10) {
      1 => one,
      2 || 3 || 4 => few,
      _ => many,
    };
  }
}
