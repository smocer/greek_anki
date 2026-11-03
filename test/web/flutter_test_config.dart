import 'dart:async';

// These portable tests use fixtures instead of the VM-only file asset loader.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await testMain();
}
