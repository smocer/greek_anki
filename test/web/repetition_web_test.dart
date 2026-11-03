import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/progress_store.dart';
import 'package:greek_anki/data/study_session_store.dart';
import 'package:greek_anki/domain/app_language.dart';
import 'package:greek_anki/domain/review_schedule.dart';
import 'package:greek_anki/domain/review_selection.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/vocabulary.dart';

import '../fsrs_progress_test.dart' as scheduling;

void main() {
  scheduling.main();

  for (final style in SessionStyle.values) {
    test('web session IDs, recovery and FSRS work together ($style)', () {
      final cards = [
        for (var i = 0; i < 12; i++)
          VocabularyCard(
            id: 'word-$i',
            prompt: const LocalizedText(en: 'I want', ru: 'Хочу'),
            meaning: const LocalizedText(en: 'I want', ru: 'Хочу'),
            greek: 'θέλω',
            pronunciation: const LocalizedText(en: 'THE-lo', ru: 'ТЭ-ло'),
          ),
      ];
      final records = <String, ReviewSchedule>{};
      var session = StudySession(
        cards: cards,
        mode: StudyMode.typing,
        style: style,
        shuffle: false,
        scheduleFor: (card) => records[card.id],
      );
      for (var turn = 0; !session.isComplete && turn < 200; turn++) {
        final card = session.current;
        final correct = turn != 0;
        session.checkAnswer(correct ? card.greek : 'λάθος');
        final attempt = session.attemptFor(correct: correct);
        records[card.id] = decodeReviewSchedule(
          encodeReviewSchedule(
            ReviewSchedule.afterAttempt(
              previous: records[card.id],
              attempt: attempt,
            ),
          ),
        );
        session.advance(correct: correct, attempt: attempt);
        if (turn == 4) {
          final saved = decodeStudySession(
            encodeStudySession(session.snapshot),
          );
          session.dispose();
          session = StudySession.restore(
            cards: cards,
            snapshot: saved,
            scheduleFor: (card) => records[card.id],
          );
        }
      }
      expect(session.isComplete, isTrue);
      expect(session.completed, cards.length);
      expect(records, hasLength(cards.length));
      expect(records.values.every((record) => record.memory != null), isTrue);
      session.dispose();
    });
  }
}
