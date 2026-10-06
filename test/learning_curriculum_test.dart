import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/learning_curriculum.dart';
import 'package:greek_anki/data/october_lesson.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';
import 'support/memory_progress_store.dart';

void main() {
  VocabularyDeck deck(String id) =>
      learningDecks.singleWhere((d) => d.id == id);
  const matcher = GreekAnswer();

  test('three sections have a small, complete set of collections', () {
    expect(
      LearningSection.values.map(
        (section) =>
            learningCollections.where((c) => c.section == section).length,
      ),
      [6, 3, 6],
    );
    for (final collection in learningCollections) {
      final cards = collection.deck.cards;
      expect(cards, isNotEmpty);
      expect(cards.map((c) => c.id).toSet().length, cards.length);
      expect(
        cards
            .map((c) => c.reviewIdentity!.key(StudyMode.typing))
            .toSet()
            .length,
        cards.length,
      );
      for (final card in cards) {
        expect(matcher.matches(card.greek, card), isTrue, reason: card.id);
        expect(card.addedWeek, isNotNull, reason: card.id);
        expect(card.prompt.en.trim(), isNotEmpty);
        expect(card.prompt.ru.trim(), isNotEmpty);
      }
    }
  });

  test(
    'nouns test base forms and show their gender without requiring an article',
    () {
      final nouns = deck('words-nouns').cards;
      final book = nouns.singleWhere((c) => c.greek == 'βιβλίο');
      expect(book.displayedAnswer, 'το βιβλίο');
      for (final answer in ['βιβλίο', 'το βιβλίο']) {
        expect(matcher.matches(answer, book), isTrue);
      }
      for (final answer in ['βιβλιο', 'βίβλιο', 'βιβλίου', 'η βιβλίο']) {
        expect(matcher.matches(answer, book), isFalse);
      }
      expect(nouns.map((c) => c.greek).toSet().length, nouns.length);
      expect(
        nouns.any((c) => c.prompt.en.contains('Add the article')),
        isFalse,
      );
      expect(nouns.any((c) => c.greek == 'φίλο'), isFalse);
      final beer = nouns.singleWhere((c) => c.greek == 'μπίρα');
      expect(matcher.matches('μπύρα', beer), isTrue);
      expect(matcher.matches('η μπύρα', beer), isTrue);
    },
  );

  test(
    'all fourteen words and possessive pronouns are independently learnable',
    () {
      final words = learningCollections
          .where((c) => c.section == LearningSection.words)
          .expand((c) => c.deck.cards)
          .toList();
      for (final greek in [
        'δουλειά',
        'γραφείο',
        'μητέρα',
        'τραγούδι',
        'μπίρα',
        'καφές',
        'κινητό',
        'σταθερό',
        'νούμερο',
        'λείπω',
        'λάθος',
        'σωστό',
        'ξανά',
        'μόνο',
      ]) {
        final card = words.singleWhere((c) => c.greek == greek);
        expect(card.addedWeek, octoberWeek);
      }
      final pronouns = deck('words-pronouns').cards;
      for (final greek in ['μου', 'σου', 'του', 'της', 'μας', 'σας', 'τους']) {
        expect(
          pronouns.any(
            (c) => c.greek == greek && c.id.startsWith('possessive-'),
          ),
          isTrue,
        );
        expect(
          deck(
            'grammar-possession',
          ).cards.any((c) => c.greek.contains(' $greek')),
          isTrue,
        );
      }
      expect(
        pronouns
            .where((c) => c.greek == 'μου')
            .map((c) => c.prompt.en)
            .toSet()
            .length,
        2,
      );
      for (final greek in ['αυτός', 'αυτή', 'αυτό']) {
        expect(
          pronouns.where((c) => c.greek == greek).length,
          2,
          reason: 'Personal and demonstrative meanings are both learnable.',
        );
      }
      expect(
        deck('words-verbs').cards.map((c) => c.greek),
        containsAll(['είμαι', 'λέγομαι', 'τραγουδώ', 'λείπω', 'μένω']),
      );
      expect(
        deck('words-verbs').cards.any((c) => c.greek == 'μένεις'),
        isFalse,
      );
    },
  );

  test(
    'grammar prompts contain no Greek hints or blanks in either language',
    () {
      final greek = RegExp(r'[\u0370-\u03FF\u1F00-\u1FFF]');
      for (final group in learningCollections.where(
        (c) => c.section == LearningSection.grammar,
      )) {
        for (final card in group.deck.cards) {
          for (final text in [
            card.prompt.en,
            card.prompt.ru,
            card.meaning.en,
            card.meaning.ru,
          ]) {
            expect(
              greek.hasMatch(text),
              isFalse,
              reason: '${group.deck.id}/${card.id}: $text',
            );
            expect(text.contains('___'), isFalse);
          }
        }
      }
      final possessive = deck(
        'grammar-possession',
      ).cards.singleWhere((c) => c.id == 'possession-her-bag');
      expect(possessive.prompt.ru, 'Это её сумка.');
      expect(possessive.greek, 'Αυτή είναι η τσάντα της.');
      expect(matcher.matches('της', possessive), isFalse);
      expect(matcher.matches('Αυτή είναι η τσάντα της', possessive), isTrue);
      final phone = deck(
        'grammar-possession',
      ).cards.singleWhere((c) => c.id == 'possession-his-phone');
      expect(matcher.matches('Αυτό είναι το τηλέφωνο του.', phone), isFalse);
      expect(matcher.matches('Αυτό είναι το τηλέφωνό του.', phone), isTrue);
      expect(deck('grammar-gender').cards.length, 12);
    },
  );

  test(
    'regrouped exercises retain progress while new word tasks stay independent',
    () async {
      final store = MemoryProgressStore();
      final record = ReviewSchedule(level: 2, dueAt: DateTime(2099));
      store.records['numbers-0-10.typing.number-7'] = record;
      store.records['live-present.typing.i'] = record;
      store.records['possession.typing.my-book'] = record;
      store.records['articles-cases.typing.book-nom'] = record;
      final progress = LearningProgress(store);
      await progress.load(learningDecks);
      expect(progress.learned(deck('words-numbers'), StudyMode.typing), 1);
      expect(progress.learned(deck('words-verbs'), StudyMode.typing), 1);
      expect(progress.learned(deck('grammar-possession'), StudyMode.typing), 1);
      expect(progress.learned(deck('words-nouns'), StudyMode.typing), 0);
      expect(progress.learned(deck('grammar-verbs'), StudyMode.typing), 0);
      final grammar = deck('grammar-verbs');
      final word = deck(
        'words-verbs',
      ).cards.singleWhere((c) => c.greek == 'μένω');
      final drill = grammar.cards.singleWhere((c) => c.greek == 'μένω');
      expect(
        word.reviewIdentity!.key(StudyMode.typing),
        isNot(drill.reviewIdentity!.key(StudyMode.typing)),
      );
      await progress.record(
        deck: grammar,
        mode: StudyMode.typing,
        card: drill,
        correct: false,
      );
      expect(store.records['live-present.typing.i'], record);
      expect(store.records['articles-cases.typing.book-nom'], record);
    },
  );

  test('week, theme and search filters select actual word cards', () {
    final nouns = learningCollections.first;
    final now = DateTime(2026, 10, 6);
    final recent = nouns.filter(period: VocabularyPeriod.thisWeek, now: now);
    expect(recent.cards.length, 9);
    final phone = nouns.filter(
      period: VocabularyPeriod.thisWeek,
      theme: LearningTheme.phone,
      now: now,
    );
    expect(
      phone.cards.map((c) => c.greek),
      containsAll(['κινητό', 'σταθερό', 'νούμερο']),
    );
    final result = nouns.filter(query: 'μολυβι', now: now);
    expect(result.cards.single.greek, 'μολύβι');
    expect(
      nouns.filter(query: 'карандаш', now: now).cards.single.greek,
      'μολύβι',
    );
    expect(
      nouns
          .filter(theme: LearningTheme.places, query: 'Russia', now: now)
          .cards
          .single
          .greek,
      'Ρωσία',
    );
    final verbs = learningCollections.singleWhere(
      (c) => c.deck.id == 'words-verbs',
    );
    expect(
      verbs
          .filter(theme: LearningTheme.classroom, now: now)
          .cards
          .map((c) => c.greek),
      containsAll(['διαβάζω', 'μαθαίνω', 'σπουδάζω']),
    );
  });

  test('large collections produce varied batches capped at fifteen', () {
    final cards = deck('words-nouns').cards;
    final first = sessionBatch(cards, random: Random(1));
    final second = sessionBatch(cards, random: Random(2));
    expect(first.length, 15);
    expect(first.map((c) => c.id).toSet().length, 15);
    expect(first.map((c) => c.id), isNot(second.map((c) => c.id)));
    expect(sessionBatch(cards.take(3).toList()).length, 3);
  });
}
