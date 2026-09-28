import 'package:flutter/material.dart';

import '../domain/learning_progress.dart';
import '../domain/app_updates.dart';
import '../domain/app_language.dart';
import '../domain/vocabulary.dart';
import 'study_screen.dart';
import 'topic_picker.dart';
import 'app_strings.dart';
import 'language_switch.dart';
import 'theme.dart';
import 'vocabulary_sheet.dart';
import 'web_update_notice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.decks,
    required this.progress,
    required this.onLanguageChanged,
    this.updates,
  });
  final List<VocabularyDeck> decks;
  final LearningProgress progress;
  final Future<void> Function(AppLanguage) onLanguageChanged;
  final AppUpdates? updates;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _deckIndex = 0;
  VocabularyDeck get _deck => widget.decks[_deckIndex];

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

  Future<void> _start(StudyMode mode) async {
    final due = widget.progress.dueCards(_deck, mode);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StudyScreen(
          deck: _deck,
          cards: due.isEmpty ? _deck.cards : due,
          mode: mode,
          progress: widget.progress,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _chooseTopic() async {
    final id = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => TopicPicker(decks: widget.decks, selectedId: _deck.id),
    );
    if (!mounted || id == null) return;
    setState(
      () => _deckIndex = widget.decks.indexWhere((deck) => deck.id == id),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListenableBuilder(
            listenable: widget.progress,
            builder: (context, _) => ListView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Palette.ink,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'α',
                        style: TextStyle(
                          fontSize: 29,
                          height: 1,
                          color: Palette.lime,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Eyebrow('Greek Anki', color: Palette.ink),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ελληνικά',
                      style: TextStyle(color: Palette.muted, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                LanguageSwitch(onChanged: widget.onLanguageChanged),
                if (widget.updates case final updates?)
                  WebUpdateNotice(updates: updates),
                const SizedBox(height: 24),
                Text(
                  context.strings.headline,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  context.strings.tagline,
                  style: TextStyle(color: Palette.muted),
                ),
                const SizedBox(height: 28),
                if (widget.decks.length > 1) ...[
                  OutlinedButton.icon(
                    onPressed: _chooseTopic,
                    icon: const Icon(Icons.grid_view_rounded, size: 19),
                    label: Text(
                      context.strings.chooseTopic(widget.decks.length),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                _DeckCover(
                  deck: _deck,
                  onBrowse: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    useSafeArea: true,
                    builder: (_) => VocabularySheet(deck: _deck),
                  ),
                ),
                const SizedBox(height: 28),
                Eyebrow(context.strings.choosePractice),
                const SizedBox(height: 14),
                _ModeTile(
                  title: context.strings.flashcards,
                  description: context.strings.flashcardsDescription,
                  icon: Icons.style_outlined,
                  learned: widget.progress.learned(_deck, StudyMode.flashcards),
                  due: widget.progress
                      .dueCards(_deck, StudyMode.flashcards)
                      .length,
                  total: _deck.cards.length,
                  onTap: () => _start(StudyMode.flashcards),
                ),
                const SizedBox(height: 12),
                _ModeTile(
                  title: context.strings.hardMode,
                  description: context.strings.hardDescription,
                  icon: Icons.edit_outlined,
                  hard: true,
                  learned: widget.progress.learned(_deck, StudyMode.typing),
                  due: widget.progress.dueCards(_deck, StudyMode.typing).length,
                  total: _deck.cards.length,
                  onTap: () => _start(StudyMode.typing),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 14,
                      color: Palette.muted,
                    ),
                    SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        widget.updates == null
                            ? context.strings.offlineFooter
                            : context.strings.browserFooter,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Palette.muted),
                      ),
                    ),
                  ],
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
                            onPressed: () => Navigator.of(context).pop(),
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

class _DeckCover extends StatelessWidget {
  const _DeckCover({required this.deck, required this.onBrowse});
  final VocabularyDeck deck;
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(24, 22, 24, 18),
    decoration: BoxDecoration(
      color: Palette.lime,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Eyebrow(context.strings.firstWords, color: Palette.ink),
            ),
            const SizedBox(width: 8),
            Text(
              context.strings.cardCount(deck.cards.length),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          deck.cover,
          style: TextStyle(
            fontSize: deck.cover.length <= 5 ? 68 : 40,
            height: 1.12,
            fontWeight: FontWeight.w400,
            letterSpacing: deck.cover.length <= 5 ? -3 : -1,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          context.localize(deck.title),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Expanded(
              child: Text(
                context.localize(deck.subtitle),
                style: const TextStyle(fontSize: 13),
              ),
            ),
            TextButton(
              onPressed: onBrowse,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.strings.browse),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_outward_rounded, size: 17),
                ],
              ),
            ),
          ],
        ),
      ],
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
  final VoidCallback onTap;
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
