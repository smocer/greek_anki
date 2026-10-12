import 'dart:convert';

import '../domain/greek_text.dart';

/// Consolidates dictionary words, while keeping phrase/grammar exercises intact.
int consolidateWordData(Map<String, dynamic> root) {
  final cards = root['cards'] as Map<String, dynamic>;
  final collections = root['collections'] as List;
  final groups = <String, Set<String>>{};
  final formGroups = <String, String>{};
  for (final collection in collections) {
    if (collection['section'] != 'words') continue;
    for (final key in List<String>.from(collection['deck']['cards'])) {
      final entry = cards[key];
      if (entry['wordGroup'] == null) continue;
      final group = entry['wordGroup'] as String;
      for (final form in [
        entry['greek'],
        for (final form in entry['forms'] as List? ?? []) form['greek'],
      ]) {
        final normalized = GreekText.answerKey(form as String);
        if (formGroups.containsKey(normalized) &&
            formGroups[normalized] != group) {
          throw FormatException('Conflicting wordGroup for $form');
        }
        formGroups[normalized] = group;
      }
    }
  }
  final protected = <String>{
    for (final deck in root['decks'] as List)
      ...List<String>.from(deck['cards']),
    for (final collection in collections)
      if (collection['section'] != 'words')
        ...List<String>.from(collection['deck']['cards']),
  };
  for (final collection in collections) {
    if (collection['section'] != 'words') continue;
    for (final key in List<String>.from(collection['deck']['cards'])) {
      final word = GreekText.answerKey(cards[key]['greek'] as String);
      final group = cards[key]['wordGroup'] ?? formGroups[word];
      groups
          .putIfAbsent(
            group == null ? 'word:$word' : 'group:$group',
            () => <String>{},
          )
          .add(key);
    }
  }
  var merged = 0;
  for (final keys in groups.values.where((keys) => keys.length > 1)) {
    final first = keys.first;
    final canonical = protected.contains(first) ? 'merged-words/$first' : first;
    final entries = [
      for (final key in keys) cards[key] as Map<String, dynamic>,
    ];
    final result =
        jsonDecode(jsonEncode(entries.first)) as Map<String, dynamic>;
    List<dynamic> union(String field) =>
        {for (final entry in entries) ...entry[field] as List? ?? []}.toList();
    final senses = <String, dynamic>{};
    for (final entry in entries) {
      for (final sense in entry['senses'] as List? ?? [entry['prompt']]) {
        senses[jsonEncode(sense)] = sense;
      }
    }
    result['senses'] = senses.values.toList();
    Map<String, String> joined(Iterable<dynamic> values, String separator) => {
      for (final language in ['en', 'ru'])
        language: {
          for (final value in values) value[language] as String,
        }.join(separator),
    };
    result['prompt'] = joined(senses.values, ' / ');
    final notes = entries
        .where((e) => e['explanation'] != null)
        .map((e) => e['explanation']);
    if (notes.isNotEmpty) result['explanation'] = joined(notes, '\n\n');
    for (final field in ['labels', 'alternatives', 'acceptedAnswers']) {
      result[field] = union(field);
    }
    final wordGroup = entries
        .map((e) => e['wordGroup'])
        .whereType<String>()
        .firstOrNull;
    if (wordGroup != null) {
      result['wordGroup'] = wordGroup;
      final forms = <String, dynamic>{};
      for (final entry in entries) {
        for (final form
            in entry['forms'] as List? ??
                [
                  {
                    'greek': entry['greek'],
                    'answerDisplay': entry['answerDisplay'] ?? entry['greek'],
                    'pronunciation': entry['pronunciation'],
                  },
                ]) {
          forms.putIfAbsent(
            GreekText.answerKey(form['greek'] as String),
            () => form,
          );
        }
      }
      result['forms'] = forms.values.toList();
      result['answerDisplay'] = {
        for (final form in forms.values) form['answerDisplay'] as String,
      }.join(' / ');
      result['pronunciation'] = joined(
        forms.values.map((form) => form['pronunciation']),
        ' / ',
      );
      result['alternatives'] = {
        ...result['alternatives'] as List,
        for (final form in forms.values) form['greek'],
      }.where((value) => value != result['greek']).toList();
      result['acceptedAnswers'] = {
        ...result['acceptedAnswers'] as List,
        for (final form in forms.values) form['answerDisplay'],
      }.toList();
    }
    final dates = [
      for (final entry in entries)
        if (entry['addedWeek'] != null) entry['addedWeek'] as String,
    ]..sort();
    if (dates.isNotEmpty) result['addedWeek'] = dates.first;
    result['aliases'] = {
      ...union('aliases').cast<String>(),
      for (final entry in entries) entry['id'] as String,
    }.where((id) => id != result['id']).toList();
    final primary = jsonEncode(result['reviewIdentity']);
    final reviews = <String, dynamic>{};
    for (final entry in entries) {
      for (final identity in [
        entry['reviewIdentity'],
        ...entry['reviewAliases'] as List? ?? [],
      ]) {
        if (identity != null && jsonEncode(identity) != primary) {
          reviews[jsonEncode(identity)] = identity;
        }
      }
    }
    result['reviewAliases'] = reviews.values.toList();
    cards[canonical] = result;
    final allThemes = <String>{};
    for (final collection in collections) {
      if (collection['section'] != 'words') continue;
      final themes = collection['themes'] as Map<String, dynamic>? ?? {};
      for (final entry in entries) {
        allThemes.addAll(List<String>.from(themes[entry['id']] ?? []));
      }
    }
    for (final collection in collections) {
      if (collection['section'] != 'words') continue;
      final references = List<String>.from(collection['deck']['cards']);
      if (!references.any(keys.contains)) continue;
      collection['deck']['cards'] = {
        for (final key in references) keys.contains(key) ? canonical : key,
      }.toList();
      final themes = collection['themes'] ??= <String, dynamic>{};
      for (final entry in entries) {
        themes.remove(entry['id']);
      }
      themes[result['id']] = allThemes.toList();
    }
    final referenced = <String>{
      ...protected,
      for (final collection in collections)
        ...List<String>.from(collection['deck']['cards']),
    };
    for (final key in keys) {
      if (!referenced.contains(key)) cards.remove(key);
    }
    merged += keys.length - 1;
  }
  return merged;
}
