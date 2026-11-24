# Flashcard UI requirements

When changing flashcard or writing-practice UI, verify layout before finishing:

- Keep the current prompt, answer input and primary actions usable on narrow phones. Keep routine progress compact; put the full breakdown behind a clearly labelled control.
- Never clip text, allow horizontal overflow, or use a fixed-height card that overflows when text wraps. Long explanations and unusually long prompts must scroll safely; do not shrink them to unreadable text.
- Keep primary actions visible above safe areas and the device keyboard. Do not hide required actions below the on-screen Greek keyboard.
- Run widget layout tests in English, Russian and Chinese, covering question, revealed answer, wrong answer, repeated-review/spacing, deferral and completion states. Include 320×568 and 390×700 portrait, 568×320 landscape, large text (at least 2×), and device-keyboard insets.
- Check a representative browser layout visually as well as testing it. Verify no Flutter overflow exceptions and no clipped/unreachable controls. Report the exact configurations tested.
- If a requested design cannot fit these constraints, report the limitation and explain the safe scrolling or alternative layout used. Never claim it fits every possible viewport without evidence.

# Content and review safety

- Use blank-sentence context for short functional words (pronouns, prepositions, particles, conjunctions) when it clarifies their use. Add it to nouns, verbs or adjectives only for a documented ambiguity; ordinary items such as πιάτο do not need a blank.
- Prefer basic vocabulary forms over productive diminutives. Do not strip -άκι mechanically: lexicalized words and proper names can have a different meaning from their apparent base.
- Preserve review identities or aliases when consolidating cards.
- Explain Greek-specific grammar in each learner language. Verify etymologies and cultural claims using authoritative sources; do not invent memory stories and present them as history.

# Git safety

Create branches with `--no-track`. Before each push, verify branch, remote,
upstream and explicit destination. Only push to a remote branch with the same
name; never push a working branch directly to a protected/default branch or
bypass a push guard. Publish new branches with
`git push --set-upstream origin HEAD:refs/heads/<local-branch-name>`.
