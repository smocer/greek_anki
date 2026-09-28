import 'package:greek_anki/domain/progress_store.dart';
import 'package:greek_anki/domain/review_schedule.dart';

class MemoryProgressStore implements ProgressStore {
  final records = <String, ReviewSchedule>{};
  bool shouldFail = false;

  @override
  Future<ReviewSchedule?> read(String key) async => records[key];

  @override
  Future<void> write(String key, ReviewSchedule schedule) async {
    if (shouldFail) throw StateError('Disk unavailable');
    records[key] = schedule;
  }
}
