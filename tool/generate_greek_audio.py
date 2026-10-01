"""Generate bundled Greek example-word clips; requires edge-tts 7.2.8.

Run: python tool/generate_greek_audio.py
Voice: Microsoft el-GR-AthinaNeural, rate -15%. Only public lesson text
is sent to the synthesis service. Existing nonempty clips are preserved.
"""
import asyncio
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / '.dart_tool/audio_generator'))
import edge_tts


async def main():
    destination = ROOT / 'assets/audio/greek'
    destination.mkdir(parents=True, exist_ok=True)
    # Letter names use the native recording importer.
    clips = {}
    manifest = ROOT / 'tool/greek_audio_examples.json'
    if manifest.exists():
        clips.update(json.loads(manifest.read_text(encoding='utf-8')))
    gate = asyncio.Semaphore(3)

    async def generate(key, text):
        path = destination / f'{key}.mp3'
        if path.exists() and path.stat().st_size > 1000:
            return
        async with gate:
            for attempt in range(3):
                try:
                    await edge_tts.Communicate(
                        text, 'el-GR-AthinaNeural', rate='-15%'
                    ).save(str(path))
                    print(f'Generated {key}', flush=True)
                    return
                except Exception:
                    if attempt == 2:
                        raise
                    await asyncio.sleep(2)

    await asyncio.gather(*(generate(key, text) for key, text in clips.items()))
    print(f'Ready: {len(clips)} clips', flush=True)


if __name__ == '__main__':
    asyncio.run(main())
