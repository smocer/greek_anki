import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'greek_answer.dart';
import 'vocabulary.dart';

enum CardPhase { question, answer }

// Memento: persist the session's queues and counters without copying vocabulary.
class StudySessionSnapshot {
  StudySessionSnapshot({
    required this.mode,
    required Iterable<String> cards,
    required Iterable<String> pending,
    required Iterable<String> window,
    required Iterable<String> learned,
    required Iterable<String> seen,
    required Iterable<String> history,
    required this.historyIndex,
    required this.firstTryCorrect,
    required this.repetitions,
    required this.phase,
    required this.typedCorrect,
    required this.submittedAnswer,
  }) : cards = List.unmodifiable(cards),
       pending = List.unmodifiable(pending),
       window = List.unmodifiable(window),
       learned = List.unmodifiable(learned),
       seen = List.unmodifiable(seen),
       history = List.unmodifiable(history);

  final StudyMode mode;
  final List<String> cards, pending, window, learned, seen, history;
  final int? historyIndex;
  final int firstTryCorrect, repetitions;
  final CardPhase phase;
  final bool? typedCorrect;
  final String submittedAnswer;
}

class StudySession extends ChangeNotifier {
  StudySession({
    required List<VocabularyCard> cards,
    required this.mode,
    Random? random,
    bool shuffle = true,
    this._answerMatcher = const GreekAnswer(),
  }) : _random = random ?? Random(),
       _cards = List.unmodifiable(cards),
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

  factory StudySession.restore({
    required List<VocabularyCard> cards,
    required StudySessionSnapshot snapshot,
    Random? random,
  }) {
    final available = {
      for (final card in cards)
        card.reviewIdentity?.key(snapshot.mode) ?? card.id: card,
    };
    final keys = snapshot.cards.toSet();
    void require(bool valid) {
      if (!valid) throw const FormatException('Invalid saved study session');
    }

    require(keys.isNotEmpty && keys.length == snapshot.cards.length);
    require(keys.every(available.containsKey));
    for (final group in [
      snapshot.pending,
      snapshot.window,
      snapshot.learned,
      snapshot.seen,
    ]) {
      require(group.toSet().length == group.length && keys.containsAll(group));
    }
    require(keys.containsAll(snapshot.history));
    final pending = snapshot.pending.toSet();
    final window = snapshot.window.toSet();
    final learned = snapshot.learned.toSet();
    require(pending.intersection(window).isEmpty);
    require(pending.intersection(learned).isEmpty);
    require({...pending, ...window, ...learned}.length == keys.length);
    require(snapshot.seen.toSet().containsAll(learned));
    require(window.difference(learned).length <= _learningWindowSize);
    require(window.length <= _windowSize);
    require(
      learned.length == keys.length
          ? pending.isEmpty && window.isEmpty
          : window.isNotEmpty,
    );
    require(
      snapshot.historyIndex == null ||
          (snapshot.historyIndex! >= 0 &&
              snapshot.historyIndex! < snapshot.history.length),
    );
    require(
      snapshot.firstTryCorrect >= 0 &&
          snapshot.firstTryCorrect <= snapshot.seen.length &&
          snapshot.repetitions >= 0,
    );
    require(
      snapshot.mode == StudyMode.typing
          ? snapshot.history.isEmpty &&
                (snapshot.phase == CardPhase.answer) ==
                    (snapshot.typedCorrect != null)
          : snapshot.typedCorrect == null,
    );

    List<VocabularyCard> resolve(List<String> ids) => [
      for (final id in ids) available[id]!,
    ];
    final session = StudySession(
      cards: resolve(snapshot.cards),
      mode: snapshot.mode,
      random: random,
      shuffle: false,
    );
    session._pending
      ..clear()
      ..addAll(resolve(snapshot.pending));
    session._window
      ..clear()
      ..addAll(resolve(snapshot.window));
    session._learned.addAll({
      for (final id in snapshot.learned) id: available[id]!,
    });
    session._seen.addAll(snapshot.seen);
    session._history.addAll(resolve(snapshot.history));
    session._historyIndex = snapshot.historyIndex;
    session._firstTryCorrect = snapshot.firstTryCorrect;
    session._repetitions = snapshot.repetitions;
    session._phase = snapshot.phase;
    session._typedCorrect = snapshot.typedCorrect;
    session._submittedAnswer = snapshot.submittedAnswer;
    return session;
  }

  final StudyMode mode;
  final int total;
  final List<VocabularyCard> _cards;
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
  String _submittedAnswer = '';

  StudySessionSnapshot get snapshot => StudySessionSnapshot(
    mode: mode,
    cards: _cards.map(_cardKey),
    pending: _pending.map(_cardKey),
    window: _window.map(_cardKey),
    learned: _learned.keys,
    seen: _seen,
    history: _history.map(_cardKey),
    historyIndex: _historyIndex,
    firstTryCorrect: _firstTryCorrect,
    repetitions: _repetitions,
    phase: _phase,
    typedCorrect: _typedCorrect,
    submittedAnswer: _submittedAnswer,
  );

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
  String get submittedAnswer => _submittedAnswer;

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
    _submittedAnswer = input;
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
    _submittedAnswer = '';
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
    _submittedAnswer = '';
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
