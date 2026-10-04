"""Run with .dart_tool/vocabulary_nlp/Scripts/python.exe -m unittest discover -s tool."""
import contextlib
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import annotate_greek_vocabulary as annotation


class ImportAnnotationTest(unittest.TestCase):
    def test_new_unlabelled_sentences_and_repeat_import_preserve_word_dates(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / 'tool').mkdir()
            (root / 'lib/data').mkdir(parents=True)
            cards = [{'source': 'new', 'sourceId': 'sentence', 'greek': 'Γράφω το βιβλίο.'}]
            metadata = {'new.sentence': {'labels': [], 'addedWeek': '2026-09-28'}}
            hints = {'γράφω': {'labels': ['verb']}, 'βιβλίο': {'labels': ['noun']}}
            def save(path, data):
                path.write_text(json.dumps(data, ensure_ascii=False), encoding='utf-8')
            input_path, hints_path = root / 'input.json', root / 'hints.json'
            save(input_path, cards)
            save(hints_path, hints)
            save(root / 'tool/vocabulary_metadata.json', metadata)
            def run():
                with patch.object(annotation, 'ROOT', root), patch('sys.argv', [
                    'annotation', '--input', str(input_path), '--hints', str(hints_path)
                ]), contextlib.redirect_stdout(io.StringIO()):
                    annotation.main()
            run()
            output = json.loads((root / 'tool/vocabulary_tokens.json').read_text(encoding='utf-8'))
            tokens = output['cards']['new.sentence']['tokens']
            self.assertEqual([token['labels'] for token in tokens], [['verb'], ['article'], ['noun']])
            for token in tokens:
                self.assertEqual(cards[0]['greek'][token['start']:token['end']], token['surface'])
            cards.append({'source': 'new', 'sourceId': 'later', 'greek': 'Γράφω βιβλίο.'})
            metadata['new.later'] = {'labels': [], 'addedWeek': '2026-10-05'}
            save(input_path, cards)
            save(root / 'tool/vocabulary_metadata.json', metadata)
            run()
            dates = json.loads((root / 'tool/vocabulary_word_dates.json').read_text(encoding='utf-8'))
            self.assertEqual(dates['verb:γράφω'], '2026-09-28')
            self.assertEqual(dates['noun:βιβλίο'], '2026-09-28')
            self.assertIn('VocabularyLabel.noun', (root / 'lib/data/vocabulary_words.dart').read_text(encoding='utf-8'))


if __name__ == '__main__':
    unittest.main()
