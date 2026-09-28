import 'package:shared_preferences/shared_preferences.dart';

import '../domain/app_language.dart';
import '../domain/language_store.dart';

class PreferencesLanguageStore implements LanguageStore {
  PreferencesLanguageStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;
  static const _key = 'settings.v1.language';

  @override
  Future<AppLanguage> read() async =>
      AppLanguage.fromCode(await _preferences.getString(_key));

  @override
  Future<void> write(AppLanguage language) =>
      _preferences.setString(_key, language.code);
}
