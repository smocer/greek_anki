"""Decode all dictionary clips with FFmpeg, checking duration and signal.

Requires imageio-ffmpeg in .dart_tool/audio_generator.
Run: python tool/verify_greek_audio.py
"""
from concurrent.futures import ThreadPoolExecutor
import argparse
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / '.dart_tool/audio_generator'))
import imageio_ffmpeg


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--existing-only', action='store_true',
                        help='Validate completed clips while generation is running')
    args = parser.parse_args()
    manifest = json.loads((ROOT / 'tool/greek_dictionary_audio.json').read_text('utf-8'))
    if args.existing_only:
        manifest = {key: text for key, text in manifest.items()
                    if (ROOT / 'assets/audio/greek' / f'{key}.mp3').exists()}
    if not manifest:
        raise ValueError('No clips found to validate')
    executable = imageio_ffmpeg.get_ffmpeg_exe()

    def verify(key):
        path = ROOT / 'assets/audio/greek' / f'{key}.mp3'
        result = subprocess.run(
            [executable, '-v', 'error', '-xerror', '-i', str(path),
             '-f', 's16le', '-ac', '1', '-ar', '16000', 'pipe:1'],
            capture_output=True, check=True,
            creationflags=subprocess.CREATE_NO_WINDOW if sys.platform == 'win32' else 0,
        )
        # At least 100 ms of decoded PCM and some nonzero samples.
        if len(result.stdout) < 3200 or not any(result.stdout):
            raise ValueError(f'Empty or silent clip: {key}')
        return len(result.stdout) / 32000

    with ThreadPoolExecutor(max_workers=4) as workers:
        durations = list(workers.map(verify, manifest))
    print(f'Validated {len(durations)} MP3s; duration {min(durations):.2f}–{max(durations):.2f}s')


if __name__ == '__main__':
    main()
