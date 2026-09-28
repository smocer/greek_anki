import 'dart:js_interop';

import '../domain/app_updates.dart';

@JS('greekAnki.checkForUpdate')
external JSPromise<JSBoolean> _checkForUpdate();

@JS('greekAnki.reload')
external void _reload();

AppUpdates createAppUpdates() => _BrowserUpdates();

class _BrowserUpdates implements AppUpdates {
  @override
  Future<bool> isAvailable() async => (await _checkForUpdate().toDart).toDart;

  @override
  void reload() => _reload();
}
