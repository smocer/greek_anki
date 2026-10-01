import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'app_strings.dart';

// One lazy player for the app keeps clips from overlapping. No platform audio
// channel is opened until the user presses a pronunciation button.
class PronunciationPlayback extends ChangeNotifier {
  AudioPlayer? _player;
  String? currentAsset;
  bool loading = false;

  Future<void> play(String asset) async {
    if (loading) return;
    loading = true;
    notifyListeners();
    try {
      if (_player == null) {
        _player = AudioPlayer();
        _player!.onPlayerComplete.listen((_) {
          currentAsset = null;
          notifyListeners();
        });
      }
      currentAsset = asset;
      await _player!.stop();
      if (currentAsset != asset) return;
      await _player!.play(AssetSource(asset));
      if (currentAsset != asset) await _player!.stop();
    } catch (_) {
      currentAsset = null;
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> stop(String asset) async {
    if (currentAsset != asset) return;
    currentAsset = null;
    await _player?.stop();
    notifyListeners();
  }
}

final pronunciationPlayback = PronunciationPlayback();

class PronunciationButton extends StatefulWidget {
  const PronunciationButton({
    super.key,
    required this.asset,
    required this.label,
  });
  final String asset;
  final String label;

  @override
  State<PronunciationButton> createState() => _PronunciationButtonState();
}

class _PronunciationButtonState extends State<PronunciationButton> {
  Future<void> _play() async {
    try {
      if (pronunciationPlayback.currentAsset == widget.asset) {
        await pronunciationPlayback.stop(widget.asset);
      } else {
        await pronunciationPlayback.play(widget.asset);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.strings.audioError)));
      }
    }
  }

  @override
  void dispose() {
    unawaited(pronunciationPlayback.stop(widget.asset).catchError((_) {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: pronunciationPlayback,
    builder: (context, _) {
      final playing = pronunciationPlayback.currentAsset == widget.asset;
      return IconButton(
        tooltip: '${context.strings.listen}: ${widget.label}',
        onPressed: pronunciationPlayback.loading ? null : _play,
        icon: Icon(
          playing ? Icons.stop_circle_outlined : Icons.volume_up_outlined,
        ),
      );
    },
  );
}
