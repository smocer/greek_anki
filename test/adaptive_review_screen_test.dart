import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/app.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/data/study_session_store.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/review_selection.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_language_store.dart';
import 'support/memory_progress_store.dart';
import 'support/memory_study_session_store.dart';

void main() {
  void phone(WidgetTester tester) {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  for (final language in AppLanguage.values) {
    final strings = AppStrings(language);
    testWidgets(
      'Review all is reachable and includes the whole filter (${language.code})',
      (tester) async {
        phone(tester);
        final sessions = MemoryStudySessionStore();
        await tester.pumpWidget(
          GreekAnkiApp(
            sessionStore: sessions,
            store: MemoryProgressStore(),
            languageStore: MemoryLanguageStore(language: language),
          ),
        );
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.byKey(const ValueKey('style-reviewAll')),
          150,
          scrollable: find.byType(Scrollable).first,
        );
        await tap(tester, find.byKey(const ValueKey('style-reviewAll')));
        await tester.scrollUntilVisible(
          find.text(strings.hardMode),
          150,
          scrollable: find.byType(Scrollable).first,
        );
        await tap(tester, find.text(strings.hardMode));
        final checkpoint = decodeStudySession(sessions.records.values.single);
        expect(checkpoint.style, SessionStyle.reviewAll);
        expect(
          checkpoint.cards.length,
          currentDictionary.learningDecks
              .singleWhere((d) => d.id == 'words-nouns')
              .cards
              .length,
        );
        final button = find.byKey(const ValueKey('check-typing'));
        expect(tester.getRect(button).bottom, lessThanOrEqualTo(700));
        expect(tester.takeException(), isNull);
        await tap(tester, find.byIcon(Icons.close_rounded));
        await tap(tester, find.text(strings.hardMode));
        expect(
          decodeStudySession(sessions.records.values.single).sessionId,
          checkpoint.sessionId,
        );
      },
    );

    testWidgets(
      'repeated failures can be deferred without a false mastery claim (${language.code})',
      (tester) async {
        phone(tester);
        final deck = currentDictionary.learningDecks.singleWhere(
          (d) => d.id == 'words-verbs',
        );
        final reviews = MemoryProgressStore();
        await tester.pumpWidget(
          MaterialApp(
            theme: appTheme,
            locale: Locale(language.code),
            supportedLocales: const [Locale('en'), Locale('ru'), Locale('zh')],
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            home: StudyScreen(
              deck: deck,
              cards: [deck.cards.first],
              mode: StudyMode.typing,
              style: SessionStyle.reviewAll,
              progress: LearningProgress(reviews),
              sessionStore: MemoryStudySessionStore(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        for (var n = 0; n < 3; n++) {
          await tap(tester, find.text(strings.dontKnow));
          await tap(tester, find.text(strings.continueLabel));
        }
        // One confirmation must not allow deferral to leave a future due date.
        await tap(tester, find.byTooltip(strings.phoneKeyboard));
        await tester.enterText(find.byType(TextField), deck.cards.first.greek);
        await tester.pump();
        await tap(tester, find.byKey(const ValueKey('check-typing')));
        await tap(tester, find.text(strings.continueLabel));
        expect(reviews.records.values.single.level, greaterThan(0));
        expect(find.byKey(const ValueKey('defer-card')), findsOneWidget);
        expect(
          tester.getRect(find.byKey(const ValueKey('check-typing'))).bottom,
          lessThanOrEqualTo(700),
        );
        await tap(tester, find.byKey(const ValueKey('defer-card')));
        expect(find.text(strings.sessionComplete), findsOneWidget);
        expect(find.text(strings.deferredCount(1)), findsOneWidget);
        expect(find.text(strings.wordsRemembered(0)), findsOneWidget);
        expect(find.text('Μπράβο!'), findsNothing);
        expect(reviews.records.values.single.level, 0);
        expect(reviews.records.values.single.isDue(DateTime.now()), isTrue);
        expect(reviews.records.values.single.attempts, hasLength(4));
        expect(tester.takeException(), isNull);
      },
    );
  }
}
