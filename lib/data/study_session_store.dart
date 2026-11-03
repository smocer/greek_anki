import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/study_session.dart';
import '../domain/study_session_store.dart';
import '../domain/vocabulary.dart';
import '../domain/review_selection.dart';

class PreferencesStudySessionStore implements StudySessionStore {
  PreferencesStudySessionStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<StudySessionSnapshot?> read(String key) async {
    final saved = await _preferences.getString('session.v1.$key');
    return saved == null ? null : decodeStudySession(saved);
  }

  @override
  Future<void> write(String key, StudySessionSnapshot snapshot) =>
      _preferences.setString('session.v1.$key', encodeStudySession(snapshot));

  @override
  Future<void> remove(String key) => _preferences.remove('session.v1.$key');
}

String encodeStudySession(StudySessionSnapshot snapshot) => jsonEncode({
  'mode': snapshot.mode.name,
  'cards': snapshot.cards,
  'pending': snapshot.pending,
  'window': snapshot.window,
  'learned': snapshot.learned,
  'seen': snapshot.seen,
  'history': snapshot.history,
  'historyIndex': snapshot.historyIndex,
  'firstTryCorrect': snapshot.firstTryCorrect,
  'repetitions': snapshot.repetitions,
  'phase': snapshot.phase.name,
  'typedCorrect': snapshot.typedCorrect,
  'submittedAnswer': snapshot.submittedAnswer,
  'style': snapshot.style.name,
  'sessionId': snapshot.sessionId,
  'turn': snapshot.turn,
  'reviewPicks': snapshot.reviewPicks,
  'evidence': snapshot.evidence.map(
    (key, value) => MapEntry(key, value.toMap()),
  ),
  'deferred': snapshot.deferred,
  'answeredAt': snapshot.answeredAt?.toUtc().toIso8601String(),
});

StudySessionSnapshot decodeStudySession(String saved) {
  final data = jsonDecode(saved) as Map<String, dynamic>;
  return StudySessionSnapshot(
    mode: StudyMode.values.byName(data['mode'] as String),
    cards: List<String>.from(data['cards'] as List),
    pending: List<String>.from(data['pending'] as List),
    window: List<String>.from(data['window'] as List),
    learned: List<String>.from(data['learned'] as List),
    seen: List<String>.from(data['seen'] as List),
    history: List<String>.from(data['history'] as List),
    historyIndex: data['historyIndex'] as int?,
    firstTryCorrect: data['firstTryCorrect'] as int,
    repetitions: data['repetitions'] as int,
    phase: CardPhase.values.byName(data['phase'] as String),
    typedCorrect: data['typedCorrect'] as bool?,
    submittedAnswer: data['submittedAnswer'] as String,
    style: SessionStyle.values.byName(data['style'] as String? ?? 'learning'),
    sessionId: data['sessionId'] as String?,
    turn: data['turn'] as int? ?? 0,
    reviewPicks: data['reviewPicks'] as int? ?? 0,
    evidence: (data['evidence'] as Map<String, dynamic>? ?? {}).map(
      (key, value) => MapEntry(
        key,
        PracticeEvidence.fromMap(value as Map<String, dynamic>),
      ),
    ),
    deferred: List<String>.from(data['deferred'] as List? ?? []),
    answeredAt: data['answeredAt'] == null
        ? null
        : DateTime.parse(data['answeredAt'] as String).toUtc(),
  );
}
