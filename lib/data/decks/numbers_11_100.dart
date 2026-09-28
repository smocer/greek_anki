import '../../domain/app_language.dart';
import '../../domain/vocabulary.dart';
import '../deck_composition.dart';
import 'numbers_11_20.dart';
import 'numbers_tens.dart';

final numbers11To100Deck = VocabularyDeck(
  id: 'numbers-11-100',
  title: const LocalizedText(
    en: '11–20 & tens to 100',
    ru: '11–20 и десятки до 100',
  ),
  subtitle: const LocalizedText(
    en: 'Teens, twenty, and the tens',
    ru: 'От одиннадцати до двадцати, затем десятки',
  ),
  note: const LocalizedText(
    en: 'Learn 11 and 12 separately; 13–19 build on ten. Learn the tens through 100, then add a separate word for the units. Use εκατό alone and εκατόν before another number.',
    ru: '11 и 12 запоминаем отдельно; в 13–19 узнаются десять и единицы. Затем учим десятки до 100. Как «сорок три», десятки и единицы пишутся отдельно. Само по себе 100 — εκατό, перед следующим числом — εκατόν.',
  ),
  cover: '11–100',
  cards: List.unmodifiable([
    ...cardsFrom(numbers1120Deck),
    ...cardsFrom(numbersTensDeck),
  ]),
);
