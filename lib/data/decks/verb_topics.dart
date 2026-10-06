import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';
import '../deck_composition.dart';
import 'do_present.dart';
import 'drink_present.dart';
import 'start_present.dart';
import 'live_present.dart';
import 'want_present.dart';
import 'wait_present.dart';
import 'have_present.dart';
import 'read_present.dart';
import 'write_present.dart';
import 'open_present.dart';
import 'close_present.dart';
import 'learn_present.dart';
import 'study_present.dart';
import 'know_present.dart';
import 'understand_present.dart';
import 'finish_present.dart';
import 'work_present.dart';
import 'pay_present.dart';
import 'buy_present.dart';
import 'see_present.dart';

const everydayVerbSources = [
  doPresentDeck,
  drinkPresentDeck,
  startPresentDeck,
  livePresentDeck,
  wantPresentDeck,
  waitPresentDeck,
  havePresentDeck,
  readPresentDeck,
  writePresentDeck,
  openPresentDeck,
  closePresentDeck,
  learnPresentDeck,
  studyPresentDeck,
  knowPresentDeck,
  understandPresentDeck,
  finishPresentDeck,
  workPresentDeck,
  payPresentDeck,
  buyPresentDeck,
  seePresentDeck,
];

final basicVerbsDeck = VocabularyDeck(
  id: 'basic-verbs',
  title: const LocalizedText(en: 'Everyday verbs', ru: 'Основные глаголы'),
  subtitle: const LocalizedText(
    en: 'The “I” form: one card per verb',
    ru: 'Форма «я»: одна карточка на глагол',
  ),
  cover: 'κάνω · έχω',
  note: const LocalizedText(
    en: 'Learn each verb in the first-person singular: κάνω means I do, έχω means I have. The separate conjugation drill practices six persons with μένω, διαβάζω, and καταλαβαίνω. Είμαι, λέγομαι, and τραγουδώ have their own grammar topics.',
    ru: 'Учим глаголы в первом лице единственного числа: κάνω — «я делаю», έχω — «у меня есть». Это формы «я», а не русские инфинитивы «делать» и «иметь». В отдельной тренировке спряжения — все шесть форм μένω, διαβάζω и καταλαβαίνω. Для είμαι, λέγομαι и τραγουδώ есть отдельные грамматические темы.',
  ),
  cards: List.unmodifiable([
    for (final source in everydayVerbSources)
      ...cardsFrom(source, ids: const ['i']),
  ]),
);

const conjugationSources = [
  livePresentDeck,
  readPresentDeck,
  understandPresentDeck,
];
const conjugationPersonIds = ['i', 'you', 'he', 'we', 'you-plural', 'they'];

final presentConjugationDeck = VocabularyDeck(
  id: 'present-conjugation',
  title: const LocalizedText(
    en: 'Verb endings: six persons',
    ru: 'Спряжение: шесть форм',
  ),
  subtitle: const LocalizedText(
    en: 'μένω · διαβάζω · καταλαβαίνω',
    ru: 'μένω · διαβάζω · καταλαβαίνω',
  ),
  cover: '-ω → -ουμε',
  note: const LocalizedText(
    en: 'Three verbs, from short to long: μένω (I live), διαβάζω (I read), καταλαβαίνω (I understand). Practice I, you, he/she/it, we, you, they. The present endings are -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Subject pronouns are optional; polite you uses the plural form. Learn the stress with each word.',
    ru: 'Три глагола от короткого к длинному: μένω (я живу), διαβάζω (я читаю), καταλαβαίνω (я понимаю). Тренируем я, ты, он/она/оно, мы, вы/Вы, они. Как в русском «живу — живёшь — живём», лицо видно по окончанию: -ω, -εις, -ει, -ουμε, -ετε, -ουν(ε). Местоимение можно опустить; вежливое Вы совпадает с множественным числом. Ударение запоминаем вместе со словом.',
  ),
  cards: List.unmodifiable([
    for (final source in conjugationSources)
      ...cardsFrom(source, ids: conjugationPersonIds),
  ]),
);
