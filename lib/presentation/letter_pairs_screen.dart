import 'package:flutter/material.dart';

import '../data/greek_letter_pairs.dart';
import 'app_strings.dart';
import 'pronunciation_button.dart';
import 'theme.dart';

class LetterPairsScreen extends StatelessWidget {
  const LetterPairsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.strings.letterPairs)),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              context.strings.letterPairsIntro,
              style: const TextStyle(color: Palette.muted),
            ),
            const SizedBox(height: 16),
            for (final pair in greekLetterPairs) ...[
              Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            pair.letters,
                            style: const TextStyle(fontSize: 36),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Text(
                              '/${pair.ipa}/',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(context.localize(pair.rule)),
                      const SizedBox(height: 12),
                      for (final example in pair.examples)
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${example.word} · /${example.ipa}/',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    context.localize(example.meaning),
                                    style: const TextStyle(
                                      color: Palette.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PronunciationButton(
                              asset: example.audioAsset,
                              label: example.word,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    ),
  );
}
