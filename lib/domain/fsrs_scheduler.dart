import 'package:fsrs/fsrs.dart' as fsrs;

import 'recall_attempt.dart';

/// Adapter: FSRS owns the memory equations; the session owns short practice
/// steps. Never map a forgotten answer to FSRS's successful "Hard" rating.
class FsrsScheduler {
  static final _scheduler = fsrs.Scheduler(
    desiredRetention: 0.9,
    learningSteps: const [],
    relearningSteps: const [],
    enableFuzzing: false,
  );

  static fsrs.Card review(fsrs.Card? memory, RecallAttempt attempt) =>
      _scheduler
          .reviewCard(
            memory ?? fsrs.Card(cardId: 0, due: attempt.at),
            attempt.correct ? fsrs.Rating.good : fsrs.Rating.again,
            reviewDateTime: attempt.at.toUtc(),
          )
          .card;

  static double retrievability(fsrs.Card memory, DateTime now) =>
      _scheduler.getCardRetrievability(memory, currentDateTime: now.toUtc());

  /// Legacy records have no review log. Preserve their due date and seed a
  /// conservative memory estimate from the old interval, without fabricating
  /// historical attempts. Subsequent real reviews replace this estimate.
  static fsrs.Card migrate(int days, DateTime due) {
    final last = due.toUtc().subtract(Duration(days: days));
    final initial = review(
      null,
      RecallAttempt(
        id: 'migration',
        at: last,
        outcome: RecallOutcome.correct,
        independent: true,
      ),
    );
    return initial.copyWith(stability: days.toDouble(), due: due.toUtc());
  }
}
