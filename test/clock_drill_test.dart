import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/domain/clock_drill.dart';
import 'package:greek_anki/domain/greek_text.dart';

void main() {
  const matcher = GreekClockAnswer();

  test(
    'random practice covers the clock in five-minute steps without repeats',
    () {
      final generator = ClockTimeGenerator(random: Random(831));
      final seen = <int>{};
      ClockTime? previous;
      for (var i = 0; i < 10000; i++) {
        final time = generator.next(previous: previous);
        expect(time.hour, inInclusiveRange(1, 12));
        expect(time.minute, inInclusiveRange(0, 55));
        expect(time.minute % 5, 0);
        expect(time.slot, isNot(previous?.slot));
        seen.add(time.slot);
        previous = time;
      }
      expect(seen, hasLength(144));
    },
  );

  test('only representable clock times are permitted', () {
    for (final (hour, minute) in [(0, 0), (13, 0), (1, -5), (1, 60), (1, 8)]) {
      expect(() => ClockTime(hour, minute), throwsArgumentError);
    }
  });

  test(
    'every clock has a valid displayed answer and unambiguous alternatives',
    () {
      final meaningByAnswer = <String, int>{};
      for (var hour = 1; hour <= 12; hour++) {
        for (var minute = 0; minute < 60; minute += 5) {
          final time = ClockTime(hour, minute);
          expect(matcher.matches(matcher.display(time), time), isTrue);
          for (final answer in matcher.answersFor(time)) {
            final key = GreekText.answerKey(answer);
            final other = meaningByAnswer[key];
            expect(other == null || other == time.slot, isTrue, reason: answer);
            meaningByAnswer[key] = time.slot;
          }
        }
      }
    },
  );

  test('quarter, half, exact and next-hour wording use the right hour', () {
    for (final (hour, minute, expected) in [
      (12, 0, 'Είναι δώδεκα ακριβώς.'),
      (1, 15, 'Είναι μία και τέταρτο.'),
      (3, 30, 'Είναι τρεις και μισή.'),
      (3, 35, 'Είναι τέσσερις παρά είκοσι πέντε.'),
      (11, 40, 'Είναι δώδεκα παρά είκοσι.'),
      (12, 45, 'Είναι μία παρά τέταρτο.'),
      (12, 55, 'Είναι μία παρά πέντε.'),
    ]) {
      expect(matcher.display(ClockTime(hour, minute)), expected);
    }
  });

  test('standard spellings and spoken or numeric minutes are accepted', () {
    for (final (hour, minute, answers) in [
      (1, 0, ['μία', 'μια', 'Είναι μία ακριβώς.', 'Η ώρα είναι μία.']),
      (1, 30, ['μιάμιση', 'μία και μισή', 'μία και τριάντα λεπτά']),
      (3, 30, ['τρεισήμισι', 'τρεις και μισή']),
      (4, 30, ['τεσσερισήμισι', 'τέσσερις και μισή']),
      (7, 15, ['εφτά και τέταρτο', 'επτά και δεκαπέντε']),
      (8, 25, ['οχτώ και είκοσι πέντε', 'οκτώ και είκοσι πέντε λεπτά']),
      (9, 0, ['εννέα', 'εννιά']),
      (
        2,
        45,
        ['τρεις παρά τέταρτο', 'τρεις παρά δεκαπέντε', 'δύο και σαράντα πέντε'],
      ),
      (12, 50, ['ΜΊΑ   ΠΑΡΆ ΔΈΚΑ!', 'δώδεκα και πενήντα']),
    ]) {
      final time = ClockTime(hour, minute);
      for (final answer in answers) {
        expect(matcher.matches(answer, time), isTrue, reason: answer);
      }
    }
  });

  test('strict spelling, feminine hours and the clock meaning matter', () {
    for (final (hour, minute, wrong) in [
      (3, 0, 'τρία'),
      (4, 0, 'τέσσερα'),
      (1, 0, 'ένα'),
      (1, 30, 'μία και μισό'),
      (1, 30, 'μία και μιση'),
      (1, 15, 'μία και τετάρτο'),
      (1, 15, 'ειναι μία και τέταρτο'),
      (1, 15, 'μία και τεταρτο'),
      (1, 15, 'one fifteen'),
      (1, 15, '1:15'),
      (1, 15, 'δεκατρείς και τέταρτο'),
      (12, 45, 'δώδεκα παρά τέταρτο'),
      (11, 55, 'δώδεκα και πέντε'),
      (1, 0, ''),
    ]) {
      expect(
        matcher.matches(wrong, ClockTime(hour, minute)),
        isFalse,
        reason: wrong,
      );
    }
    expect(
      matcher.matches('μι\u0301α και τε\u0301ταρτο', ClockTime(1, 15)),
      isTrue,
    );
  });
}
