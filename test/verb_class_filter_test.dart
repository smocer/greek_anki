import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/curriculum.dart';

const verbClasses = {
  LearningTheme.verbA,
  LearningTheme.verbB1,
  LearningTheme.verbB2,
  LearningTheme.verbAB,
};

void main() {
  LearningCollection verbs() => currentDictionary.collections.singleWhere(
    (collection) => collection.deck.id == 'words-verbs',
  );

  test('all four verb classes filter the merged catalog by taught pattern', () {
    final collection = verbs();
    for (final (theme, examples) in [
      (LearningTheme.verbA, ['γράφω', 'παίρνω', 'κατεβαίνω']),
      (LearningTheme.verbB1, ['μιλάω', 'προτιμώ', 'τραγουδώ', 'ζητάω']),
      (LearningTheme.verbB2, ['μπορώ', 'ζω', 'οδηγώ', 'ευχαριστώ']),
      (LearningTheme.verbAB, ['ακούω', 'λέω', 'πάω', 'τρώω']),
    ]) {
      final filtered = collection.filter(
        theme: theme,
        now: DateTime(2026, 10, 27),
      );
      expect(filtered.cards.map((card) => card.greek), containsAll(examples));
      expect(
        filtered.cards.every(
          (card) => collection.themes[card.id]!.contains(theme),
        ),
        isTrue,
      );
    }

    final b1 = collection.filter(
      theme: LearningTheme.verbB1,
      now: DateTime.now(),
    );
    final b2 = collection.filter(
      theme: LearningTheme.verbB2,
      now: DateTime.now(),
    );
    expect(b1.cards.map((card) => card.greek), isNot(contains('μπορώ')));
    expect(b2.cards.map((card) => card.greek), isNot(contains('μιλάω')));
  });

  test('each active verb is classified and other verb types stay unforced', () {
    final collection = verbs();
    const otherTypes = {'είμαι', 'λέγομαι', 'βρέχομαι', 'κοιμάμαι'};
    for (final card in collection.deck.cards) {
      final classes = (collection.themes[card.id] ?? {}).intersection(
        verbClasses,
      );
      expect(
        classes.isEmpty,
        otherTypes.contains(card.greek),
        reason: card.greek,
      );
    }
    for (final other in currentDictionary.collections) {
      if (other.deck.id == collection.deck.id) continue;
      expect(other.availableThemes.intersection(verbClasses), isEmpty);
    }
  });

  test('mixed forms retain both classes and ordinary topic tags', () {
    final collection = verbs();
    Set<LearningTheme> themes(String greek) =>
        collection.themes[collection.deck.cards
            .singleWhere((card) => card.greek == greek)
            .id]!;
    for (final greek in ['πάω', 'λέω', 'τρώω']) {
      expect(
        themes(greek),
        containsAll([LearningTheme.verbA, LearningTheme.verbAB]),
      );
    }
    expect(
      themes('παρακαλώ'),
      containsAll([LearningTheme.verbB1, LearningTheme.verbB2]),
    );
    expect(
      themes('μαγειρεύω'),
      containsAll([
        LearningTheme.food,
        LearningTheme.home,
        LearningTheme.verbA,
      ]),
    );
    final filtered = collection.filter(
      theme: LearningTheme.verbB2,
      query: 'οδηγώ',
      now: DateTime.now(),
    );
    expect(filtered.cards.single.greek, 'οδηγώ');
    final excluding = collection.filter(
      excludedThemes: {LearningTheme.verbAB},
      now: DateTime.now(),
    );
    expect(excluding.cards.map((card) => card.greek), isNot(contains('ακούω')));
    expect(excluding.cards.map((card) => card.greek), contains('είμαι'));
  });
}
