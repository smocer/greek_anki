import json
from pathlib import Path
import tempfile
import unittest

from build_web import package_site


class WebReleaseTests(unittest.TestCase):
    def test_assets_change_url_but_entry_and_storage_origin_stay_put(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            build, site = root / 'web', root / 'site'
            build.mkdir()
            for name in ['index.html', 'app_loader.js', 'manifest.json', 'flutter_bootstrap.js', 'main.dart.js']:
                (build / name).write_text(name)
            (build / 'assets').mkdir()
            (build / 'assets/FontManifest.json').write_text('[]')
            (build / 'flutter_service_worker.js').write_text('old worker')
            first = package_site(build, site)
            self.assertTrue((site / 'index.html').is_file())
            self.assertTrue((site / f'app/{first}/assets/FontManifest.json').is_file())
            self.assertFalse((site / 'flutter_service_worker.js').exists())
            self.assertEqual(first, package_site(build, site))
            (build / 'main.dart.js').write_text('new lesson')
            second = package_site(build, site)
            self.assertNotEqual(first, second)
            self.assertEqual(json.loads((site / 'release.json').read_text()), {
                'id': second, 'base': f'app/{second}/',
            })
            self.assertEqual((site / f'app/{second}/main.dart.js').read_text(), 'new lesson')
            self.assertTrue((site / '.nojekyll').exists())
            self.assertFalse((site / f'app/{first}').exists())


if __name__ == '__main__':
    unittest.main()
