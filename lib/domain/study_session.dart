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
    bool shuffle = true,
    this._answerMatcher = const GreekAnswer(),
  }) : _queue = shuffle ? (List.of(cards)..shuffle(random)) : List.of(cards),
       total = cards.length {
    if (cards.isEmpty) {
      throw ArgumentError('A session needs at least one card.');
    }
    if (cards.map(_cardKey).toSet().length != cards.length) {
      throw ArgumentError('Card IDs must be unique within a session.');
    }
  }

  final StudyMode mode;
  final int total;
  final List<VocabularyCard> _queue;
  final GreekAnswer _answerMatcher;
  final Set<String> _seen = {};
  final List<VocabularyCard> _history = [];
  int? _historyIndex;
  String _cardKey(VocabularyCard card) =>
      card.reviewIdentity?.key(mode) ?? card.id;
  int _completed = 0;
  int _firstTryCorrect = 0;
  int _repetitions = 0;
  CardPhase _phase = CardPhase.question;
  bool? _typedCorrect;

  VocabularyCard get current =>
      _historyIndex == null ? _queue.first : _history[_historyIndex!];
  String get currentKey => _cardKey(current);
  bool get isComplete => _queue.isEmpty && !isReviewing;
  bool get isReviewing => _historyIndex != null;
  bool get canGoPrevious =>
      mode == StudyMode.flashcards && (_historyIndex ?? _history.length) > 0;
  int get completed => _completed;
  int get firstTryCorrect => _firstTryCorrect;
  int get repetitions => _repetitions;
  double get progress => _completed / total;
  CardPhase get phase => isReviewing ? CardPhase.answer : _phase;
  bool? get typedCorrect => _typedCorrect;

  void previous() {
    if (!canGoPrevious) return;
    _historyIndex = (_historyIndex ?? _history.length) - 1;
    notifyListeners();
  }

  void next() {
    if (!isReviewing) return;
    final nextIndex = _historyIndex! + 1;
    _historyIndex = nextIndex < _history.length ? nextIndex : null;
    notifyListeners();
  }

  void reveal() {
    if (isComplete || isReviewing || mode != StudyMode.flashcards) return;
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
    if (isComplete || isReviewing || _phase != CardPhase.answer) return;
    final card = _queue.removeAt(0);
    if (mode == StudyMode.flashcards) _history.add(card);
    if (_seen.add(_cardKey(card)) && correct) _firstTryCorrect++;
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
