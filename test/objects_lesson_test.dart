import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void main() {
  VocabularyDeck deck(String id) =>
      currentDictionary.learningDecks.singleWhere((deck) => deck.id == id);
  VocabularyCard card(String deckId, String id) =>
      deck(deckId).cards.singleWhere((card) => card.id == 'objects-$id');
  const matcher = GreekAnswer();

  test('objects require accusative forms and the intended pronoun', () {
    for (final (id, correct, wrong) in [
      ('station-object', 'Ψάχνω τον σταθμό.', 'Ψάχνω ο σταθμός.'),
      ('bank-object', 'Βλέπεις την τράπεζα;', 'Βλέπεις η τράπεζα;'),
      ('know-him-positive', 'Ναι, τον ξέρω.', 'Ναι, του ξέρω.'),
      ('know-her-positive', 'Ναι, την ξέρω.', 'Ναι, της ξέρω.'),
      ('know-it-negative', 'Όχι, δεν το ξέρω.', 'Όχι, δεν τον ξέρω.'),
    ]) {
      final entry = card('grammar-nouns', id);
      expect(matcher.matches(correct, entry), isTrue);
      expect(matcher.matches(wrong, entry), isFalse);
    }
    expect(
      matcher.matches(
        'Ναι, τη ξέρω.',
        card('grammar-nouns', 'know-her-positive'),
      ),
      isTrue,
    );
    final whom = card('words-pronouns', 'whom');
    expect(matcher.matches('ποιον;', whom), isTrue);
    expect(matcher.matches('ποιόν', whom), isFalse);
    expect(matcher.matches('ποιος', whom), isFalse);
    final question = card('grammar-questions', 'whom-call');
    expect(matcher.matches('Ποιος φωνάζει;', question), isFalse);
    expect(matcher.matches('Ποιον φωνάζεις;', question), isTrue);
  });

  test('gender variants and articles stay flexible only in vocabulary', () {
    final adjective = card('words-descriptions', 'difficult');
    for (final answer in ['δύσκολος', 'δύσκολη', 'δύσκολο']) {
      expect(matcher.matches(answer, adjective), isTrue);
    }
    expect(matcher.matches('δυσκολο', adjective), isFalse);
    final lesson = card('grammar-nouns', 'lesson-subject');
    expect(matcher.matches('Το μάθημα είναι δύσκολο.', lesson), isTrue);
    expect(matcher.matches('Το μάθημα είναι δύσκολος.', lesson), isFalse);
    final full = card('words-descriptions', 'full');
    expect(matcher.matches('πλήρης', full), isTrue);
    expect(matcher.matches('πλήρες', full), isTrue);
    expect(
      matcher.matches('Πλήρης ωράριο.', card('phrases-everyday', 'full-time')),
      isFalse,
    );
    final station = card('words-nouns', 'station');
    expect(matcher.matches('σταθμός', station), isTrue);
    expect(matcher.matches('ο σταθμός', station), isTrue);
    expect(matcher.matches('η σταθμός', station), isFalse);
  });

  test(
    'when clauses accept verb variants without confusing question words',
    () {
      final question = card('grammar-questions', 'when-eat');
      final statement = card('grammar-questions', 'eat-when-hungry');
      expect(matcher.matches('Πότε τρως;', question), isTrue);
      expect(matcher.matches('Όταν τρως;', question), isFalse);
      for (final answer in [
        'Τρώω όταν πεινάω.',
        'Τρώω όταν πεινώ.',
        'Όταν πεινάω, τρώω.',
      ]) {
        expect(matcher.matches(answer, statement), isTrue);
      }
      for (final answer in [
        'Τρώω πότε πεινάω.',
        'Τρώω όταν πίνω.',
        'Τρωω όταν πεινάω.',
      ]) {
        expect(matcher.matches(answer, statement), isFalse);
      }
      for (final group in currentDictionary.learningDecks) {
        for (final entry in group.cards.where(
          (c) => c.id.startsWith('objects-'),
        )) {
          expect(entry.prompt.en, isNot(matches(RegExp(r'[Α-Ωα-ωάέήίόύώ_]'))));
          expect(entry.prompt.ru, isNot(matches(RegExp(r'[Α-Ωα-ωάέήίόύώ_]'))));
        }
      }
    },
  );

  test(
    'new senses merge into known words without resetting review history',
    () async {
      final pronouns = deck('words-pronouns');
      final verbs = deck('words-verbs');
      final us = pronouns.cards.singleWhere((c) => c.greek == 'μας');
      final seek = verbs.cards.singleWhere((c) => c.greek == 'ζητάω');
      expect(
        us.senses.map((s) => s.ru),
        containsAll(['Наш', 'Нас (прямое дополнение)']),
      );
      expect(us.aliases, contains('objects-us-object'));
      expect(us.addedWeek, '2026-10-05');
      expect(seek.aliases, contains('objects-seek-staff'));
      expect(
        seek.senses.map((s) => s.ru),
        contains('Ищу (например, сотрудника)'),
      );
      expect(matcher.matches('ζητώ', seek), isTrue);

      final store = MemoryProgressStore();
      final saved = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
      for (final mode in StudyMode.values) {
        store.records['october-lesson.${mode.name}.possessive-our'] = saved;
        store.records['words-verbs.${mode.name}.languages-request'] = saved;
      }
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(currentDictionary.learningDecks);
      for (final mode in StudyMode.values) {
        expect(progress.learned(pronouns, mode), 1);
        expect(progress.learned(verbs, mode), 1);
        expect(progress.dueCards(pronouns, mode), isNot(contains(us)));
        expect(progress.dueCards(verbs, mode), isNot(contains(seek)));
      }
    },
  );
}
