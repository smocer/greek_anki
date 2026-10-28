import 'dart:convert';

import 'curriculum.dart';
import 'study_session.dart';
import 'vocabulary.dart';

/// Identify the chosen pool, not today's due cards or its random ordering.
/// This keeps bookmarks separate for filters, batch sizes and study modes.
String studySessionKey({
  required VocabularyDeck deck,
  required StudyMode mode,
  required int? limit,
  required CardOrder order,
}) => jsonEncode([
  deck.id,
  mode.name,
  limit,
  order.name,
  (deck.cards.map((card) => card.reviewIdentity?.key(mode) ?? card.id).toList()
    ..sort()),
]);

abstract interface class StudySessionStore {
  Future<StudySessionSnapshot?> read(String key);
  Future<void> write(String key, StudySessionSnapshot snapshot);
  Future<void> remove(String key);
}
