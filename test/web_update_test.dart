import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/domain/app_updates.dart';
import 'package:greek_anki/presentation/web_update_notice.dart';

class _Updates implements AppUpdates {
  bool available = false;
  bool fail = false;
  int reloads = 0;

  @override
  Future<bool> isAvailable() async {
    if (fail) throw StateError('offline');
    return available;
  }

  @override
  void reload() => reloads++;
}

void main() {
  testWidgets('poll failure retries; only an explicit tap reloads the app', (
    tester,
  ) async {
    final updates = _Updates()..fail = true;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: WebUpdateNotice(updates: updates)),
      ),
    );
    await tester.pump();
    expect(find.text('Refresh app'), findsNothing);
    updates
      ..fail = false
      ..available = true;
    await tester.pump(const Duration(minutes: 2));
    await tester.pump();
    expect(find.text('An update is ready'), findsOneWidget);
    expect(updates.reloads, 0);
    await tester.tap(find.text('Refresh app'));
    expect(updates.reloads, 1);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('an update stays behind a practice route until returning home', (
    tester,
  ) async {
    final updates = _Updates();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Column(
              children: [
                WebUpdateNotice(updates: updates),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          const Scaffold(body: Text('Practice in progress')),
                    ),
                  ),
                  child: const Text('Practice'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Practice'));
    await tester.pumpAndSettle();
    updates.available = true;
    await tester.pump(const Duration(minutes: 2));
    await tester.pump();
    expect(find.text('Refresh app'), findsNothing);
    expect(find.text('Practice in progress'), findsOneWidget);
    expect(updates.reloads, 0);
    tester.state<NavigatorState>(find.byType(Navigator)).pop();
    await tester.pumpAndSettle();
    expect(find.text('Refresh app'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'a late network reply after disposal does not update the widget',
    (tester) async {
      final result = Completer<bool>();
      await tester.pumpWidget(
        MaterialApp(home: WebUpdateNotice(updates: _PendingUpdates(result))),
      );
      await tester.pumpWidget(const SizedBox());
      result.complete(true);
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}

class _PendingUpdates implements AppUpdates {
  _PendingUpdates(this.result);
  final Completer<bool> result;
  @override
  Future<bool> isAvailable() => result.future;
  @override
  void reload() {}
}
