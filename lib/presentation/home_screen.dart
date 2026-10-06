import 'package:flutter/material.dart';

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
  VocabularyDeck get _deck => _selection?.deck ?? _collection.deck;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
  });

  Future<void> _start(StudyMode mode) async {
    final due = widget.progress.dueCards(_deck, mode);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StudyScreen(
          deck: _deck,
          cards: sessionBatch(due.isEmpty ? _deck.cards : due),
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
          TopicPicker(collection: _collection, selection: _selection),
    );
    if (mounted && selected != null) setState(() => _selection = selected);
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
                      (c) => c.section == _section,
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
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Palette.lime,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localize(_deck.subtitle),
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        context.strings.cardCount(_deck.cards.length),
                        style: const TextStyle(fontSize: 12),
                      ),
                      if (_selection != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _selection!.description(context.strings),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        children: [
                          TextButton.icon(
                            key: const ValueKey('choose-category'),
                            onPressed: _filter,
                            icon: const Icon(Icons.tune_rounded, size: 18),
                            label: Text(context.strings.filters),
                          ),
                          TextButton.icon(
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
                          if (_selection != null)
                            TextButton(
                              onPressed: () =>
                                  setState(() => _selection = null),
                              child: Text(context.strings.clearFilters),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.strings.sessionSize,
                  style: const TextStyle(color: Palette.muted, fontSize: 12),
                ),
                const SizedBox(height: 12),
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
                    onTap: _deck.cards.isEmpty ? null : () => _start(mode),
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
