import 'dart:math' as math;
import 'package:flutter/material.dart' hide DayPeriod;

import '../domain/date_drill.dart';
import 'app_strings.dart';
import 'theme.dart';

/// A horizon and sun/moon distinguish the five lesson periods without Greek hints.
class DayPeriodPicture extends StatelessWidget {
  const DayPeriodPicture({super.key, required this.period});
  final DayPeriod period;

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.strings.dayPeriod(period),
    excludeSemantics: true,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 70,
          child: CustomPaint(painter: _PeriodPainter(period)),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            context.strings.dayPeriod(period),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

class _PeriodPainter extends CustomPainter {
  const _PeriodPainter(this.period);
  final DayPeriod period;

  @override
  void paint(Canvas canvas, Size size) {
    final night = period == DayPeriod.night;
    final background = night
        ? Palette.ink
        : period == DayPeriod.evening
        ? const Color(0xFFF2D4BC)
        : const Color(0xFFE6F1F4);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      Paint()..color = background,
    );
    final center = switch (period) {
      DayPeriod.morning => Offset(size.width * .25, size.height * .48),
      DayPeriod.midday => Offset(size.width * .5, size.height * .28),
      DayPeriod.afternoon => Offset(size.width * .75, size.height * .48),
      DayPeriod.evening => Offset(size.width * .8, size.height * .76),
      DayPeriod.night => Offset(size.width * .7, size.height * .3),
    };
    final light = Paint()
      ..color = night ? const Color(0xFFF9F1CE) : const Color(0xFFE1A62F);
    canvas.drawCircle(center, 11, light);
    if (night) {
      canvas.drawCircle(
        center + const Offset(6, -4),
        10,
        Paint()..color = background,
      );
      for (final star in [
        Offset(size.width * .18, 16),
        Offset(size.width * .4, 32),
        Offset(size.width * .88, 19),
      ]) {
        canvas.drawCircle(star, 1.8, light);
      }
    } else {
      for (var ray = 0; ray < 8; ray++) {
        final angle = ray * math.pi / 4;
        final vector = Offset(math.cos(angle), math.sin(angle));
        canvas.drawLine(
          center + vector * 14,
          center + vector * 18,
          light..strokeWidth = 1.5,
        );
      }
    }
    final horizon = size.height * .8;
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
    );
    canvas.drawRect(
      Rect.fromLTWH(0, horizon, size.width, size.height - horizon),
      Paint()..color = night ? const Color(0xFF172D26) : Palette.softGreen,
    );
    canvas.drawLine(
      Offset(0, horizon),
      Offset(size.width, horizon),
      Paint()
        ..color = Palette.muted
        ..strokeWidth = 1,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PeriodPainter oldDelegate) =>
      period != oldDelegate.period;
}
