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
  VocabularyCard card(String collection, String id) =>
      deck(collection).cards.singleWhere((card) => card.id == 'likes-$id');
  const matcher = GreekAnswer();

  test('liking agrees with what is liked, not the person who likes it', () {
    for (final (collection, id, correct, wrong) in [
      (
        'grammar-verbs',
        'music-we',
        'Μας αρέσει η μουσική.',
        'Μας αρέσουμε η μουσική.',
      ),
      (
        'grammar-verbs',
        'children-i',
        'Μου αρέσουν τα παιδιά.',
        'Μου αρέσει τα παιδιά.',
      ),
      ('grammar-verbs', 'like-you', 'Μου αρέσεις.', 'Μου αρέσει.'),
      (
        'grammar-nouns',
        'coffee-subject',
        'Μου αρέσει ο καφές.',
        'Μου αρέσει τον καφέ.',
      ),
      (
        'grammar-nouns',
        'prefer-coffee',
        'Προτιμώ τον καφέ.',
        'Προτιμώ ο καφές.',
      ),
      (
        'grammar-questions',
        'children-negative',
        'Δεν μου αρέσουν τα παιδιά.',
        'Δεν εγώ αρέσουν τα παιδιά.',
      ),
    ]) {
      final entry = card(collection, id);
      expect(matcher.matches(correct, entry), isTrue, reason: id);
      expect(matcher.matches(wrong, entry), isFalse, reason: id);
    }
    expect(
      matcher.matches(
        'Του αρέσει η μουσική.',
        card('grammar-verbs', 'music-she'),
      ),
      isFalse,
    );
  });

  test('activity clauses keep person agreement and allow taught variants', () {
    final swimming = card('grammar-verbs', 'swim-we');
    for (final answer in [
      'Μας αρέσει να κολυμπάμε.',
      'Μας αρέσει να κολυμπούμε.',
    ]) {
      expect(matcher.matches(answer, swimming), isTrue);
    }
    for (final answer in [
      'Μας αρέσουν να κολυμπάμε.',
      'Μας αρέσει να κολυμπάω.',
      'Μας αρεσει να κολυμπάμε.',
    ]) {
      expect(matcher.matches(answer, swimming), isFalse);
    }
    final preference = card('grammar-nouns', 'prefer-music');
    for (final answer in ['Προτιμάω την μουσική.', 'Εγώ προτιμώ τη μουσική.']) {
      expect(matcher.matches(answer, preference), isTrue);
    }
    expect(matcher.matches('προτιμάω', card('words-verbs', 'prefer')), isTrue);
    for (final entry
        in currentDictionary.learningDecks
            .where((d) => d.id.startsWith('grammar-'))
            .expand((d) => d.cards)
            .where((c) => c.id.startsWith('likes-'))) {
      for (final prompt in [entry.prompt.en, entry.prompt.ru]) {
        expect(prompt, isNot(matches(RegExp(r'[\u0370-\u03ff_]'))));
      }
    }
  });

  test(
    'frappe variants keep their own articles and names stay out of nouns',
    () {
      final frappe = card('words-nouns', 'frappe');
      for (final answer in ['φραπέ', 'το φραπέ', 'φραπές', 'ο φραπές']) {
        expect(matcher.matches(answer, frappe), isTrue);
      }
      for (final answer in ['η φραπέ', 'το φραπές', 'φραπε']) {
        expect(matcher.matches(answer, frappe), isFalse);
      }
      final newYork = card('words-names', 'new-york');
      expect(matcher.matches('η Νέα Υόρκη', newYork), isTrue);
      expect(deck('words-nouns').cards.any((c) => c.id == newYork.id), isFalse);
      expect(newYork.addedWeek, '2026-10-19');
    },
  );

  test(
    'new indirect-object senses preserve existing pronoun progress',
    () async {
      final pronouns = deck('words-pronouns');
      final store = MemoryProgressStore();
      final saved = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
      for (final (greek, id, sense) in [
        ('σου', 'possessive-your', 'Тебе'),
        ('του', 'possessive-his', 'Ему'),
        ('της', 'possessive-her', 'Ей'),
        ('μας', 'possessive-our', 'Нам'),
        ('σας', 'possessive-your-plural', 'Вам'),
        ('τους', 'possessive-their', 'Им'),
      ]) {
        final word = pronouns.cards.singleWhere((c) => c.greek == greek);
        expect(word.id, id);
        expect(word.senses.map((s) => s.ru), contains(sense));
        expect(word.addedWeek, '2026-10-05');
        for (final mode in StudyMode.values) {
          final key = 'october-lesson.${mode.name}.$id';
          expect(word.reviewIdentity!.key(mode), key);
          store.records[key] = saved;
        }
      }
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(currentDictionary.learningDecks);
      for (final mode in StudyMode.values) {
        expect(progress.learned(pronouns, mode), 6);
      }
    },
  );
}
