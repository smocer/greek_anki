# Word frequency ordering

“Most frequent first” orders the eligible cards before the session limit is
applied. Random and newest-added ordering remain available. Review scheduling,
saved mastery and the balanced within-session repeats are unchanged.

## Source

Greek word-form counts from **OPUS OpenSubtitles v2024**, retrieved 24 November
2026. The OPUS API marked v2024 as the latest OpenSubtitles release on that date.

- [OPUS release and attribution](https://opus.nlpl.eu/legacy/OpenSubtitles-v2024.php)
- [OpenSubtitles](https://www.opensubtitles.org/)
- [Greek frequency file](https://object.pouta.csc.fi/OPUS-OpenSubtitles/v2024/freq/el.freq.gz)
- P. Lison and J. Tiedemann (2016), *OpenSubtitles2016: Extracting Large Parallel Corpora from Movie and TV Subtitles*, LREC 2016.
- J. Tiedemann (2012), *Parallel Data, Tools and Interfaces in OPUS*, LREC 2012.

Only aggregate counts for spellings needed by this app are bundled, not subtitle
sentences. The generated file records the source SHA-256. Reproduce or update it:

```sh
curl -fL https://object.pouta.csc.fi/OPUS-OpenSubtitles/v2024/freq/el.freq.gz -o /tmp/el.freq.gz
python3 tool/generate_greek_frequency.py /tmp/el.freq.gz
dart format lib/domain/greek_frequency_data.dart
```

Run this generator when adding Greek spellings. The catalog coverage test checks
that every target spelling is covered, including explicit zero counts.

## Interpretation and limits

Counts are case-insensitive but stress-sensitive, combining equivalent Unicode
spellings and final sigma. They measure observed word forms, not summed lemmas
or meanings. For equivalent forms on one card, the highest count is used. For
multiword targets the rarest component determines the estimate, so an article
cannot make a rare noun appear common. This is a compound approximation, not
an observed phrase frequency. Unknown forms sort last; ties retain input order.

Movie/TV dialogue has genre, translation and name biases. Frequency helps
prioritize familiar everyday vocabulary, but does not predict a particular exam.
No claims are made that these counts represent 2026 conversations.
