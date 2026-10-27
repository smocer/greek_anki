import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/curriculum.dart';
import 'package:greek_anki/domain/greek_text.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/domain/word_search.dart';

void main() {
  test('Greek fragments find words and gender forms across categories', () {
    final search = WordSearch(currentDictionary.collections);
    for (final query in ['επικ', 'ΠΙΚΊΝΔ', 'επικίνδυνο', 'επικι\u0301νδυνη']) {
      final results = search.find(query);
      expect(results, hasLength(1), reason: query);
      expect(results.single.prompt.en, 'Dangerous');
    }
    for (final (query, answer) in [
      ('αθην', 'Αθήνα'),
      ('η χώρα', 'χώρα'),
      ('πάλι', 'ξανά'),
      ('κάποιον', 'κάποιος'),
    ]) {
      expect(search.find(query).map((card) => card.greek), contains(answer));
    }
    expect(search.find('επικίνδυνος').single.greek, 'επικίνδυνος');
    expect(search.find('επικίνδυνοσ').single.greek, 'επικίνδυνος');
  });

  test('empty and unmatched searches do not return the whole catalog', () {
    final search = WordSearch(currentDictionary.collections);
    for (final query in ['', '   ', ';;', 'αβγδεζηθικλ', 'dangerous']) {
      expect(search.find(query), isEmpty, reason: query);
    }
  });

  test('greetings stored in Phrases are reachable by Greek text', () {
    final search = WordSearch(currentDictionary.collections);
    for (final query in ['καλημέρα', 'καλημερα', 'ΚΑΛΗΜΈΡΑ', 'καλημ']) {
      expect(
        search.find(query).map((card) => card.prompt.en),
        contains('Good morning!'),
        reason: query,
      );
    }
  });

  test('every catalog card, answer form and Greek word is reachable', () {
    final search = WordSearch(currentDictionary.collections);
    final greekWord = RegExp(r'[\u0370-\u03ff\u1f00-\u1fff\u0300-\u036f]+');
    var checkedCards = 0;

    // Enumerate the source catalog, not search.cards: an index exclusion must
    // fail this test even when every entry that did make the index works.
    for (final collection in currentDictionary.collections) {
      for (final card in collection.deck.cards) {
        final answers = {
          card.greek,
          card.displayedAnswer,
          ...card.alternatives,
          ...card.acceptedAnswers,
          for (final form in card.forms) ...[form.greek, form.answerDisplay],
        };
        final queries = {
          ...answers,
          for (final answer in answers)
            for (final match in greekWord.allMatches(answer)) match.group(0)!,
        };
        for (final query in queries) {
          if (GreekText.searchKey(query).isEmpty) continue;
          for (final spelling in {
            query,
            GreekText.searchKey(query).toUpperCase(),
          }) {
            final results = search.find(spelling);
            expect(
              results.any(
                (result) =>
                    identical(result, card) ||
                    (card.reviewIdentity != null &&
                        result.reviewIdentity?.key(StudyMode.flashcards) ==
                            card.reviewIdentity!.key(StudyMode.flashcards)),
              ),
              isTrue,
              reason:
                  '${collection.deck.id}/${card.id} missing for "$spelling"',
            );
          }
        }
        checkedCards++;
      }
    }
    expect(checkedCards, greaterThan(0));
  });

  test('shared cards appear once across Words, Phrases and Grammar', () {
    const text = LocalizedText(en: '', ru: '');
    const word = VocabularyCard(
      id: 'shared-word',
      greek: 'γεια',
      prompt: text,
      meaning: text,
      pronunciation: text,
      reviewIdentity: ReviewIdentity(deckId: 'original', cardId: 'hello'),
    );
    const phrase = VocabularyCard(
      id: 'phrase',
      greek: 'γεια σου',
      prompt: text,
      meaning: text,
      pronunciation: text,
    );
    const exercise = VocabularyCard(
      id: 'exercise',
      greek: 'Λέω γεια.',
      prompt: text,
      meaning: text,
      pronunciation: text,
    );
    LearningCollection collection(
      String id,
      LearningSection section,
      VocabularyCard card,
    ) => LearningCollection(
      section: section,
      deck: VocabularyDeck(
        id: id,
        title: text,
        subtitle: text,
        cover: '',
        cards: [card],
      ),
    );
    final search = WordSearch([
      collection('words-a', LearningSection.words, word),
      collection('words-b', LearningSection.words, word),
      collection('phrases', LearningSection.phrases, phrase),
      collection('grammar', LearningSection.grammar, exercise),
    ]);
    expect(search.find('γεια'), [word, phrase, exercise]);
    expect(search.find('γεια σου'), [phrase]);
  });
}
