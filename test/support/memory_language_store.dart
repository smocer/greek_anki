import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/language_store.dart';

class MemoryLanguageStore implements LanguageStore {
  MemoryLanguageStore({this.language = AppLanguage.english});
  AppLanguage language;
  bool shouldFail = false;

  @override
  Future<AppLanguage> read() async => language;

  @override
  Future<void> write(AppLanguage value) async {
    if (shouldFail) throw StateError('Disk unavailable');
    language = value;
  }
}
