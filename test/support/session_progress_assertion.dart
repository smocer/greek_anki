import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Verify saved mastery in the progress details without crowding the card UI.
Future<void> expectRemembered(WidgetTester tester, String text) async {
  await tester.tap(find.byIcon(Icons.info_outline_rounded));
  await tester.pumpAndSettle();
  expect(find.text(text), findsOneWidget);
  await tester.tap(
    find
        .descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextButton),
        )
        .last,
  );
  await tester.pumpAndSettle();
}
