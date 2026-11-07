import 'dart:math';

import 'greek_text.dart';

class NumberGenerator {
  NumberGenerator({Random? random}) : _random = random ?? Random();
  final Random _random;

  // All 10,001 integers have the same probability, including consecutive repeats.
  int next() => _random.nextInt(10001);
}

enum NumberGender { neuter, feminine }

/// Compose a small set of spelling variants, rather than parsing Greek text.
class GreekNumberAnswer {
  const GreekNumberAnswer();

  static const _small = [
    ['μηδέν'],
    ['ένα'],
    ['δύο', 'δυο'],
    ['τρία'],
    ['τέσσερα'],
    ['πέντε'],
    ['έξι'],
    ['εφτά', 'επτά'],
    ['οχτώ', 'οκτώ'],
    ['εννιά', 'εννέα'],
    ['δέκα'],
    ['έντεκα'],
    ['δώδεκα'],
    ['δεκατρία'],
    ['δεκατέσσερα'],
    ['δεκαπέντε'],
    ['δεκαέξι', 'δεκάξι'],
    ['δεκαεφτά', 'δεκαεπτά'],
    ['δεκαοχτώ', 'δεκαοκτώ'],
    ['δεκαεννιά', 'δεκαεννέα'],
  ];
  static const _tens = [
    '',
    '',
    'είκοσι',
    'τριάντα',
    'σαράντα',
    'πενήντα',
    'εξήντα',
    'εβδομήντα',
    'ογδόντα',
    'ενενήντα',
  ];
  static const _hundreds = [
    <String>[],
    ['εκατό'],
    ['διακόσια'],
    ['τριακόσια'],
    ['τετρακόσια'],
    ['πεντακόσια'],
    ['εξακόσια'],
    ['εφτακόσια', 'επτακόσια'],
    ['οχτακόσια', 'οκτακόσια'],
    ['εννιακόσια'],
  ];

  List<String> answersFor(
    int number, {
    NumberGender gender = NumberGender.neuter,
  }) {
    RangeError.checkValueInInterval(number, 0, 10000, 'number');
    if (number < 20) {
      if (gender == NumberGender.feminine) {
        final feminine = switch (number) {
          1 => ['μία', 'μια'],
          3 => ['τρεις'],
          4 => ['τέσσερις'],
          13 => ['δεκατρείς'],
          14 => ['δεκατέσσερις'],
          _ => null,
        };
        if (feminine != null) return feminine;
      }
      return _small[number];
    }
    if (number < 100) {
      return _join([_tens[number ~/ 10]], number % 10, gender);
    }
    if (number < 1000) {
      var prefix = _hundreds[number ~/ 100];
      if (number ~/ 100 == 1 && number % 100 != 0) {
        prefix = ['εκατόν', 'εκατό'];
      } else if (gender == NumberGender.feminine && number >= 200) {
        prefix = [
          for (final form in prefix) '${form.substring(0, form.length - 1)}ες',
        ];
      }
      return _join(prefix, number % 100, gender);
    }
    final thousands = number ~/ 1000;
    final prefix = thousands == 1
        ? (gender == NumberGender.feminine ? ['χίλιες'] : ['χίλια'])
        : [
            for (final word in answersFor(
              thousands,
              gender: NumberGender.feminine,
            ))
              '$word χιλιάδες',
          ];
    return _join(prefix, number % 1000, gender);
  }

  List<String> _join(
    List<String> prefixes,
    int remainder,
    NumberGender gender,
  ) => remainder == 0
      ? prefixes
      : [
          for (final prefix in prefixes)
            for (final suffix in answersFor(remainder, gender: gender))
              '$prefix $suffix',
        ];

  String display(int number) => answersFor(number).first;

  bool matches(String input, int number) {
    final key = GreekText.answerKey(input);
    return answersFor(
      number,
    ).any((answer) => GreekText.answerKey(answer) == key);
  }
}
