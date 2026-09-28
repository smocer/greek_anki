import 'package:shared_preferences/shared_preferences.dart';

import '../domain/progress_store.dart';
import '../domain/review_schedule.dart';

// Adapter: the rest of the app knows only the small ProgressStore interface.
class PreferencesProgressStore implements ProgressStore {
  PreferencesProgressStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<ReviewSchedule?> read(String key) async {
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
      _preferences.setStringList('review.v1.$key', [
        schedule.level.toString(),
        schedule.dueAt.toUtc().toIso8601String(),
      ]);
}
