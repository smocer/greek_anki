import 'package:greek_anki/data/study_session_store.dart';
import 'package:greek_anki/domain/study_session.dart';
import 'package:greek_anki/domain/study_session_store.dart';

class MemoryStudySessionStore implements StudySessionStore {
  final records = <String, String>{};
  bool shouldFail = false;

  @override
  Future<StudySessionSnapshot?> read(String key) async {
    if (shouldFail) throw StateError('Storage unavailable');
    final value = records[key];
    return value == null ? null : decodeStudySession(value);
  }

  @override
  Future<void> write(String key, StudySessionSnapshot snapshot) async {
    if (shouldFail) throw StateError('Storage unavailable');
    records[key] = encodeStudySession(snapshot);
  }

  @override
  Future<void> remove(String key) async {
    if (shouldFail) throw StateError('Storage unavailable');
    records.remove(key);
  }
}
