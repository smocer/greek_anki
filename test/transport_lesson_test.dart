import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void main() {
  VocabularyDeck deck(String id) =>
      currentDictionary.learningDecks.singleWhere((d) => d.id == id);
  VocabularyCard card(String collection, String id) =>
      deck(collection).cards.singleWhere((c) => c.id == 'transport-$id');
  const matcher = GreekAnswer();

  test(
    'go exercises accept both taught patterns but keep the right person',
    () {
      for (final (id, short, long, wrong) in [
        ('i', 'πάω', 'πηγαίνω', 'πας'),
        ('you', 'πας', 'πηγαίνεις', 'πάει'),
        ('he', 'πάει', 'πηγαίνει', 'πάω'),
        ('we', 'πάμε', 'πηγαίνουμε', 'πάτε'),
        ('you-plural', 'πάτε', 'πηγαίνετε', 'πάμε'),
        ('they', 'πάνε', 'πηγαίνουν', 'πάει'),
      ]) {
        final entry = card('grammar-verbs', 'go-$id');
        expect(matcher.matches('$short στην δουλειά.', entry), isTrue);
        expect(matcher.matches('$long στη δουλειά.', entry), isTrue);
        expect(matcher.matches('$wrong στην δουλειά.', entry), isFalse);
      }
      expect(
        matcher.matches(
          'Εμείς πηγαίνουμε στην δουλειά.',
          card('grammar-verbs', 'go-we'),
        ),
        isTrue,
      );
      expect(
        matcher.matches(
          'Αυτοί πηγαίνουνε στη δουλειά.',
          card('grammar-verbs', 'go-they'),
        ),
        isTrue,
      );
      expect(
        matcher.matches('παμε στην δουλειά.', card('grammar-verbs', 'go-we')),
        isFalse,
      );
    },
  );

  test('route and timing answers preserve case, number and meaning', () {
    for (final (id, correct, wrong) in [
      ('to-station', 'Πηγαίνω στον σταθμό.', 'Πηγαίνω στον σταθμός.'),
      ('to-market', 'Πάω στη λαϊκή.', 'Πάω στο λαϊκή.'),
      ('on-foot', 'Πάω με τα πόδια.', 'Πάω με το πόδι.'),
      ('by-bus', 'Πάω με το λεωφορείο.', 'Πάω στο λεωφορείο.'),
      (
        'through-centre',
        'Το λεωφορείο περνά από το κέντρο.',
        'Το λεωφορείο περνά στο κέντρο.',
      ),
      (
        'in-fifteen',
        'Φτάνει σε δεκαπέντε λεπτά.',
        'Φτάνει κάθε δεκαπέντε λεπτά.',
      ),
    ]) {
      final entry = card('grammar-location', id);
      expect(matcher.matches(correct, entry), isTrue, reason: id);
      expect(matcher.matches(wrong, entry), isFalse, reason: id);
    }
    for (final answer in ['Είναι οχτώ και δέκα.', 'Οκτώ και δέκα.']) {
      expect(
        matcher.matches(answer, card('phrases-everyday', 'eight-ten')),
        isTrue,
      );
    }
  });

  test(
    'vocabulary flexibility does not weaken spelling or grammar agreement',
    () {
      final trolley = card('words-nouns', 'trolleybus');
      for (final answer in ['τρόλεϊ', 'το τρόλεϊ']) {
        expect(matcher.matches(answer, trolley), isTrue);
      }
      for (final answer in ['τρόλει', 'τρολεϊ', 'ο τρόλεϊ']) {
        expect(matcher.matches(answer, trolley), isFalse);
      }
      final interests = card('words-nouns', 'interests');
      expect(matcher.matches('τα ενδιαφέροντα', interests), isTrue);
      expect(matcher.matches('το ενδιαφέρον', interests), isFalse);
      for (final answer in ['επόμενος', 'επόμενη', 'επόμενο']) {
        expect(
          matcher.matches(answer, card('words-descriptions', 'next')),
          isTrue,
        );
      }
      final nextBus = card('grammar-gender', 'next-bus');
      expect(matcher.matches('Το επόμενο λεωφορείο.', nextBus), isTrue);
      expect(matcher.matches('Ο επόμενος λεωφορείο.', nextBus), isFalse);
      for (final entry
          in currentDictionary.learningDecks
              .where((d) => d.id.startsWith('grammar-'))
              .expand((d) => d.cards)
              .where((c) => c.id.startsWith('transport-'))) {
        for (final prompt in [
          entry.prompt.en,
          entry.prompt.ru,
          entry.prompt.zh,
        ]) {
          expect(prompt, isNot(matches(RegExp(r'[\u0370-\u03ff_]'))));
        }
      }
    },
  );

  test(
    'destination names stay separate and go vocabulary keeps progress',
    () async {
      final nouns = deck('words-nouns');
      final names = deck('words-names');
      for (final name in names.cards.where(
        (c) => c.id.startsWith('transport-'),
      )) {
        expect(nouns.cards.any((c) => c.id == name.id), isFalse);
        expect(name.addedWeek, '2026-10-19');
      }
      final verbs = deck('words-verbs');
      final go = verbs.cards.singleWhere((c) => c.greek == 'πάω');
      expect(matcher.matches('πηγαίνω', go), isTrue);
      expect(go.id, 'languages-go');
      expect(go.addedWeek, '2026-10-12');
      final store = MemoryProgressStore();
      for (final mode in StudyMode.values) {
        store.records['words-verbs.${mode.name}.languages-go'] = ReviewSchedule(
          level: 3,
          dueAt: DateTime.utc(2099),
        );
      }
      final progress = LearningProgress(store);
      addTearDown(progress.dispose);
      await progress.load(currentDictionary.learningDecks);
      for (final mode in StudyMode.values) {
        expect(progress.dueCards(verbs, mode), isNot(contains(go)));
      }
    },
  );
}
