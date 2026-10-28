import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/word_search.dart';

import 'support/memory_progress_store.dart';

void main() {
  VocabularyDeck deck(String id) =>
      currentDictionary.learningDecks.singleWhere((deck) => deck.id == id);

  const movedForms = [
    ('oct16-requests', 'ζητάει', 'grammar-verbs-b1'),
    ('languages-it-rains', 'βρέχει', 'grammar-verbs'),
  ];

  test('every verb vocabulary card teaches a first-person singular form', () {
    for (final card in deck('words-verbs').cards) {
      for (final prompt in [card.prompt, ...card.senses]) {
        expect(prompt.en, startsWith('I '), reason: card.id);
      }
      for (final answer in {
        card.greek,
        card.displayedAnswer,
        ...card.alternatives,
        ...card.acceptedAnswers,
        for (final form in card.forms) ...[form.greek, form.answerDisplay],
      }) {
        // Present vocabulary uses -ω (including stressed -ώ) or -μαι,
        // including είμαι. Check every accepted form, not just the display.
        expect(
          GreekText.searchKey(answer),
          matches(RegExp(r'^(?:εγω )?[α-ωϊϋ]+(?:ω|μαι)$')),
          reason: '${card.id}: $answer belongs in grammar practice',
        );
      }
    }
  });

  test('third-person forms are grammar practice and remain searchable', () {
    final search = WordSearch(currentDictionary.collections);
    const matcher = GreekAnswer();
    for (final (id, greek, destination) in movedForms) {
      final locations = currentDictionary.learningDecks.where(
        (deck) => deck.cards.any((card) => card.id == id),
      );
      expect(locations.map((deck) => deck.id), [destination]);
      final card = deck(destination).cards.singleWhere((card) => card.id == id);
      expect(matcher.matches(greek, card), isTrue);
      expect(search.find(greek), contains(card));
    }
    final request = deck(
      'words-verbs',
    ).cards.singleWhere((card) => card.greek == 'ζητάω');
    expect(matcher.matches('ζητώ', request), isTrue);
    expect(matcher.matches('ζητάει', request), isFalse);
    final thirdPerson = deck(
      'grammar-verbs-b1',
    ).cards.singleWhere((card) => card.id == 'oct16-requests');
    expect(matcher.matches('ζητάω', thirdPerson), isFalse);
  });

  test(
    'moving verb forms to grammar preserves saved reviews in both modes',
    () async {
      final store = MemoryProgressStore();
      for (final (id, _, _) in movedForms) {
        for (final mode in StudyMode.values) {
          store.records['words-verbs.${mode.name}.$id'] = ReviewSchedule(
            level: 3,
            dueAt: DateTime.utc(2099),
          );
        }
      }
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(currentDictionary.learningDecks);
      for (final (id, _, destination) in movedForms) {
        final grammar = deck(destination);
        final card = grammar.cards.singleWhere((card) => card.id == id);
        expect(card.addedWeek, '2026-10-12');
        for (final mode in StudyMode.values) {
          final originalKey = 'words-verbs.${mode.name}.$id';
          expect(card.reviewIdentity!.key(mode), originalKey);
          expect(progress.dueCards(grammar, mode), isNot(contains(card)));
          expect(progress.learned(grammar, mode), 1);
          expect(progress.learned(deck('words-verbs'), mode), 0);
          await progress.record(
            deck: grammar,
            mode: mode,
            card: card,
            correct: false,
          );
          expect(store.records[originalKey]!.level, 0);
          expect(
            store.records,
            isNot(contains('$destination.${mode.name}.$id')),
          );
        }
      }
    },
  );
}
