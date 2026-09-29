import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/domain/greek_answer.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/vocabulary.dart';

void main() {
  const matcher = GreekAnswer();
  VocabularyDeck deck(String id) => greekDecks.firstWhere((d) => d.id == id);
  VocabularyCard card(String deckId, String id) =>
      deck(deckId).cards.firstWhere((c) => c.id == id);

  test('town vocabulary covers the lesson in focused bilingual topics', () {
    const groups = {
      'transport-streets': [
        'το λιμάνι',
        'το μετρό',
        'το λεωφορείο',
        'το τρένο',
        'η στάση',
        'η πλατεία',
        'η οδός',
      ],
      'shops-services': [
        'το σχολείο',
        'το φαρμακείο',
        'το περίπτερο',
        'το νοσοκομείο',
        'ο φούρνος',
        'το μαγαζί',
        'το ξενοδοχείο',
      ],
      'culture-dining': [
        'ο κινηματογράφος',
        'το μουσείο',
        'το θέατρο',
        'το εστιατόριο',
        'η ταβέρνα',
      ],
      'nature-geography': [
        'η θάλασσα',
        'ο ήλιος',
        'ο ουρανός',
        'η Ευρώπη',
        'η Ασία',
        'η Αμερική',
        'η Αφρική',
      ],
    };
    for (final entry in groups.entries) {
      expect(deck(entry.key).cards.map((c) => c.greek), entry.value);
    }
    expect(card('classroom-objects', 'picture').greek, 'η εικόνα');
    expect(card('classroom-objects', 'letter').greek, 'το γράμμα');
    expect(card('introductions', 'name').greek, 'το όνομα');
    expect(card('basic-verbs', 'see-present.i').greek, 'βλέπω');
    expect(deck('present-conjugation').cards.length, 18);
  });

  test('gender drill asks for the article and noun, including exceptions', () {
    for (final (id, correct, wrong) in [
      ('kostas', 'ο Κώστας', 'η Κώστας'),
      ('letter', 'το γράμμα', 'η γράμμα'),
      ('child', 'το παιδί', 'ο παιδί'),
      ('cyprus', 'η Κύπρος', 'ο Κύπρος'),
      ('paphos', 'η Πάφος', 'ο Πάφος'),
      ('limassol', 'η Λεμεσός', 'ο Λεμεσός'),
      ('street', 'η οδός', 'ο οδός'),
      ('egypt', 'η Αίγυπτος', 'ο Αίγυπτος'),
    ]) {
      final c = card('noun-gender', id);
      expect(matcher.matches(correct, c), isTrue);
      expect(matcher.matches(wrong, c), isFalse);
      expect(matcher.matches(correct.split(' ').first, c), isFalse);
      expect(c.prompt.en, contains('…'));
      expect(c.prompt.ru, contains('…'));
    }
  });

  test('seeing drill distinguishes nominative, accusative and pronouns', () {
    for (final (id, correct, wrong) in [
      ('george', 'Βλέπω τον Γιώργο', 'Βλέπω τον Γιώργος'),
      ('kostas', 'Βλέπω τον Κώστα', 'Βλέπω τον Κώστας'),
      ('john', 'Βλέπω τον Γιάννη', 'Βλέπω τον Γιάννης'),
      ('maria', 'Βλέπω την Μαρία', 'Βλέπω η Μαρία'),
      ('picture', 'Βλέπω την εικόνα', 'Βλέπω το εικόνα'),
      ('train', 'Βλέπω το τρένο', 'Βλέπω τον τρένο'),
      ('child', 'Βλέπω το παιδί', 'Βλέπω τον παιδί'),
      ('letter', 'Βλέπω το γράμμα', 'Βλέπω την γράμμα'),
    ]) {
      final c = card('seeing-objects', id);
      expect(matcher.matches(correct, c), isTrue);
      expect(matcher.matches('Εγώ $correct', c), isTrue);
      expect(matcher.matches(wrong, c), isFalse);
      expect(
        matcher.matches(correct.replaceFirst('Βλέπω', 'Βλέπεις'), c),
        isFalse,
      );
      expect(matcher.matches(GreekText.searchKey(correct), c), isFalse);
    }
  });

  test('new feminine phrases accept full την and στην without a nu drill', () {
    for (final (deckId, id, full, shorter) in [
      ('location', 'at-stop', 'στην στάση', 'στη στάση'),
      ('location', 'at-sea', 'στην θάλασσα', 'στη θάλασσα'),
      ('origin', 'from-france', 'από την Γαλλία', 'από τη Γαλλία'),
      ('origin', 'from-denmark', 'από την Δανία', 'από τη Δανία'),
      ('origin', 'from-bulgaria', 'από την Βουλγαρία', 'από τη Βουλγαρία'),
      ('seeing-objects', 'maria', 'Βλέπω την Μαρία', 'Βλέπω τη Μαρία'),
      (
        'living-places',
        'live-thessaloniki',
        'Μένω στην Θεσσαλονίκη',
        'Μένω στη Θεσσαλονίκη',
      ),
      ('living-places', 'live-limassol', 'Μένω στην Λεμεσό', 'Μένω στη Λεμεσό'),
      (
        'living-places',
        'live-new-york',
        'Μένω στην Νέα Υόρκη',
        'Μένω στη Νέα Υόρκη',
      ),
    ]) {
      final c = card(deckId, id);
      expect(matcher.matches(full, c), isTrue);
      expect(matcher.matches(shorter, c), isTrue);
      expect(GreekText.answerKey(c.greek), GreekText.answerKey(full));
      expect(matcher.matches(GreekText.searchKey(full), c), isFalse);
    }
  });

  test('origin and location practice gender, number and noun endings', () {
    for (final (deckId, id, correct, wrong) in [
      ('origin', 'from-lebanon', 'από τον Λίβανο', 'από τον Λίβανος'),
      ('origin', 'from-egypt', 'από την Αίγυπτο', 'από την Αίγυπτος'),
      ('origin', 'from-morocco', 'από το Μαρόκο', 'από τον Μαρόκο'),
      ('origin', 'from-usa', 'από τις ΗΠΑ', 'από την ΗΠΑ'),
      ('location', 'at-bakery', 'στον φούρνο', 'στον φούρνος'),
      ('location', 'at-museum', 'στο μουσείο', 'στον μουσείο'),
      ('location', 'at-cinema', 'στον κινηματογράφο', 'στον κινηματογράφος'),
      ('living-places', 'live-paphos', 'Μένω στην Πάφο', 'Μένω στον Πάφο'),
      (
        'living-places',
        'live-limassol',
        'Μένω στην Λεμεσό',
        'Μένω στην Λεμεσός',
      ),
    ]) {
      expect(matcher.matches(correct, card(deckId, id)), isTrue);
      expect(matcher.matches(wrong, card(deckId, id)), isFalse);
    }
    final countries = deck('countries').cards.map((c) => c.greek);
    expect(
      countries,
      containsAll([
        'ο Λίβανος',
        'η Γαλλία',
        'η Αργεντινή',
        'το Μαρόκο',
        'το Μπουρούντι',
        'το Αφγανιστάν',
        'το Ισραήλ',
        'η Αίγυπτος',
        'οι ΗΠΑ',
        'η Ιταλία',
        'η Κίνα',
        'η Δανία',
        'η Βουλγαρία',
      ]),
    );
  });

  test('new compound numbers accept spelling variants with correct stress', () {
    for (final (number, primary, alternative) in [
      (28, 'είκοσι οκτώ', 'είκοσι οχτώ'),
      (39, 'τριάντα εννέα', 'τριάντα εννιά'),
      (47, 'σαράντα εφτά', 'σαράντα επτά'),
      (49, 'σαράντα εννέα', 'σαράντα εννιά'),
      (77, 'εβδομήντα εφτά', 'εβδομήντα επτά'),
      (89, 'ογδόντα εννέα', 'ογδόντα εννιά'),
    ]) {
      final c = card('numbers-compound', 'number-$number');
      expect(c.greek, primary);
      expect(matcher.matches(alternative, c), isTrue);
      expect(matcher.matches(GreekText.searchKey(primary), c), isFalse);
      expect(matcher.matches(GreekText.searchKey(alternative), c), isFalse);
    }
  });
}
