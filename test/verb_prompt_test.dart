import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/learning_progress.dart';
import 'package:greek_anki/domain/vocabulary.dart';
import 'package:greek_anki/presentation/app_strings.dart';
import 'package:greek_anki/presentation/card_explanation.dart';
import 'package:greek_anki/presentation/study_screen.dart';
import 'package:greek_anki/presentation/theme.dart';

import 'support/memory_progress_store.dart';

void main() {
  for (final language in AppLanguage.values) {
    testWidgets(
      'λέγομαι is hidden until the hard-mode answer is revealed (${language.code})',
      (tester) async {
        tester.view.physicalSize = const Size(430, 960);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final deck = currentDictionary.learningDecks.singleWhere(
          (deck) => deck.id == 'words-verbs',
        );
        final card = deck.cards.singleWhere((card) => card.greek == 'λέγομαι');
        final progress = LearningProgress(MemoryProgressStore());
        addTearDown(progress.dispose);

        await tester.pumpWidget(
          MaterialApp(
            theme: appTheme,
            locale: Locale(language.code),
            supportedLocales: [
              for (final language in AppLanguage.values) Locale(language.code),
            ],
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            home: StudyScreen(
              deck: deck,
              cards: [card],
              mode: StudyMode.typing,
              progress: progress,
            ),
          ),
        );
        await tester.pumpAndSettle();

        final answerText = find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data ?? widget.textSpan?.toPlainText() ?? '')
                  .toLowerCase()
                  .contains('λέγομαι'),
        );
        expect(find.text(card.prompt.resolve(language)), findsOneWidget);
        expect(answerText, findsNothing);
        expect(find.byType(CardExplanation), findsNothing);

        final reveal = find.text(AppStrings(language).dontKnow);
        await tester.ensureVisible(reveal);
        await tester.tap(reveal);
        await tester.pumpAndSettle();

        expect(find.text('λέγομαι'), findsOneWidget);
        expect(find.byType(CardExplanation), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
