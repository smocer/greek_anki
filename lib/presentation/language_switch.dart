import 'package:flutter/material.dart';

import '../domain/app_language.dart';
import 'app_strings.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key, required this.onChanged});
  final Future<void> Function(AppLanguage) onChanged;

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  bool _saving = false;

  Future<void> _select(Set<AppLanguage> selected) async {
    if (_saving || selected.single == context.strings.language) return;
    setState(() => _saving = true);
    try {
      await widget.onChanged(selected.single);
    } catch (error, stack) {
      debugPrint('Could not save language: $error\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.strings.languageSaveError)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.strings.languageLabel,
    child: SegmentedButton<AppLanguage>(
      expandedInsets: EdgeInsets.zero,
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(value: AppLanguage.english, label: Text('English')),
        ButtonSegment(value: AppLanguage.russian, label: Text('Русский')),
      ],
      selected: {context.strings.language},
      onSelectionChanged: _saving ? null : _select,
      style: SegmentedButton.styleFrom(
        minimumSize: const Size(0, 44),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
