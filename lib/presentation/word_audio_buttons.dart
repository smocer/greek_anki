import 'package:flutter/material.dart';

import '../data/dictionary_audio.dart';
import '../domain/vocabulary.dart';
import 'app_strings.dart';
import 'pronunciation_button.dart';

class WordAudioButtons extends StatelessWidget {
  const WordAudioButtons({super.key, required this.card, this.color});
  final VocabularyCard card;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final clips = dictionaryAudioFor(card);
    if (clips.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        children: [
          for (final clip in clips)
            PronunciationButton(
              key: ValueKey(clip.asset),
              asset: clip.asset,
              label: clip.text,
              color: color,
              buttonText: clips.length == 1
                  ? context.strings.playAudio
                  : '${context.strings.playAudio} · ${clip.text}',
            ),
        ],
      ),
    );
  }
}
