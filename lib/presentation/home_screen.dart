import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/app_language.dart';
import '../domain/app_updates.dart';
import '../domain/curriculum.dart';
import '../domain/learning_progress.dart';
import '../domain/vocabulary.dart';
import 'alphabet_screen.dart';
import 'app_strings.dart';
import 'grammar_screen.dart';
import 'language_switch.dart';
import 'study_screen.dart';
import 'theme.dart';
import 'topic_picker.dart';
import 'vocabulary_sheet.dart';
import 'web_update_notice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.collections,
    required this.progress,
    required this.onLanguageChanged,
    this.updates,
  });
  final List<LearningCollection> collections;
  final LearningProgress progress;
  final Future<void> Function(AppLanguage) onLanguageChanged;
  final AppUpdates? updates;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  LearningSection _section = LearningSection.words;
  late LearningCollection _collection = widget.collections.first;
  CollectionSelection? _selection;
  final _count = TextEditingController(text: '15');
  bool _allCards = false;
  String _customCount = '15';
  CardOrder _cardOrder = CardOrder.random;
  LearningCollection get _activeCollection {
    if (_collection.deck.id != 'words-nouns') return _collection;
    final names = widget.collections
        .where((c) => c.deck.id == 'words-names')
        .firstOrNull;
    if (names == null) return _collection;
    final nouns = _collection.deck;
    return LearningCollection(
      section: _collection.section,
      deck: VocabularyDeck(
        id: nouns.id,
        title: nouns.title,
        subtitle: nouns.subtitle,
        cover: nouns.cover,
        note: nouns.note,
        cards: [...nouns.cards, ...names.deck.cards],
      ),
      themes: {..._collection.themes, ...names.themes},
    );
  }

  int? get _sessionLimit => _allCards ? null : int.tryParse(_count.text);
  VocabularyDeck get _deck => _selection?.deck ?? _activeCollection.deck;

  void _syncCount() {
    if (_allCards) _count.text = '${_deck.cards.length}';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _count.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) setState(() {});
  }

  void _select(LearningCollection collection) => setState(() {
    _collection = collection;
    _section = collection.section;
    _selection = null;
    _syncCount();
  });

  Future<void> _start(StudyMode mode) async {
    final limit = _sessionLimit;
    if (!_allCards && (limit == null || limit < 1)) return;
    final due = widget.progress.dueCards(_deck, mode);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StudyScreen(
          deck: _deck,
          cards: sessionBatch(
            _allCards || due.isEmpty ? _deck.cards : due,
            limit: limit ?? _deck.cards.length,
            order: _cardOrder,
          ),
          sessionLimit: limit,
          cardOrder: _cardOrder,
          mode: mode,
          progress: widget.progress,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _filter() async {
    final selected = await showModalBottomSheet<CollectionSelection>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) =>
          TopicPicker(collection: _activeCollection, selection: _selection),
    );
    if (mounted && selected != null) {
      setState(() {
        _selection = selected;
        _syncCount();
      });
    }
  }

  void _reference() => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    builder: (sheetContext) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(context.strings.reference),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
          ),
          for (final entry in [
            (
              context.strings.alphabetTitle,
              Icons.menu_book_outlined,
              const AlphabetScreen(),
            ),
            (
              context.strings.grammarTables,
              Icons.table_chart_outlined,
              const GrammarScreen(),
            ),
          ])
            ListTile(
              leading: Icon(entry.$2),
              title: Text(entry.$1),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(sheetContext);
                Navigator.of(
                  context,
                ).push(MaterialPageRoute<void>(builder: (_) => entry.$3));
              },
            ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListenableBuilder(
            listenable: widget.progress,
            builder: (context, _) => ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Eyebrow('Greek Anki', color: Palette.ink),
                    ),
                    TextButton.icon(
                      onPressed: _reference,
                      icon: const Icon(Icons.menu_book_outlined, size: 18),
                      label: Text(context.strings.reference),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LanguageSwitch(onChanged: widget.onLanguageChanged),
                if (widget.updates case final updates?)
                  WebUpdateNotice(updates: updates),
                const SizedBox(height: 24),
                Text(
                  context.strings.headline.replaceAll('\n', ' '),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  context.strings.tagline,
                  style: const TextStyle(color: Palette.muted),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final section in LearningSection.values)
                      ChoiceChip(
                        key: ValueKey('section-${section.name}'),
                        label: Text(context.localize(section.title)),
                        selected: _section == section,
                        showCheckmark: false,
                        onSelected: (_) => _select(
                          widget.collections.firstWhere(
                            (c) => c.section == section,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  key: ValueKey('collection-${_section.name}'),
                  initialValue: _collection.deck.id,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: context.strings.practiceGroup,
                  ),
                  items: [
                    for (final c in widget.collections.where(
                      (c) =>
                          c.section == _section && c.deck.id != 'words-names',
                    ))
                      DropdownMenuItem(
                        value: c.deck.id,
                        child: Text(
                          context.localize(c.deck.title),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (id) {
                    if (id != null) {
                      _select(
                        widget.collections.firstWhere((c) => c.deck.id == id),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Palette.lime,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.strings.language == AppLanguage.chinese
                                  ? '${context.localize(_deck.subtitle)}（共${_deck.cards.length}张）'
                                  : context.localize(_deck.subtitle),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                            if (context.strings.language !=
                                AppLanguage.chinese) ...[
                              const SizedBox(height: 10),
                              Text(
                                context.strings.cardCount(_deck.cards.length),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 8,
                                    ),
                                  ),
                                  onPressed: () => showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    showDragHandle: true,
                                    useSafeArea: true,
                                    builder: (_) => VocabularySheet(
                                      deck: _deck,
                                      catalogCards: widget.collections
                                          .expand((c) => c.deck.cards)
                                          .toList(),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_outward_rounded,
                                    size: 18,
                                  ),
                                  label: Text(context.strings.browse),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextButton.icon(
                                        key: const ValueKey('choose-category'),
                                        onPressed: _filter,
                                        style: TextButton.styleFrom(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 8,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.tune_rounded,
                                          size: 18,
                                        ),
                                        label: Text(
                                          _selection == null
                                              ? context.strings.filters
                                              : '${context.strings.filters}（${_selection!.description(context.strings)}）',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    if (_selection != null)
                                      Flexible(
                                        flex: 2,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 8,
                                            ),
                                            minimumSize: const Size(0, 40),
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          onPressed: () => setState(() {
                                            _selection = null;
                                            _syncCount();
                                          }),
                                          child: Text(
                                            context.strings.clearFilters,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    key: const ValueKey('session-count'),
                                    controller: _count,
                                    enabled: !_allCards,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (_) => setState(() {}),
                                    decoration: InputDecoration(
                                      labelText: context.strings.sessionCount,
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                      errorText:
                                          !_allCards &&
                                              (_sessionLimit == null ||
                                                  _sessionLimit! < 1)
                                          ? context.strings.invalidSessionCount
                                          : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                FilterChip(
                                  key: const ValueKey('session-all'),
                                  label: Text(context.strings.allCards),
                                  selected: _allCards,
                                  onSelected: (value) => setState(() {
                                    if (value) _customCount = _count.text;
                                    _allCards = value;
                                    if (value) {
                                      _syncCount();
                                    } else {
                                      _count.text = _customCount;
                                    }
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<CardOrder>(
                              key: const ValueKey('session-order'),
                              initialValue: _cardOrder,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: context.strings.cardOrder,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              items: [
                                for (final order in CardOrder.values)
                                  DropdownMenuItem(
                                    value: order,
                                    child: Text(
                                      context.strings.cardOrderTitle(order),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                              ],
                              onChanged: (order) {
                                if (order != null) {
                                  setState(() => _cardOrder = order);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                for (final mode in StudyMode.values) ...[
                  _ModeTile(
                    title: mode == StudyMode.typing
                        ? context.strings.hardMode
                        : context.strings.flashcards,
                    description: mode == StudyMode.typing
                        ? context.strings.hardDescription
                        : context.strings.flashcardsDescription,
                    icon: mode == StudyMode.typing
                        ? Icons.edit_outlined
                        : Icons.style_outlined,
                    hard: mode == StudyMode.typing,
                    learned: widget.progress.learned(_deck, mode),
                    due: widget.progress.dueCards(_deck, mode).length,
                    total: _deck.cards.length,
                    onTap:
                        _deck.cards.isEmpty ||
                            (!_allCards &&
                                (_sessionLimit == null || _sessionLimit! < 1))
                        ? null
                        : () => _start(mode),
                  ),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 8),
                Text(
                  widget.updates == null
                      ? context.strings.offlineFooter
                      : context.strings.browserFooter,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Palette.muted),
                ),
                if (widget.updates != null)
                  TextButton.icon(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(context.strings.homeScreenTitle),
                        content: SingleChildScrollView(
                          child: Text(context.strings.homeScreenHelp),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(context.strings.close),
                          ),
                        ],
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_to_home_screen_rounded,
                      size: 18,
                    ),
                    label: Text(context.strings.homeScreenTitle),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.title,
    required this.description,
    required this.icon,
    required this.learned,
    required this.due,
    required this.total,
    required this.onTap,
    this.hard = false,
  });
  final String title;
  final String description;
  final IconData icon;
  final int learned;
  final int due;
  final int total;
  final VoidCallback? onTap;
  final bool hard;

  @override
  Widget build(BuildContext context) => Material(
    color: hard ? Colors.transparent : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: const BorderSide(color: Palette.line),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: hard ? Palette.softOrange : Palette.softGreen,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: hard ? Palette.orange : Palette.ink,
                size: 23,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: Palette.muted),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    due == 0
                        ? context.strings.caughtUp
                        : context.strings.reviewStatus(due, learned, total),
                    style: const TextStyle(fontSize: 11, color: Palette.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, size: 21),
          ],
        ),
      ),
    ),
  );
}
