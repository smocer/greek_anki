import 'package:flutter/material.dart';

import '../domain/vocabulary.dart';
import '../domain/greek_text.dart';
import 'app_strings.dart';
import 'theme.dart';

class TopicPicker extends StatefulWidget {
  const TopicPicker({super.key, required this.decks, required this.selectedId});
  final List<VocabularyDeck> decks;
  final String selectedId;

  @override
  State<TopicPicker> createState() => _TopicPickerState();
}

class _TopicPickerState extends State<TopicPicker> {
  String _query = '';

  bool _matches(VocabularyDeck deck) {
    // Search both teaching languages and the Greek answers, regardless of UI locale.
    final terms = [
      deck.id,
      deck.title.en,
      deck.title.ru,
      deck.subtitle.en,
      deck.subtitle.ru,
      for (final card in deck.cards) ...[
        card.prompt.en,
        card.prompt.ru,
        card.greek,
        ...card.alternatives,
      ],
    ].join(' ');
    final normalized = GreekText.searchKey(terms);
    return GreekText.searchKey(
      _query,
    ).split(RegExp(r'\s+')).every(normalized.contains);
  }

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.85,
    minChildSize: 0.5,
    maxChildSize: 0.95,
    builder: (context, controller) {
      final visible = widget.decks.where(_matches).toList();
      return Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          0,
          24,
          MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.strings.topics,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            Text(
              context.strings.topicSummary(
                widget.decks.length,
                widget.decks.fold(0, (sum, deck) => sum + deck.cards.length),
              ),
              style: const TextStyle(fontSize: 13, color: Palette.muted),
            ),
            const SizedBox(height: 18),
            TextField(
              key: const ValueKey('topic-search'),
              decoration: InputDecoration(
                hintText: context.strings.searchTopics,
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              onChanged: (value) =>
                  setState(() => _query = value.trim().toLowerCase()),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: visible.isEmpty
                  ? Center(child: Text(context.strings.noTopics))
                  : ListView.separated(
                      controller: controller,
                      padding: const EdgeInsets.only(bottom: 28),
                      itemCount: visible.length,
                      separatorBuilder: (_, _) =>
                          const Divider(height: 1, color: Palette.line),
                      itemBuilder: (context, index) {
                        final deck = visible[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                          title: Text(context.localize(deck.title)),
                          subtitle: Text(
                            '${context.localize(deck.subtitle)}\n${context.strings.cardCount(deck.cards.length)}',
                          ),
                          trailing: Icon(
                            deck.id == widget.selectedId
                                ? Icons.check_circle_rounded
                                : Icons.arrow_forward_rounded,
                            size: 21,
                          ),
                          onTap: () => Navigator.pop(context, deck.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      );
    },
  );
}
