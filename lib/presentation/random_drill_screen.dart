import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/date_drill.dart';
import '../domain/number_drill.dart';
import 'app_strings.dart';
import 'day_period_picture.dart';
import 'greek_keyboard.dart';
import 'labeled_field.dart';
import 'practice_layout.dart';
import 'theme.dart';

enum RandomDrillKind { number, date }

/// Shared form lifecycle; the small domain matchers own the Greek answer rules.
class RandomDrillScreen extends StatefulWidget {
  const RandomDrillScreen({
    super.key,
    required this.kind,
    this.numbers,
    this.dates,
  });
  final RandomDrillKind kind;
  final NumberGenerator? numbers;
  final DateDrillGenerator? dates;

  @override
  State<RandomDrillScreen> createState() => _RandomDrillScreenState();
}

class _RandomDrillScreenState extends State<RandomDrillScreen> {
  static const _numberAnswer = GreekNumberAnswer();
  static const _dateAnswer = GreekDateAnswer();
  late final _numbers = widget.numbers ?? NumberGenerator();
  late final _dates = widget.dates ?? DateDrillGenerator();
  bool get _isDate => widget.kind == RandomDrillKind.date;
  late int _number;
  late DateDrillQuestion _date;
  late final _controllers = List.generate(
    _isDate ? 2 : 1,
    (_) => TextEditingController(),
  );
  late final _focusNodes = List.generate(
    _controllers.length,
    (_) => FocusNode(),
  );
  int _active = 0;
  bool _greekKeyboard = true;
  List<bool>? _results;

  @override
  void initState() {
    super.initState();
    _generate();
    for (var i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus && _active != i) {
          setState(() => _active = i);
        }
      });
      _controllers[i].addListener(_inputChanged);
    }
  }

  void _inputChanged() => setState(() {});

  void _generate() {
    if (_isDate) {
      _date = _dates.next();
    } else {
      _number = _numbers.next();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.removeListener(_inputChanged);
      controller.dispose();
    }
    for (final focus in _focusNodes) {
      focus.dispose();
    }
    super.dispose();
  }

  bool get _canCheck =>
      _results == null && _controllers.every((c) => c.text.trim().isNotEmpty);

  void _check() {
    if (!_canCheck) return;
    for (final focus in _focusNodes) {
      focus.unfocus();
    }
    setState(
      () => _results = _isDate
          ? [
              _dateAnswer.matchesDate(_controllers[0].text, _date),
              _dateAnswer.matchesTime(_controllers[1].text, _date),
            ]
          : [_numberAnswer.matches(_controllers[0].text, _number)],
    );
  }

  void _next() {
    setState(() {
      _generate();
      _results = null;
      _active = 0;
      for (final controller in _controllers) {
        controller.clear();
      }
    });
    _focusEditableInput();
  }

  void _focusEditableInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_greekKeyboard && _results == null) {
        _focusNodes[_active].requestFocus();
      }
    });
  }

  String _label(BuildContext context, int index) => !_isDate
      ? context.strings.answerHint
      : index == 0
      ? context.strings.dateAnswerLabel
      : context.strings.timeAnswerLabel;

  String _solution(int index) => !_isDate
      ? _numberAnswer.display(_number)
      : index == 0
      ? _dateAnswer.displayDate(_date)
      : _dateAnswer.displayTime(_date);

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final title = _isDate ? strings.dateDrill : strings.numberDrill;
    final instructions = _isDate
        ? strings.dateDrillInstructions
        : strings.numberDrillInstructions;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: strings.drillHelp,
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(child: Text(instructions)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(strings.close),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PracticeActions(
        child: FilledButton(
          key: ValueKey(
            _results == null ? 'check-random-drill' : 'next-random-drill',
          ),
          onPressed: _results != null
              ? _next
              : _canCheck
              ? _check
              : null,
          child: Text(
            _results != null ? strings.nextDrill : strings.checkAnswer,
          ),
        ),
      ),
      body: PracticeBody(
        contentBuilder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isDate) ...[
              Text(
                DateFormat.MMMEd(
                  strings.language.code,
                ).addPattern('h:mm').format(_date.date),
                key: const ValueKey('date-prompt'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              DayPeriodPicture(period: _date.period),
            ] else ...[
              Text(
                '$_number',
                key: const ValueKey('number-prompt'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 60),
              ),
              Text(
                strings.numberDrillDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Palette.muted),
              ),
              const SizedBox(height: 12),
            ],
            for (var i = 0; i < _controllers.length; i++) ...[
              LabeledField(
                label: _label(context, i),
                child: TextField(
                  key: ValueKey('drill-answer-$i'),
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  readOnly: _greekKeyboard || _results != null,
                  showCursor: _results == null,
                  autocorrect: false,
                  enableSuggestions: false,
                  minLines: 1,
                  maxLines: 3,
                  textInputAction: i + 1 == _controllers.length
                      ? TextInputAction.done
                      : TextInputAction.next,
                  style: const TextStyle(fontSize: 19),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    suffixIcon: _results == null
                        ? null
                        : Icon(
                            _results![i]
                                ? Icons.check_rounded
                                : Icons.close_rounded,
                            color: _results![i] ? Palette.ink : Palette.red,
                            semanticLabel: _results![i]
                                ? strings.exactlyRight
                                : strings.incorrectAnswer,
                          ),
                  ),
                  onTap: () => setState(() => _active = i),
                  onSubmitted: (_) {
                    if (i + 1 == _controllers.length) {
                      _check();
                    } else {
                      setState(() => _active = i + 1);
                      _focusEditableInput();
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (_results == null) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      strings.inputHelp,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Palette.muted,
                      ),
                    ),
                  ),
                  KeyboardToggle(
                    useGreekKeyboard: _greekKeyboard,
                    onPressed: () {
                      for (final focus in _focusNodes) {
                        focus.unfocus();
                      }
                      setState(() => _greekKeyboard = !_greekKeyboard);
                      _focusEditableInput();
                    },
                  ),
                ],
              ),
              if (_greekKeyboard)
                GreekKeyboard(
                  key: ValueKey('drill-keyboard-$_active'),
                  controller: _controllers[_active],
                ),
            ] else
              Semantics(
                liveRegion: true,
                child: Column(
                  children: [
                    for (var i = 0; i < _results!.length; i++)
                      Container(
                        key: ValueKey('drill-feedback-$i'),
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _results![i]
                              ? Palette.softGreen
                              : Palette.softOrange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${_label(context, i)} · ${_results![i] ? strings.exactlyRight : strings.incorrectAnswer}',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _solution(i),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
