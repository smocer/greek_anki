class ReviewSchedule {
  const ReviewSchedule({required this.level, required this.dueAt});

  final int level;
  final DateTime dueAt;

  static const intervalsInDays = [1, 3, 7, 14, 30];

  bool isDue(DateTime now) => !dueAt.isAfter(now);

  static ReviewSchedule afterAnswer({
    required ReviewSchedule? previous,
    required bool correct,
    required DateTime now,
  }) {
    if (!correct) return ReviewSchedule(level: 0, dueAt: now);
    // Extra practice before a due date cannot accelerate the review schedule.
    if (previous != null && !previous.isDue(now)) return previous;
    final level = ((previous?.level ?? 0) + 1).clamp(1, intervalsInDays.length);
    return ReviewSchedule(
      level: level,
      dueAt: now.add(Duration(days: intervalsInDays[level - 1])),
    );
  }
}
