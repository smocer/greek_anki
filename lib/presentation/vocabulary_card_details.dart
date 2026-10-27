import 'package:flutter/material.dart';

import '../domain/vocabulary.dart';
import 'app_strings.dart';
import 'theme.dart';
import 'vocabulary_preview.dart';

/// The revealed dictionary entry shared by browsing and word lookup.
class VocabularyCardDetails extends StatelessWidget {
  const VocabularyCardDetails({
    super.key,
    required this.card,
    required this.weeks,
  });

  final VocabularyCard card;
  final List<String> weeks;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localize(card.prompt),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          card.displayedAnswer,
          style: TextStyle(
            color: additionColor(card.addedWeek, weeks),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          card.addedWeek == null
              ? context.strings.unknownWeek
              : context.strings.weekOf(card.addedWeek!),
          style: const TextStyle(fontSize: 11, color: Palette.muted),
        ),
        Text(
          context.localize(card.pronunciation),
          style: const TextStyle(fontSize: 13, color: Palette.muted),
        ),
        if (card.alternatives.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            context.strings.also(card.alternatives.join(' / ')),
            style: const TextStyle(fontSize: 12, color: Palette.muted),
          ),
        ],
        if (card.explanation != null) ...[
          const SizedBox(height: 12),
          Text(
            context.localize(card.explanation!),
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ],
    ),
  );
}
