import 'package:flutter/material.dart';

import '../domain/clock_drill.dart';
import 'analog_clock.dart';
import 'app_strings.dart';
import 'greek_keyboard.dart';
import 'practice_layout.dart';
import 'theme.dart';

class ClockDrillScreen extends StatefulWidget {
  const ClockDrillScreen({super.key, this.generator});

  final ClockTimeGenerator? generator;

  @override
  State<ClockDrillScreen> createState() => _ClockDrillScreenState();
}

class _ClockDrillScreenState extends State<ClockDrillScreen> {
  late final _generator = widget.generator ?? ClockTimeGenerator();
  late ClockTime _time = _generator.next();
  static const _matcher = GreekClockAnswer();
  final _answer = TextEditingController();
  final _focus = FocusNode();
  bool _useGreekKeyboard = true;
  bool? _correct;

  @override
  void dispose() {
    _answer.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _check() {
    if (_correct != null || _answer.text.trim().isEmpty) return;
    _focus.unfocus();
    setState(() => _correct = _matcher.matches(_answer.text, _time));
  }

  void _next() {
    if (_correct == null) return;
    setState(() {
      _time = _generator.next(previous: _time);
      _correct = null;
      _answer.clear();
    });
    _focusEditableInput();
  }

  void _focusEditableInput() {
    // Rebuild the formerly read-only field before opening its web input
    // connection. Focusing it earlier can leave the browser editor read-only.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_useGreekKeyboard && _correct == null) {
        _focus.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: BackButton(onPressed: () => Navigator.pop(context)),
      title: Text(context.strings.clockDrill),
      actions: [
        IconButton(
          tooltip: context.strings.clockInstructions,
          icon: const Icon(Icons.help_outline_rounded),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(context.strings.clockQuestion),
              content: Text(context.strings.clockInstructions),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.strings.close),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    bottomNavigationBar: PracticeActions(
      child: _correct != null
          ? FilledButton.icon(
              key: const ValueKey('next-clock'),
              autofocus: true,
              onPressed: _next,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: Text(context.strings.nextClock),
            )
          : ValueListenableBuilder<TextEditingValue>(
              valueListenable: _answer,
              builder: (context, value, _) => FilledButton(
                key: const ValueKey('check-clock'),
                onPressed: value.text.trim().isEmpty ? null : _check,
                child: Text(context.strings.checkAnswer),
              ),
            ),
    ),
    body: PracticeBody(
      contentBuilder: (context, constraints) {
        // Leave space for the answer and full keyboard before sizing the clock.
        final clockSize = _correct == null && _useGreekKeyboard
            ? (constraints.maxHeight - 350).clamp(144.0, 240.0)
            : (constraints.maxHeight - 240).clamp(120.0, 240.0);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SizedBox.square(
                dimension: clockSize,
                child: AnalogClock(time: _time),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('clock-answer'),
              controller: _answer,
              focusNode: _focus,
              readOnly: _useGreekKeyboard || _correct != null,
              showCursor: _correct == null,
              autocorrect: false,
              enableSuggestions: false,
              minLines: 1,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                hintText: context.strings.answerHint,
                hintStyle: const TextStyle(fontSize: 16, color: Palette.muted),
                suffixIcon: _correct != null
                    ? null
                    : KeyboardToggle(
                        useGreekKeyboard: _useGreekKeyboard,
                        onPressed: () {
                          _focus.unfocus();
                          setState(
                            () => _useGreekKeyboard = !_useGreekKeyboard,
                          );
                          _focusEditableInput();
                        },
                      ),
              ),
              onSubmitted: (_) => _check(),
            ),
            const SizedBox(height: 10),
            if (_correct case final correct?)
              _feedback(context, correct)
            else if (_useGreekKeyboard)
              GreekKeyboard(controller: _answer),
          ],
        );
      },
    ),
  );

  Widget _feedback(BuildContext context, bool correct) => Semantics(
    liveRegion: true,
    child: Container(
      key: const ValueKey('clock-feedback'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: correct ? Palette.softGreen : Palette.softOrange,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            correct ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: correct ? Palette.ink : Palette.red,
          ),
          const SizedBox(height: 6),
          Text(
            correct
                ? context.strings.exactlyRight
                : context.strings.incorrectAnswer,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _matcher.display(_time),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 23),
          ),
          const SizedBox(height: 4),
          Text(_time.digital, style: const TextStyle(color: Palette.muted)),
        ],
      ),
    ),
  );
}
