#!/usr/bin/env python3
"""Build a static site with a fresh release pointer and versioned app assets."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SHELL_FILES = {'index.html', 'app_loader.js', 'manifest.json', 'icons', 'favicon.png'}


def package_site(build: Path, destination: Path) -> str:
    digest = hashlib.sha256()
    for file in sorted(build.rglob('*')):
        if file.is_file():
            digest.update(file.relative_to(build).as_posix().encode())
            digest.update(b'\0')
            digest.update(file.read_bytes())
    release_id = digest.hexdigest()[:16]
    # Replace only our generated site directory, never source or device data.
    if destination.exists():
        shutil.rmtree(destination)
    destination.mkdir(parents=True)
    app = destination / 'app' / release_id
    app.mkdir(parents=True)
    for item in build.iterdir():
        if item.name in {'release.json', 'flutter_service_worker.js'}:
            continue
        target = (destination if item.name in SHELL_FILES else app) / item.name
        if item.is_dir():
            shutil.copytree(item, target)
        else:
            shutil.copy2(item, target)
    (destination / 'release.json').write_text(json.dumps({
        'id': release_id, 'base': f'app/{release_id}/',
    }) + '\n')
    (destination / '.nojekyll').touch()
    return release_id


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base-href', default='/greek_anki/')
    args = parser.parse_args()
    if not args.base_href.startswith('/') or not args.base_href.endswith('/'):
        parser.error('--base-href must start and end with /')
    subprocess.run([
        'flutter', 'build', 'web', '--release', '--no-web-resources-cdn',
        '--base-href', args.base_href,
    ], cwd=ROOT, check=True)
    release_id = package_site(ROOT / 'build/web', ROOT / 'build/site')
    print(f'Site ready: build/site (release {release_id})')


if __name__ == '__main__':
    main()
