import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';

import 'support/memory_progress_store.dart';

void main() {
  final dictionary = currentDictionary;
  VocabularyDeck deck(String id) =>
      dictionary.learningDecks.singleWhere((d) => d.id == id);
  const matcher = GreekAnswer();

  test('personal and geographical names are separate from common nouns', () {
    final names = deck('words-names').cards;
    final nouns = deck('words-nouns').cards;
    expect(
      names.map((c) => c.greek),
      containsAll(['Αργεντινή', 'Ελένη', 'Λευκωσία', 'Ευρώπη']),
    );
    final nameIds = names.map((c) => c.id).toSet();
    expect(nouns.any((c) => nameIds.contains(c.id)), isFalse);
    expect(
      nouns.map((c) => c.greek),
      containsAll(['μουσείο', 'σπίτι', 'φούρνος', 'ζωή']),
    );
    for (final card in names) {
      expect(matcher.matches(card.greek, card), isTrue);
      final answers = card.forms.isEmpty
          ? [card.displayedAnswer]
          : card.forms.map((form) => form.answerDisplay);
      for (final answer in answers) {
        expect(matcher.matches(answer, card), isTrue);
      }
    }
  });

  test('moving names retains saved schedules in both study modes', () async {
    final store = MemoryProgressStore();
    final record = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
    for (final mode in StudyMode.values) {
      for (final id in ['countries.argentina', 'noun-gender.eleni']) {
        store.records['words-nouns.${mode.name}.$id'] = record;
      }
    }
    final progress = LearningProgress(store);
    addTearDown(progress.dispose);
    await progress.load(dictionary.learningDecks);
    for (final mode in StudyMode.values) {
      expect(progress.learned(deck('words-names'), mode), 2);
      expect(progress.learned(deck('words-nouns'), mode), 0);
      expect(
        progress.dueCards(deck('words-names'), mode).map((c) => c.greek),
        isNot(anyOf(contains('Αργεντινή'), contains('Ελένη'))),
      );
    }
    final eleni = deck(
      'words-names',
    ).cards.singleWhere((c) => c.greek == 'Ελένη');
    await progress.record(
      deck: deck('words-names'),
      mode: StudyMode.typing,
      card: eleni,
      correct: false,
    );
    expect(
      store.records['words-nouns.typing.noun-gender.eleni'],
      isNot(record),
    );
    expect(
      store.records.keys.any((key) => key.startsWith('words-names.')),
      isFalse,
    );
  });

  test('work and life lesson extends two existing profession cards', () {
    final previous =
        GreekDictionary.merge(File(dictionaryAsset).readAsStringSync(), {
          for (final file in Directory(
            dictionaryAdditionsDirectory,
          ).listSync().whereType<File>())
            if (file.path.endsWith('.json') &&
                !file.path.endsWith('2026-10-12-work-life.json'))
              file.path: file.readAsStringSync(),
        });
    final before = previous.learningDecks.expand((d) => d.cards).toList();
    final after = dictionary.learningDecks.expand((d) => d.cards).toList();
    expect(after.length - before.length, 31);
    for (final group in ['doctoral-student', 'physiotherapist']) {
      final old = before.singleWhere((c) => c.wordGroup == group);
      final card = after.singleWhere((c) => c.wordGroup == group);
      expect(
        card.reviewIdentity!.key(StudyMode.typing),
        old.reviewIdentity!.key(StudyMode.typing),
      );
      expect(card.addedWeek, old.addedWeek);
      expect(card.forms.length, 4);
      expect(
        card.reviewAliases.map((identity) => identity.key(StudyMode.typing)),
        containsAll(
          old.reviewAliases.map((identity) => identity.key(StudyMode.typing)),
        ),
      );
      for (final form in card.forms) {
        expect(matcher.matches(form.greek, card), isTrue, reason: form.greek);
        expect(
          matcher.matches(form.answerDisplay, card),
          isTrue,
          reason: form.answerDisplay,
        );
      }
    }
    final newCards = after.where((c) => c.id.startsWith('work-life-'));
    expect(newCards, hasLength(31));
    expect(newCards.every((c) => c.addedWeek == '2026-10-12'), isTrue);
  });

  test('new answers retain accents and gender alternatives are searchable', () {
    final nouns = dictionary.collections.singleWhere(
      (c) => c.deck.id == 'words-nouns',
    );
    final journalist = nouns
        .filter(query: 'δημοσιογράφος', now: DateTime(2026, 10, 12))
        .cards
        .single;
    for (final answer in ['δημοσιογράφος', 'η δημοσιογράφος']) {
      expect(matcher.matches(answer, journalist), isTrue);
    }
    expect(matcher.matches('δημοσιογραφος', journalist), isFalse);
    final animal = nouns.deck.cards.singleWhere((c) => c.greek == 'ζώο');
    expect(matcher.matches('το ζώο', animal), isTrue);
    expect(matcher.matches('η ζώο', animal), isFalse);
    expect(matcher.matches('ζωο', animal), isFalse);
    final answer = deck(
      'words-verbs',
    ).cards.singleWhere((c) => c.greek == 'απαντώ');
    expect(matcher.matches('απαντάω', answer), isTrue);
    final recent = nouns.filter(
      period: VocabularyPeriod.thisWeek,
      now: DateTime(2026, 10, 12),
    );
    expect(
      recent.cards.where((c) => c.id.startsWith('work-life-')),
      hasLength(7),
    );
    expect(
      nouns
          .filter(query: 'φυσιοθεραπεύτρια', now: DateTime(2026, 10, 12))
          .cards
          .single
          .wordGroup,
      'physiotherapist',
    );
  });
}
