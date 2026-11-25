import 'package:flutter/material.dart';

import '../data/grammar_drill_data.dart';
import '../domain/curriculum.dart';
import '../domain/grammar_drill.dart';
import 'app_strings.dart';
import 'greek_keyboard.dart';
import 'labeled_field.dart';
import 'practice_layout.dart';
import 'theme.dart';

String grammarDrillTitle(AppStrings strings, GrammarDrillKind kind) =>
    switch (kind) {
      GrammarDrillKind.nounPlural => strings.nounPluralDrill,
      GrammarDrillKind.adjectivePlural => strings.adjectivePluralDrill,
      GrammarDrillKind.quantity => strings.quantityDrill,
    };

class GrammarDrillScreen extends StatefulWidget {
  const GrammarDrillScreen({
    super.key,
    required this.kind,
    required this.collections,
    this.generator,
  });
  final GrammarDrillKind kind;
  final List<LearningCollection> collections;
  final GrammarDrillGenerator? generator;

  @override
  State<GrammarDrillScreen> createState() => _GrammarDrillScreenState();
}

class _GrammarDrillScreenState extends State<GrammarDrillScreen> {
  late final _generator =
      widget.generator ??
      createGrammarDrill(
        kind: widget.kind,
        collections: widget.collections,
        nouns: nounPluralEntries,
        adjectives: adjectivePluralEntries,
        quantities: quantityEntries,
      );
  late GrammarDrillQuestion _question = _generator.next();
  final _controller = TextEditingController();
  final _focus = FocusNode();
  bool _greekKeyboard = true;
  bool? _correct;
  bool get _quantity => widget.kind == GrammarDrillKind.quantity;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_changed);
  }

  void _changed() => setState(() {});
  @override
  void dispose() {
    _controller.removeListener(_changed);
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _check() {
    if (_correct != null || _controller.text.trim().isEmpty) return;
    _focus.unfocus();
    setState(() => _correct = _question.matches(_controller.text));
  }

  void _next() {
    setState(() {
      _question = _generator.next();
      _correct = null;
      _controller.clear();
    });
    _focusInput();
  }

  void _focusInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_greekKeyboard && _correct == null) _focus.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final title = grammarDrillTitle(strings, widget.kind);
    return Scaffold(
      // Long localized drill titles live in the scrollable body, not a clipped toolbar.
      appBar: AppBar(
        title: Text(strings.grammarTitle),
        actions: [
          IconButton(
            tooltip: strings.drillHelp,
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(strings.drillHelp),
                content: SingleChildScrollView(
                  child: Text(
                    _quantity
                        ? strings.quantityDrillInstructions
                        : strings.pluralDrillInstructions,
                  ),
                ),
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
            _correct == null ? 'check-grammar-drill' : 'next-grammar-drill',
          ),
          onPressed: _correct != null
              ? _next
              : _controller.text.trim().isEmpty
              ? null
              : _check,
          child: Text(
            _correct == null ? strings.checkAnswer : strings.nextDrill,
          ),
        ),
      ),
      body: PracticeBody(
        contentBuilder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              key: const ValueKey('grammar-drill-title'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              _question.prompt,
              key: const ValueKey('grammar-drill-prompt'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 4),
            Text(
              _question.meaning.resolve(strings.language),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Palette.muted),
            ),
            if (_quantity)
              Text(
                _question.number == GrammaticalNumber.singular
                    ? strings.singularNoun
                    : strings.pluralNoun,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            const SizedBox(height: 12),
            LabeledField(
              label: _quantity ? strings.missingWord : strings.pluralAnswer,
              child: TextField(
                key: const ValueKey('grammar-drill-answer'),
                controller: _controller,
                focusNode: _focus,
                readOnly: _greekKeyboard || _correct != null,
                showCursor: _correct == null,
                autocorrect: false,
                enableSuggestions: false,
                minLines: 1,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 19),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  suffixIcon: _correct == null
                      ? null
                      : Icon(
                          _correct! ? Icons.check_rounded : Icons.close_rounded,
                          color: _correct! ? Palette.ink : Palette.red,
                          semanticLabel: _correct!
                              ? strings.exactlyRight
                              : strings.incorrectAnswer,
                        ),
                ),
                onSubmitted: (_) => _check(),
              ),
            ),
            const SizedBox(height: 8),
            if (_correct == null) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _quantity ? strings.inputHelp : strings.pluralInputHelp,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Palette.muted,
                      ),
                    ),
                  ),
                  KeyboardToggle(
                    useGreekKeyboard: _greekKeyboard,
                    onPressed: () {
                      _focus.unfocus();
                      setState(() => _greekKeyboard = !_greekKeyboard);
                      _focusInput();
                    },
                  ),
                ],
              ),
              if (_greekKeyboard) GreekKeyboard(controller: _controller),
            ] else
              Semantics(
                liveRegion: true,
                child: Container(
                  key: const ValueKey('grammar-drill-feedback'),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _correct! ? Palette.softGreen : Palette.softOrange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _correct!
                            ? strings.exactlyRight
                            : strings.incorrectAnswer,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _question.solution,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      ),
                      if (_quantity) ...[
                        const SizedBox(height: 8),
                        Text(
                          _question.prompt.replaceFirst(
                            '___',
                            _question.answers.first,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
