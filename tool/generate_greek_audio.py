"""Generate bundled Greek word clips; requires edge-tts 7.3.1.

Run: python tool/generate_greek_audio.py
Refresh dictionary manifest: flutter test tool/export_dictionary_audio.dart
Install dependencies: python -m pip install --target .dart_tool/audio_generator edge-tts==7.3.1
Voice: Microsoft el-GR-AthinaNeural, rate -15%. Only public lesson text
is sent to the synthesis service. Existing nonempty clips are preserved.
"""
import asyncio
import argparse
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / '.dart_tool/audio_generator'))
import edge_tts


async def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dictionary-only', action='store_true')
    parser.add_argument('--limit', type=int, help='Limit missing clips for a trial run')
    args = parser.parse_args()
    destination = ROOT / 'assets/audio/greek'
    destination.mkdir(parents=True, exist_ok=True)
    staging = ROOT / '.dart_tool/audio_pending'
    # Letter names use the native recording importer.
    clips = {}
    manifests = ['greek_dictionary_audio.json']
    if not args.dictionary_only:
        manifests.insert(0, 'greek_audio_examples.json')
    for filename in manifests:
        manifest = ROOT / 'tool' / filename
        if manifest.exists():
            clips.update(json.loads(manifest.read_text(encoding='utf-8')))
    missing = {
        key: text for key, text in clips.items()
        if not (destination / f'{key}.mp3').exists()
        or (destination / f'{key}.mp3').stat().st_size <= 1000
    }
    if args.limit is not None:
        missing = dict(list(missing.items())[:args.limit])
    print(f'Requested: {len(clips)} clips; missing: {len(missing)}', flush=True)
    gate = asyncio.Semaphore(3)

    async def generate(key, text):
        path = destination / f'{key}.mp3'
        if destination.resolve() not in path.resolve().parents:
            raise ValueError(f'Unsafe audio path: {key}')
        path.parent.mkdir(parents=True, exist_ok=True)
        if path.exists() and path.stat().st_size > 1000:
            return
        async with gate:
            for attempt in range(3):
                try:
                    # Keep partial files outside assets so Flutter cannot bundle
                    # a file that disappears during the final atomic rename.
                    temporary = staging / f'{key}.mp3.part'
                    temporary.parent.mkdir(parents=True, exist_ok=True)
                    await edge_tts.Communicate(
                        text, 'el-GR-AthinaNeural', rate='-15%'
                    ).save(str(temporary))
                    if temporary.stat().st_size <= 1000:
                        raise ValueError(f'Empty or truncated audio: {key}')
                    temporary.replace(path)
                    print(f'Generated {key}', flush=True)
                    return
                except Exception as error:
                    print(f'Retry {attempt + 1} for {key}: {error}', flush=True)
                    if attempt == 2:
                        raise
                    await asyncio.sleep(2)

    results = await asyncio.gather(
        *(generate(key, text) for key, text in missing.items()),
        return_exceptions=True,
    )
    failed = [key for key, result in zip(missing, results) if isinstance(result, Exception)]
    if failed:
        raise RuntimeError(f'Failed {len(failed)} clips: {", ".join(failed)}')
    print(f'Ready: {len(missing)} newly generated clips', flush=True)


if __name__ == '__main__':
    asyncio.run(main())
