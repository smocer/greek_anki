import 'package:flutter/material.dart';
import '../domain/vocabulary.dart';
import '../domain/vocabulary_category.dart';
import '../domain/greek_text.dart';
import 'app_strings.dart';
import 'theme.dart';
import 'vocabulary_preview.dart';

class TopicPicker extends StatefulWidget {
  const TopicPicker({
    super.key,
    required this.decks,
    required this.selectedId,
    this.selectedLabel = VocabularyLabel.topic,
    this.selectedPeriod = VocabularyPeriod.all,
  });
  final List<VocabularyDeck> decks;
  final String selectedId;
  final VocabularyLabel selectedLabel;
  final VocabularyPeriod selectedPeriod;
  @override
  State<TopicPicker> createState() => _TopicPickerState();
}

class _TopicPickerState extends State<TopicPicker> {
  late VocabularyLabel _label = widget.selectedLabel;
  late VocabularyPeriod _period = widget.selectedPeriod;
  late String _topicId =
      widget.decks.any((deck) => deck.id == widget.selectedId)
      ? widget.selectedId
      : widget.decks.first.id;
  final _search = TextEditingController();
  String _query = '';
  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  VocabularyDeck get _chosen => _label == VocabularyLabel.topic
      ? widget.decks.firstWhere((deck) => deck.id == _topicId)
      : VocabularyCatalog(widget.decks).category(_label);

  bool _matches(VocabularyCard card) {
    final terms = GreekText.searchKey(
      [
        card.prompt.en,
        card.prompt.ru,
        card.greek,
        card.meaning.en,
        card.meaning.ru,
        ...card.alternatives,
      ].join(' '),
    );
    return GreekText.searchKey(
      _query,
    ).split(RegExp(r'\s+')).every(terms.contains);
  }

  void _clearSearch() {
    _query = '';
    _search.clear();
  }

  bool _matchesWord(VocabularyWordEntry entry) {
    final terms = GreekText.searchKey(
      [
        entry.word.surface,
        entry.word.lemma,
        for (final card in entry.sources) ...[
          card.greek,
          card.prompt.en,
          card.prompt.ru,
        ],
      ].join(' '),
    );
    return GreekText.searchKey(
      _query,
    ).split(RegExp(r'\s+')).every(terms.contains);
  }

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: .9,
    minChildSize: .5,
    maxChildSize: .95,
    builder: (context, controller) {
      final chosen = _chosen;
      final catalog = VocabularyCatalog(widget.decks);
      final now = DateTime.now();
      final words = _label == VocabularyLabel.topic
          ? null
          : catalog
                .words(_label)
                .where(
                  (word) =>
                      _matchesWord(word) &&
                      _period.includes(word.addedWeek, now),
                )
                .toList();
      final visible = words == null
          ? newestFirst(
              chosen.cards.where(
                (card) =>
                    _matches(card) && _period.includes(card.addedWeek, now),
              ),
            )
          : sourceCardsFor(words);
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
              context.strings.chooseCategory,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: VocabularyPreview(
                cards: visible,
                words: words,
                weeks: words == null ? catalog.weeks : catalog.wordWeeks,
                controller: controller,
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<VocabularyLabel>(
                      key: const ValueKey('category-label'),
                      initialValue: _label,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: context.strings.chooseLabel,
                      ),
                      items: [
                        for (final label in VocabularyLabel.values)
                          DropdownMenuItem(
                            value: label,
                            child: Text(
                              context.localize(labelTitle(label)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: (label) {
                        if (label != null) {
                          setState(() {
                            _label = label;
                            _clearSearch();
                          });
                        }
                      },
                    ),
                    if (_label == VocabularyLabel.topic) ...[
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        key: const ValueKey('category-topic'),
                        initialValue: _topicId,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: context.strings.chooseTopicLabel,
                        ),
                        items: [
                          for (final deck in widget.decks)
                            DropdownMenuItem(
                              value: deck.id,
                              child: Text(
                                context.localize(deck.title),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: (id) {
                          if (id != null) {
                            setState(() {
                              _topicId = id;
                              _clearSearch();
                            });
                          }
                        },
                      ),
                    ],
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
                      onChanged: (query) =>
                          setState(() => _query = query.trim()),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '${context.strings.vocabularyPreview} · ${words == null ? context.strings.cardCount(visible.length) : context.strings.wordCount(words.length)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      words == null
                          ? context.strings.categoryHint
                          : context.strings.wordCategoryHint(visible.length),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Palette.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const AdditionLegend(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              key: const ValueKey('use-category'),
              onPressed: visible.isEmpty
                  ? null
                  : () => Navigator.pop(
                      context,
                      VocabularyDeck(
                        id: chosen.id,
                        title: chosen.title,
                        subtitle: chosen.subtitle,
                        cover: chosen.cover,
                        note: chosen.note,
                        period: _period,
                        cards: visible,
                      ),
                    ),
              child: Text(context.strings.useCategory),
            ),
          ],
        ),
      );
    },
  );
}
