import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/domain/date_drill.dart';
import 'number_drill_test.dart' show FixedRandom;

void main() {
  const answer = GreekDateAnswer();
  test(
    'current year, leap years and last minute are generated as civil dates',
    () {
      var year = 2026;
      final random = FixedRandom(0);
      final generator = DateDrillGenerator(
        random: random,
        now: () => DateTime(year, 7),
      );
      expect(generator.next().date, DateTime.utc(2026));
      expect(random.bound, 365 * 24 * 60);
      year = 2028;
      expect(generator.next().date, DateTime.utc(2028));
      expect(random.bound, 366 * 24 * 60);
      final last = DateDrillGenerator(
        random: FixedRandom(366 * 1440 - 1),
        now: () => DateTime(2028),
      );
      expect(last.next().date, DateTime.utc(2028, 12, 31, 23, 59));
      final sample = DateDrillGenerator(
        random: Random(5),
        now: () => DateTime(2026),
      );
      final months = <int>{}, minutes = <int>{};
      for (var i = 0; i < 5000; i++) {
        final date = sample.next().date;
        expect(date.year, 2026);
        months.add(date.month);
        minutes.add(date.minute);
      }
      expect(months.length, 12);
      expect(minutes.length, 60);
    },
  );
  test('every day and minute has an accepted display answer', () {
    for (var day = 0; day < 366; day++) {
      final q = DateDrillQuestion(DateTime.utc(2028).add(Duration(days: day)));
      expect(answer.matchesDate(answer.displayDate(q), q), isTrue);
    }
    for (var minute = 0; minute < 1440; minute++) {
      final q = DateDrillQuestion(
        DateTime.utc(2026, 11, 7).add(Duration(minutes: minute)),
      );
      expect(answer.matchesTime(answer.displayTime(q), q), isTrue);
    }
  });
  test('separate date and time inputs accept simple natural word orders', () {
    final q = DateDrillQuestion(DateTime.utc(2026, 11, 7, 11, 50));
    for (final date in [
      'Το Σάββατο επτά Νοεμβρίου.',
      'Σάββατο εφτά Νοεμβρίου',
      'Επτά Νοεμβρίου, το Σάββατο',
    ]) {
      expect(answer.matchesDate(date, q), isTrue, reason: date);
    }
    for (final time in [
      'Έντεκα και πενήντα το πρωί.',
      'Στις έντεκα και πενήντα το πρωί',
      'Το πρωί, δώδεκα παρά δέκα',
      'Είναι δώδεκα παρά δέκα το πρωί',
    ]) {
      expect(answer.matchesTime(time, q), isTrue, reason: time);
    }
    for (final bad in [
      'Σάββατο επτά Νοέμβριος',
      'Κυριακή επτά Νοεμβρίου',
      'Σάββατο οχτώ Νοεμβρίου',
      'Σάββατο 7 Νοεμβρίου',
      'Σάββατο επτά Νοεμβρίου 2026',
      'Σαββατο επτά Νοεμβρίου',
    ]) {
      expect(answer.matchesDate(bad, q), isFalse, reason: bad);
    }
    for (final bad in [
      'έντεκα και πενήντα',
      'έντεκα και πενήντα το βράδυ',
      'έντεκα και πέντε το πρωί',
      'έντεκα και πενηντα το πρωί',
    ]) {
      expect(answer.matchesTime(bad, q), isFalse, reason: bad);
    }
  });
  test('dates use feminine counts, genitive month and first of month', () {
    for (final (date, text) in [
      (DateTime.utc(2026, 11, 1), 'Κυριακή πρώτη Νοεμβρίου'),
      (DateTime.utc(2026, 11, 3), 'Την Τρίτη τρεις Νοεμβρίου'),
      (DateTime.utc(2026, 11, 4), 'Τετάρτη τέσσερις Νοεμβρίου'),
      (DateTime.utc(2026, 11, 13), 'Παρασκευή δεκατρείς Νοεμβρίου'),
      (DateTime.utc(2026, 11, 21), 'Σάββατο είκοσι μία Νοεμβρίου'),
      (DateTime.utc(2026, 5, 1), 'Παρασκευή πρώτη Μαΐου'),
    ]) {
      expect(
        answer.matchesDate(text, DateDrillQuestion(date)),
        isTrue,
        reason: text,
      );
    }
    final q = DateDrillQuestion(DateTime.utc(2026, 11, 3));
    expect(answer.matchesDate('Τρίτη τρία Νοεμβρίου', q), isFalse);
  });
  test('period boundaries, midnight/noon and singular hours are explicit', () {
    final expected = {
      0: DayPeriod.night,
      4: DayPeriod.night,
      5: DayPeriod.morning,
      11: DayPeriod.morning,
      12: DayPeriod.midday,
      14: DayPeriod.midday,
      15: DayPeriod.afternoon,
      18: DayPeriod.afternoon,
      19: DayPeriod.evening,
      23: DayPeriod.evening,
    };
    for (final entry in expected.entries) {
      expect(DayPeriod.at(entry.key), entry.value);
    }
    for (final (hour, minute, text) in [
      (0, 0, 'δώδεκα τη νύχτα'),
      (12, 0, 'δώδεκα το μεσημέρι'),
      (13, 1, 'στη μία και ένα λεπτό το μεσημέρι'),
      (13, 30, 'στη μιάμιση το μεσημέρι'),
      (23, 59, 'στις δώδεκα παρά ένα λεπτό το βράδυ'),
      (1, 31, 'δύο παρά είκοσι εννέα την νύχτα'),
    ]) {
      expect(
        answer.matchesTime(
          text,
          DateDrillQuestion(DateTime.utc(2026, 1, 1, hour, minute)),
        ),
        isTrue,
        reason: text,
      );
    }
  });
}
