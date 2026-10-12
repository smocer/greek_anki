import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:greek_anki/data/dictionary.dart';

class _FileDictionaryBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin') {
      return const StandardMessageCodec().encodeMessage({
        dictionaryAsset: [],
        for (final file in Directory(
          dictionaryAdditionsDirectory,
        ).listSync().whereType<File>())
          file.path.replaceAll('\\', '/'): [],
      })!;
    }
    final bytes = await File(key).readAsBytes();
    return ByteData.sublistView(bytes);
  }
}

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadGreekDictionary(bundle: _FileDictionaryBundle());
  await testMain();
}
