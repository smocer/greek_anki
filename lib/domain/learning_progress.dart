import 'package:flutter/foundation.dart';

import 'progress_store.dart';
import 'review_schedule.dart';
import 'recall_attempt.dart';
import 'vocabulary.dart';

// Observer: ChangeNotifier updates the home screen after a persisted answer.
class LearningProgress extends ChangeNotifier {
  LearningProgress(this._store, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final ProgressStore _store;
  final DateTime Function() _now;
  final Map<String, ReviewSchedule> _records = {};

  String _key(VocabularyDeck deck, StudyMode mode, VocabularyCard card) =>
      card.reviewIdentity?.key(mode) ?? '${deck.id}.${mode.name}.${card.id}';

  Future<void> load(List<VocabularyDeck> decks) async {
    final loaded = <String, ReviewSchedule>{};
    for (final deck in decks) {
      for (final mode in StudyMode.values) {
        for (final card in deck.cards) {
          final key = _key(deck, mode, card);
          var record = await _store.read(key);
          if (record == null) {
            for (final alias in card.reviewAliases) {
              final previous = await _store.read(alias.key(mode));
              if (previous != null &&
                  (record == null || previous.dueAt.isBefore(record.dueAt))) {
                record = previous;
              }
            }
          }
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

  ReviewSchedule? schedule(
    VocabularyDeck deck,
    StudyMode mode,
    VocabularyCard card,
  ) => _records[_key(deck, mode, card)];

  List<VocabularyCard> dueCards(VocabularyDeck deck, StudyMode mode) {
    final now = _now();
    return deck.cards.where((card) {
      final record = _records[_key(deck, mode, card)];
      return record == null || record.isDue(now);
    }).toList();
  }

  Future<void> defer({
    required VocabularyDeck deck,
    required StudyMode mode,
    required VocabularyCard card,
  }) async {
    final key = _key(deck, mode, card);
    final previous = _records[key];
    if (previous == null) return;
    final schedule = ReviewSchedule(
      level: 0,
      dueAt: _now().toUtc(),
      memory: previous.memory,
      attempts: previous.attempts,
    );
    await _store.write(key, schedule);
    _records[key] = schedule;
    notifyListeners();
  }

  Future<void> record({
    required VocabularyDeck deck,
    required StudyMode mode,
    required VocabularyCard card,
    required bool correct,
    RecallAttempt? attempt,
  }) async {
    final key = _key(deck, mode, card);
    final schedule = attempt == null
        ? ReviewSchedule.afterAnswer(
            previous: _records[key],
            correct: correct,
            now: _now(),
          )
        : ReviewSchedule.afterAttempt(
            previous: _records[key],
            attempt: attempt,
          );
    await _store.write(key, schedule);
    _records[key] = schedule;
    notifyListeners();
  }
}
