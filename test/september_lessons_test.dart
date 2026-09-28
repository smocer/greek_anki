import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import 'support/memory_progress_store.dart';

void main() {
  const matcher = GreekAnswer();
  VocabularyDeck deck(String id) => greekDecks.firstWhere((d) => d.id == id);
  VocabularyCard card(String deckId, String id) =>
      deck(deckId).cards.firstWhere((c) => c.id == id);

  test('core vocabulary and everyday phrases remain available', () {
    final answers = greekDecks
        .expand((d) => d.cards)
        .expand((c) => [c.greek, ...c.alternatives])
        .map(GreekText.answerKey)
        .toSet();
    for (final greek in [
      'δεκάξι',
      'τριάντα',
      'σαράντα',
      'πενήντα',
      'εξήντα',
      'εβδομήντα',
      'ογδόντα',
      'ενενήντα',
      'εκατό',
      'είκοσι ένα',
      'τριάντα δύο',
      'σαράντα τρία',
      'πενήντα τέσσερα',
      'εξήντα πέντε',
      'εβδομήντα έξι',
      'ογδόντα εφτά',
      'ενενήντα οχτώ',
      'εκατόν ένα',
      'Πού μένεις;',
      'Πού μένετε;',
      'Πού ακριβώς;',
      'Κοντά σε τι;',
      'ο γείτονας',
      'οι γείτονες',
      'Μένω στη Λευκωσία.',
      'Μένω στα Λατσιά.',
      'Μένω στον Στρόβολο.',
      'Μένω στην Αθήνα.',
      'Μένω στην Κυψέλη.',
      'Μένω στον Πειραιά.',
      'Μένω στο Πασαλιμάνι.',
      'Μένω Κυκλάδων είκοσι εννέα.',
      'Μένω Μουσών είκοσι τρία.',
      'Ναι;',
      'Παρακαλώ;',
      'Ποιος είναι στο τηλέφωνο;',
      'Ο Γιάννης είναι εκεί;',
      'Δεν είναι εδώ.',
      'Είμαι στο σπίτι με την Τζούλια.',
      'το τηλέφωνό μου',
      'Έχεις τηλέφωνο;',
      'Το τηλέφωνό μου είναι…',
      'Πώς πάει;',
      'Τι γίνεται;',
      'Τι νέα;',
      'Τα ίδια.',
      'Καλούτσικα.',
      'Χάλια!',
      'Όχι και τόσο καλά.',
      'Χαίρετε!',
      'Γεια χαρά!',
      'Καλό βράδυ!',
      'Άντε, γεια!',
      'Πω πω!',
      'ο σκύλος',
      'ο γάτος',
      'το σπίτι',
      'το σκυλάκι',
      'ή',
      'η',
      'πάντα',
      'ακόμα',
      'μήπως',
    ]) {
      expect(answers, contains(GreekText.answerKey(greek)), reason: greek);
    }
  });

  test(
    'the three representative verbs cover six persons and subject pronouns',
    () {
      // Independent lesson examples catch a skipped person or a wrong ending.
      const expected = {
        'live': 'μένω μένεις μένει μένουμε μένετε μένουν',
        'read': 'διαβάζω διαβάζεις διαβάζει διαβάζουμε διαβάζετε διαβάζουν',
        'understand':
            'καταλαβαίνω καταλαβαίνεις καταλαβαίνει καταλαβαίνουμε καταλαβαίνετε καταλαβαίνουν',
      };
      const ids = ['i', 'you', 'he', 'we', 'you-plural', 'they'];
      const subjects = ['εγώ', 'εσύ', 'αυτός', 'εμείς', 'εσείς', 'αυτοί'];
      for (final entry in expected.entries) {
        final forms = entry.value.split(' ');
        for (var i = 0; i < forms.length; i++) {
          final c = card(
            'present-conjugation',
            '${entry.key}-present.${ids[i]}',
          );
          expect(matcher.matches(forms[i], c), isTrue);
          expect(matcher.matches('${subjects[i]} ${forms[i]}', c), isTrue);
          expect(matcher.matches(forms[(i + 1) % 6], c), isFalse);
          expect(matcher.matches(GreekText.searchKey(forms[i]), c), isFalse);
        }
        expect(
          matcher.matches(
            '${forms.last}ε',
            card('present-conjugation', '${entry.key}-present.they'),
          ),
          isTrue,
        );
      }
    },
  );

  test(
    'article gender, noun cases and grammatical stress stay significant',
    () {
      expect(matcher.matches('ή', card('lesson-connectors', 'or')), isTrue);
      expect(matcher.matches('η', card('lesson-connectors', 'or')), isFalse);
      expect(
        matcher.matches('η', card('lesson-connectors', 'feminine-article')),
        isTrue,
      );
      expect(
        matcher.matches('ή', card('lesson-connectors', 'feminine-article')),
        isFalse,
      );
      expect(
        matcher.matches(
          'το τηλέφωνό μου',
          card('phone-conversations', 'my-phone'),
        ),
        isTrue,
      );
      for (final wrong in [
        'το τηλέφωνο μου',
        'το τηλεφωνό μου',
        'το τηλέφωνό μού',
      ]) {
        expect(
          matcher.matches(wrong, card('phone-conversations', 'my-phone')),
          isFalse,
        );
      }
      expect(
        matcher.matches(
          'Μένω στα Λατσιά',
          card('living-places', 'live-latsia'),
        ),
        isTrue,
      );
      expect(
        matcher.matches(
          'Μένω στην Λατσιά',
          card('living-places', 'live-latsia'),
        ),
        isFalse,
      );
      expect(
        matcher.matches(
          'Μένω στον Στρόβολος',
          card('living-places', 'live-strovolos'),
        ),
        isFalse,
      );
      expect(
        matcher.matches('τον γείτονα', card('neighbours', 'neighbour-object')),
        isTrue,
      );
      expect(
        matcher.matches('του γείτονα', card('neighbours', 'neighbour-object')),
        isFalse,
      );
      expect(
        matcher.matches('του σπιτιού', card('pets-home', 'house-genitive')),
        isTrue,
      );
      expect(
        matcher.matches('του σπίτιου', card('pets-home', 'house-genitive')),
        isFalse,
      );
    },
  );

  test('new number and spelling variants keep their own required accents', () {
    for (final (deckId, id, correct, wrong) in [
      ('numbers-11-100', 'numbers-11-20.number-16', 'δεκάξι', 'δεκαξι'),
      ('numbers-compound', 'number-87', 'ογδόντα επτά', 'ογδόντα επτα'),
      ('numbers-compound', 'number-98', 'ενενήντα οχτώ', 'ενενηντα οχτώ'),
      ('numbers-compound', 'number-101', 'εκατόν ένα', 'εκατό ένα'),
      (
        'addresses-nearby',
        'pontou-address',
        'μένω πόντου δεκάξι',
        'μένω πόντου δεκάέξι',
      ),
    ]) {
      expect(matcher.matches(correct, card(deckId, id)), isTrue);
      expect(matcher.matches(wrong, card(deckId, id)), isFalse);
    }
  });

  test(
    'every main answer can be entered with the built-in letter keyboard',
    () {
      final keys = 'ςερτυθιοπασδφγηξκλζχψωβνμάέήίόύώ '.split('').toSet();
      for (final c in greekDecks.expand((d) => d.cards)) {
        final letters = c.greek.toLowerCase().replaceAll(
          RegExp(r'[.,;?!…:]'),
          '',
        );
        expect(letters.split('').every(keys.contains), isTrue, reason: c.id);
      }
    },
  );

  test('grouped topics preserve old reviews and keep new cards due', () async {
    final previous = ReviewSchedule(level: 3, dueAt: DateTime.utc(2099));
    final store = MemoryProgressStore()
      ..records['start-present.typing.i'] = previous;
    final progress = LearningProgress(store);
    await progress.load(greekDecks);
    expect(progress.learned(deck('basic-verbs'), StudyMode.typing), 1);
    expect(
      progress.dueCards(deck('small-words'), StudyMode.typing).map((c) => c.id),
      contains('start-present.lesson-always-nine'),
    );
    expect(
      progress.dueCards(deck('present-conjugation'), StudyMode.typing).length,
      deck('present-conjugation').cards.length,
    );
    expect(store.records['start-present.typing.i'], same(previous));
  });
}
