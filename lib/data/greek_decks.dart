import '../domain/vocabulary.dart';
import 'dictionary.dart';

/// Source topics come from the dictionary, rather than Dart card literals.
List<VocabularyDeck> get greekDecks => currentDictionary.decks;
