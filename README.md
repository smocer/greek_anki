# Greek Anki

**[Open Greek Anki](https://smocer.github.io/greek_anki/)**

Pushes to `main` publish the production website. Pull requests run checks and
build the app without deploying.

Learn modern Greek with English and Russian explanations. Works in a browser on iPhone, iPad, Android and desktop, without an account or subscription. Add the link to your home screen for a convenient shortcut.

## Choose what to learn

- **Words:** nouns, verbs, pronouns, adjectives/adverbs, connecting words/prepositions and numbers. Names & places is a separate group for personal names, places, languages and nationalities. Practise individual meanings and spellings. Nouns use their base form; their article is optional in your answer and visible when you reveal it. Verbs use the first-person present.
- **Phrases:** social conversations, classroom language and everyday situations, including phone conversations.
- **Grammar:** articles/gender, noun forms/cases, verb forms, location/origin, possession and questions/negation. Practise using familiar vocabulary in different grammatical roles.
- **Reference:** the alphabet, handwriting, sounds and grammar tables.

Choose **Filters** to narrow a group by theme, addition week or an English, Russian or Greek search. Weekly additions join the existing groups. Search accepts Greek without accents. **Browse / Все слова** shows answers, pronunciation guides and explanations without quizzing you.

## Practice

**Flashcards:** recall the Greek answer, reveal it, then choose **Again** or **Got it**.

**Previous** lets you review earlier flashcards and their audio. Use **Next** to
return to your current card; viewing history does not change scores or review
schedules. You can also revisit the last card from the completion screen.

**Hard mode:** type using the built-in Greek keyboard or your device keyboard. Grammar prompts are entirely in English or Russian: translate the complete phrase. Greek answers and explanations appear only after checking. There are no Greek sentence hints or fill-in-the-blank prompts.

Correct stress is required. Missing, misplaced or extra accents are incorrect. Capitalization and sentence punctuation are optional. Articles are optional for noun vocabulary; grammatical endings and articles remain part of phrase and grammar answers. Standard listed alternatives such as **εφτά / επτά**, **οκτώ / οχτώ** and **εννέα / εννιά** are accepted. The default for 7 is **εφτά**.

**Clock drill:** read a random analog clock and type the time in Greek. Times use five-minute steps on a 12-hour face. Check your answer, see the correct wording, then choose **Next clock** for another time. Spoken forms with **και**, **παρά**, **τέταρτο** and **μισή**, as well as numeric minute wording, are accepted; **είναι** is optional. Accents and feminine hour forms still matter. This drill runs indefinitely, keeps no progress or scores, and exits with the back button.

Choose **Learn & repeat** for unfamiliar material, or **Review all** to check every card in the current filtered group. Both work with Flashcards and Hard mode, and keep separate saved sessions. Choose random order (default), Greek alphabetical order, or newest additions first.

**Learn & repeat:** choose a count (default **15**) from due/new cards, or **All** to include every selected card. The moving window contains three learning cards plus reviews: **3 + 1**, **2 + 2**, or **1 + 3**. Reviews favour recent mistakes, with one coverage pick in every five selections. Weights are capped and decrease with repeated appearances. Optional reviews normally wait for eight intervening answers; if all candidates are cooling down, the oldest available card fills the slot. Tiny batches use the available words.

**Review all:** each easy word is checked once. Difficult words return between other cards, including at the end of the batch. This mode always includes every card in the current filter, even cards not yet due.

After a mistake, a word needs **two successful recalls after a gap**. A quick correction after seeing the answer is useful practice but does not finish the word. The gap is eight other answers, reduced for smaller available pools. Recent difficulty from previous sessions also triggers confirmation. After three failures, **Leave for later** lets you finish the rest; deferred cards stay due and the summary lists them separately from remembered cards.

Back and page reload preserve the selected batch, answers, confirmation steps and review rotation. Another round starts only after finishing the current one. Saved sessions from earlier versions remain usable.

**English / Русский** switches the interface, translations, explanations and pronunciation guides together. Russian explanations compare familiar cases, ты/Вы, grammatical gender and word roots with their Greek counterparts. Pronunciation guides are approximate aids.

## Progress

Flashcards and hard mode have separate review histories. Equivalent exercises retain their progress when regrouped. Learning a standalone word is tracked separately from using it in a grammar exercise. Previous article-required noun exercises do not automatically count as mastery of the new word-only cards; their saved records remain intact.

Long-term reviews use **FSRS-6**, with a 90% target recall rate. Intervals adapt to each card's recall history instead of fixed day levels. Early successful practice is logged without extending the due date; quick corrections do not inflate memory strength. Forgotten cards become due again. Existing due dates are preserved; legacy intervals seed an initial memory estimate because earlier versions did not save attempt history.

Every submitted outcome is saved, including accent-only mistakes. The last five meaningful attempts drive recent difficulty; quick successful corrections do not erase failures, and two spaced successes retire the recent penalty. Accents still matter in Hard mode. Input speed is not used for grading or scheduling.

Progress is saved in the current browser or native app. It survives ordinary updates, but does not sync across devices or browsers. Clearing website or app data removes it. Use the same browser or home-screen shortcut each time.

The website needs internet to open or update. When an update is available, the main menu offers **Refresh app**. Practice sessions are never refreshed automatically. The native Android app also works offline.

- [Learning guide](docs/curriculum.md)
- [Vocabulary filters and weeks](docs/vocabulary_metadata.md)
- [Update the JSON dictionary](docs/dictionary.md)
- [Grammar notes and references](docs/grammar.md)

Greek Anki is an independent Anki-style learning app. It does not import Anki packages or sync with AnkiWeb.
