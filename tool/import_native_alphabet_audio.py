"""Import a public-domain recording of the Modern Greek alphabet.

Speaker: CuteHappyBrute. Audio cleaned by RoB (2010).
Source: https://commons.wikimedia.org/wiki/File:Ell-AlphabitosUpload.ogg
Requires imageio-ffmpeg. All clips come from the same original recording.
Boundaries are placed inside the pauses between successive letter names.
"""
import hashlib
from pathlib import Path
import subprocess
import sys
import urllib.request

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / '.dart_tool/audio_generator'))
import imageio_ffmpeg

URL = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Ell-AlphabitosUpload.ogg'
SOURCE_SHA1 = '84fcf58f5f8f130e579cafdfb7aecdb07f857958'
LETTERS = 'αβγδεζηθικλμνξοπρστυφχψω'
BOUNDARIES = [
    1.84, 2.60, 3.44, 4.27, 5.15, 6.05, 6.89, 7.64,
    8.49, 9.36, 10.19, 11.02, 11.67, 12.41, 13.27,
    14.26, 14.85, 15.57, 16.49, 17.20, 18.10, 18.69,
    19.37, 20.05, 20.83,
]


def main():
    source = ROOT / '.dart_tool/greek-alphabet-native.ogg'
    if not source.exists():
        request = urllib.request.Request(URL, headers={'User-Agent': 'GreekAnkiAudio/1.0'})
        source.write_bytes(urllib.request.urlopen(request).read())
    if hashlib.sha1(source.read_bytes()).hexdigest() != SOURCE_SHA1:
        raise ValueError('Recording changed; recheck letter boundaries before importing')
    ffmpeg = imageio_ffmpeg.get_ffmpeg_exe()
    destination = ROOT / 'assets/audio/greek'
    destination.mkdir(parents=True, exist_ok=True)
    for letter, start, end in zip(LETTERS, BOUNDARIES, BOUNDARIES[1:]):
        output = destination / f'native-name-{ord(letter):x}.mp3'
        subprocess.run([
            ffmpeg, '-y', '-ss', str(start), '-i', str(source),
            '-t', str(end - start), '-ac', '1', '-ar', '24000',
            '-codec:a', 'libmp3lame', '-b:a', '96k', '-write_xing', '0',
            '-id3v2_version', '0', str(output),
        ], check=True, capture_output=True)
        print(f'Imported {output.name}')


if __name__ == '__main__':
    main()
