# Standalone grammar drills

Below the clock, number and date drills, the home screen offers noun plurals,
adjective plurals, and quantity agreement (πόσος / πόση / πόσο). These drills run
indefinitely, use typed answers, and never read or write learning progress.
Check an answer, read the correction, then choose Next. Back returns home.

## Shopping filters

The bakery, kiosk (περίπτερο), street-market and supermarket themes follow the
shopping groups in the textbook. They overlap where a product belongs in more
than one shop. Tags reuse existing vocabulary IDs and preserve review history.
The quantity drill draws only from products in these themes; shop names and
bare units of measurement are not quantity questions.

## Plurals

The full current noun and adjective collections supply the pools, independently
of home-screen filters. `lib/data/grammar_drill_data.dart` contains explicit,
reviewed forms linked to vocabulary IDs. Do not derive plural spelling or stress
from a suffix at runtime. Irregular forms, compounds and accepted spelling
variants need individual review.

Answers require the nominative plural and its article, including every accent.
Case, harmless whitespace and punctuation are normalized, but articles and
stress are not optional. Adjectives keep the prompted gender. Nouns may have an
irregular gender-changing plural, such as ο χρόνος → τα χρόνια.

Most prompts contain one word with its article. For λάθος and όλος, a short noun
phrase makes the intended adjective use unambiguous: ο λάθος αριθμός → οι λάθος
αριθμοί; όλος ο μήνας → όλοι οι μήνες. Enter the whole plural phrase.

Words already plural, or without an ordinary plural in their taught meaning,
have explicit exclusions. For example, σκι meaning skiing is excluded: τα σκι
refers to equipment. This avoids inventing plurals or silently changing senses.

Each next question excludes the preceding gender + singular-ending pattern.
Masculine -ης and -ής share a pattern. Masculine -ος can follow masculine -ας;
a different gender can also follow the same ending. Selection samples eligible
questions directly, so it cannot get stuck in a retry loop.

## Quantity agreement

Both constructions occur:

- `___ χυμοί υπάρχουν στο σπίτι;` → πόσοι (nominative subject).
- `___ χυμούς θέλεις;` → πόσους (accusative object).
- `___ καφές υπάρχει στο σπίτι;` → πόσος.
- `___ καφέ θέλεις;` → πόσο / πόσον.

Singular subjects use υπάρχει; plural subjects use υπάρχουν. Feminine πόση /
πόσες and neuter πόσο / πόσα have the same forms in both cases. Questions show
singular or plural explicitly, also resolving invariant words such as τοστ.
Only the missing quantity word is entered; no sentence parser is needed.

The next question must require a different canonical answer, across both cases.
πόσο and optional masculine accusative πόσον share a key. There are seven keys:
πόσος, πόσοι, πόσο, πόση, πόσους, πόσες, πόσα.

## Authoring and validation

When adding or consolidating nouns/adjectives, update the reviewed morphology
metadata or give a defensible exclusion. Include all grouped gender forms.
Shopping product entries need an explicit masculine nominative as well as the
accusative, and an appropriate count/mass number. Do not use household-unit
questions without a named product (for example, bare “how many kilograms”).

`grammar_drill_test.dart` checks coverage of every current vocabulary card,
strict articles/stress, answer reachability, both cases, agreement and consecutive
pattern exclusion. `grammar_drill_screen_test.dart` checks all three drills and
locales at 320×568, 390×700 and 568×320, at 1× and 2× text, including wrong/correct
answers, next, device-keyboard insets and back without saving progress. It checks
text truncation as well as overflow, with actions pinned outside scrolling content.

## Language references

- [Greek Ministry of Education: nouns](https://ebooks.edu.gr/ebooks/v/html/8547/2334/Grammatiki-Neas-Ellinikis-Glossas_A-B-G-Gymnasiou_html-apli/index_C_02.html): paradigms, invariant nouns and number restrictions.
- [Greek Ministry of Education: adjectives](https://ebooks.edu.gr/ebooks/v/html/8547/2334/Grammatiki-Neas-Ellinikis-Glossas_A-B-G-Gymnasiou_html-apli/index_C_03.html): agreement, irregular and invariant adjectives.
- [Ministry beginner workbook](https://www.gsvetlly.minedu.gov.gr/publications/docs2023/3_EGXIRIDIO__TETRADIO_ASKISEON.pdf): quantity agreement.
- [CGL: αέρας](https://www.greek-language.gr/greekLang/modern_greek/tools/lexica/search.html?lq=αέρας): ordinary plural αέρηδες.
- [Learner dictionary](https://core.ac.uk/download/pdf/49279978.pdf): αλκοόλ has no ordinary plural.
- [CGL: πρωί](https://www.greek-language.gr/greekLang/modern_greek/tools/lexica/triantafyllides/search.html?lq=πρωί): plural πρωινά.
- [Beginner Greek dictionary](https://museduc.gr/docs/gymnasio/Dictionary.pdf): noun λάθος versus invariant adjective λάθος.
- [Ministry: Ταξίδι στη γλώσσα](https://gsvetlly.minedu.gov.gr/publications/docs2023/Ταξίδι_στη_γλώσσα.pdf): όλος + article + noun.
- [CGL: φρέσκος](https://www.greek-language.gr/greekLang/modern_greek/tools/lexica/triantafyllides/search.html?lq=φρέσκος): feminine variants in -η / -ια.
