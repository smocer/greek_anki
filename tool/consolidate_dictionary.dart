import 'dart:convert';
import 'dart:io';

import 'package:greek_anki/data/word_consolidation.dart';

void main() {
  final file = File('assets/dictionary/greek.json');
  final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final count = consolidateWordData(data);
  if (count > 0) {
    file.writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(data)}\n',
    );
  }
  stdout.writeln('Consolidated $count duplicate word definitions.');
}
