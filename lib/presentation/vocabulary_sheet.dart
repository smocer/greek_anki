import 'package:flutter/material.dart';

import '../domain/vocabulary.dart';
import '../domain/vocabulary_category.dart';
import 'app_strings.dart';
import 'card_explanation.dart';
import 'theme.dart';
import 'vocabulary_preview.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localize(card.prompt),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        card.displayedAnswer,
                        style: TextStyle(
                          color: additionColor(
                            card.addedWeek,
                            additionWeeks(catalogCards ?? deck.cards),
                          ),
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.addedWeek == null
                            ? context.strings.unknownWeek
                            : context.strings.weekOf(card.addedWeek!),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Palette.muted,
                        ),
                      ),
                      Text(
                        context.localize(card.pronunciation),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Palette.muted,
                        ),
                      ),
                      if (card.alternatives.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          context.strings.also(card.alternatives.join(' / ')),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Palette.muted,
                          ),
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
