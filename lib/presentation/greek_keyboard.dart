import 'app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme.dart';

class GreekKeyboard extends StatelessWidget {
  const GreekKeyboard({super.key, required this.controller});
  final TextEditingController controller;

  void _insert(String text) {
    final value = controller.value;
    final selection = value.selection;
    final start = selection.isValid ? selection.start : value.text.length;
    final end = selection.isValid ? selection.end : value.text.length;
    controller.value = TextEditingValue(
      text: value.text.replaceRange(start, end, text),
      selection: TextSelection.collapsed(offset: start + text.length),
    );
    HapticFeedback.selectionClick();
  }

  void _backspace() {
    final value = controller.value;
    final selection = value.selection;
    final end = selection.isValid ? selection.end : value.text.length;
    var start = selection.isValid ? selection.start : end;
    if (start == end) {
      if (start == 0) return;
      start -= value.text.substring(0, start).characters.last.length;
    }
    controller.value = TextEditingValue(
      text: value.text.replaceRange(start, end, ''),
      selection: TextSelection.collapsed(offset: start),
    );
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final row in ['ςερτυθιοπ', 'ασδφγηξκλ', 'ζχψωβνμ', 'άέήίόύώ'])
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row
                .split('')
                .map(
                  (letter) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: _Key(label: letter, onTap: () => _insert(letter)),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      Row(
        children: [
          const SizedBox(width: 2),
          Expanded(
            child: _Key(
              label: context.strings.space,
              onTap: () => _insert(' '),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 70,
            child: _Key(
              label: context.strings.delete,
              icon: Icons.backspace_outlined,
              onTap: _backspace,
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    ],
  );
}

class _Key extends StatelessWidget {
  const _Key({required this.label, required this.onTap, this.icon});
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
        side: const BorderSide(color: Palette.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 46,
          child: Center(
            child: ExcludeSemantics(
              child: icon != null
                  ? Icon(icon, size: 21)
                  : Text(
                      label,
                      style: TextStyle(
                        fontSize: label.runes.length == 1 ? 23 : 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ),
        ),
      ),
    ),
  );
}
