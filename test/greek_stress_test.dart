import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';

void main() {
  const matcher = GreekAnswer();
  VocabularyCard card(String deckId, String cardId) => greekDecks
      .firstWhere((deck) => deck.id == deckId)
      .cards
      .firstWhere((card) => card.id == cardId);

  test(
    'rejects absent, misplaced and extra stress on primary and alternative spellings',
    () {
      final seven = card('numbers-0-10', 'number-7');
      for (final answer in ['εφτά', 'επτά', 'ΕΠΤΆ', '  εφτά!  ']) {
        expect(matcher.matches(answer, seven), isTrue, reason: answer);
      }
      for (final answer in [
        'εφτα',
        'επτα',
        'ΕΠΤΑ',
        'έφτα',
        'έπτα',
        'έφτά',
        'επτά\u0301',
      ]) {
        expect(matcher.matches(answer, seven), isFalse, reason: answer);
      }
      final eight = card('numbers-0-10', 'number-8');
      for (final answer in ['οκτώ', 'οχτώ']) {
        expect(matcher.matches(answer, eight), isTrue, reason: answer);
      }
      for (final answer in ['οκτω', 'οχτω', 'όκτω', 'όχτω', 'όκτώ']) {
        expect(matcher.matches(answer, eight), isFalse, reason: answer);
      }
    },
  );

  test(
    'checks every stress mark in a phrase, including the extra possessive accent',
    () {
      final phrase = card('origin', 'i-from-cyprus');
      expect(matcher.matches('Είμαι από την Κύπρο', phrase), isTrue);
      for (final answer in [
        'ειμαι από την Κύπρο',
        'είμαι απο την Κύπρο',
        'είμαι από την Κυπρο',
        'είμαι από την Κυπρό',
      ]) {
        expect(matcher.matches(answer, phrase), isFalse, reason: answer);
      }
      final possession = card('possession', 'my-name');
      expect(matcher.matches('το όνομά μου', possession), isTrue);
      for (final answer in ['το όνομα μου', 'το ονομά μου', 'το όνομά μού']) {
        expect(matcher.matches(answer, possession), isFalse, reason: answer);
      }
      expect(matcher.matches('πού', card('questions', 'where')), isTrue);
      expect(matcher.matches('που', card('questions', 'where')), isFalse);
      expect(matcher.matches('τι', card('questions', 'what')), isTrue);
      expect(matcher.matches('τί', card('questions', 'what')), isFalse);
    },
  );

  test(
    'accepts equivalent Unicode tonos encodings without losing stress or diaeresis',
    () {
      final seven = card('numbers-0-10', 'number-7');
      for (final answer in ['επτα\u0301', 'επτα\u0341', 'επτά']) {
        expect(matcher.matches(answer, seven), isTrue, reason: answer);
      }
      expect(matcher.matches('ε\u0301πτα', seven), isFalse);
      for (final (composed, decomposed) in [
        ('ά', 'α\u0301'),
        ('έ', 'ε\u0301'),
        ('ή', 'η\u0301'),
        ('ί', 'ι\u0301'),
        ('ό', 'ο\u0301'),
        ('ύ', 'υ\u0301'),
        ('ώ', 'ω\u0301'),
        ('ΐ', 'ι\u0308\u0301'),
        ('ΰ', 'υ\u0308\u0301'),
      ]) {
        expect(GreekText.answerKey(composed), GreekText.answerKey(decomposed));
        expect(
          GreekText.answerKey(composed),
          isNot(GreekText.answerKey(decomposed.replaceAll('\u0301', ''))),
        );
      }
      expect(GreekText.answerKey('Μαΐου'), isNot(GreekText.answerKey('Μαίου')));
    },
  );

  test('search stays stress insensitive while hard-mode grading is strict', () {
    expect(GreekText.searchKey('ΕΠΤΆ'), GreekText.searchKey('επτα'));
    expect(GreekText.searchKey('Ρωσία'), GreekText.searchKey('ρωσια'));
    expect(GreekText.answerKey('επτά'), isNot(GreekText.answerKey('επτα')));
  });

  test('a missing stress fails and repeats until corrected in hard mode', () {
    final session = StudySession(
      cards: [card('numbers-0-10', 'number-7')],
      mode: StudyMode.typing,
    );
    session.checkAnswer('επτα');
    expect(session.typedCorrect, isFalse);
    session.advance(correct: session.typedCorrect!);
    expect(session.isComplete, isFalse);
    expect(session.completed, 0);
    session.checkAnswer('επτά');
    expect(session.typedCorrect, isTrue);
    session.advance(correct: session.typedCorrect!);
    expect(session.isComplete, isTrue);
    expect(session.firstTryCorrect, 0);
    session.dispose();
  });
}
