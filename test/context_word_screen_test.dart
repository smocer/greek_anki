import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';
import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  for (final language in AppLanguage.values) {
    for (final mode in StudyMode.values) {
      testWidgets(
        'context is visible before answering; explanation waits ($language, $mode)',
        (tester) async {
          tester.view.physicalSize = const Size(320, 640);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final deck = currentDictionary.learningDecks.singleWhere(
            (d) => d.id == 'words-prepositions',
          );
          final card = deck.cards.singleWhere((c) => c.greek == 'με');
          final progress = LearningProgress(MemoryProgressStore());
          addTearDown(progress.dispose);
          await tester.pumpWidget(
            MaterialApp(
              theme: appTheme,
              locale: Locale(language.code),
              supportedLocales: const [
                Locale('en'),
                Locale('ru'),
                Locale('zh'),
              ],
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              home: StudyScreen(
                deck: deck,
                cards: [card],
                mode: mode,
                progress: progress,
                sessionStore: MemoryStudySessionStore(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(
            find.text(card.contextExample!.resolve(language)),
            findsOneWidget,
          );
          expect(find.text(card.explanation!.resolve(language)), findsNothing);
          final action = mode == StudyMode.typing
              ? find.byKey(const ValueKey('check-typing'))
              : find.text(AppStrings(language).revealAnswer);
          expect(tester.getRect(action).bottom, lessThanOrEqualTo(640));
          if (mode == StudyMode.flashcards) {
            await tester.tap(action);
            await tester.pumpAndSettle();
            expect(
              find.text(card.explanation!.resolve(language)),
              findsOneWidget,
            );
          }
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
