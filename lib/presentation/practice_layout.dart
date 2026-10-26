import 'package:flutter/material.dart';

import 'theme.dart';

/// Scroll long prompts and feedback without moving the primary action.
class PracticeBody extends StatelessWidget {
  const PracticeBody({super.key, required this.contentBuilder});

  final Widget Function(BuildContext, BoxConstraints) contentBuilder;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    bottom: false,
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: contentBuilder(context, constraints),
          ),
        ),
      ),
    ),
  );
}

/// Use in Scaffold.bottomNavigationBar so snackbars appear above the controls.
class PracticeActions extends StatelessWidget {
  const PracticeActions({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: SafeArea(
      top: false,
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Palette.line)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(width: double.infinity, child: child),
            ),
          ),
        ),
      ),
    ),
  );
}
