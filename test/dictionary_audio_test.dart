import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greek_anki/data/dictionary.dart';

import '../tool/dictionary_audio_manifest.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'audio manifest covers the current dictionary and all distinct word forms',
    () {
      final manifest = jsonDecode(
        File('tool/greek_dictionary_audio.json').readAsStringSync(),
      );
      expect(manifest, dictionaryAudioManifest(currentDictionary));
    },
  );

  test(
    'every dictionary audio clip is nonempty MP3 and bundled by Flutter',
    () async {
      final manifest = dictionaryAudioManifest(currentDictionary);
      final assets = await AssetManifest.loadFromAssetBundle(rootBundle);
      final bundled = assets.listAssets().toSet();
      for (final key in manifest.keys) {
        final path = 'assets/audio/greek/$key.mp3';
        expect(bundled, contains(path), reason: path);
        final bytes = File(path).readAsBytesSync();
        expect(bytes.length, greaterThan(1000), reason: path);
        final id3 = bytes[0] == 0x49 && bytes[1] == 0x44 && bytes[2] == 0x33;
        final mpeg = bytes[0] == 0xff && bytes[1] & 0xe0 == 0xe0;
        expect(id3 || mpeg, isTrue, reason: '$path has no MP3 header');
      }
    },
  );
}
