import 'package:fsrs/fsrs.dart' as fsrs;

import 'fsrs_scheduler.dart';
import 'recall_attempt.dart';

class ReviewSchedule {
  const ReviewSchedule({
    required this.level,
    required this.dueAt,
    this.memory,
    this.attempts = const [],
  });

  final int level;
  final DateTime dueAt;
  // Serialized FSRS state keeps mutable package objects out of app state.
  final Map<String, dynamic>? memory;
  final List<RecallAttempt> attempts;

  static const intervalsInDays = [1, 3, 7, 14, 30];

  bool isDue(DateTime now) => !dueAt.isAfter(now);

  double get weakness => recallWeakness(attempts);
  DateTime? get lastAttemptAt => attempts.lastOrNull?.at;

  double recallProbability(DateTime now) => memory == null
      ? (isDue(now) ? 0.8 : 1)
      : FsrsScheduler.retrievability(fsrs.Card.fromMap(memory!), now);

  static ReviewSchedule afterAttempt({
    required ReviewSchedule? previous,
    required RecallAttempt attempt,
  }) {
    // A reload between saving the answer and saving the session can replay it.
    if (previous?.attempts.any((a) => a.id == attempt.id) ?? false) {
      return previous!;
    }
    final history = List<RecallAttempt>.unmodifiable([
      ...?previous?.attempts,
      attempt,
    ]);
    final shouldSchedule =
        previous == null ||
        !attempt.correct ||
        (attempt.independent && previous.isDue(attempt.at));
    if (!shouldSchedule) {
      return ReviewSchedule(
        level: previous.level,
        dueAt: previous.dueAt,
        memory: previous.memory,
        attempts: history,
      );
    }
    final oldMemory = previous?.memory;
    final memory = FsrsScheduler.review(
      oldMemory != null
          ? fsrs.Card.fromMap(oldMemory)
          : previous != null && previous.level > 0
          ? FsrsScheduler.migrate(
              intervalsInDays[(previous.level - 1).clamp(0, 4)],
              previous.dueAt,
            )
          : null,
      attempt,
    );
    return ReviewSchedule(
      level: attempt.correct ? ((previous?.level ?? 0) + 1).clamp(1, 5) : 0,
      dueAt: attempt.correct ? memory.due : attempt.at,
      memory: Map.unmodifiable(memory.toMap()),
      attempts: history,
    );
  }

  static ReviewSchedule afterAnswer({
    required ReviewSchedule? previous,
    required bool correct,
    required DateTime now,
  }) {
    return afterAttempt(
      previous: previous,
      attempt: RecallAttempt(
        id: '${now.microsecondsSinceEpoch}:${previous?.attempts.length ?? 0}',
        at: now.toUtc(),
        outcome: correct ? RecallOutcome.correct : RecallOutcome.incorrect,
        independent: true,
      ),
    );
  }
}
