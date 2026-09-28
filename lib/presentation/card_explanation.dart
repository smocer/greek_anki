import 'package:flutter/material.dart';

import '../domain/app_language.dart';
import 'app_strings.dart';
import 'theme.dart';

/// Reused only on revealed answers and in the vocabulary reference.
class CardExplanation extends StatelessWidget {
  const CardExplanation({super.key, required this.explanation});
  final LocalizedText explanation;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Palette.softGreen,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(context.strings.grammarConnection, color: Palette.ink),
        const SizedBox(height: 8),
        Text(
          context.localize(explanation),
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    ),
  );
}
