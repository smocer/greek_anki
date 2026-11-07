import 'dart:math';

import 'clock_drill.dart';
import 'greek_text.dart';
import 'number_drill.dart';

enum DayPeriod {
  morning('το πρωί'),
  midday('το μεσημέρι'),
  afternoon('το απόγευμα'),
  evening('το βράδυ'),
  night('τη νύχτα');

  const DayPeriod(this.greek);
  final String greek;

  static DayPeriod at(int hour) => switch (hour) {
    < 5 => night,
    < 12 => morning,
    < 15 => midday,
    < 19 => afternoon,
    _ => evening,
  };
}

class DateDrillQuestion {
  const DateDrillQuestion(this.date);
  final DateTime date;
  DayPeriod get period => DayPeriod.at(date.hour);
  ClockTime get time => ClockTime.toMinute(
    date.hour % 12 == 0 ? 12 : date.hour % 12,
    date.minute,
  );
}

class DateDrillGenerator {
  DateDrillGenerator({Random? random, DateTime Function()? now})
    : _random = random ?? Random(),
      _now = now ?? DateTime.now;
  final Random _random;
  final DateTime Function() _now;

  DateDrillQuestion next() {
    final year = _now().year;
    // UTC civil dates avoid missing/repeated hours at daylight-saving changes.
    final start = DateTime.utc(year);
    final minutes = DateTime.utc(year + 1).difference(start).inMinutes;
    return DateDrillQuestion(
      start.add(Duration(minutes: _random.nextInt(minutes))),
    );
  }
}

/// A finite set of templates, independently checking date and time.
class GreekDateAnswer {
  const GreekDateAnswer();
  static const _numbers = GreekNumberAnswer();
  static const _clock = GreekClockAnswer();
  static const _weekdays = [
    'Δευτέρα',
    'Τρίτη',
    'Τετάρτη',
    'Πέμπτη',
    'Παρασκευή',
    'Σάββατο',
    'Κυριακή',
  ];
  static const _months = [
    'Ιανουαρίου',
    'Φεβρουαρίου',
    'Μαρτίου',
    'Απριλίου',
    'Μαΐου',
    'Ιουνίου',
    'Ιουλίου',
    'Αυγούστου',
    'Σεπτεμβρίου',
    'Οκτωβρίου',
    'Νοεμβρίου',
    'Δεκεμβρίου',
  ];

  Iterable<String> dateAnswers(DateDrillQuestion question) sync* {
    final date = question.date;
    final weekday = _weekdays[date.weekday - 1];
    final month = _months[date.month - 1];
    final days = date.day == 1
        ? ['πρώτη', 'μία', 'μια']
        : _numbers.answersFor(date.day, gender: NumberGender.feminine);
    final articles = date.weekday == DateTime.saturday
        ? ['', 'το ']
        : ['', 'την ', 'τη '];
    for (final day in days) {
      for (final article in articles) {
        yield '$article$weekday $day $month';
        yield '$day $month $article$weekday';
      }
    }
  }

  Iterable<String> timeAnswers(DateDrillQuestion question) sync* {
    final periods = question.period == DayPeriod.night
        ? ['τη νύχτα', 'την νύχτα']
        : [question.period.greek];
    for (final phrase in _clock.phrasesFor(question.time)) {
      final singular =
          phrase.startsWith('μία') ||
          phrase.startsWith('μια') ||
          phrase.startsWith('μιάμιση');
      final prefixes = [
        '',
        'είναι ',
        'η ώρα είναι ',
        if (singular) ...['στη ', 'στην '] else 'στις ',
      ];
      for (final period in periods) {
        for (final prefix in prefixes) {
          yield '$prefix$phrase $period';
          yield '$period $prefix$phrase';
        }
      }
    }
  }

  String displayDate(DateDrillQuestion question) => dateAnswers(question).first;
  String displayTime(DateDrillQuestion question) => timeAnswers(question).first;
  bool matchesDate(String input, DateDrillQuestion question) =>
      _matches(input, dateAnswers(question));
  bool matchesTime(String input, DateDrillQuestion question) =>
      _matches(input, timeAnswers(question));
  bool _matches(String input, Iterable<String> answers) {
    final key = GreekText.answerKey(input);
    return answers.any((answer) => GreekText.answerKey(answer) == key);
  }
}
