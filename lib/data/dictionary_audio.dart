import '../domain/curriculum.dart';
import '../domain/greek_text.dart';
import '../domain/vocabulary.dart';
import 'dictionary.dart';

class DictionaryAudioClip {
  const DictionaryAudioClip({required this.key, required this.text});
  final String key;
  final String text;
  String get asset => 'audio/greek/$key.mp3';
}

/// Shared by export and playback. Resolve moved cards using their word
/// collection, rather than their historical review identity or UI deck.
class DictionaryAudioCatalog {
  DictionaryAudioCatalog(GreekDictionary dictionary) {
    for (final collection in dictionary.collections) {
      if (collection.section != LearningSection.words) continue;
      for (final card in collection.deck.cards) {
        final forms = <String, String>{};
        for (final text in [
          card.greek,
          for (final form in card.forms) form.greek,
          ...card.alternatives,
        ]) {
          final trimmed = text.trim();
          if (trimmed.isNotEmpty) {
            forms.putIfAbsent(GreekText.answerKey(trimmed), () => trimmed);
          }
        }
        final clips = <DictionaryAudioClip>[];
        var index = 0;
        for (final text in forms.values) {
          final suffix = index == 0 ? '' : '-variant-$index';
          final key = '${collection.deck.id}/${card.id}$suffix';
          if (!RegExp(r'^words-[a-z-]+/[a-zA-Z0-9._-]+$').hasMatch(key) ||
              _manifest.containsKey(key)) {
            throw StateError('Unsafe or duplicate dictionary audio path: $key');
          }
          _manifest[key] = text;
          clips.add(DictionaryAudioClip(key: key, text: text));
          index++;
        }
        _byCard.putIfAbsent(_cardKey(card), () => List.unmodifiable(clips));
      }
    }
  }

  final _manifest = <String, String>{};
  final _byCard = <String, List<DictionaryAudioClip>>{};
  static String _cardKey(VocabularyCard card) =>
      '${card.id}\u0000${GreekText.answerKey(card.greek)}';

  List<DictionaryAudioClip> clipsFor(VocabularyCard card) =>
      _byCard[_cardKey(card)] ?? const [];

  Map<String, String> get manifest => Map.fromEntries(
    _manifest.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
  );
}

Map<String, String> dictionaryAudioManifest(GreekDictionary dictionary) =>
    DictionaryAudioCatalog(dictionary).manifest;

GreekDictionary? _source;
DictionaryAudioCatalog? _catalog;

List<DictionaryAudioClip> dictionaryAudioFor(VocabularyCard card) {
  final dictionary = currentDictionary;
  if (!identical(_source, dictionary)) {
    _catalog = DictionaryAudioCatalog(dictionary);
    _source = dictionary;
  }
  return _catalog!.clipsFor(card);
}
