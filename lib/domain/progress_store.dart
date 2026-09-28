import 'review_schedule.dart';

abstract interface class ProgressStore {
  Future<ReviewSchedule?> read(String key);
  Future<void> write(String key, ReviewSchedule schedule);
}
