import 'decks/transport_streets.dart';
import 'decks/shops_services.dart';
import 'decks/culture_dining.dart';
import 'decks/nature_geography.dart';
import 'decks/noun_gender.dart';
import 'decks/seeing_objects.dart';
import 'decks/lesson_connectors.dart';
import 'decks/diminutives.dart';
import 'decks/pets_home.dart';
import 'decks/small_talk_replies.dart';
import 'decks/more_greetings.dart';
import 'decks/everyday_places.dart';
import 'decks/here_there_negation.dart';
import 'decks/phone_conversations.dart';
import 'decks/neighbours.dart';
import 'decks/addresses_nearby.dart';
import 'decks/living_places.dart';
import 'decks/numbers_compound.dart';
import '../domain/vocabulary.dart';
import 'deck_composition.dart';
import 'vocabulary_metadata.dart';
import 'decks/verb_topics.dart';
import 'decks/buy_present.dart';
import 'decks/pay_present.dart';
import 'decks/work_present.dart';
import 'decks/finish_present.dart';
import 'decks/understand_present.dart';
import 'decks/know_present.dart';
import 'decks/study_present.dart';
import 'decks/learn_present.dart';
import 'decks/close_present.dart';
import 'decks/open_present.dart';
import 'decks/write_present.dart';
import 'decks/read_present.dart';
import 'decks/have_present.dart';
import 'decks/wait_present.dart';
import 'decks/want_present.dart';
import 'decks/live_present.dart';
import 'decks/numbers_0_10.dart';
import 'decks/numbers_11_100.dart';
import 'decks/greetings.dart';
import 'decks/how_are_you.dart';
import 'decks/introductions.dart';
import 'decks/subject_pronouns.dart';
import 'decks/be_present.dart';
import 'decks/called_present.dart';
import 'decks/countries.dart';
import 'decks/origin.dart';
import 'decks/articles_cases.dart';
import 'decks/possession.dart';
import 'decks/names_vocative.dart';
import 'decks/forms_of_address.dart';
import 'decks/classroom_objects.dart';
import 'decks/classroom_phrases.dart';
import 'decks/questions.dart';
import 'decks/small_words.dart';
import 'decks/do_present.dart';
import 'decks/drink_present.dart';
import 'decks/start_present.dart';
import 'decks/sing_present.dart';
import 'decks/location.dart';

// Grouping changes do not change the review identity of an existing card.
final authoredGreekDecks = List<VocabularyDeck>.unmodifiable([
  numbers0To10Deck,
  numbers11To100Deck,
  greetingsDeck,
  howAreYouDeck,
  withExtraCards(introductionsDeck, [
    ...cardsFrom(writePresentDeck, ids: const ['write-name']),
  ]),
  subjectPronounsDeck,
  bePresentDeck,
  calledPresentDeck,
  countriesDeck,
  originDeck,
  articlesCasesDeck,
  nounGenderDeck,
  seeingObjectsDeck,
  possessionDeck,
  namesVocativeDeck,
  formsOfAddressDeck,
  withExtraCards(classroomObjectsDeck, [
    ...cardsFrom(doPresentDeck, ids: const ['i-exercise']),
    ...cardsFrom(closePresentDeck, ids: const ['close-book']),
    ...cardsFrom(openPresentDeck, ids: const ['open-books']),
    ...cardsFrom(readPresentDeck, ids: const ['read-my-book', 'read-page']),
    ...cardsFrom(wantPresentDeck, ids: const ['want-book']),
    ...cardsFrom(buyPresentDeck, ids: const ['buy-books']),
  ]),
  withExtraCards(classroomPhrasesDeck, [
    ...cardsFrom(knowPresentDeck, ids: const ['know-english', 'not-know-say']),
    ...cardsFrom(
      learnPresentDeck,
      ids: const ['learn-greek', 'learning-question'],
    ),
    ...cardsFrom(
      understandPresentDeck,
      ids: const ['understand-say', 'we-not-understand'],
    ),
  ]),
  withExtraCards(questionsDeck, [
    ...cardsFrom(doPresentDeck, ids: const ['you-do-what']),
    ...cardsFrom(drinkPresentDeck, ids: const ['you-drink-what']),
    ...cardsFrom(waitPresentDeck, ids: const ['wait-what']),
    ...cardsFrom(workPresentDeck, ids: const ['where-work']),
    ...cardsFrom(wantPresentDeck, ids: const ['children-want']),
  ]),
  withExtraCards(smallWordsDeck, [
    ...cardsFrom(
      finishPresentDeck,
      ids: const ['they-finish-lesson', 'lesson-finishes'],
    ),
    ...cardsFrom(
      startPresentDeck,
      ids: const ['we-start-now', 'lesson-starts', 'lesson-always-nine'],
    ),
  ]),
  basicVerbsDeck,
  presentConjugationDeck,
  singPresentDeck,
  locationDeck,
  numbersCompoundDeck,
  withExtraCards(livingPlacesDeck, [
    ...cardsFrom(livePresentDeck, ids: const ['ask-live', 'we-here']),
  ]),
  addressesNearbyDeck,
  neighboursDeck,
  withExtraCards(phoneConversationsDeck, [
    ...cardsFrom(havePresentDeck, ids: const ['have-phone', 'not-phone-yet']),
    ...cardsFrom(writePresentDeck, ids: const ['write-mum']),
  ]),
  hereThereNegationDeck,
  transportStreetsDeck,
  shopsServicesDeck,
  cultureDiningDeck,
  natureGeographyDeck,
  withExtraCards(everydayPlacesDeck, [
    ...cardsFrom(closePresentDeck, ids: const ['bank-closes']),
    ...cardsFrom(openPresentDeck, ids: const ['bank-opens']),
    ...cardsFrom(
      studyPresentDeck,
      ids: const ['kostas-university', 'at-university'],
    ),
    ...cardsFrom(workPresentDeck, ids: const ['work-bank']),
    ...cardsFrom(buyPresentDeck, ids: const ['buy-supermarket']),
    ...cardsFrom(payPresentDeck, ids: const ['pay-now', 'pay-bill']),
  ]),
  moreGreetingsDeck,
  withExtraCards(smallTalkRepliesDeck, [
    ...cardsFrom(waitPresentDeck, ids: const ['wait-maria']),
  ]),
  withExtraCards(petsHomeDeck, [
    ...cardsFrom(drinkPresentDeck, ids: const ['i-water']),
  ]),
  diminutivesDeck,
  lessonConnectorsDeck,
]);

final greekDecks = List<VocabularyDeck>.unmodifiable(
  authoredGreekDecks.map(withVocabularyMetadata),
);
