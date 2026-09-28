import 'package:flutter/foundation.dart';

import 'progress_store.dart';
import 'review_schedule.dart';
import 'vocabulary.dart';

// Observer: ChangeNotifier updates the home screen after a persisted answer.
class LearningProgress extends ChangeNotifier {
  LearningProgress(this._store, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final ProgressStore _store;
  final DateTime Function() _now;
  final Map<String, ReviewSchedule> _records = {};

  String _key(VocabularyDeck deck, StudyMode mode, VocabularyCard card) =>
      '${deck.id}.${mode.name}.${card.id}';

  Future<void> load(List<VocabularyDeck> decks) async {
    final loaded = <String, ReviewSchedule>{};
    for (final deck in decks) {
      for (final mode in StudyMode.values) {
        for (final card in deck.cards) {
          final key = _key(deck, mode, card);
          final record = await _store.read(key);
          if (record != null) loaded[key] = record;
        }
      }
    }
    _records
      ..clear()
      ..addAll(loaded);
    notifyListeners();
  }

  int learned(VocabularyDeck deck, StudyMode mode) => deck.cards
      .where((card) => (_records[_key(deck, mode, card)]?.level ?? 0) > 0)
      .length;

  List<VocabularyCard> dueCards(VocabularyDeck deck, StudyMode mode) {
    final now = _now();
    return deck.cards.where((card) {
      final record = _records[_key(deck, mode, card)];
      return record == null || record.isDue(now);
    }).toList();
  }

  Future<void> record({
    required VocabularyDeck deck,
    required StudyMode mode,
    required VocabularyCard card,
    required bool correct,
  }) async {
    final key = _key(deck, mode, card);
    final schedule = ReviewSchedule.afterAnswer(
      previous: _records[key],
      correct: correct,
      now: _now(),
    );
    await _store.write(key, schedule);
    _records[key] = schedule;
    notifyListeners();
  }
}
