# Migration fixtures

These are the frozen pre-JSON vocabulary sources. The app never imports them.
They remain here for migration parity tests and the historical NLP tools.
Do not edit them to update the live dictionary. Edit
`assets/dictionary/greek.json` instead.

`tool/migrate_dictionary.dart` is a one-time exporter, not an update command:
running it again overwrites the JSON with the original migration snapshot.
