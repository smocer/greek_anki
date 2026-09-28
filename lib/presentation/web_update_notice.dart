import 'dart:async';

import 'package:flutter/material.dart';

import '../domain/app_updates.dart';
import 'app_strings.dart';
import 'theme.dart';

/// Kept on the home route, so updates never interrupt a practice session.
class WebUpdateNotice extends StatefulWidget {
  const WebUpdateNotice({super.key, required this.updates});
  final AppUpdates updates;

  @override
  State<WebUpdateNotice> createState() => _WebUpdateNoticeState();
}

class _WebUpdateNoticeState extends State<WebUpdateNotice>
    with WidgetsBindingObserver {
  late final Timer _timer;
  bool _available = false;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _timer = Timer.periodic(const Duration(minutes: 2), (_) => _check());
    _check();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _check();
  }

  Future<void> _check() async {
    if (_checking || _available) return;
    _checking = true;
    try {
      final available = await widget.updates.isAvailable();
      if (mounted) setState(() => _available = available);
    } catch (error) {
      // Connectivity is optional after launch. Retry on resume or the next poll;
      // an update-check failure must not block studying already-loaded cards.
      debugPrint('Update check failed; will retry: $error');
    } finally {
      _checking = false;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_available) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Palette.softGreen,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.strings.updateAvailable,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(context.strings.updateNote),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: widget.updates.reload,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(context.strings.updateAction),
            ),
          ],
        ),
      ),
    );
  }
}
