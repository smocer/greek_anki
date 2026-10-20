import 'dart:collection';
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
  }) : _random = random ?? Random(),
       total = cards.length {
    if (cards.isEmpty) {
      throw ArgumentError('A session needs at least one card.');
    }
    if (cards.map(_cardKey).toSet().length != cards.length) {
      throw ArgumentError('Card IDs must be unique within a session.');
    }
    final pending = List.of(cards);
    if (shuffle) pending.shuffle(_random);
    _pending.addAll(pending);
    _fillWindow();
  }

  final StudyMode mode;
  final int total;
  static const _windowSize = 4;
  static const _learningWindowSize = _windowSize - 1;
  final Random _random;
  final Queue<VocabularyCard> _pending = Queue();
  final List<VocabularyCard> _window = [];
  final Map<String, VocabularyCard> _learned = {};
  final GreekAnswer _answerMatcher;
  final Set<String> _seen = {};
  final List<VocabularyCard> _history = [];
  int? _historyIndex;
  String _cardKey(VocabularyCard card) =>
      card.reviewIdentity?.key(mode) ?? card.id;
  int _firstTryCorrect = 0;
  int _repetitions = 0;
  CardPhase _phase = CardPhase.question;
  bool? _typedCorrect;

  VocabularyCard get current =>
      _historyIndex == null ? _window.first : _history[_historyIndex!];
  String get currentKey => _cardKey(current);
  bool get isReview =>
      !isComplete && !isReviewing && _learned.containsKey(currentKey);
  bool get isComplete => completed == total && !isReviewing;
  bool get isReviewing => _historyIndex != null;
  bool get canGoPrevious =>
      mode == StudyMode.flashcards && (_historyIndex ?? _history.length) > 0;
  int get completed => _learned.length;
  int get firstTryCorrect => _firstTryCorrect;
  int get repetitions => _repetitions;
  double get progress => completed / total;
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
    final card = _window.removeAt(0);
    if (mode == StudyMode.flashcards) _history.add(card);
    final key = _cardKey(card);
    if (_seen.add(key) && correct) _firstTryCorrect++;
    if (correct) {
      _learned[key] = card;
    } else {
      _repetitions++;
      _learned.remove(key);
      if (_learningCount < _learningWindowSize) {
        _window.add(card);
      } else {
        // A forgotten review takes the next learning slot, without adding
        // a fourth learning word to the current window.
        _pending.addFirst(card);
      }
    }
    _fillWindow();
    _phase = CardPhase.question;
    _typedCorrect = null;
    notifyListeners();
  }

  int get _learningCount =>
      _window.where((card) => !_learned.containsKey(_cardKey(card))).length;

  void _fillWindow() {
    if (isComplete) {
      _window.clear();
      return;
    }

    var learningCount = _learningCount;
    while (learningCount < _learningWindowSize && _pending.isNotEmpty) {
      _window.add(_pending.removeFirst());
      learningCount++;
    }

    // Fill the remaining slots with reviews: 3 + 1, 2 + 2, or 1 + 3.
    // Before the first success or in tiny batches, fewer words are available.
    final windowKeys = _window.map(_cardKey).toSet();
    final candidates =
        _learned.entries
            .where((entry) => !windowKeys.contains(entry.key))
            .map((entry) => entry.value)
            .toList()
          ..shuffle(_random);
    final missingReviews = _windowSize - _window.length;
    _window.addAll(candidates.take(max(0, missingReviews)));
  }
}
