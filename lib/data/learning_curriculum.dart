import '../domain/curriculum.dart';
import '../domain/vocabulary.dart';
import 'dictionary.dart';

List<LearningCollection> get learningCollections =>
    currentDictionary.collections;
List<VocabularyDeck> get learningDecks => currentDictionary.learningDecks;
