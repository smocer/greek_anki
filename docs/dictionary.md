# Updating the dictionary

**To add new words, submit a new JSON file in `assets/dictionary/additions/`.**
For example: `assets/dictionary/additions/2026-10-12-food.json`.
There is no need to edit `greek.json`, Dart code, `pubspec.yaml`, or a file manifest.
One file can contain one or more words, phrases, or grammar exercises.

The app discovers all `.json` files in the directory, sorts them by filename,
and adds their entries to the specified learning collections. `greek.json`
remains the base dictionary. Addition files are merged into the in-memory
catalog when it loads, without changing the base file. No Dart generation or
NLP processing is required.

After changes reach `main`, the existing GitHub Actions workflow runs checks,
builds the website, and publishes it. Refreshing the web app loads the updated
dictionary. Native Android apps must be rebuilt and installed to receive the
updated bundled content. There is currently no separate online dictionary download.

## Base dictionary structure

- `schemaVersion`: currently `1`.
- `cards`: word and exercise definitions, each identified by a unique key that
  collections can reference.
- `collections`: the learning groups on the home screen, organized into `words`,
  `phrases`, and `grammar`. Each collection's `deck.cards` lists card keys;
  `themes` assigns themes using card IDs.
- `decks`: the original source topics, retained for compatibility and regression
  checks. The home screen uses `collections`. Adding entries to the home screen
  does not require changes to `decks`.

Some definitions in `cards` are different exercises for the same word, such as
vocabulary practice and a grammar exercise requiring its article. Before editing,
follow the target collection's `deck.cards` references to the correct definition.
Multiple collections can reference one definition to avoid maintaining duplicates.

## Adding a new file

1. Copy [`new-words.example.json`](new-words.example.json) into
   `assets/dictionary/additions/` with a new filename. Place it directly in that
   directory, not in a subdirectory.
2. Update the entries. A complete example file is shown below:

```json
{
  "schemaVersion": 1,
  "addedWeek": "2026-10-12",
  "words": [
    {
      "id": "pear-2026-10",
      "collection": "words-nouns",
      "greek": "αχλάδι",
      "answerDisplay": "το αχλάδι",
      "prompt": {"en": "Pear", "ru": "Груша"},
      "pronunciation": {"en": "a-HLA-dhi", "ru": "а-ХЛА-ди"},
      "labels": ["noun"],
      "themes": ["food"]
    }
  ]
}
```

3. **Submit the new file.** The web publishing workflow validates and publishes
   the merged dictionary.

`collection` identifies an existing learning group, such as `words-nouns`,
`words-names`, `words-verbs`, `words-pronouns`, `words-descriptions`, `words-connectors`,
`words-numbers`, `phrases-social`, `phrases-classroom`, or `phrases-everyday`.
For grammar exercises, use a `grammar-*` collection ID from the base dictionary.
Unknown collection IDs produce an error.

Use `words-nouns` for common nouns and `words-names` for personal names and
geographical names (countries, cities and continents). Keep names used in
phrases or grammar exercises in those exercises' existing collections.

Filenames are unrestricted. Each entry needs a unique `id`; do not reuse an ID
across files. Addition files append entries. Duplicate IDs, conflicting review
keys, or invalid fields fail validation instead of silently replacing existing
content. To change an existing entry, edit the file that defines it.

When a new ID adds another meaning for the same Greek word, the entries are
merged into one word definition. `senses` retains the individual meanings, the
prompt combines them, and labels, themes, and explanations are combined. When a
word belongs to multiple parts of speech, the collections share its definition.
Matching preserves stress: `που` and `πού` are not merged. Phrase and grammar
exercises retain their separate learning purposes.

Merged entries retain the earliest addition date. `aliases` records the old
card IDs, and `reviewAliases` retains the old review keys. An existing primary
review record takes precedence; otherwise, a record is loaded from the old
aliases. Subsequent reviews are saved under the primary key. Use a new, unique
ID when adding a new meaning.

## Field rules

Masculine and feminine forms with the same meaning share a `wordGroup`, such as
`teacher`, and are combined into one card when loaded. Use a gender-neutral
meaning in `prompt`. Each
card's `forms` stores the `greek`, `answerDisplay`, and `pronunciation` for each
form. Either form is accepted, and aliases retain the old card IDs and review
keys. New meanings for an existing form are automatically merged into that card.
To add another gender form, assign the same `wordGroup` to the new entry. Do not
group words with unrelated meanings. This applies only to vocabulary; grammar
exercises still require the gender form specified by the prompt.

Required entry fields in addition files are `id`, `collection`, `prompt`,
`greek`, and `pronunciation`. Set `addedWeek` at the file level for all entries,
or individually on each entry. `meaning` defaults to “Translate into Greek.”
`reviewIdentity` defaults to the entry's `collection` and `id`, so renaming a
file does not affect review history. All localized text includes both `en` and
`ru`, and supports an optional `zh` translation for Chinese. Include `zh` in
new prompts, meanings, and explanations. Older content without `zh` falls back
to English. Pronunciation can reuse the Latin reading guide for Chinese.
Write Greek as normal Unicode text, retaining stress marks.

Optional fields include `explanation`, `answerDisplay`, `alternatives`,
`acceptedAnswers`, `labels`, `addedWeek`, and `words`. `alternatives` contains
spelling variants shown to the learner; `acceptedAnswers` contains additional
accepted full answers. New entries can omit `words`: the home screen's
vocabulary, themes, and collections do not depend on automatic tokenization.

New nouns in `words-nouns` and names in `words-names` automatically accept answers
with or without their specified article. For example, the template's `greek: "αχλάδι"` and
`answerDisplay: "το αχλάδι"` are both accepted without repeating them in
`acceptedAnswers`. For grouped gender forms, each form's `greek` and
`answerDisplay` are accepted separately; the combined display with a slash is
not an answer. This rule applies only to noun vocabulary. Phrases and grammar
exercises still require their specified articles, and stress remains mandatory.

`addedWeek` must be the Monday of the relevant week in `YYYY-MM-DD` format. It is
used by the weekly filters.

Supported `labels`: `noun`, `verb`, `adjective`, `adverb`, `pronoun`, `article`,
`preposition`, `conjunction`, `numeral`, and `interjection`.

Supported themes: `people`, `family`, `classroom`, `home`, `food`, `places`,
`travel`, `phone`, `time`, and `conversation`.

**Keep existing `reviewIdentity.deckId` and `reviewIdentity.cardId` values unchanged.**
These fields form the key for saved review records. If an existing entry moves
to another `collection`, explicitly retain its original `reviewIdentity` to
preserve review history. Card IDs must be unique within a collection.

## Validation and legacy files

Run `flutter analyze` and `flutter test` locally. The tests read the dictionary,
discover and merge addition files, and validate IDs, fields, dates, and themes.
Invalid data blocks web publication. If loading fails in the app, the existing
loading error and retry screen is shown.

The old Dart dictionary lives in `tool/legacy_data/` and is used only by historical
regression tests and migration tools. The app does not read it. Do not edit those
files to update learning content. `tool/migrate_dictionary.dart` is a one-time
export tool and refuses to overwrite an existing dictionary.
