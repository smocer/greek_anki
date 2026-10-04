import 'package:flutter/material.dart';

import '../data/greek_grammar.dart';
import 'app_strings.dart';
import 'theme.dart';

class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.strings.grammarTitle)),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              context.strings.grammarIntro,
              style: const TextStyle(color: Palette.muted),
            ),
            const SizedBox(height: 20),
            for (final topic in greekGrammar) ...[
              Card(
                color: Colors.white,
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  title: Text(context.localize(topic.title)),
                  subtitle: Text(context.localize(topic.summary)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => GrammarTopicScreen(topic: topic),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    ),
  );
}

class GrammarTopicScreen extends StatelessWidget {
  const GrammarTopicScreen({super.key, required this.topic});
  final GrammarTopic topic;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.localize(topic.title))),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              context.localize(topic.summary),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            for (final note in topic.notes) ...[
              Text(context.localize(note)),
              const SizedBox(height: 16),
            ],
            if (topic.tables.isNotEmpty)
              Text(
                context.strings.grammarTableHint,
                style: const TextStyle(fontSize: 12, color: Palette.muted),
              ),
            const SizedBox(height: 12),
            for (final table in topic.tables) ...[
              Text(
                table.title.en,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Palette.line),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    key: ValueKey(table),
                    columnSpacing: 24,
                    headingRowColor: const WidgetStatePropertyAll(
                      Palette.softGreen,
                    ),
                    columns: [
                      for (final header in table.headers)
                        DataColumn(label: Text(header.en)),
                    ],
                    rows: [
                      for (final row in table.rows)
                        DataRow(
                          cells: [for (final cell in row) DataCell(Text(cell))],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ],
        ),
      ),
    ),
  );
}
