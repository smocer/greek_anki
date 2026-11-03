enum RecallOutcome { correct, accentError, incorrect, skipped }

/// One submitted answer, not a keystroke or a view of the answer.
class RecallAttempt {
  const RecallAttempt({
    required this.id,
    required this.at,
    required this.outcome,
    required this.independent,
  });

  final String id;
  final DateTime at;
  final RecallOutcome outcome;
  final bool independent;
  bool get correct => outcome == RecallOutcome.correct;

  Map<String, Object?> toMap() => {
    'id': id,
    'at': at.toUtc().toIso8601String(),
    'outcome': outcome.name,
    'independent': independent,
  };

  factory RecallAttempt.fromMap(Map<String, dynamic> map) => RecallAttempt(
    id: map['id'] as String,
    at: DateTime.parse(map['at'] as String).toUtc(),
    outcome: RecallOutcome.values.byName(map['outcome'] as String),
    independent: map['independent'] as bool,
  );
}

/// Recent independent successes retire old difficulty. Quick corrections do
/// not overwrite a failure; repeated failures remain useful evidence.
double recallWeakness(Iterable<RecallAttempt> history) {
  final recent = history
      .where((attempt) => attempt.independent || !attempt.correct)
      .toList()
      .reversed
      .take(5)
      .toList();
  if (recent.isEmpty) return 0;
  if (recent.length >= 2 && recent.take(2).every((a) => a.correct)) return 0;
  var weight = 1.0;
  var total = 0.0;
  var failures = 0.0;
  for (final attempt in recent) {
    final severity = switch (attempt.outcome) {
      RecallOutcome.correct => 0.0,
      RecallOutcome.accentError => 0.35,
      RecallOutcome.incorrect || RecallOutcome.skipped => 1.0,
    };
    failures += severity * weight;
    total += weight;
    weight *= 0.65;
  }
  return failures / total;
}
