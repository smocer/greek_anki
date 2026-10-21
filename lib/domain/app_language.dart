enum AppLanguage {
  english('en'),
  russian('ru'),
  chinese('zh');

  const AppLanguage(this.code);
  final String code;

  static AppLanguage fromCode(String? code) => switch (code) {
    'ru' => russian,
    'zh' || 'zh-CN' || 'zh-TW' => chinese,
    _ => english,
  };
}

class LocalizedText {
  const LocalizedText({required this.en, required this.ru, this.zh});
  const LocalizedText.shared(String text) : en = text, ru = text, zh = text;

  final String en;
  final String ru;
  final String? zh;

  String resolve(AppLanguage language) => switch (language) {
    AppLanguage.english => en,
    AppLanguage.russian => ru,
    AppLanguage.chinese => zh ?? en,
  };
}
