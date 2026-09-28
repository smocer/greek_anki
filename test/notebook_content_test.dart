import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void main() {
  const matcher = GreekAnswer();
  VocabularyDeck deck(String id) =>
      greekDecks.firstWhere((deck) => deck.id == id);
  VocabularyCard card(String deckId, String cardId) =>
      deck(deckId).cards.firstWhere((card) => card.id == cardId);

  test('small bilingual topics have stable unique IDs and usable answers', () {
    expect(greekDecks.map((d) => d.id).toSet().length, greekDecks.length);
    for (final deck in greekDecks) {
      expect(deck.cards.length, inInclusiveRange(6, 15), reason: deck.id);
      expect(
        deck.cards.map((c) => c.id).toSet().length,
        deck.cards.length,
        reason: deck.id,
      );
      for (final c in deck.cards) {
        for (final text in [
          c.prompt.en,
          c.prompt.ru,
          c.meaning.en,
          c.meaning.ru,
          c.pronunciation.en,
          c.pronunciation.ru,
        ]) {
          expect(text.trim(), isNotEmpty, reason: '${deck.id}/${c.id}');
        }
        if (deck.id != 'numbers-0-10') {
          expect(c.explanation?.en, isNotEmpty, reason: '${deck.id}/${c.id}');
          expect(
            c.explanation?.ru,
            matches(RegExp('[А-Яа-яёЁ]')),
            reason: c.id,
          );
        }
        for (final answer in [
          c.greek,
          ...c.alternatives,
          ...c.acceptedAnswers,
        ]) {
          expect(answer, matches(RegExp('[Α-Ωα-ωάέήίόύώ]')), reason: c.id);
          expect(
            answer,
            isNot(matches(RegExp('[A-Za-zА-Яа-яЁё]'))),
            reason: c.id,
          );
          expect(
            matcher.matches(GreekText.answerKey(answer).toUpperCase(), c),
            isTrue,
            reason: c.id,
          );
        }
      }
    }
  });

  test('all notebook topics and distinctive expressions are represented', () {
    final answers = greekDecks
        .expand((d) => d.cards)
        .expand((c) => [c.greek, ...c.alternatives])
        .map(GreekText.answerKey)
        .toSet();
    for (final greek in [
      'έντεκα',
      'ένδεκα',
      'δώδεκα',
      'δεκατρία',
      'δεκατέσσερα',
      'γιατί',
      'τραγουδώ',
      'τι',
      'πίνω',
      'λέγομαι',
      'το παράδειγμα',
      'Τι κάνεις;',
      'Τι κάνετε;',
      'καλά',
      'πολύ καλά',
      'μια χαρά',
      'Πώς είσαι;',
      'Πώς είστε;',
      'ο αριθμός',
      'ο Γιώργος',
      'Γιώργο!',
      'ο Πέτρος',
      'Πέτρο!',
      'ο Γιάννης',
      'Γιάννη!',
      'ο Κωνσταντίνος',
      'Κωνσταντίνε!',
      'ο Αλέξανδρος',
      'Αλέξανδρε!',
      'ο κύριος',
      'κύριε',
      'ο φίλος',
      'φίλε',
      'κυρία',
      'είμαι',
      'είσαι',
      'είναι',
      'είμαστε',
      'είστε',
      'ποιος',
      'ποια',
      'και',
      'εδώ',
      'έλα',
      'εγώ',
      'εσύ',
      'εσείς',
      'το βιβλίο μου',
      'το βιβλίο σας',
      'Πώς σε λένε;',
      'Με λένε Γιώργο.',
      'Με λένε Μαρία.',
      'Εσένα;',
      'Είμαι ο Γιώργος.',
      'Είμαι η Μαρία.',
      'Από πού είσαι;',
      'Είμαι από τη Ρωσία.',
      'Είμαι από το Ιράκ.',
      'επίσης',
      'το διάλειμμα',
      'αρχίζω',
      'πάμε',
      'το βιβλίο',
      'η σελίδα',
      'η άσκηση',
      'παιδιά',
      'Τι σημαίνει;',
      'Τα λέμε αύριο!',
    ]) {
      expect(answers, contains(GreekText.answerKey(greek)), reason: greek);
    }
  });

  test(
    'phrases allow punctuation omission but preserve stress and grammar',
    () {
      final origin = card('origin', 'i-from-russia');
      for (final text in [
        'είμαι από τη Ρωσία',
        'ΕΊΜΑΙ   ΑΠΌ ΤΗΝ ΡΩΣΊΑ!',
        'εγώ είμαι από τη Ρωσία.',
      ]) {
        expect(matcher.matches(text, origin), isTrue);
      }
      for (final text in [
        'είσαι από τη Ρωσία',
        'είμαι από η Ρωσία',
        'είμαι από το Ρωσία',
        'είμαι από Ρωσία',
        'eimai apo ti rosia',
        'είμαιαπότηρωσία',
      ]) {
        expect(matcher.matches(text, origin), isFalse, reason: text);
      }
      final name = card('introductions', 'ask-name');
      for (final text in ['Πώς σε λένε', 'ΠΏΣ ΣΕ ΛΈΝΕ?', 'Πώς σε λένε\u037e']) {
        expect(matcher.matches(text, name), isTrue);
      }
      expect(matcher.matches('πώς σας λένε', name), isFalse);
      expect(
        matcher.matches('καλά ευχαριστώ', card('how-are-you', 'fine-thanks')),
        isTrue,
      );
      expect(
        matcher.matches('ο Γιώργος', card('names-vocative', 'george-call')),
        isFalse,
      );
      expect(
        matcher.matches('τον φίλο', card('articles-cases', 'friend-gen')),
        isFalse,
      );
      expect(
        matcher.matches('του φίλου', card('articles-cases', 'friend-gen')),
        isTrue,
      );
    },
  );

  test(
    'six-person drills cover each studied verb, including genuine variants',
    () {
      for (final id in [
        'be-present',
        'called-present',
        'do-present',
        'drink-present',
        'start-present',
        'sing-present',
      ]) {
        expect(deck(id).cards.take(6).length, 6);
      }
      expect(matcher.matches('τραγουδάω', card('sing-present', 'i')), isTrue);
      expect(matcher.matches('τραγουδάμε', card('sing-present', 'we')), isTrue);
      expect(
        matcher.matches('εγώ τραγουδάω', card('sing-present', 'i')),
        isTrue,
      );
      expect(matcher.matches('τραγουδάς', card('sing-present', 'i')), isFalse);
      expect(card('numbers-11-20', 'number-17').greek, 'δεκαεφτά');
      expect(
        matcher.matches('δεκαεπτά', card('numbers-11-20', 'number-17')),
        isTrue,
      );
    },
  );

  test(
    'v1 number progress loads with new topics; modes and topics stay independent',
    () async {
      final old = ReviewSchedule(level: 2, dueAt: DateTime.utc(2099));
      final store = MemoryProgressStore()
        ..records['numbers-0-10.flashcards.number-7'] = old;
      final progress = LearningProgress(store);
      await progress.load(greekDecks);
      expect(progress.learned(deck('numbers-0-10'), StudyMode.flashcards), 1);
      expect(progress.learned(deck('numbers-0-10'), StudyMode.typing), 0);
      expect(
        progress.dueCards(deck('origin'), StudyMode.typing).length,
        deck('origin').cards.length,
      );
      await progress.record(
        deck: deck('origin'),
        mode: StudyMode.typing,
        card: card('origin', 'from-russia'),
        correct: true,
      );
      expect(progress.learned(deck('origin'), StudyMode.typing), 1);
      expect(progress.learned(deck('origin'), StudyMode.flashcards), 0);
      expect(progress.learned(deck('countries'), StudyMode.typing), 0);
      expect(store.records['numbers-0-10.flashcards.number-7'], same(old));
    },
  );

  test('each new deck can complete as a typed session', () {
    for (final deck in greekDecks) {
      final session = StudySession(cards: deck.cards, mode: StudyMode.typing);
      while (!session.isComplete) {
        session.checkAnswer(GreekText.answerKey(session.current.greek));
        expect(session.typedCorrect, isTrue, reason: deck.id);
        session.advance(correct: true);
      }
      expect(session.firstTryCorrect, deck.cards.length);
      session.dispose();
    }
  });
}
