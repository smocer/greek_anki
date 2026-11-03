import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greek_anki/data/progress_store.dart';
import 'package:greek_anki/domain/recall_attempt.dart';
import 'package:greek_anki/domain/review_schedule.dart';

class _Preferences implements SharedPreferencesAsync {
  final values = <String, Object>{};
  @override
  Future<String?> getString(String key) async => values[key] as String?;
  @override
  Future<List<String>?> getStringList(String key) async =>
      values[key] as List<String>?;
  @override
  Future<void> setString(String key, String value) async {
    values[key] = value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final start = DateTime.utc(2026, 11, 3);
  RecallAttempt attempt(
    String id,
    DateTime at, {
    bool correct = true,
    bool independent = true,
  }) => RecallAttempt(
    id: id,
    at: at,
    outcome: correct ? RecallOutcome.correct : RecallOutcome.incorrect,
    independent: independent,
  );

  test(
    'v1 migration preserves due date and progress; subsequent reviews use FSRS',
    () async {
      final preferences = _Preferences();
      final due = start.add(const Duration(days: 12));
      preferences.values['review.v1.verbs'] = ['4', due.toIso8601String()];
      final store = PreferencesProgressStore(preferences: preferences);
      final legacy = (await store.read('verbs'))!;
      expect(legacy.level, 4);
      expect(legacy.dueAt, due);
      expect(legacy.attempts, isEmpty);
      final early = ReviewSchedule.afterAttempt(
        previous: legacy,
        attempt: attempt('1', start),
      );
      expect(early.dueAt, due);
      expect(early.attempts, hasLength(1));
      await store.write('verbs', early);
      final reloaded = (await store.read('verbs'))!;
      final scheduled = ReviewSchedule.afterAttempt(
        previous: reloaded,
        attempt: attempt('2', due),
      );
      expect(scheduled.memory, isNotNull);
      expect(scheduled.dueAt.isAfter(due), isTrue);
      expect(scheduled.attempts.map((a) => a.id), ['1', '2']);
      expect(preferences.values['review.v1.verbs'], [
        '4',
        due.toIso8601String(),
      ]);
    },
  );

  test('FSRS grows past 30 days and a lapse shortens the next interval', () {
    ReviewSchedule? record;
    var date = start;
    for (var i = 0; i < 6; i++) {
      record = ReviewSchedule.afterAttempt(
        previous: record,
        attempt: attempt('$i', date),
      );
      date = record.dueAt;
    }
    final previousStability = (record!.memory!['stability'] as num).toDouble();
    expect(previousStability, greaterThan(30));
    final forgotten = ReviewSchedule.afterAttempt(
      previous: record,
      attempt: attempt('forgot', date, correct: false),
    );
    expect(forgotten.isDue(date), isTrue);
    expect(forgotten.level, 0);
    expect(forgotten.memory!['stability'], lessThan(previousStability));
    final retry = ReviewSchedule.afterAttempt(
      previous: forgotten,
      attempt: attempt(
        'retry',
        date.add(const Duration(seconds: 10)),
        independent: false,
      ),
    );
    expect(retry.memory, forgotten.memory);
    expect(retry.dueAt, forgotten.dueAt);
    final recovered = ReviewSchedule.afterAttempt(
      previous: retry,
      attempt: attempt('spaced', date.add(const Duration(minutes: 5))),
    );
    expect(recovered.dueAt.isAfter(date), isTrue);
    expect(recovered.memory!['stability'], lessThan(previousStability));
  });

  test(
    'full history and FSRS state round-trip; crash replay is idempotent',
    () async {
      final preferences = _Preferences();
      final store = PreferencesProgressStore(preferences: preferences);
      ReviewSchedule? record;
      for (var i = 0; i < 30; i++) {
        record = ReviewSchedule.afterAttempt(
          previous: record,
          attempt: attempt(
            '$i',
            start.add(Duration(minutes: i)),
            correct: i % 3 != 0,
          ),
        );
      }
      await store.write('typing.verb', record!);
      final loaded = (await PreferencesProgressStore(
        preferences: preferences,
      ).read('typing.verb'))!;
      expect(loaded.attempts, hasLength(30));
      expect(loaded.memory, record.memory);
      expect(loaded.dueAt, record.dueAt);
      final replayed = ReviewSchedule.afterAttempt(
        previous: loaded,
        attempt: record.attempts.last,
      );
      expect(replayed, same(loaded));
      expect(await store.read('flashcards.verb'), isNull);
      expect(encodeReviewSchedule(loaded), encodeReviewSchedule(record));
    },
  );

  test(
    'early successful drills add evidence without inflating long-term memory',
    () {
      final first = ReviewSchedule.afterAttempt(
        previous: null,
        attempt: attempt('first', start),
      );
      var record = first;
      for (var i = 1; i <= 50; i++) {
        record = ReviewSchedule.afterAttempt(
          previous: record,
          attempt: attempt('$i', start.add(Duration(seconds: i * 10))),
        );
      }
      expect(record.attempts, hasLength(51));
      expect(record.memory, first.memory);
      expect(record.dueAt, first.dueAt);
      expect(
        record.recallProbability(start.add(const Duration(days: 30))),
        lessThan(record.recallProbability(start)),
      );
    },
  );
}
