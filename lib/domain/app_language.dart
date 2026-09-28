enum AppLanguage {
  english('en'),
  russian('ru');

  const AppLanguage(this.code);
  final String code;

  static AppLanguage fromCode(String? code) => code == 'ru' ? russian : english;
}

class LocalizedText {
  const LocalizedText({required this.en, required this.ru});
  const LocalizedText.shared(String text) : en = text, ru = text;

  final String en;
  final String ru;

  String resolve(AppLanguage language) => switch (language) {
    AppLanguage.english => en,
    AppLanguage.russian => ru,
  };
}
