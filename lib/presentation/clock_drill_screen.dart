import 'package:flutter/material.dart';

import '../domain/clock_drill.dart';
import 'analog_clock.dart';
import 'app_strings.dart';
import 'greek_keyboard.dart';
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
    if (!_useGreekKeyboard) _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: BackButton(onPressed: () => Navigator.pop(context)),
      title: Text(context.strings.clockDrill),
    ),
    body: SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.strings.clockQuestion,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  context.strings.clockInstructions,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Palette.muted, fontSize: 13),
                ),
                const SizedBox(height: 18),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 240),
                    child: AnalogClock(time: _time),
                  ),
                ),
                const SizedBox(height: 20),
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
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: context.strings.answerHint,
                    hintStyle: const TextStyle(
                      fontSize: 17,
                      color: Palette.muted,
                    ),
                  ),
                  onSubmitted: (_) => _check(),
                ),
                const SizedBox(height: 16),
                if (_correct case final correct?) ...[
                  Semantics(
                    liveRegion: true,
                    child: Container(
                      key: const ValueKey('clock-feedback'),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: correct ? Palette.softGreen : Palette.softOrange,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            correct
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                            color: correct ? Palette.ink : Palette.red,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            correct
                                ? context.strings.exactlyRight
                                : context.strings.incorrectAnswer,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _matcher.display(_time),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 23),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _time.digital,
                            style: const TextStyle(color: Palette.muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    key: const ValueKey('next-clock'),
                    autofocus: true,
                    onPressed: _next,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: Text(context.strings.nextClock),
                  ),
                ] else ...[
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
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _answer,
                    builder: (context, value, _) => FilledButton(
                      key: const ValueKey('check-clock'),
                      onPressed: value.text.trim().isEmpty ? null : _check,
                      child: Text(context.strings.checkAnswer),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
