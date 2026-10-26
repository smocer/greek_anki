import 'package:flutter/material.dart';

import 'theme.dart';

/// A wrapping label above the control, clear of its border and fill.
class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ExcludeSemantics(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Palette.muted,
          ),
        ),
      ),
      const SizedBox(height: 6),
      Semantics(label: label, child: child),
    ],
  );
}
