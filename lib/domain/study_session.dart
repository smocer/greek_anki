import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'greek_answer.dart';
import 'greek_text.dart';
import 'recall_attempt.dart';
import 'review_schedule.dart';
import 'review_selection.dart';
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
    this.style = SessionStyle.learning,
    this.sessionId,
    this.turn = 0,
    this.reviewPicks = 0,
    this.evidence = const {},
    this.deferred = const [],
    this.answeredAt,
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
  final SessionStyle style;
  final String? sessionId;
  final int turn, reviewPicks;
  final Map<String, PracticeEvidence> evidence;
  final List<String> deferred;
  final DateTime? answeredAt;
}

class StudySession extends ChangeNotifier {
  StudySession({
    required List<VocabularyCard> cards,
    required this.mode,
    Random? random,
    bool shuffle = true,
    this.style = SessionStyle.learning,
    ReviewSchedule? Function(VocabularyCard)? scheduleFor,
    DateTime Function()? now,
    this._answerMatcher = const GreekAnswer(),
  }) : _random = random ?? Random(),
       _scheduleFor = scheduleFor ?? ((_) => null),
       _now = now ?? DateTime.now,
       _cards = List.unmodifiable(cards),
       total = cards.length {
    if (cards.isEmpty) {
      throw ArgumentError('A session needs at least one card.');
    }
    if (cards.map(_cardKey).toSet().length != cards.length) {
      throw ArgumentError('Card IDs must be unique within a session.');
    }
    final pending = List.of(cards);
    _sessionId =
        '${_now().microsecondsSinceEpoch}-${_random.nextInt(0x100000000)}';
    if (shuffle) pending.shuffle(_random);
    _pending.addAll(pending);
    _fillWindow();
  }

  factory StudySession.restore({
    required List<VocabularyCard> cards,
    required StudySessionSnapshot snapshot,
    Random? random,
    ReviewSchedule? Function(VocabularyCard)? scheduleFor,
    DateTime Function()? now,
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
    final deferred = snapshot.deferred.toSet();
    require(pending.intersection(window).isEmpty);
    require(pending.intersection(learned).isEmpty);
    require(keys.containsAll(snapshot.evidence.keys));
    require(
      keys.containsAll(deferred) && deferred.length == snapshot.deferred.length,
    );
    require(deferred.intersection({...pending, ...window, ...learned}).isEmpty);
    require(
      {
            ...pending,
            ...window,
            ...learned,
            ...deferred,
            ...snapshot.evidence.entries
                .where((e) => e.value.confirmations > 0)
                .map((e) => e.key),
          }.length ==
          keys.length,
    );
    require(snapshot.seen.toSet().containsAll(learned));
    require(window.difference(learned).length <= _learningWindowSize);
    require(window.length <= _windowSize);
    require(
      learned
                      .where(
                        (key) =>
                            (snapshot.evidence[key]?.confirmations ?? 0) == 0,
                      )
                      .length +
                  deferred.length ==
              keys.length
          ? pending.isEmpty && window.isEmpty
          : window.isNotEmpty,
    );
    require(snapshot.turn >= 0 && snapshot.reviewPicks >= 0);
    require(
      snapshot.evidence.values.every(
        (e) => e.lastTurn == null || e.lastTurn! < snapshot.turn,
      ),
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
      style: snapshot.style,
      scheduleFor: scheduleFor,
      now: now,
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
    session._sessionId = snapshot.sessionId ?? session._sessionId;
    session._turn = snapshot.turn;
    session._reviewPicks = snapshot.reviewPicks;
    session._evidence.addAll(snapshot.evidence);
    session._deferred.addAll(snapshot.deferred);
    session._answeredAt = snapshot.answeredAt;
    return session;
  }

  final StudyMode mode;
  final SessionStyle style;
  final ReviewSchedule? Function(VocabularyCard) _scheduleFor;
  final DateTime Function() _now;
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
  late String _sessionId;
  int _turn = 0, _reviewPicks = 0;
  final Map<String, PracticeEvidence> _evidence = {};
  final Set<String> _deferred = {};
  DateTime? _answeredAt;
  int get _minimumGap =>
      min(ReviewSelection.cooldown, max(0, total - _deferred.length - 1));

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
    style: style,
    sessionId: _sessionId,
    turn: _turn,
    reviewPicks: _reviewPicks,
    evidence: Map.unmodifiable(_evidence),
    deferred: List.unmodifiable(_deferred),
    answeredAt: _answeredAt,
  );

  VocabularyCard get current =>
      _historyIndex == null ? _window.first : _history[_historyIndex!];
  String get currentKey => _cardKey(current);
  bool get isReview =>
      !isComplete && !isReviewing && _learned.containsKey(currentKey);
  bool get isComplete => isFinished && !isReviewing;
  bool get isFinished => completed + deferredCount == total;
  bool get isReviewing => _historyIndex != null;
  bool get canGoPrevious =>
      mode == StudyMode.flashcards && (_historyIndex ?? _history.length) > 0;
  int get completed => _learned.keys
      .where((key) => (_evidence[key]?.confirmations ?? 0) == 0)
      .length;
  int get deferredCount => _deferred.length;
  int get checkedCount => _seen.length;
  int get uncheckedCount => total - checkedCount;
  int get confirmationsRemaining => _evidence.entries
      .where((entry) => !_deferred.contains(entry.key))
      .fold(0, (count, entry) => count + entry.value.confirmations);

  /// Cards needed before any outstanding word is eligible for a spaced check.
  /// Includes the current spacing card; this is not a session finish estimate.
  int get spacingCardsRemaining {
    final waits = _evidence.entries
        .where(
          (entry) =>
              !_deferred.contains(entry.key) && entry.value.confirmations > 0,
        )
        .map((entry) => _confirmationWait(entry.value));
    return waits.isEmpty ? 0 : waits.reduce(min);
  }

  int _confirmationWait(PracticeEvidence evidence) =>
      max(0, _minimumGap - (_turn - evidence.lastTurn! - 1));

  bool get isSpacingReview =>
      !isReviewing && !isComplete && uncheckedCount == 0 && !isConfirmation;
  int get awaitingConfirmation => _evidence.entries
      .where((e) => !_deferred.contains(e.key) && e.value.confirmations > 0)
      .length;
  bool get isConfirmation =>
      !isComplete &&
      !isReviewing &&
      (_evidence[currentKey]?.confirmations ?? 0) > 0;
  int get currentConfirmationsRemaining =>
      isConfirmation ? _evidence[currentKey]!.confirmations : 0;
  bool get canDefer =>
      !isComplete &&
      !isReviewing &&
      phase == CardPhase.question &&
      (_evidence[currentKey]?.failures ?? 0) >= 3 &&
      (_evidence[currentKey]?.confirmations ?? 0) > 0;
  int get firstTryCorrect => _firstTryCorrect;
  int get repetitions => _repetitions;
  double get progress => (completed + deferredCount) / total;
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
    _answeredAt = _now().toUtc();
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
    _answeredAt = _now().toUtc();
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
    _answeredAt = _now().toUtc();
    notifyListeners();
  }

  void advance({required bool correct, RecallAttempt? attempt}) {
    if (isComplete || isReviewing || _phase != CardPhase.answer) return;
    attempt ??= attemptFor(correct: correct);
    final previous = _evidence[currentKey] ?? PracticeEvidence();
    _evidence[currentKey] = previous.after(
      attempt,
      _turn,
      historicallyWeak: (_scheduleFor(current)?.weakness ?? 0) >= 0.15,
    );
    _turn++;
    final card = _window.removeAt(0);
    if (mode == StudyMode.flashcards) _history.add(card);
    final key = _cardKey(card);
    if (_seen.add(key) && correct) _firstTryCorrect++;
    if (correct) {
      _learned[key] = card;
    } else {
      _repetitions++;
      _learned.remove(key);
      if (style == SessionStyle.reviewAll) {
        // Retry candidates live in evidence, separate from the unseen queue.
      } else if (_learningCount < _learningWindowSize) {
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
    _answeredAt = null;
    notifyListeners();
  }

  RecallAttempt attemptFor({required bool correct}) {
    final last = _evidence[currentKey]?.lastTurn;
    final at = _answeredAt ?? _now().toUtc();
    final previousAt = _scheduleFor(current)?.lastAttemptAt;
    var outcome = correct ? RecallOutcome.correct : RecallOutcome.incorrect;
    if (!correct && mode == StudyMode.typing) {
      if (_submittedAnswer.isEmpty) {
        outcome = RecallOutcome.skipped;
      } else if ([
        current.greek,
        ...current.alternatives,
        ...current.acceptedAnswers,
      ].any(
        (a) => GreekText.searchKey(a) == GreekText.searchKey(_submittedAnswer),
      )) {
        outcome = RecallOutcome.accentError;
      }
    }
    return RecallAttempt(
      id: '$_sessionId:$_turn',
      at: at,
      outcome: outcome,
      independent:
          (previousAt != null &&
              at.difference(previousAt) >= const Duration(minutes: 10)) ||
          (last == null ? previousAt == null : _turn - last - 1 >= _minimumGap),
    );
  }

  void deferCurrent() {
    if (!canDefer) return;
    final key = currentKey;
    _deferred.add(key);
    _learned.remove(key);
    _window.removeAt(0);
    _fillWindow();
    notifyListeners();
  }

  int get _learningCount =>
      _window.where((card) => !_learned.containsKey(_cardKey(card))).length;

  void _fillWindow() {
    if (isFinished) {
      _window.clear();
      return;
    }
    if (style == SessionStyle.reviewAll || uncheckedCount == 0) {
      // Once every word has been seen, schedule confirmations from the whole
      // batch. A four-card rotating window cannot satisfy an eight-card gap.
      if (style == SessionStyle.learning) {
        _window.clear();
        _pending.clear(); // Seen failures are now scheduled through evidence.
      }
      _fillReviewAll();
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
    final candidates = _learned.entries
        .where((entry) => !windowKeys.contains(entry.key))
        .map((entry) => entry.value)
        .toList();
    final missingReviews = _windowSize - _window.length;
    for (var slot = 0; slot < missingReviews && candidates.isNotEmpty; slot++) {
      final card = _selectReview(candidates, turn: _turn + _window.length);
      candidates.remove(card);
      _window.add(card);
    }
  }

  VocabularyCard _selectReview(
    List<VocabularyCard> cards, {
    required int turn,
  }) {
    final candidates = cards.map((card) {
      final key = _cardKey(card);
      final evidence = _evidence[key];
      final schedule = _scheduleFor(card);
      return ReviewCandidate(
        key: key,
        weakness:
            max(
              schedule?.weakness ?? 0,
              recallWeakness(evidence?.recent ?? []),
            ) +
            (schedule == null
                ? 0
                : (1 - schedule.recallProbability(_now())) * 0.3),
        lastTurn: evidence?.lastTurn,
        presentations: evidence?.presentations ?? 0,
        lastReviewAt: schedule?.lastAttemptAt,
        confirmations: evidence?.confirmations ?? 0,
      );
    }).toList();
    final key = const ReviewSelection().choose(
      candidates,
      turn: turn,
      pick: _reviewPicks++,
      random: _random,
      minimumGap: _minimumGap,
    );
    return cards.firstWhere((c) => _cardKey(c) == key);
  }

  void _fillReviewAll() {
    if (_window.isNotEmpty) return;
    final retries = _cards.where((card) {
      final key = _cardKey(card);
      return !_deferred.contains(key) &&
          (_evidence[key]?.confirmations ?? 0) > 0;
    }).toList();
    final ready = retries
        .where((card) => _confirmationWait(_evidence[_cardKey(card)]!) == 0)
        .toList();
    if (ready.isNotEmpty && (_pending.isEmpty || _turn % 4 == 3)) {
      _window.add(_selectReview(ready, turn: _turn));
    } else if (_pending.isNotEmpty) {
      _window.add(_pending.removeFirst());
    } else {
      // Space the final difficult words with already checked words. These
      // fillers remain in the selected batch and can expose a new lapse.
      final available = _cards
          .where((c) => !_deferred.contains(_cardKey(c)))
          .toList();
      _window.add(_selectReview(available, turn: _turn));
    }
  }
}
