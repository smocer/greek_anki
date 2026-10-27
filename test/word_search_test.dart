import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/curriculum.dart';
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
    expect(search.find('αθην').single.greek, 'Αθήνα');
    expect(search.find('η χώρα').single.greek, 'χώρα');
    expect(search.find('πάλι').single.greek, 'ξανά');
    expect(search.find('κάποιον').single.greek, 'κάποιος');
    expect(search.find('επικίνδυνος').single.greek, 'επικίνδυνος');
    expect(search.find('επικίνδυνοσ').single.greek, 'επικίνδυνος');
  });

  test('empty and unmatched searches do not return the whole catalog', () {
    final search = WordSearch(currentDictionary.collections);
    for (final query in ['', '   ', ';;', 'αβγδεζηθικλ', 'dangerous']) {
      expect(search.find(query), isEmpty, reason: query);
    }
  });

  test('shared vocabulary appears once and exercises are excluded', () {
    const text = LocalizedText(en: '', ru: '');
    const word = VocabularyCard(
      id: 'shared-word',
      greek: 'γεια',
      prompt: text,
      meaning: text,
      pronunciation: text,
      reviewIdentity: ReviewIdentity(deckId: 'original', cardId: 'hello'),
    );
    const exercise = VocabularyCard(
      id: 'exercise',
      greek: 'γεια σου',
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
      collection('phrases', LearningSection.phrases, exercise),
      collection('grammar', LearningSection.grammar, exercise),
    ]);
    expect(search.find('γεια'), [word]);
    expect(search.find('γεια σου'), isEmpty);
  });
}
