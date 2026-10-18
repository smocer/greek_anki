// Run: flutter test tool/export_dictionary_audio.dart
// Export the same merged, consolidated word catalog that the app loads.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';
import 'dictionary_audio_manifest.dart';

void main() {
  test('export dictionary word audio manifest', () {
    final dictionary =
        GreekDictionary.merge(File(dictionaryAsset).readAsStringSync(), {
          for (final file in Directory(
            dictionaryAdditionsDirectory,
          ).listSync().whereType<File>())
            if (file.path.endsWith('.json')) file.path: file.readAsStringSync(),
        });
    final clips = dictionaryAudioManifest(dictionary);
    File('tool/greek_dictionary_audio.json').writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(clips)}\n',
    );
    stdout.writeln(
      'Exported ${clips.length} dictionary word and variant clips.',
    );
  });
}
