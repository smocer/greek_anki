import 'dart:math';

import 'package:flutter/material.dart';

import '../domain/clock_drill.dart';
import 'app_strings.dart';
import 'theme.dart';

class AnalogClock extends StatelessWidget {
  const AnalogClock({super.key, required this.time});

  final ClockTime time;

  @override
  Widget build(BuildContext context) => Semantics(
    image: true,
    label: context.strings.clockReading(time.digital),
    child: AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(painter: _ClockPainter(time)),
    ),
  );
}

class _ClockPainter extends CustomPainter {
  const _ClockPainter(this.time);

  final ClockTime time;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 4;
    Offset point(double turns, double distance) =>
        center +
        Offset(sin(turns * 2 * pi) * distance, -cos(turns * 2 * pi) * distance);

    canvas.drawCircle(center, radius, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Palette.line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    for (var tick = 0; tick < 60; tick++) {
      final hourTick = tick % 5 == 0;
      canvas.drawLine(
        point(tick / 60, radius * (hourTick ? 0.88 : 0.92)),
        point(tick / 60, radius * 0.96),
        Paint()
          ..color = hourTick ? Palette.ink : Palette.line
          ..strokeWidth = hourTick ? 2.5 : 1,
      );
    }
    for (var hour = 1; hour <= 12; hour++) {
      final text = TextPainter(
        text: TextSpan(
          text: '$hour',
          style: TextStyle(
            color: Palette.ink,
            fontSize: radius * 0.16,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      text.paint(
        canvas,
        point(hour / 12, radius * 0.73) - text.size.center(Offset.zero),
      );
      text.dispose();
    }

    void hand(double turns, double length, double width, Color color) {
      canvas.drawLine(
        center,
        point(turns, radius * length),
        Paint()
          ..color = color
          ..strokeWidth = radius * width
          ..strokeCap = StrokeCap.round,
      );
    }

    // The hour hand advances between numbers as the minutes increase.
    hand((time.hour + time.minute / 60) / 12, 0.48, 0.065, Palette.ink);
    hand(time.minute / 60, 0.65, 0.035, Palette.orange);
    canvas.drawCircle(center, radius * 0.05, Paint()..color = Palette.ink);
  }

  @override
  bool shouldRepaint(_ClockPainter oldDelegate) =>
      oldDelegate.time.slot != time.slot;
}
