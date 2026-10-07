import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/family_lesson.dart';
import 'package:greek_anki/data/learning_curriculum.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/vocabulary_category.dart';

void main() {
  const matcher = GreekAnswer();
  LearningCollection collection(String id) =>
      learningCollections.singleWhere((c) => c.deck.id == id);
  VocabularyCard card(String collectionId, String suffix) =>
      collection(collectionId).deck.cards.singleWhere(
        (card) => card.id.split('.').last == 'family-$suffix',
      );

  test(
    'all family vocabulary is available through existing word collections',
    () {
      final nouns = collection('words-nouns').deck.cards;
      expect(
        nouns.map((c) => c.greek),
        containsAll([
          'οικογένεια',
          'πατέρας',
          'μπαμπάς',
          'μαμά',
          'γονείς',
          'αδερφός',
          'αδερφή',
          'αδέρφια',
          'άντρας',
          'γυναίκα',
          'γιος',
          'κόρη',
          'παππούς',
          'γιαγιά',
          'εγγονός',
          'εγγονή',
          'θείος',
          'θεία',
          'ανιψιός',
          'ανιψιά',
          'ξάδελφος',
          'ξαδέλφη',
          'γαμπρός',
          'νύφη',
          'πεθερός',
          'πεθερά',
          'φωτογραφία',
          'καφενείο',
          'φυτό',
        ]),
      );
      expect(nouns.where((c) => c.greek == 'μητέρα').length, 1);
      expect(
        collection('words-verbs').deck.cards.map((c) => c.greek),
        contains('λέω'),
      );
      expect(
        collection('words-pronouns').deck.cards.map((c) => c.greek),
        containsAll(['τον', 'την', 'το', 'όλοι', 'όλες', 'όλα']),
      );
      expect(
        collection('words-descriptions').deck.cards.map((c) => c.greek),
        containsAll([
          'παντρεμένος',
          'παντρεμένη',
          'ελεύθερος',
          'ελεύθερη',
          'χωρισμένος',
          'χωρισμένη',
        ]),
      );
      expect(learningCollections.length, 15);
      for (final group in learningCollections) {
        for (final entry in group.deck.cards.where(
          (c) => c.id.contains('family-'),
        )) {
          expect(entry.addedWeek, familyWeek);
          expect(entry.explanation?.en, isNotEmpty);
          expect(entry.explanation?.ru, isNotEmpty);
        }
      }
    },
  );

  test(
    'noun spelling alternatives allow articles but still require stress',
    () {
      for (final example in [
        (
          'brother',
          ['αδερφός', 'αδελφός', 'ο αδελφός'],
          ['αδερφος', 'αδέρφος', 'η αδερφός'],
        ),
        ('sister', ['αδερφή', 'αδελφή', 'η αδελφή'], ['αδερφη', 'ο αδερφή']),
        (
          'siblings',
          ['αδέρφια', 'αδέλφια', 'τα αδέλφια'],
          ['αδελφια', 'οι αδέρφια'],
        ),
        ('parents', ['γονείς', 'οι γονείς'], ['γονεις', 'τα γονείς']),
        (
          'male-cousin',
          ['ξάδελφος', 'ξάδερφος', 'ο ξάδερφος'],
          ['ξαδελφος', 'ξαδέλφος'],
        ),
        (
          'female-cousin',
          ['ξαδέλφη', 'ξαδέρφη', 'η ξαδέρφη'],
          ['ξάδελφη', 'ξαδελφη'],
        ),
      ]) {
        final entry = card('words-nouns', example.$1);
        for (final answer in example.$2) {
          expect(
            matcher.matches(answer, entry),
            isTrue,
            reason: '${entry.id}: $answer',
          );
        }
        for (final answer in example.$3) {
          expect(
            matcher.matches(answer, entry),
            isFalse,
            reason: '${entry.id}: $answer',
          );
        }
      }
    },
  );

  test('different senses and pronoun roles have explicit separate prompts', () {
    for (final ids in [
      ('husband', 'man'),
      ('wife', 'woman'),
      ('groom', 'son-in-law'),
      ('bride', 'daughter-in-law'),
    ]) {
      final first = card('words-nouns', ids.$1);
      final second = card('words-nouns', ids.$2);
      expect(first.greek, second.greek);
      expect(first.prompt.ru, isNot(second.prompt.ru));
      expect(
        first.reviewIdentity!.key(StudyMode.typing),
        isNot(second.reviewIdentity!.key(StudyMode.typing)),
      );
    }
    final him = card('words-pronouns', 'him-object');
    expect(him.prompt.ru, contains('его зовут'));
    expect(matcher.matches('του', him), isFalse);
    final her = card('words-pronouns', 'her-object');
    expect(matcher.matches('την', her), isTrue);
    expect(matcher.matches('τη', her), isTrue);
    expect(matcher.matches('της', her), isFalse);
  });

  test(
    'grammar checks names, gender, cases and the extra possessive accent',
    () {
      final name = card('grammar-nouns', 'his-name-george');
      expect(matcher.matches('Τον λένε Γιώργο', name), isTrue);
      for (final wrong in [
        'Του λένε Γιώργο',
        'Τον λένε Γιώργος',
        'Τον λένε τον Γιώργο',
      ]) {
        expect(matcher.matches(wrong, name), isFalse, reason: wrong);
      }
      final herName = card('grammar-nouns', 'her-name-eleni');
      expect(matcher.matches('Την λένε Ελένη', herName), isTrue);
      expect(matcher.matches('Τη λένε Ελένη', herName), isTrue);
      final married = card('grammar-gender', 'i-married-woman');
      expect(matcher.matches('Είμαι παντρεμένη', married), isTrue);
      expect(matcher.matches('Είμαι παντρεμένος', married), isFalse);
      expect(matcher.matches('παντρεμένη', married), isFalse);
      final family = card('grammar-possession', 'this-family');
      expect(matcher.matches('Αυτή είναι η οικογένειά μου', family), isTrue);
      expect(matcher.matches('Αυτή είναι η οικογένεια μου', family), isFalse);
      final father = card('grammar-nouns', 'with-father');
      expect(matcher.matches('με τον πατέρα', father), isTrue);
      expect(matcher.matches('με του πατέρα', father), isFalse);
      expect(matcher.matches('με τον πατέρας', father), isFalse);
      final mother = card('grammar-nouns', 'to-mother');
      expect(matcher.matches('στην μητέρα', mother), isTrue);
      expect(matcher.matches('στη μητέρα', mother), isTrue);
    },
  );

  test(
    'family filter combines old and new content and respects week selection',
    () {
      final nouns = collection('words-nouns');
      final now = DateTime(2026, 10, 8);
      final family = nouns.filter(theme: LearningTheme.family, now: now);
      expect(
        family.cards.map((c) => c.greek),
        containsAll([
          'μητέρα',
          'πατέρας',
          'οικογένεια',
          'παιδί',
          'κορίτσι',
          'αγόρι',
        ]),
      );
      expect(family.cards.any((c) => c.greek == 'καφενείο'), isFalse);
      expect(
        nouns
            .filter(theme: LearningTheme.family, query: 'ξάδερφος', now: now)
            .cards
            .single
            .greek,
        'ξάδελφος',
      );
      final recent = nouns.filter(
        theme: LearningTheme.family,
        period: VocabularyPeriod.thisWeek,
        now: now,
      );
      expect(recent.cards.any((c) => c.greek == 'πατέρας'), isTrue);
      expect(recent.cards.any((c) => c.greek == 'παιδί'), isFalse);
      final possession = collection(
        'grammar-possession',
      ).filter(theme: LearningTheme.family, now: now);
      expect(
        possession.cards.map((c) => c.greek),
        contains('Αυτή είναι η οικογένειά μου.'),
      );
    },
  );
}
