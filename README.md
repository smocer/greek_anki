# Greek Anki

**Open the app: [smocer.github.io/greek_anki](https://smocer.github.io/greek_anki/)**

Works in a browser on iPhone, iPad, Android, and desktop. No account needed. Use Safari or Chrome directly (rather than an in-app messaging browser). Add it to the home screen for a convenient shortcut.

A small offline Flutter app for learning modern Greek, with **477 cards across 52 focused beginner topics**, based on the September 22 and September 28 classroom notes and lesson pages. Cream, forest green, and one card at a time.

## Practice

- **English / Русский:** switch the learning language from the main menu. Interface text, meanings, and pronunciation guides change together. The choice is saved across restarts; learning progress is shared across languages.

- **Flashcards:** recall the Greek word, phrase, or grammatical form, reveal the answer and pronunciation, then choose **Again** or **Got it**.
- **Hard mode:** type the Greek answer using the built-in Greek keyboard or your phone keyboard. The built-in keyboard includes direct keys for stressed vowels: ά, έ, ή, ί, ό, ύ, ώ. Stress marks are required in the correct positions; missing, misplaced, or extra stress is incorrect. Capitalization and sentence punctuation are optional. Articles, word boundaries, and grammatical endings are checked. Greek letters are required; Latin transliterations are rejected. Standard alternatives for 7, 8, and 9 are accepted. For 7, **εφτά** (ef-TA / эф-ТА) is the default and **επτά** is the alternative.
- Missed cards return after two other cards when possible. A session ends when every selected card has been recalled correctly.
- Each mode has its own saved progress. Due and new cards are reviewed first; when none are due, the mode starts a full practice session.
- Successful due reviews are spaced by 1, 3, 7, 14, then 30 days. Forgetting a card resets it. Practicing early does not artificially extend its schedule.
- Search topics by title or vocabulary in either teaching language or Greek (Greek stress marks are optional in search).
- Browse a deck to see all words, approximate pronunciations, variants, and bilingual grammar explanations.
- Explanations appear after reveal/check, linking Greek to Russian where appropriate: ты/Вы, cases, gender, possession, and familiar roots. Differences are explained explicitly.
- All six persons of 22 verbs are practiced, including είμαι, μένω, έχω, θέλω, διαβάζω, μαθαίνω, σπουδάζω, and καταλαβαίνω. Each new verb has its own short drill and sentence examples.
- Numbers include 0–20, every ten through 100, and compound examples through 101. Other topics cover origin, residence, addresses, phone conversations, greetings, neighbours, pets, diminutives, and noun cases.
- See [the curriculum and notebook review](docs/curriculum.md) for topic boundaries, additions, and grammar references.
- See [the September 28 lesson review](docs/lessons_2026_09_28.md) for the nine new pages, their coverage, and grammar distinctions.

This is an independent Anki-style learning app, with a simple review schedule. It does not import Anki packages or sync with AnkiWeb. No account or subscription is needed. The website needs internet to open or update; the native Android app also works offline. Progress is stored locally in the current browser or native app and is lost if its data is cleared. It does not sync across browsers/devices or transfer automatically from the APK. Use the same browser or home-screen shortcut each time.

## Publish weekly lessons

The `main` branch is deployed automatically to GitHub Pages. Change the lesson files, then commit and push. GitHub Actions runs the tests, builds Flutter for the web, and publishes the site. Students keep the same link and refresh; nobody needs another APK or an Apple developer account.

```sh
git add lib/data docs
git commit -m "Add this week's Greek lessons"
git push origin main
```

Check the **Actions** tab before announcing a lesson: a failed test/build does not replace the live version. Only files pushed to `main` are published. The repository and website are public; do not add credentials or classmates' personal information.

The main menu checks for updates on return to the app and every two minutes, with a **Refresh app** button when a new release is available. Practice sessions are never refreshed automatically. Existing review records survive normal deployments because card IDs, storage keys, and the site's origin stay stable. New cards start unlearned. Roll back by reverting the relevant commit and pushing again.

### Run the website locally

```sh
flutter pub get
flutter run -d chrome
```

To test the same versioned static output used by GitHub Pages:

```sh
python3 tool/build_web.py --base-href /
python3 -m http.server 8080 --directory build/site
# Open http://localhost:8080
```

The normal Pages build uses `--base-href /greek_anki/`. Upload **build/site/**, not the source or build/web directory, if hosting it elsewhere. Use HTTPS outside localhost and keep the URL stable to retain browser progress.

### Web delivery design

`web/app_loader.js` fetches a small, uncached release pointer on every page opening. `tool/build_web.py` places the Flutter app, fonts, and renderer together under `app/<content-hash>/`, so an old browser cache cannot mix code from different releases. The page URL stays stable. There is no custom service worker or guaranteed offline web launch. Runtime lesson editing, student accounts, analytics, a database, and cross-device syncing are not needed for this setup.

The existing storage Adapter maps to browser local storage through `shared_preferences`. The optional `AppUpdates` adapter uses a small JavaScript bridge only on web; native builds keep their existing offline behavior. The home-route update notice observes lifecycle changes, and reloads only after a tap.

## Run and install

Developed and tested with Flutter 3.44.2 / Dart 3.12.2.

```sh
flutter pub get
flutter run
flutter analyze
flutter test
flutter build apk --release
adb -s DEVICE_SERIAL install -r build/app/outputs/flutter-apk/app-release.apk
adb -s DEVICE_SERIAL shell am start -n dev.egor.greek_anki/.MainActivity
```

The release APK is universal (ARM 32-bit, ARM 64-bit, and x86-64) and requires Android 7.0 or newer. The Android launcher name is **Greek Anki**, package `dev.egor.greek_anki`. The release APK uses the local development signing key for personal device installation. Configure a dedicated signing key before store distribution. Android is built and tested; the generated iOS project is included but has not been built or validated.

## Add more vocabulary

Each topic is a typed, declarative `VocabularyDeck` in `lib/data/decks/`. Edit its cards there, or create a new file and register its deck in `lib/data/greek_decks.dart`. The topic picker discovers registered decks automatically. Content is compiled into the app, with no runtime editor or generated inflection rules.

```dart
VocabularyCard(
  id: 'greeting-hello',
  prompt: LocalizedText(en: 'hello', ru: 'привет'),
  meaning: LocalizedText(en: 'a greeting', ru: 'приветствие'),
  greek: 'γεια',
  pronunciation: LocalizedText(en: 'ya', ru: 'я'),
  explanation: LocalizedText(
    en: 'An informal greeting.',
    ru: 'Неформальное приветствие; сравните «привет».',
  ),
)
```

Use `LocalizedText(en: ..., ru: ...)` for prompts, meanings, pronunciation guides, and deck descriptions; use `LocalizedText.shared(...)` for identical content such as digits. Both translations are required, so new words cannot silently lack Russian support.

Keep deck and card IDs stable and unique. IDs are used for saved progress, so changing displayed text or reordering cards preserves progress. `alternatives` contains visible accepted Greek variants; `acceptedAnswers` holds longer valid phrasings, such as an optional subject pronoun, without crowding the card. Neither field relaxes matching globally; include the correct stress marks in every accepted form. Comparison preserves stress and recognizes canonically equivalent Unicode encodings; do not add unaccented versions to bypass the grading rule. The pronunciation is a reading aid, with capitals marking stress.

## Structure

- `lib/data/greek_decks.dart`: topic registry; `lib/data/decks/`: individual bilingual content files, separate from behavior and UI.
- `lib/domain/`: card/deck models, answer normalization, scheduling, session queue, and learning progress.
- `lib/domain/progress_store.dart`: small storage interface.
- `lib/data/progress_store.dart`: adapter to Flutter's `SharedPreferencesAsync` local storage.
- `lib/domain/app_language.dart`: supported languages and typed bilingual learning content.
- `lib/data/language_store.dart`: saved language preference, independent of review records.
- `lib/presentation/app_strings.dart`: interface translations, driven by Flutter’s `Localizations` observer.
- `lib/presentation/`: home, study, vocabulary browser, Greek keyboard, and shared visual theme.

`StudySession` and `LearningProgress` use Flutter's native Observer mechanism (`ChangeNotifier`). `ListenableBuilder` observes changes; no extra state-management framework is needed. The storage adapter is injected into the app, which allows deterministic tests without touching device data. Answers advance only after their progress write succeeds; storage errors leave the current card available for retry.

Tests cover notebook vocabulary coverage, all topic sessions, bilingual content integrity, phrase punctuation, grammatical-case rejection, compatibility with original number review records, topic search/selection, explanation visibility, long phrases with enlarged Russian text, every number, accent and capitalization handling, alternate spellings, rejection of Latin lookalikes, retry ordering, review intervals, independent persistent progress, save failures, complete sessions, Greek keyboard editing, scrolling at large text sizes, Russian layouts, language persistence and save failures, and unchanged progress when switching languages.

Storage API reference: [shared_preferences](https://pub.dev/packages/shared_preferences).
