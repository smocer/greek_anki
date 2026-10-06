import 'package:flutter/material.dart';
import '../domain/vocabulary.dart';
import '../domain/vocabulary_category.dart';
import 'app_strings.dart';
import 'theme.dart';

Color additionColor(String? week, List<String> weeks) {
  if (week != null && weeks.isNotEmpty && week == weeks.first) {
    return const Color(0xFF237A42);
  }
  if (week != null && weeks.length > 1 && week == weeks[1]) {
    return const Color(0xFF8A6500);
  }
  return Colors.black87;
}

List<String> additionWeeks(Iterable<VocabularyCard> cards) =>
    cards.map((card) => card.addedWeek).whereType<String>().toSet().toList()
      ..sort((a, b) => b.compareTo(a));

class AdditionLegend extends StatelessWidget {
  const AdditionLegend({super.key});
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 16,
    runSpacing: 6,
    children: [
      for (final entry in [
        (const Color(0xFF237A42), context.strings.latestWeek),
        (const Color(0xFF8A6500), context.strings.previousWeek),
        (Colors.black87, context.strings.olderWeeks),
      ])
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, size: 8, color: entry.$1),
            const SizedBox(width: 5),
            Text(
              entry.$2,
              style: const TextStyle(fontSize: 11, color: Palette.muted),
            ),
          ],
        ),
    ],
  );
}

class VocabularyPreview extends StatelessWidget {
  const VocabularyPreview({
    super.key,
    required this.cards,
    required this.weeks,
    this.controller,
    this.header,
    this.words,
  });
  final List<VocabularyCard> cards;
  final List<String> weeks;
  final ScrollController? controller;
  final Widget? header;
  final List<VocabularyWordEntry>? words;
  @override
  Widget build(BuildContext context) {
    final sorted = newestFirst(cards);
    final count = words?.length ?? sorted.length;
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: (count == 0 ? 1 : count) + (header == null ? 0 : 1),
      itemBuilder: (context, index) {
        if (header != null && index == 0) return header!;
        if (header != null) index -= 1;
        if (count == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(context.strings.noWords),
          );
        }
        final entry = words?[index];
        final card = entry?.example ?? sorted[index];
        final week = entry?.addedWeek ?? card.addedWeek;
        final previousWeek = index == 0
            ? null
            : (words == null
                  ? sorted[index - 1].addedWeek
                  : words![index - 1].addedWeek);
        final color = additionColor(week, weeks);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (index == 0 || week != previousWeek)
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10),
                child: Text(
                  week == null
                      ? context.strings.unknownWeek
                      : context.strings.weekOf(week),
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Container(
              key: ValueKey(
                entry == null
                    ? 'preview-${card.reviewIdentity?.deckId ?? ''}-${card.id}'
                    : 'preview-word-${entry.id}',
              ),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border(left: BorderSide(color: color, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry?.word.surface ?? card.displayedAnswer,
                    style: TextStyle(
                      color: color,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  if (entry != null) ...[
                    Text(
                      '${context.strings.sourceExample}: ${card.greek}',
                      style: const TextStyle(fontSize: 13, color: Palette.ink),
                    ),
                    const SizedBox(height: 3),
                  ],
                  Text(
                    context.localize(card.prompt),
                    style: const TextStyle(fontSize: 13, color: Palette.muted),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
