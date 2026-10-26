import 'dart:math';

import 'greek_text.dart';

/// A position on a twelve-hour clock, in five-minute steps.
class ClockTime {
  ClockTime(this.hour, this.minute) {
    RangeError.checkValueInInterval(hour, 1, 12, 'hour');
    RangeError.checkValueInInterval(minute, 0, 55, 'minute');
    if (minute % 5 != 0) {
      throw ArgumentError.value(minute, 'minute', 'Must be a multiple of five');
    }
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
  static const _minutes = {
    5: 'πέντε',
    10: 'δέκα',
    15: 'δεκαπέντε',
    20: 'είκοσι',
    25: 'είκοσι πέντε',
    30: 'τριάντα',
    35: 'τριάντα πέντε',
    40: 'σαράντα',
    45: 'σαράντα πέντε',
    50: 'πενήντα',
    55: 'πενήντα πέντε',
  };
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
      > 30 => '${_hours[time.nextHour].first} παρά ${_minutes[60 - minute]}',
      _ => '$hour και ${_minutes[minute]}',
    };
    return 'Είναι $phrase.';
  }

  bool matches(String input, ClockTime time) {
    final key = GreekText.answerKey(input);
    return answersFor(time).any((answer) => GreekText.answerKey(answer) == key);
  }

  Iterable<String> answersFor(ClockTime time) sync* {
    final phrases = <String>{};
    for (final hour in _hours[time.hour]) {
      if (time.minute == 0) {
        phrases.addAll([hour, '$hour ακριβώς', '$hour η ώρα']);
      } else {
        final minutes = _minutes[time.minute]!;
        phrases.addAll(['$hour και $minutes', '$hour και $minutes λεπτά']);
        if (time.minute == 15) phrases.add('$hour και τέταρτο');
        if (time.minute == 30) phrases.add('$hour και μισή');
      }
    }
    if (time.minute > 30) {
      for (final hour in _hours[time.nextHour]) {
        final minutes = _minutes[60 - time.minute]!;
        phrases.addAll(['$hour παρά $minutes', '$hour παρά $minutes λεπτά']);
        if (time.minute == 45) phrases.add('$hour παρά τέταρτο');
      }
    }
    if (time.minute == 30) phrases.addAll(_halfHours[time.hour]);

    for (final phrase in phrases) {
      yield phrase;
      yield 'Είναι $phrase';
      if (!phrase.endsWith('η ώρα')) yield 'Η ώρα είναι $phrase';
    }
  }
}
