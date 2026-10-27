import 'package:flutter/material.dart';

import '../domain/vocabulary.dart';
import '../domain/vocabulary_category.dart';
import 'app_strings.dart';
import 'card_explanation.dart';
import 'theme.dart';
import 'vocabulary_preview.dart';
import 'vocabulary_card_details.dart';

class VocabularySheet extends StatelessWidget {
  const VocabularySheet({
    super.key,
    required this.deck,
    this.catalogCards,
    this.label,
  });
  final VocabularyDeck deck;
  final List<VocabularyCard>? catalogCards;
  final VocabularyLabel? label;

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.8,
    minChildSize: 0.4,
    maxChildSize: 0.95,
    builder: (context, scrollController) => label != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: VocabularyPreview(
              cards: deck.cards,
              words: VocabularyCatalog([deck])
                  .words(label!)
                  .where(
                    (word) =>
                        deck.period.includes(word.addedWeek, DateTime.now()),
                  )
                  .toList(),
              weeks: VocabularyCatalog([
                VocabularyDeck(
                  id: 'library',
                  title: deck.title,
                  subtitle: deck.subtitle,
                  cover: deck.cover,
                  cards: catalogCards ?? deck.cards,
                ),
              ]).wordWeeks,
              controller: scrollController,
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localize(deck.title),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.strings.wordCategoryHint(deck.cards.length),
                    style: const TextStyle(color: Palette.muted),
                  ),
                  const SizedBox(height: 16),
                  const AdditionLegend(),
                ],
              ),
            ),
          )
        : ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            children: [
              Text(
                context.localize(deck.title),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                context.strings.browseIntro,
                style: const TextStyle(color: Palette.muted),
              ),
              if (deck.note != null) ...[
                const SizedBox(height: 16),
                CardExplanation(explanation: deck.note!),
              ],
              const SizedBox(height: 16),
              const AdditionLegend(),
              for (final card in newestFirst(deck.cards)) ...[
                VocabularyCardDetails(
                  card: card,
                  weeks: additionWeeks(catalogCards ?? deck.cards),
                ),
                const Divider(height: 1, color: Palette.line),
              ],
              const SizedBox(height: 20),
              Text(
                context.strings.pronunciationNote,
                style: const TextStyle(fontSize: 12, color: Palette.muted),
              ),
            ],
          ),
  );
}
