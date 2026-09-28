/// Platform adapter for checking the published app without changing a session.
abstract interface class AppUpdates {
  Future<bool> isAvailable();
  void reload();
}
