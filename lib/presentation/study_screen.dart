import 'dart:async';

import 'app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/learning_progress.dart';
import '../domain/curriculum.dart';
import '../domain/study_session.dart';
import '../domain/study_session_store.dart';
import '../domain/vocabulary.dart';
import 'greek_keyboard.dart';
import 'practice_layout.dart';
import 'card_explanation.dart';
import 'theme.dart';
import 'word_audio_buttons.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({
    super.key,
    required this.deck,
    required this.cards,
    required this.mode,
    required this.progress,
    required this.sessionStore,
    this.sessionLimit = 15,
    this.cardOrder = CardOrder.random,
  });
  final VocabularyDeck deck;
  final List<VocabularyCard> cards;
  final StudyMode mode;
  final LearningProgress progress;
  final StudySessionStore sessionStore;
  final int? sessionLimit;
  final CardOrder cardOrder;

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  late StudySession _session;
  late Future<void> _loading;
  late final String _sessionKey;
  final _answer = TextEditingController();
  final _focus = FocusNode();
  bool _useGreekKeyboard = true;
  bool _saving = false;
  Object? _saveError;
  bool get _hard => widget.mode == StudyMode.typing;

  @override
  void initState() {
    super.initState();
    _session = StudySession(
      cards: widget.cards,
      mode: widget.mode,
      shuffle: false,
    );
    _sessionKey = studySessionKey(
      deck: widget.deck,
      mode: widget.mode,
      limit: widget.sessionLimit,
      order: widget.cardOrder,
    );
    _loading = _loadSession();
  }

  Future<void> _loadSession() async {
    final saved = await widget.sessionStore.read(_sessionKey);
    if (!mounted) return;
    if (saved != null) {
      if (saved.mode != widget.mode) {
        throw const FormatException('Saved study mode does not match');
      }
      final restored = StudySession.restore(
        cards: widget.deck.cards,
        snapshot: saved,
      );
      _session.dispose();
      _session = restored;
      _answer.text = _session.submittedAnswer;
    }
    await _saveSession();
  }

  Future<void> _saveSession() => _session.completed == _session.total
      ? widget.sessionStore.remove(_sessionKey)
      : widget.sessionStore.write(_sessionKey, _session.snapshot);

  @override
  void dispose() {
    _session.dispose();
    _answer.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<bool> _saveChange(FutureOr<void> Function() change) async {
    if (_saving) return false;
    setState(() => _saving = true);
    try {
      await change();
      await _saveSession();
      _saveError = null;
      return true;
    } catch (error, stack) {
      _saveError = error;
      debugPrint('Could not save study progress: $error\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.strings.sessionSaveError),
            action: SnackBarAction(
              label: context.strings.tryAgain,
              onPressed: () => _saveChange(() {}),
            ),
          ),
        );
      }
      return false;
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _advance(bool correct) async {
    if (_session.isReviewing) return;
    await _saveChange(() async {
      await widget.progress.record(
        deck: widget.deck,
        mode: widget.mode,
        card: _session.current,
        correct: correct,
      );
      if (!mounted) return;
      _answer.clear();
      _session.advance(correct: correct);
      _focusEditableInput();
      HapticFeedback.lightImpact();
    });
  }

  Future<void> _leave() async {
    if (_saving) return;
    if (_saveError != null && !await _saveChange(() {})) return;
    if (mounted) Navigator.pop(context);
  }

  void _check() {
    if (_answer.text.trim().isEmpty) return;
    _focus.unfocus();
    _saveChange(() => _session.checkAnswer(_answer.text));
    HapticFeedback.lightImpact();
  }

  void _focusEditableInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted &&
          _hard &&
          !_useGreekKeyboard &&
          !_session.isComplete &&
          _session.phase != CardPhase.answer) {
        _focus.requestFocus();
      }
    });
  }

  void _restart() {
    _saveChange(() {
      final due = widget.progress.dueCards(widget.deck, widget.mode);
      _session.dispose();
      _session = StudySession(
        cards: sessionBatch(
          widget.sessionLimit == null || due.isEmpty ? widget.deck.cards : due,
          limit: widget.sessionLimit ?? widget.deck.cards.length,
          order: widget.cardOrder,
        ),
        mode: widget.mode,
        shuffle: false,
      );
      _answer.clear();
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
    future: _loading,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          !snapshot.hasError) {
        return _studyContent(context);
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _hard ? context.strings.hardMode : context.strings.flashcards,
          ),
        ),
        body: Center(
          child: snapshot.hasError
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.strings.sessionLoadError,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => setState(() {
                          _loading = _loadSession();
                        }),
                        child: Text(context.strings.tryAgain),
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      );
    },
  );

  Widget _studyContent(BuildContext context) => PopScope(
    canPop: !_saving && _saveError == null,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop && !_saving) _leave();
    },
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: context.strings.backToDecks,
          onPressed: _saving ? null : _leave,
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(
          _hard ? context.strings.hardMode : context.strings.flashcards,
        ),
        actions: [
          if (!_hard)
            ListenableBuilder(
              listenable: _session,
              builder: (context, _) => _session.isComplete
                  ? const SizedBox.shrink()
                  : IconButton(
                      key: const ValueKey('previous-card'),
                      tooltip: context.strings.previousCard,
                      onPressed: !_saving && _session.canGoPrevious
                          ? () => _saveChange(_session.previous)
                          : null,
                      icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    ),
            ),
        ],
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: _session,
        builder: (context, _) => _session.isComplete
            ? const SizedBox.shrink()
            : PracticeActions(
                child: _hard
                    ? _typingActions(context)
                    : _flashcardActions(context),
              ),
      ),
      body: ListenableBuilder(
        listenable: _session,
        builder: (context, _) {
          if (_session.isComplete) {
            return SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: _Completion(
                    session: _session,
                    onRestart: _saving ? null : _restart,
                    onDone: _saving ? null : _leave,
                    onPrevious: !_saving && !_hard && _session.canGoPrevious
                        ? () => _saveChange(_session.previous)
                        : null,
                  ),
                ),
              ),
            );
          }
          return PracticeBody(
            contentBuilder: (context, constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SessionProgress(
                  session: _session,
                  title: context.localize(widget.deck.title),
                ),
                SizedBox(height: _hard ? 12 : 20),
                if (_hard)
                  ..._typingContent(context)
                else
                  ..._flashcardContent(context, constraints.maxHeight),
              ],
            ),
          );
        },
      ),
    ),
  );

  List<Widget> _flashcardContent(BuildContext context, double height) {
    final revealed = _session.phase == CardPhase.answer;
    return [
      Text(
        _session.isReviewing
            ? context.strings.reviewCard
            : revealed
            ? context.strings.letItSinkIn
            : context.strings.howDoYouSay,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 8),
      Text(
        _session.isReviewing
            ? context.strings.reviewHistoryHint
            : revealed
            ? context.strings.didYouRemember
            : context.strings.sayBeforeFlip,
        style: const TextStyle(color: Palette.muted),
      ),
      const SizedBox(height: 26),
      Semantics(
        button: !revealed,
        label: revealed ? null : context.strings.revealGreekAnswer,
        child: Material(
          color: revealed ? Palette.ink : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: revealed ? Palette.ink : Palette.line),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: revealed || _saving
                ? null
                : () => _saveChange(_session.reveal),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (height - 330).clamp(270.0, 420.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: revealed
                      ? _RevealedCard(
                          key: ValueKey('${_session.currentKey}-answer'),
                          card: _session.current,
                        )
                      : _QuestionCard(
                          key: ValueKey('${_session.currentKey}-question'),
                          card: _session.current,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
      if (revealed && _session.current.explanation != null) ...[
        const SizedBox(height: 16),
        CardExplanation(explanation: _session.current.explanation!),
      ],
      if (!_session.isReviewing) ...[
        const SizedBox(height: 18),
        Text(
          _saving
              ? context.strings.savingProgress
              : context.strings.missedCardsReturn,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Palette.muted),
        ),
      ],
    ];
  }

  Widget _flashcardActions(BuildContext context) {
    if (_session.isReviewing) {
      return FilledButton.icon(
        key: const ValueKey('next-card'),
        onPressed: _saving ? null : () => _saveChange(_session.next),
        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
        label: Text(context.strings.nextCard),
      );
    }
    if (_session.phase != CardPhase.answer) {
      return FilledButton.icon(
        onPressed: _saving ? null : () => _saveChange(_session.reveal),
        icon: const Icon(Icons.flip_rounded, size: 19),
        label: Text(context.strings.revealAnswer),
      );
    }
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _saving ? null : () => _advance(false),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.strings.again, textAlign: TextAlign.center),
                Text(
                  context.strings.repeatSoon,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, color: Palette.muted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton(
            onPressed: _saving ? null : () => _advance(true),
            child: Text(context.strings.gotIt, textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }

  Widget _typingActions(BuildContext context) {
    if (_session.phase == CardPhase.answer) {
      return FilledButton(
        onPressed: _saving ? null : () => _advance(_session.typedCorrect!),
        child: Text(
          _saving ? context.strings.saving : context.strings.continueLabel,
        ),
      );
    }
    return Row(
      children: [
        Flexible(
          child: TextButton(
            onPressed: _saving
                ? null
                : () {
                    _focus.unfocus();
                    _saveChange(_session.skip);
                  },
            child: Text(context.strings.dontKnow, textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _answer,
            builder: (context, value, _) => FilledButton(
              key: const ValueKey('check-typing'),
              onPressed: _saving || value.text.trim().isEmpty ? null : _check,
              child: Text(
                context.strings.checkAnswer,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _typingContent(BuildContext context) {
    final answered = _session.phase == CardPhase.answer;
    final card = _session.current;
    return [
      Eyebrow(context.strings.writeInGreek),
      const SizedBox(height: 8),
      Text(
        context.localize(card.prompt),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: _promptSize(context.localize(card.prompt), numericSize: 64),
          height: 1.1,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        context.localize(card.meaning),
        textAlign: TextAlign.center,
        style: const TextStyle(color: Palette.muted),
      ),
      const SizedBox(height: 12),
      TextField(
        key: const ValueKey('greek-answer'),
        controller: _answer,
        focusNode: _focus,
        readOnly: _useGreekKeyboard || answered,
        showCursor: !answered,
        autocorrect: false,
        enableSuggestions: false,
        minLines: 1,
        maxLines: 3,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, letterSpacing: 0.5),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          hintText: context.strings.answerHint,
          hintStyle: const TextStyle(fontSize: 17, color: Palette.muted),
          suffixIcon: answered
              ? Icon(
                  _session.typedCorrect!
                      ? Icons.check_rounded
                      : Icons.close_rounded,
                  color: _session.typedCorrect! ? Palette.ink : Palette.red,
                  semanticLabel: _session.typedCorrect!
                      ? context.strings.exactlyRight
                      : context.strings.incorrectAnswer,
                )
              : KeyboardToggle(
                  useGreekKeyboard: _useGreekKeyboard,
                  onPressed: () {
                    _focus.unfocus();
                    setState(() => _useGreekKeyboard = !_useGreekKeyboard);
                    _focusEditableInput();
                  },
                ),
        ),
        onSubmitted: (_) => _check(),
      ),
      const SizedBox(height: 14),
      if (answered) ...[
        _AnswerFeedback(card: card, correct: _session.typedCorrect!),
        if (card.explanation != null) ...[
          const SizedBox(height: 14),
          CardExplanation(explanation: card.explanation!),
        ],
      ] else ...[
        Text(
          context.strings.inputHelp,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Palette.muted),
        ),
        const SizedBox(height: 8),
        if (_useGreekKeyboard) GreekKeyboard(controller: _answer),
      ],
    ];
  }
}

class _SessionProgress extends StatelessWidget {
  const _SessionProgress({required this.session, required this.title});
  final StudySession session;
  final String title;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              session.isReview
                  ? '$title · ${context.strings.sessionReview}'
                  : title,
              style: const TextStyle(fontSize: 12, color: Palette.muted),
            ),
          ),
          Text(
            context.strings.progress(session.completed, session.total),
            style: const TextStyle(fontSize: 12, color: Palette.muted),
          ),
        ],
      ),
      const SizedBox(height: 12),
      LinearProgressIndicator(
        value: session.progress,
        semanticsLabel: context.strings.progressAccessibility(
          session.completed,
          session.total,
        ),
      ),
    ],
  );
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({super.key, required this.card});
  final VocabularyCard card;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Eyebrow(context.strings.learningDirection),
      const SizedBox(height: 24),
      Text(
        context.localize(card.prompt),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: _promptSize(
            context.localize(card.prompt),
            numericSize: 104,
          ),
          height: 1.15,
          letterSpacing: -0.5,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        context.localize(card.meaning),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 17, color: Palette.muted),
      ),
      const SizedBox(height: 30),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.touch_app_outlined, size: 16, color: Palette.muted),
          SizedBox(width: 6),
          Flexible(
            child: Text(
              context.strings.tapToTurn,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Palette.muted),
            ),
          ),
        ],
      ),
    ],
  );
}

class _RevealedCard extends StatelessWidget {
  const _RevealedCard({super.key, required this.card});
  final VocabularyCard card;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        context.localize(card.prompt),
        textAlign: TextAlign.center,
        style: const TextStyle(color: Palette.lime, fontSize: 15),
      ),
      const SizedBox(height: 30),
      Text(
        card.displayedAnswer,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: card.greek.length > 22 ? 30 : 40,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 14),
      Text(
        context.localize(card.pronunciation),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Palette.lime,
          fontSize: 19,
          letterSpacing: 0.8,
        ),
      ),
      if (card.alternatives.isNotEmpty) ...[
        const SizedBox(height: 20),
        Text(
          context.strings.also(card.alternatives.join(' / ')),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Palette.lime, fontSize: 13),
        ),
      ],
      WordAudioButtons(card: card, color: Palette.lime),
      const SizedBox(height: 28),
      Text(
        context.strings.oneWordCloser,
        style: TextStyle(color: Color(0xFFB4C5B8), fontSize: 12),
      ),
    ],
  );
}

class _AnswerFeedback extends StatelessWidget {
  const _AnswerFeedback({required this.card, required this.correct});
  final VocabularyCard card;
  final bool correct;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: correct ? Palette.softGreen : Palette.softOrange,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Text(
            correct
                ? context.strings.exactlyRight
                : context.strings.youllGetThis,
            style: TextStyle(
              color: correct ? Palette.ink : Palette.orange,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            card.displayedAnswer,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: card.greek.length > 22 ? 27 : 34,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.localize(card.pronunciation),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Palette.muted),
          ),
          if (card.alternatives.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              context.strings.also(card.alternatives.join(' / ')),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Palette.muted),
            ),
          ],
          WordAudioButtons(card: card),
          const SizedBox(height: 16),
          Text(
            correct
                ? context.strings.rememberSpelling
                : context.strings.lookClosely,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Palette.muted),
          ),
        ],
      ),
    ),
  );
}

class _Completion extends StatelessWidget {
  const _Completion({
    required this.session,
    required this.onRestart,
    required this.onDone,
    this.onPrevious,
  });
  final StudySession session;
  final VoidCallback? onRestart;
  final VoidCallback? onDone;
  final VoidCallback? onPrevious;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 86,
              height: 86,
              decoration: const BoxDecoration(
                color: Palette.lime,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.done_all_rounded, size: 40),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Μπράβο!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 12),
          Text(
            context.strings.completionTagline,
            textAlign: TextAlign.center,
            style: TextStyle(color: Palette.muted),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Palette.line),
            ),
            child: Column(
              children: [
                Text(
                  context.strings.wordsRemembered(session.total),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  context.strings.firstTry(
                    session.firstTryCorrect,
                    session.total,
                  ),
                  style: const TextStyle(color: Palette.muted),
                ),
                if (session.repetitions > 0)
                  Text(
                    context.strings.extraPractice(session.repetitions),
                    style: const TextStyle(color: Palette.muted),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            context.strings.completionNote,
            textAlign: TextAlign.center,
            style: TextStyle(color: Palette.muted, fontSize: 13),
          ),
          const SizedBox(height: 28),
          if (onPrevious != null) ...[
            OutlinedButton.icon(
              key: const ValueKey('previous-card'),
              onPressed: onPrevious,
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: Text(context.strings.previousCard),
            ),
            const SizedBox(height: 10),
          ],
          FilledButton(
            onPressed: onDone,
            child: Text(context.strings.backToMyDeck),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onRestart,
            child: Text(context.strings.nextBatch),
          ),
        ],
      ),
    ),
  );
}

// Digits retain the original large treatment; full sentences stay readable.
double _promptSize(String prompt, {required double numericSize}) {
  if (RegExp(r'^\d+$').hasMatch(prompt)) return numericSize;
  if (prompt.length <= 14) return 38;
  if (prompt.length <= 35) return 29;
  return 24;
}
