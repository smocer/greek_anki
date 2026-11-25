import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/grammar_drill_data.dart';
import 'package:greek_anki/data/learning_curriculum.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/grammar_drill.dart';
import 'package:greek_anki/domain/greek_text.dart';

GrammarDrillGenerator generator(GrammarDrillKind kind, {Random? random}) =>
    createGrammarDrill(
      kind: kind,
      collections: learningCollections,
      nouns: nounPluralEntries,
      adjectives: adjectivePluralEntries,
      quantities: quantityEntries,
      random: random ?? Random(42),
    );

void main() {
  test(
    'every current noun and adjective has reviewed morphology or an explicit exclusion',
    () {
      for (final (id, entries) in [
        ('words-nouns', nounPluralEntries),
        ('words-adjectives', adjectivePluralEntries),
      ]) {
        final cards = learningCollections
            .singleWhere((c) => c.deck.id == id)
            .deck
            .cards;
        final ids = cards.map((c) => c.id).toSet();
        final covered = entries.map((e) => e.cardId).toSet();
        expect(covered.difference(ids), isEmpty, reason: 'Stale morphology');
        final excluded = id == 'words-nouns'
            ? pluralExclusions.keys.toSet()
            : <String>{};
        expect(excluded.difference(ids), isEmpty);
        expect(excluded.intersection(covered), isEmpty);
        expect(
          ids.difference({...covered, ...excluded}),
          isEmpty,
          reason:
              'New vocabulary needs a reviewed plural or a documented exclusion',
        );
        expect(
          entries.map((e) => (e.cardId, e.singular)).toSet().length,
          entries.length,
        );
        for (final entry in entries) {
          expect(entry.singular, matches(RegExp(r'(^| )(ο|η|το) ')));
          expect(entry.answers, isNotEmpty);
          for (final answer in entry.answers) {
            expect(
              answer,
              matches(RegExp(r'(^| )(οι|τα) ')),
              reason: entry.singular,
            );
          }
        }
        if (id == 'words-adjectives') {
          for (final card in cards) {
            final forms = entries.where((e) => e.cardId == card.id);
            expect(
              forms
                  .map(
                    (e) => RegExp(
                      r'(^| )(ο|η|το) ',
                    ).firstMatch(e.singular)!.group(2),
                  )
                  .toSet(),
              {'ο', 'η', 'το'},
              reason: card.id,
            );
          }
        }
      }
    },
  );

  test(
    'all authored answers work; plural articles and accents are mandatory',
    () {
      for (final kind in GrammarDrillKind.values) {
        for (final question in generator(kind).questions) {
          for (final answer in question.answers) {
            expect(question.matches(answer), isTrue, reason: answer);
            expect(question.matches('  $answer. '), isTrue);
            if (kind != GrammarDrillKind.quantity) {
              expect(
                question.matches(
                  answer.replaceFirst(RegExp(r'(^| )(οι|τα) '), ' ').trim(),
                ),
                isFalse,
                reason: answer,
              );
              final wrongArticle = RegExp(r'(^| )οι ').hasMatch(answer)
                  ? answer.replaceFirst('οι ', 'τα ')
                  : answer.replaceFirst('τα ', 'οι ');
              expect(question.matches(wrongArticle), isFalse, reason: answer);
            }
            var unaccented = answer;
            const accented = 'άέήίόύώ';
            const plain = 'αεηιουω';
            for (var i = 0; i < accented.length; i++) {
              unaccented = unaccented.replaceAll(accented[i], plain[i]);
            }
            if (unaccented != answer) {
              expect(question.matches(unaccented), isFalse, reason: answer);
            }
          }
        }
      }
    },
  );

  test(
    'generators never repeat a form pattern and can reach every question',
    () {
      for (final kind in GrammarDrillKind.values) {
        final drill = generator(kind);
        String? previous;
        final seen = <String>{};
        for (var i = 0; i < 20000; i++) {
          final question = drill.next();
          expect(question.pattern, isNot(previous));
          seen.add('${question.cardId}/${question.prompt}');
          previous = question.pattern;
        }
        expect(
          seen,
          drill.questions.map((q) => '${q.cardId}/${q.prompt}').toSet(),
        );
        expect(
          () => GrammarDrillGenerator([drill.questions.first]),
          throwsArgumentError,
        );
      }
    },
  );

  test(
    'quantity mixes cases with correct agreement and excludes non-shopping words',
    () {
      final questions = generator(GrammarDrillKind.quantity).questions;
      expect(questions.map((q) => q.pattern).toSet(), {
        'πόσος',
        'πόσοι',
        'πόσο',
        'πόση',
        'πόσους',
        'πόσες',
        'πόσα',
      });
      expect(questions.length, quantityEntries.length * 2);
      final nouns = learningCollections.singleWhere(
        (c) => c.deck.id == 'words-nouns',
      );
      for (final q in questions) {
        expect(nouns.themes[q.cardId]!.any(shoppingThemes.contains), isTrue);
        expect(q.prompt.split('___').length, 2);
        if (q.quantityCase == QuantityCase.nominative) {
          expect(
            q.prompt,
            contains(
              q.number == GrammaticalNumber.singular
                  ? ' υπάρχει '
                  : ' υπάρχουν ',
            ),
          );
          expect(q.prompt, endsWith('στο σπίτι;'));
          if (q.gender == 'm') {
            expect(q.answers, [
              q.number == GrammaticalNumber.singular ? 'πόσος' : 'πόσοι',
            ]);
          }
        } else {
          expect(q.prompt, endsWith('θέλεις;'));
          if (q.gender == 'm' && q.number == GrammaticalNumber.singular) {
            expect(q.matches('πόσον'), isTrue);
            expect(q.matches('πόσος'), isFalse);
          }
        }
      }
      for (final (prompt, answer) in [
        ('___ καφές υπάρχει στο σπίτι;', 'πόσος'),
        ('___ καφέ θέλεις;', 'πόσο'),
        ('___ χυμοί υπάρχουν στο σπίτι;', 'πόσοι'),
        ('___ χυμούς θέλεις;', 'πόσους'),
      ]) {
        final q = questions.firstWhere((q) => q.prompt == prompt);
        expect(q.matches(answer), isTrue);
      }
      for (final entry in quantityEntries.where((e) => e.gender == 'm')) {
        expect(entry.nominative, isNotNull, reason: entry.noun);
      }
    },
  );

  test('book shopping groups are filterable without duplicating cards', () {
    final nouns = learningCollections.singleWhere(
      (c) => c.deck.id == 'words-nouns',
    );
    for (final (word, theme) in [
      ('ψωμί', LearningTheme.bakery),
      ('εφημερίδα', LearningTheme.kiosk),
      ('ντομάτα', LearningTheme.streetMarket),
      ('οδοντόκρεμα', LearningTheme.supermarket),
    ]) {
      final card = nouns.deck.cards.firstWhere(
        (c) => GreekText.answerKey(c.greek) == GreekText.answerKey(word),
      );
      expect(nouns.themes[card.id], contains(theme));
    }
    expect(
      nouns.deck.cards.map((c) => c.id).toSet().length,
      nouns.deck.cards.length,
    );
  });
}
