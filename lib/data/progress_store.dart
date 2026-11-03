import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/progress_store.dart';
import '../domain/review_schedule.dart';
import '../domain/recall_attempt.dart';

// Adapter: the rest of the app knows only the small ProgressStore interface.
class PreferencesProgressStore implements ProgressStore {
  PreferencesProgressStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<ReviewSchedule?> read(String key) async {
    final saved = await _preferences.getString('review.v2.$key');
    if (saved != null) return decodeReviewSchedule(saved);
    final values = await _preferences.getStringList('review.v1.$key');
    if (values == null) return null;
    if (values.length != 2) {
      throw const FormatException('Invalid review record');
    }
    final level = int.parse(values[0]);
    if (level < 0 || level > ReviewSchedule.intervalsInDays.length) {
      throw const FormatException('Invalid review level');
    }
    return ReviewSchedule(level: level, dueAt: DateTime.parse(values[1]));
  }

  @override
  Future<void> write(String key, ReviewSchedule schedule) =>
      _preferences.setString('review.v2.$key', encodeReviewSchedule(schedule));
}

String encodeReviewSchedule(ReviewSchedule schedule) => jsonEncode({
  'version': 2,
  'level': schedule.level,
  'dueAt': schedule.dueAt.toUtc().toIso8601String(),
  'memory': schedule.memory,
  'attempts': schedule.attempts.map((a) => a.toMap()).toList(),
});

ReviewSchedule decodeReviewSchedule(String saved) {
  final data = jsonDecode(saved) as Map<String, dynamic>;
  if (data['version'] != 2 ||
      (data['level'] as int) < 0 ||
      (data['level'] as int) > 5) {
    throw const FormatException('Invalid review record');
  }
  return ReviewSchedule(
    level: data['level'] as int,
    dueAt: DateTime.parse(data['dueAt'] as String).toUtc(),
    memory: data['memory'] == null
        ? null
        : Map.unmodifiable(data['memory'] as Map<String, dynamic>),
    attempts: List.unmodifiable(
      (data['attempts'] as List).map(
        (a) => RecallAttempt.fromMap(a as Map<String, dynamic>),
      ),
    ),
  );
}
