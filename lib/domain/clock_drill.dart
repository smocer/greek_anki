import 'dart:math';

import 'greek_text.dart';
import 'number_drill.dart';

/// A twelve-hour time. The clock drill uses five-minute steps; date practice
/// uses [ClockTime.toMinute] for arbitrary minutes.
class ClockTime {
  factory ClockTime(int hour, int minute) {
    final time = ClockTime.toMinute(hour, minute);
    if (minute % 5 != 0) {
      throw ArgumentError.value(minute, 'minute', 'Must be a multiple of five');
    }
    return time;
  }

  ClockTime.toMinute(this.hour, this.minute) {
    RangeError.checkValueInInterval(hour, 1, 12, 'hour');
    RangeError.checkValueInInterval(minute, 0, 59, 'minute');
  }

  final int hour;
  final int minute;

  int get slot => (hour % 12) * 12 + minute ~/ 5;
  int get nextHour => hour % 12 + 1;
  String get digital => '$hour:${minute.toString().padLeft(2, '0')}';
}

class ClockTimeGenerator {
  ClockTimeGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  ClockTime next({ClockTime? previous}) {
    // Select uniformly from the other positions without a retry loop.
    var slot = _random.nextInt(previous == null ? 144 : 143);
    if (previous != null && slot >= previous.slot) slot++;
    final hour = slot ~/ 12;
    return ClockTime(hour == 0 ? 12 : hour, slot % 12 * 5);
  }
}

/// Spoken clock answers use feminine hours and neuter minute counts.
class GreekClockAnswer {
  const GreekClockAnswer();

  static const _hours = [
    <String>[],
    ['μία', 'μια'],
    ['δύο', 'δυο'],
    ['τρεις'],
    ['τέσσερις'],
    ['πέντε'],
    ['έξι'],
    ['εφτά', 'επτά'],
    ['οχτώ', 'οκτώ'],
    ['εννιά', 'εννέα'],
    ['δέκα'],
    ['έντεκα'],
    ['δώδεκα'],
  ];
  static const _numbers = GreekNumberAnswer();
  static const _halfHours = [
    <String>[],
    ['μιάμιση'],
    ['δυόμισι'],
    ['τρεισήμισι'],
    ['τεσσερισήμισι'],
    ['πεντέμισι'],
    ['εξίμισι'],
    ['εφτάμισι', 'επτάμισι'],
    ['οχτώμισι', 'οκτώμισι'],
    ['εννιάμισι', 'εννεάμισι'],
    ['δεκάμισι'],
    ['εντεκάμισι'],
    ['δωδεκάμισι'],
  ];

  String display(ClockTime time) {
    final hour = _hours[time.hour].first;
    final minute = time.minute;
    final phrase = switch (minute) {
      0 => '$hour ακριβώς',
      15 => '$hour και τέταρτο',
      30 => '$hour και μισή',
      45 => '${_hours[time.nextHour].first} παρά τέταρτο',
      > 30 =>
        '${_hours[time.nextHour].first} παρά ${_numbers.display(60 - minute)}',
      _ => '$hour και ${_numbers.display(minute)}',
    };
    return 'Είναι $phrase.';
  }

  bool matches(String input, ClockTime time) {
    final key = GreekText.answerKey(input);
    return answersFor(time).any((answer) => GreekText.answerKey(answer) == key);
  }

  Iterable<String> phrasesFor(ClockTime time) sync* {
    final phrases = <String>{};
    for (final hour in _hours[time.hour]) {
      if (time.minute == 0) {
        phrases.addAll([hour, '$hour ακριβώς', '$hour η ώρα']);
      } else {
        for (final minutes in _numbers.answersFor(time.minute)) {
          final unit = time.minute == 1 ? 'λεπτό' : 'λεπτά';
          phrases.addAll(['$hour και $minutes', '$hour και $minutes $unit']);
        }
        if (time.minute == 15) phrases.add('$hour και τέταρτο');
        if (time.minute == 30) phrases.add('$hour και μισή');
      }
    }
    if (time.minute > 30) {
      for (final hour in _hours[time.nextHour]) {
        for (final minutes in _numbers.answersFor(60 - time.minute)) {
          final unit = time.minute == 59 ? 'λεπτό' : 'λεπτά';
          phrases.addAll(['$hour παρά $minutes', '$hour παρά $minutes $unit']);
        }
        if (time.minute == 45) phrases.add('$hour παρά τέταρτο');
      }
    }
    if (time.minute == 30) phrases.addAll(_halfHours[time.hour]);

    yield* phrases;
  }

  Iterable<String> answersFor(ClockTime time) sync* {
    for (final phrase in phrasesFor(time)) {
      yield phrase;
      yield 'Είναι $phrase';
      if (!phrase.endsWith('η ώρα')) yield 'Η ώρα είναι $phrase';
    }
  }
}
