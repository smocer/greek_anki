import '../domain/curriculum.dart';
import '../domain/vocabulary.dart';
import 'dictionary.dart';

// Number cards remain in the source archive for old identities; practice uses
// the infinite number drill instead of a finite vocabulary collection.
List<LearningCollection> get learningCollections => currentDictionary
    .collections
    .where((collection) => collection.deck.id != 'words-numbers')
    .toList(growable: false);
List<VocabularyDeck> get learningDecks => learningCollections
    .map((collection) => collection.deck)
    .toList(growable: false);
