import 'package:flutter/material.dart';

import '../domain/curriculum.dart';
import '../domain/vocabulary.dart';
import '../domain/word_search.dart';
import 'app_strings.dart';
import 'labeled_field.dart';
import 'theme.dart';
import 'vocabulary_card_details.dart';
import 'vocabulary_preview.dart';

class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({super.key, required this.collections});

  final List<LearningCollection> collections;

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  late final _search = WordSearch(widget.collections);
  late final _weeks = additionWeeks(_search.cards);
  final _query = TextEditingController();
  final _scroll = ScrollController();
  List<VocabularyCard> _results = [];

  @override
  void dispose() {
    _query.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _updateResults() {
    setState(() => _results = _search.find(_query.text));
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.strings.wordSearch)),
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: CustomScrollView(
            controller: _scroll,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LabeledField(
                        label: context.strings.greekWord,
                        child: TextField(
                          key: const ValueKey('word-search-query'),
                          controller: _query,
                          textInputAction: TextInputAction.search,
                          autocorrect: false,
                          enableSuggestions: false,
                          onChanged: (_) => _updateResults(),
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            hintText: 'επικ…',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _query.text.isEmpty
                                ? null
                                : IconButton(
                                    tooltip: context.strings.clearSearch,
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _query.clear();
                                      _updateResults();
                                    },
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.strings.wordSearchHint,
                        style: const TextStyle(color: Palette.muted),
                      ),
                      if (_query.text.trim().isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          _results.isEmpty
                              ? context.strings.noSearchResults
                              : context.strings.searchResultCount(
                                  _results.length,
                                ),
                          style: const TextStyle(color: Palette.muted),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                sliver: SliverList.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      VocabularyCardDetails(
                        key: ValueKey('search-result-${_results[index].id}'),
                        card: _results[index],
                        weeks: _weeks,
                      ),
                      const Divider(height: 1, color: Palette.line),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
