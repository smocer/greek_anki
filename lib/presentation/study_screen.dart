import 'app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/learning_progress.dart';
import '../domain/curriculum.dart';
import '../domain/study_session.dart';
import '../domain/vocabulary.dart';
import 'greek_keyboard.dart';
import 'card_explanation.dart';
import 'theme.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({
    super.key,
    required this.deck,
    required this.cards,
    required this.mode,
    required this.progress,
  });
  final VocabularyDeck deck;
  final List<VocabularyCard> cards;
  final StudyMode mode;
  final LearningProgress progress;

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  late StudySession _session;
  final _answer = TextEditingController();
  final _focus = FocusNode();
  bool _useGreekKeyboard = true;
  bool _saving = false;
  bool get _hard => widget.mode == StudyMode.typing;

  @override
  void initState() {
    super.initState();
    _session = StudySession(cards: widget.cards, mode: widget.mode);
  }

  @override
  void dispose() {
    _session.dispose();
    _answer.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _advance(bool correct) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await widget.progress.record(
        deck: widget.deck,
        mode: widget.mode,
        card: _session.current,
        correct: correct,
      );
      if (!mounted) return;
      _answer.clear();
      _session.advance(correct: correct);
      HapticFeedback.lightImpact();
    } catch (error, stack) {
      debugPrint('Could not save review: $error\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.strings.answerSaveError)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _check() {
    if (_answer.text.trim().isEmpty) return;
    _focus.unfocus();
    _session.checkAnswer(_answer.text);
    HapticFeedback.lightImpact();
  }

  void _restart() {
    _session.dispose();
    setState(() {
      final due = widget.progress.dueCards(widget.deck, widget.mode);
      _session = StudySession(
        cards: sessionBatch(due.isEmpty ? widget.deck.cards : due),
        mode: widget.mode,
      );
      _answer.clear();
    });
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !_saving,
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: context.strings.backToDecks,
          onPressed: _saving ? null : () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(
          _hard ? context.strings.hardMode : context.strings.flashcards,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListenableBuilder(
              listenable: _session,
              builder: (context, _) {
                if (_session.isComplete) {
                  return _Completion(
                    session: _session,
                    onRestart: _restart,
                    onDone: () => Navigator.pop(context),
                  );
                }
                return LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SessionProgress(
                          session: _session,
                          title: context.localize(widget.deck.title),
                        ),
                        SizedBox(height: _hard ? 20 : 30),
                        if (_hard)
                          ..._typingContent(context)
                        else
                          ..._flashcardContent(context, constraints.maxHeight),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );

  List<Widget> _flashcardContent(BuildContext context, double height) {
    final revealed = _session.phase == CardPhase.answer;
    return [
      Text(
        revealed ? context.strings.letItSinkIn : context.strings.howDoYouSay,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 8),
      Text(
        revealed
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
            onTap: revealed ? null : _session.reveal,
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
      const SizedBox(height: 26),
      if (!revealed)
        FilledButton.icon(
          onPressed: _session.reveal,
          icon: const Icon(Icons.flip_rounded, size: 19),
          label: Text(context.strings.revealAnswer),
        )
      else
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _saving ? null : () => _advance(false),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.strings.again),
                    Text(
                      context.strings.repeatSoon,
                      style: TextStyle(fontSize: 10, color: Palette.muted),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: _saving ? null : () => _advance(true),
                child: Text(context.strings.gotIt),
              ),
            ),
          ],
        ),
      const SizedBox(height: 18),
      Text(
        _saving
            ? context.strings.savingProgress
            : context.strings.missedCardsReturn,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, color: Palette.muted),
      ),
    ];
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
          fontSize: _promptSize(context.localize(card.prompt), numericSize: 86),
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
      const SizedBox(height: 20),
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
        style: const TextStyle(fontSize: 25, letterSpacing: 0.5),
        decoration: InputDecoration(
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
              : null,
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
        const SizedBox(height: 22),
        FilledButton(
          onPressed: _saving ? null : () => _advance(_session.typedCorrect!),
          child: Text(
            _saving ? context.strings.saving : context.strings.continueLabel,
          ),
        ),
      ] else ...[
        Text(
          context.strings.inputHelp,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Palette.muted),
        ),
        const SizedBox(height: 18),
        if (_useGreekKeyboard) GreekKeyboard(controller: _answer),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              _focus.unfocus();
              setState(() => _useGreekKeyboard = !_useGreekKeyboard);
              if (!_useGreekKeyboard) _focus.requestFocus();
            },
            icon: const Icon(Icons.keyboard_outlined, size: 17),
            label: Text(
              _useGreekKeyboard
                  ? context.strings.phoneKeyboard
                  : context.strings.greekKeyboard,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
        const SizedBox(height: 6),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _answer,
          builder: (context, value, _) => FilledButton(
            onPressed: value.text.trim().isEmpty ? null : _check,
            child: Text(context.strings.checkAnswer),
          ),
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: () {
            _focus.unfocus();
            _session.skip();
          },
          child: Text(context.strings.dontKnow),
        ),
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
              title,
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
  });
  final StudySession session;
  final VoidCallback onRestart;
  final VoidCallback onDone;

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
