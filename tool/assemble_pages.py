"""Publish main at the site root and yuhang's branch at preview/yuhang/."""
import argparse
import json
from pathlib import Path
import shutil

ROOT = Path(__file__).resolve().parent.parent
PREVIEW_PATH = Path('preview/yuhang')


def validate_site(source: Path):
    if not (source / 'index.html').is_file():
        raise ValueError(f'Missing site entry: {source}')
    release = json.loads((source / 'release.json').read_text(encoding='utf-8'))
    base = release['base']
    app = (source / base).resolve()
    if source.resolve() not in app.parents:
        raise ValueError(f'App assets must be inside the site: {source}')
    for filename in ['flutter_bootstrap.js', 'main.dart.js']:
        if not (app / filename).is_file():
            raise ValueError(f'Missing app asset: {source}/{base}{filename}')


def assemble_pages(production: Path, preview: Path, destination: Path,
                   production_sha: str = '', preview_sha: str = ''):
    # Validate both builds before writing anything. Never replace source trees
    # or an existing deployment directory.
    for source in [production, preview]:
        validate_site(source)
        if source.resolve() in destination.resolve().parents:
            raise ValueError('Deployment output must be outside both input sites')
    if destination.exists():
        raise FileExistsError(f'Deployment directory already exists: {destination}')
    if (production / PREVIEW_PATH).exists():
        raise ValueError('Production build already contains the preview path')
    shutil.copytree(production, destination)
    preview_destination = destination / PREVIEW_PATH
    shutil.copytree(preview, preview_destination)
    for directory, branch, sha in [
        (destination, 'main', production_sha),
        (preview_destination, "yuhang's-branch", preview_sha),
    ]:
        (directory / 'build-info.json').write_text(
            json.dumps({'branch': branch, 'commit': sha}) + '\n', encoding='utf-8',
        )
    (destination / '.nojekyll').touch()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--production', type=Path, required=True)
    parser.add_argument('--preview', type=Path, required=True)
    parser.add_argument('--production-sha', default='')
    parser.add_argument('--preview-sha', default='')
    args = parser.parse_args()
    assemble_pages(args.production, args.preview, ROOT / 'build/pages',
                   args.production_sha, args.preview_sha)
    print('Pages ready: main at /; preview at /preview/yuhang/')


if __name__ == '__main__':
    main()
