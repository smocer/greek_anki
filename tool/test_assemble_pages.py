import json
from pathlib import Path
import tempfile
import unittest

from assemble_pages import assemble_pages
from build_web import package_site


class PreviewSiteTests(unittest.TestCase):
    def make_site(self, root: Path, name: str, base: str) -> Path:
        build = root / f'{name}-build'
        build.mkdir()
        (build / 'index.html').write_text(f'<base href="{base}">{name}')
        (build / 'main.dart.js').write_text(name)
        (build / 'flutter_bootstrap.js').write_text(f'bootstrap-{name}')
        site = root / f'{name}-site'
        package_site(build, site)
        return site

    def test_main_and_preview_keep_independent_entries_and_release_assets(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            production = self.make_site(root, 'main', '/greek_anki/')
            preview = self.make_site(root, 'branch', '/greek_anki/preview/yuhang/')
            destination = root / 'pages'
            assemble_pages(production, preview, destination, 'main-sha', 'preview-sha')
            for source, target, branch, sha in [
                (production, destination, 'main', 'main-sha'),
                (preview, destination / 'preview/yuhang', "yuhang's-branch", 'preview-sha'),
            ]:
                self.assertEqual((source / 'index.html').read_text(), (target / 'index.html').read_text())
                release = json.loads((target / 'release.json').read_text())
                self.assertEqual(
                    (source / release['base'] / 'main.dart.js').read_text(),
                    (target / release['base'] / 'main.dart.js').read_text(),
                )
                self.assertEqual(json.loads((target / 'build-info.json').read_text()),
                                 {'branch': branch, 'commit': sha})
            self.assertTrue((destination / '.nojekyll').is_file())

    def test_missing_preview_does_not_create_or_replace_a_site(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            production = self.make_site(root, 'main', '/greek_anki/')
            with self.assertRaises(ValueError):
                assemble_pages(production, root / 'missing-preview', root / 'pages')
            self.assertFalse((root / 'pages').exists())
            self.assertTrue((production / 'index.html').is_file())

    def test_existing_output_is_preserved(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            production = self.make_site(root, 'main', '/greek_anki/')
            preview = self.make_site(root, 'branch', '/greek_anki/preview/yuhang/')
            destination = root / 'pages'
            destination.mkdir()
            (destination / 'index.html').write_text('existing')
            with self.assertRaises(FileExistsError):
                assemble_pages(production, preview, destination)
            self.assertEqual((destination / 'index.html').read_text(), 'existing')


if __name__ == '__main__':
    unittest.main()
