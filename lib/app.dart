import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/greek_decks.dart';
import 'data/app_updates.dart';
import 'data/language_store.dart';
import 'data/progress_store.dart';
import 'domain/learning_progress.dart';
import 'domain/app_updates.dart';
import 'domain/app_language.dart';
import 'domain/language_store.dart';
import 'domain/progress_store.dart';
import 'presentation/home_screen.dart';
import 'presentation/app_strings.dart';
import 'presentation/theme.dart';

class GreekAnkiApp extends StatefulWidget {
  const GreekAnkiApp({super.key, this.store, this.languageStore});

  final ProgressStore? store;
  final LanguageStore? languageStore;

  @override
  State<GreekAnkiApp> createState() => _GreekAnkiAppState();
}

class _GreekAnkiAppState extends State<GreekAnkiApp> {
  late final LearningProgress _progress;
  late final LanguageStore _languageStore;
  late final AppUpdates? _updates;
  AppLanguage _language = AppLanguage.english;
  late Future<void> _loading;

  @override
  void initState() {
    super.initState();
    _progress = LearningProgress(widget.store ?? PreferencesProgressStore());
    _languageStore = widget.languageStore ?? PreferencesLanguageStore();
    _updates = createAppUpdates();
    _loading = _load();
  }

  Future<void> _load() async {
    final language = await _languageStore.read();
    if (!mounted) return;
    setState(() => _language = language);
    await _progress.load(greekDecks);
  }

  Future<void> _changeLanguage(AppLanguage language) async {
    await _languageStore.write(language);
    if (mounted) setState(() => _language = language);
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Greek Anki',
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    locale: Locale(_language.code),
    supportedLocales: const [Locale('en'), Locale('ru')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: FutureBuilder<void>(
      future: _loading,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off_rounded, size: 40),
                    const SizedBox(height: 20),
                    Text(
                      context.strings.loadError,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () => setState(() {
                        _loading = _load();
                      }),
                      child: Text(context.strings.tryAgain),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return HomeScreen(
          decks: greekDecks,
          progress: _progress,
          onLanguageChanged: _changeLanguage,
          updates: _updates,
        );
      },
    ),
  );
}
