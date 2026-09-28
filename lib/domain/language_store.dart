import 'app_language.dart';

abstract interface class LanguageStore {
  Future<AppLanguage> read();
  Future<void> write(AppLanguage language);
}
