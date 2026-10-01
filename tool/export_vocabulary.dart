import 'dart:convert';
import 'dart:io';
import 'package:greek_anki/data/greek_decks.dart';
import 'package:greek_anki/data/decks/verb_topics.dart';
import 'package:greek_anki/data/decks/be_present.dart';
import 'package:greek_anki/data/decks/called_present.dart';
import 'package:greek_anki/data/decks/sing_present.dart';

void main(List<String> args) {
  if (args.contains('--hints')) {
    stdout.writeln(
      jsonEncode({
        for (final deck in [
          ...everydayVerbSources,
          bePresentDeck,
          calledPresentDeck,
          singPresentDeck,
        ])
          for (final card in deck.cards.take(6))
            card.greek.toLowerCase(): {
              'labels': ['verb'],
              'lemma': deck.cards.first.greek.toLowerCase(),
            },
      }),
    );
    return;
  }
  stdout.writeln(
    jsonEncode([
      for (final deck in authoredGreekDecks)
        for (final card in deck.cards)
          {
            'deck': deck.id,
            'id': card.id,
            'source': card.reviewIdentity?.deckId ?? deck.id,
            'sourceId': card.reviewIdentity?.cardId ?? card.id,
            'greek': card.greek,
            'en': card.prompt.en,
            'labels': card.labels.map((label) => label.name).toList(),
          },
    ]),
  );
}
