import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/domain/number_drill.dart';

class FixedRandom implements Random {
  FixedRandom(this.value);
  final int value;
  int? bound;
  @override
  int nextInt(int max) {
    bound = max;
    return value;
  }

  @override
  bool nextBool() => throw UnimplementedError();
  @override
  double nextDouble() => throw UnimplementedError();
}

void main() {
  const answer = GreekNumberAnswer();
  test('uniform generator includes both bounds and permits repeats', () {
    for (final value in [0, 1, 9999, 10000]) {
      final random = FixedRandom(value);
      final generator = NumberGenerator(random: random);
      expect(generator.next(), value);
      expect(generator.next(), value);
      expect(random.bound, 10001);
    }
  });
  test('all 10001 values have distinct, accepted Greek spellings', () {
    final owners = <String, int>{};
    for (var n = 0; n <= 10000; n++) {
      final variants = answer.answersFor(n);
      expect(variants, isNotEmpty);
      for (final variant in variants) {
        expect(owners.putIfAbsent(variant, () => n), n, reason: variant);
        expect(answer.matches(variant, n), isTrue, reason: '$n: $variant');
      }
    }
  });
  test('number composition and valid variants are specific to the target', () {
    for (final (n, expected) in [
      (0, 'μηδέν'),
      (13, 'δεκατρία'),
      (21, 'είκοσι ένα'),
      (100, 'εκατό'),
      (101, 'εκατόν ένα'),
      (111, 'εκατόν έντεκα'),
      (200, 'διακόσια'),
      (700, 'επτακόσια'),
      (800, 'οκτακόσια'),
      (1000, 'χίλια'),
      (1001, 'χίλια ένα'),
      (1100, 'χίλια εκατό'),
      (2000, 'δύο χιλιάδες'),
      (3003, 'τρεις χιλιάδες τρία'),
      (4004, 'τέσσερις χιλιάδες τέσσερα'),
      (9999, 'εννέα χιλιάδες εννιακόσια ενενήντα εννέα'),
      (10000, 'δέκα χιλιάδες'),
    ]) {
      expect(answer.matches(expected, n), isTrue, reason: expected);
      expect(answer.matches(expected, n == 10000 ? 9999 : n + 1), isFalse);
    }
    expect(answer.matches('τρία χιλιάδες', 3000), isFalse);
    expect(answer.matches('τεσσερις χιλιάδες', 4000), isFalse);
    expect(answer.matches('10000', 10000), isFalse);
    expect(answer.matches('χίλια και ένα', 1001), isFalse);
    expect(() => answer.display(-1), throwsRangeError);
    expect(() => answer.display(10001), throwsRangeError);
  });
}
