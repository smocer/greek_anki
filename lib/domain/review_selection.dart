import 'dart:math';

import 'recall_attempt.dart';

enum SessionStyle { learning, reviewAll }

/// Per-session evidence survives Back/reload along with the queue.
class PracticeEvidence {
  PracticeEvidence({
    this.lastTurn,
    this.presentations = 0,
    this.failures = 0,
    this.confirmations = 0,
    this.recent = const [],
  });

  final int? lastTurn;
  final int presentations, failures, confirmations;
  final List<RecallAttempt> recent;

  PracticeEvidence after(
    RecallAttempt attempt,
    int turn, {
    required bool historicallyWeak,
  }) => PracticeEvidence(
    lastTurn: turn,
    presentations: presentations + 1,
    failures: failures + (attempt.correct ? 0 : 1),
    confirmations: !attempt.correct
        ? 2
        : presentations == 0 && historicallyWeak
        ? 2
        : attempt.independent
        ? max(0, confirmations - 1)
        : confirmations,
    recent: [
      ...recent,
      if (attempt.independent || !attempt.correct) attempt,
    ].reversed.take(5).toList().reversed.toList(),
  );

  Map<String, Object?> toMap() => {
    'lastTurn': lastTurn,
    'presentations': presentations,
    'failures': failures,
    'confirmations': confirmations,
    'recent': recent.map((a) => a.toMap()).toList(),
  };

  factory PracticeEvidence.fromMap(Map<String, dynamic> map) {
    final evidence = PracticeEvidence(
      lastTurn: map['lastTurn'] as int?,
      presentations: map['presentations'] as int,
      failures: map['failures'] as int,
      confirmations: map['confirmations'] as int,
      recent: (map['recent'] as List)
          .map((a) => RecallAttempt.fromMap(a as Map<String, dynamic>))
          .toList(),
    );
    if (evidence.presentations < 0 ||
        evidence.failures < 0 ||
        evidence.confirmations < 0 ||
        evidence.confirmations > 2 ||
        (evidence.lastTurn ?? 0) < 0) {
      throw const FormatException('Invalid practice evidence');
    }
    return evidence;
  }
}

class ReviewCandidate {
  const ReviewCandidate({
    required this.key,
    required this.weakness,
    required this.lastTurn,
    required this.presentations,
    required this.lastReviewAt,
    required this.confirmations,
  });
  final String key;
  final double weakness;
  final int? lastTurn;
  final int presentations, confirmations;
  final DateTime? lastReviewAt;
}

/// Strategy: bounded weighted sampling with a cooldown and a coverage turn.
/// The queue can use the same policy for optional reviews and confirmations.
class ReviewSelection {
  const ReviewSelection();
  static const cooldown = 8;

  String choose(
    List<ReviewCandidate> candidates, {
    required int turn,
    required int pick,
    required Random random,
    required int minimumGap,
  }) {
    final eligible = candidates
        .where(
          (c) => c.lastTurn == null || turn - c.lastTurn! - 1 >= minimumGap,
        )
        .toList();
    if (eligible.isEmpty) {
      // With a tiny pool a full cooldown is impossible. Rotate the oldest card
      // instead of repeatedly falling back to the highest error score.
      return _oldest(candidates).key;
    }
    if (pick % 5 == 4) return _oldest(eligible).key;
    final weak = eligible
        .where((c) => c.weakness >= 0.15 || c.confirmations > 0)
        .toList();
    if (weak.isEmpty) return _oldest(eligible).key;
    double weight(ReviewCandidate c) =>
        (1 + 3 * c.weakness.clamp(0, 1) + (c.confirmations > 0 ? 1 : 0)) /
        (1 + c.presentations * 0.25);
    var draw = random.nextDouble() * weak.fold(0.0, (n, c) => n + weight(c));
    for (final candidate in weak) {
      draw -= weight(candidate);
      if (draw <= 0) return candidate.key;
    }
    return weak.last.key;
  }

  ReviewCandidate _oldest(List<ReviewCandidate> candidates) =>
      candidates.reduce((a, b) {
        final turns = (a.lastTurn ?? -1).compareTo(b.lastTurn ?? -1);
        if (turns != 0) return turns < 0 ? a : b;
        final dates = (a.lastReviewAt ?? DateTime.utc(1970)).compareTo(
          b.lastReviewAt ?? DateTime.utc(1970),
        );
        return dates <= 0 ? a : b;
      });
}
