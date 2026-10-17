import 'package:flutter/material.dart';
import '../domain/curriculum.dart';
import '../domain/vocabulary.dart';
import '../domain/vocabulary_category.dart';
import 'app_strings.dart';
import 'vocabulary_preview.dart';

class CollectionSelection {
  const CollectionSelection({
    required this.deck,
    this.theme,
    this.query = '',
    this.excludedThemes = const {},
  });
  final VocabularyDeck deck;
  final LearningTheme? theme;
  final String query;
  final Set<LearningTheme> excludedThemes;
  String description(AppStrings strings) => [
    strings.periodTitle(deck.period),
    if (theme != null) strings.text(theme!.title),
    if (excludedThemes.isNotEmpty)
      '${strings.excludeThemes}：${strings.orderedThemes.where(excludedThemes.contains).map((theme) => strings.text(theme.title)).join('、')}',
    if (query.isNotEmpty) '“$query”',
  ].join(' · ');
}

class TopicPicker extends StatefulWidget {
  const TopicPicker({super.key, required this.collection, this.selection});
  final LearningCollection collection;
  final CollectionSelection? selection;
  @override
  State<TopicPicker> createState() => _TopicPickerState();
}

class _TopicPickerState extends State<TopicPicker> {
  late VocabularyPeriod _period =
      widget.selection?.deck.period ?? VocabularyPeriod.all;
  late LearningTheme? _theme = widget.selection?.theme;
  late final Set<LearningTheme> _excludedThemes = {
    ...?widget.selection?.excludedThemes,
  };
  late final _search = TextEditingController(
    text: widget.selection?.query ?? '',
  );
  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: .9,
    minChildSize: .5,
    maxChildSize: .95,
    builder: (context, controller) {
      final deck = widget.collection.filter(
        period: _period,
        theme: _theme,
        excludedThemes: _excludedThemes,
        query: _search.text,
        now: DateTime.now(),
      );
      return Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          0,
          24,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.localize(deck.title),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: VocabularyPreview(
                cards: deck.cards,
                controller: controller,
                weeks: additionWeeks(widget.collection.deck.cards),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<LearningTheme?>(
                      key: const ValueKey('collection-theme'),
                      initialValue: _theme,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: context.strings.themeFilter,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(context.strings.allThemes),
                        ),
                        for (final theme in context.strings.orderedThemes.where(
                          widget.collection.availableThemes.contains,
                        ))
                          DropdownMenuItem(
                            value: theme,
                            child: Text(context.localize(theme.title)),
                          ),
                      ],
                      onChanged: (theme) => setState(() => _theme = theme),
                    ),
                    const SizedBox(height: 12),
                    ExpansionTile(
                      key: const ValueKey('exclude-themes'),
                      tilePadding: EdgeInsets.zero,
                      initiallyExpanded: _excludedThemes.isNotEmpty,
                      title: Text(context.strings.excludeThemes),
                      subtitle: Text(context.strings.excludeThemesHint),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              for (final theme
                                  in context.strings.orderedThemes.where(
                                    widget.collection.availableThemes.contains,
                                  ))
                                FilterChip(
                                  key: ValueKey('exclude-${theme.name}'),
                                  label: Text(context.localize(theme.title)),
                                  selected: _excludedThemes.contains(theme),
                                  onSelected: (selected) => setState(() {
                                    if (selected) {
                                      _excludedThemes.add(theme);
                                    } else {
                                      _excludedThemes.remove(theme);
                                    }
                                  }),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<VocabularyPeriod>(
                      key: const ValueKey('category-period'),
                      initialValue: _period,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: context.strings.additionPeriod,
                      ),
                      items: [
                        for (final period in VocabularyPeriod.values)
                          DropdownMenuItem(
                            value: period,
                            child: Text(context.strings.periodTitle(period)),
                          ),
                      ],
                      onChanged: (period) {
                        if (period != null) setState(() => _period = period);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const ValueKey('topic-search'),
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: context.strings.searchVocabulary,
                        prefixIcon: const Icon(Icons.search_rounded),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 14),
                    Text(context.strings.cardCount(deck.cards.length)),
                    const SizedBox(height: 8),
                    const AdditionLegend(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              key: const ValueKey('use-category'),
              onPressed: deck.cards.isEmpty
                  ? null
                  : () => Navigator.pop(
                      context,
                      CollectionSelection(
                        deck: deck,
                        theme: _theme,
                        excludedThemes: Set.unmodifiable(_excludedThemes),
                        query: _search.text,
                      ),
                    ),
              child: Text(context.strings.applyFilters),
            ),
          ],
        ),
      );
    },
  );
}
