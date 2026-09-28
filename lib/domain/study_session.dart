import 'dart:math';

import 'package:flutter/foundation.dart';

import 'greek_answer.dart';
import 'vocabulary.dart';

enum CardPhase { question, answer }

class StudySession extends ChangeNotifier {
  StudySession({
    required List<VocabularyCard> cards,
    required this.mode,
    Random? random,
    this._answerMatcher = const GreekAnswer(),
  }) : _queue = List.of(cards)..shuffle(random),
       total = cards.length {
    if (cards.isEmpty) {
      throw ArgumentError('A session needs at least one card.');
    }
    if (cards.map((card) => card.id).toSet().length != cards.length) {
      throw ArgumentError('Card IDs must be unique within a session.');
    }
  }

  final StudyMode mode;
  final int total;
  final List<VocabularyCard> _queue;
  final GreekAnswer _answerMatcher;
  final Set<String> _seen = {};
  int _completed = 0;
  int _firstTryCorrect = 0;
  int _repetitions = 0;
  CardPhase _phase = CardPhase.question;
  bool? _typedCorrect;

  VocabularyCard get current => _queue.first;
  bool get isComplete => _queue.isEmpty;
  int get completed => _completed;
  int get firstTryCorrect => _firstTryCorrect;
  int get repetitions => _repetitions;
  double get progress => _completed / total;
  CardPhase get phase => _phase;
  bool? get typedCorrect => _typedCorrect;

  void reveal() {
    if (isComplete || mode != StudyMode.flashcards) return;
    _phase = CardPhase.answer;
    notifyListeners();
  }

  void checkAnswer(String input) {
    if (isComplete ||
        mode != StudyMode.typing ||
        _phase != CardPhase.question ||
        input.trim().isEmpty) {
      return;
    }
    _typedCorrect = _answerMatcher.matches(input, current);
    _phase = CardPhase.answer;
    notifyListeners();
  }

  void skip() {
    if (isComplete ||
        mode != StudyMode.typing ||
        _phase != CardPhase.question) {
      return;
    }
    _typedCorrect = false;
    _phase = CardPhase.answer;
    notifyListeners();
  }

  void advance({required bool correct}) {
    if (isComplete || _phase != CardPhase.answer) return;
    final card = _queue.removeAt(0);
    if (_seen.add(card.id) && correct) _firstTryCorrect++;
    if (correct) {
      _completed++;
    } else {
      _repetitions++;
      _queue.insert(min(2, _queue.length), card);
    }
    _phase = CardPhase.question;
    _typedCorrect = null;
    notifyListeners();
  }
}
