import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/greek_alphabet.dart';
import 'app_strings.dart';
import 'theme.dart';
import 'pronunciation_button.dart';
import 'letter_pairs_screen.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.strings.alphabetTitle),
            const SizedBox(width: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const LetterPairsScreen(),
                ),
              ),
              child: Text(context.strings.letterPairs),
            ),
          ],
        ),
      ),
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(context.strings.pronunciationHelp),
              children: [
                Text(
                  context.strings.alphabetNotes,
                  style: const TextStyle(color: Palette.muted),
                ),
                const SizedBox(height: 12),
              ],
            ),
            const SizedBox(height: 8),
            for (final letter in greekAlphabet) ...[
              Card(
                color: Colors.white,
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => LetterWritingScreen(letter: letter),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 86,
                          child: Text(
                            '${letter.upper} ${letter.lower}${letter.lower == 'σ' ? ' ς' : ''}',
                            style: TextStyle(
                              fontSize: letter.lower == 'σ' ? 27 : 34,
                              color: Palette.ink,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                letter.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text('${letter.reading} · /${letter.nameIpa}/'),
                              const SizedBox(height: 4),
                              Text(
                                '${context.strings.alphabetSound}: /${letter.sound}/',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Palette.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PronunciationButton(
                          asset: letter.audioAsset,
                          label: letter.name,
                        ),
                        const Icon(Icons.chevron_right_rounded, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    ),
  );
}

class LetterWritingScreen extends StatefulWidget {
  const LetterWritingScreen({super.key, required this.letter});
  final GreekLetter letter;

  @override
  State<LetterWritingScreen> createState() => _LetterWritingScreenState();
}

class _LetterWritingScreenState extends State<LetterWritingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  int _form = 0;
  int _stroke = 0;
  late List<Path> _paths;

  @override
  void initState() {
    super.initState();
    _animation =
        AnimationController(
          vsync: this,
          // Draw for 2.64 seconds, then hold for .66 seconds before the next stroke.
          duration: const Duration(milliseconds: 3300),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            if (_stroke < _paths.length - 1) {
              setState(() => _stroke++);
              _animation.forward(from: 0);
            } else {
              setState(() {});
            }
          }
        });
    _setPaths();
    _animation.forward();
  }

  void _setPaths() {
    final letter = widget.letter;
    _paths =
        (_form == 0
                ? letter.lowerStrokes
                : _form == 1
                ? letter.upperStrokes
                : finalSigmaStrokes)
            .map(parseTeachingStroke)
            .toList();
  }

  void _replay() {
    setState(() => _stroke = 0);
    _animation.forward(from: 0);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final letter = widget.letter;
    return Scaffold(
      appBar: AppBar(
        title: Text('${letter.upper} ${letter.lower} · ${letter.name}'),
        actions: [
          PronunciationButton(asset: letter.audioAsset, label: letter.name),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                '${context.strings.alphabetName}: ${letter.reading} /${letter.nameIpa}/',
              ),
              Text('${context.strings.alphabetSound}: /${letter.sound}/'),
              const SizedBox(height: 24),
              SegmentedButton<int>(
                segments: [
                  ButtonSegment(
                    value: 0,
                    label: Text(context.strings.lowercase),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text(context.strings.uppercase),
                  ),
                  if (letter.lower == 'σ')
                    ButtonSegment(
                      value: 2,
                      label: Text(context.strings.finalSigma),
                    ),
                ],
                showSelectedIcon: false,
                selected: {_form},
                onSelectionChanged: (selection) {
                  _animation.stop();
                  setState(() {
                    _form = selection.single;
                    _stroke = 0;
                    _setPaths();
                  });
                  _animation.forward(from: 0);
                },
              ),
              const SizedBox(height: 24),
              Text(
                context.strings.strokeOrder,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              AspectRatio(
                aspectRatio: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Palette.line),
                  ),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) => Semantics(
                      label: context.strings.strokeProgress(
                        _stroke + 1,
                        _paths.length,
                      ),
                      child: CustomPaint(
                        painter: StrokePainter(
                          _paths,
                          _stroke,
                          (_animation.value / .8).clamp(0.0, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.strings.strokeProgress(_stroke + 1, _paths.length),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      if (_animation.isAnimating) {
                        _animation.stop();
                      } else if (_animation.isCompleted) {
                        _replay();
                      } else {
                        _animation.forward();
                      }
                    }),
                    icon: Icon(
                      _animation.isAnimating ? Icons.pause : Icons.play_arrow,
                    ),
                    label: Text(
                      _animation.isAnimating
                          ? context.strings.pauseStrokes
                          : context.strings.resumeStrokes,
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _replay,
                    icon: const Icon(Icons.replay),
                    label: Text(context.strings.replayStrokes),
                  ),
                  OutlinedButton(
                    onPressed: _stroke < _paths.length - 1
                        ? () {
                            setState(() => _stroke++);
                            _animation.forward(from: 0);
                          }
                        : null,
                    child: Text(context.strings.nextStroke),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                context.strings.handwritingNote,
                style: const TextStyle(color: Palette.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The teaching data uses only absolute M, L, Q and C commands.
Path parseTeachingStroke(String source) {
  final tokens = RegExp(
    r'[MLQC]|-?\d+(?:\.\d+)?',
  ).allMatches(source).map((match) => match.group(0)!).toList();
  final path = Path();
  var index = 0;
  double number() => double.parse(tokens[index++]);
  while (index < tokens.length) {
    switch (tokens[index++]) {
      case 'M':
        path.moveTo(number(), number());
      case 'L':
        path.lineTo(number(), number());
      case 'Q':
        path.quadraticBezierTo(number(), number(), number(), number());
      case 'C':
        path.cubicTo(
          number(),
          number(),
          number(),
          number(),
          number(),
          number(),
        );
      default:
        throw FormatException('Invalid teaching stroke: $source');
    }
  }
  return path;
}

class StrokePainter extends CustomPainter {
  StrokePainter(this.paths, this.stroke, this.progress);
  final List<Path> paths;
  final int stroke;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height);
    canvas.save();
    canvas.translate((size.width - side) / 2, (size.height - side) / 2);
    canvas.scale(side / 110);
    canvas.translate(5, 5);
    final guide = Paint()
      ..color = Palette.line
      ..strokeWidth = .4;
    for (final y in [20.0, 38.0, 78.0, 93.0]) {
      canvas.drawLine(Offset(10, y), Offset(90, y), guide);
    }
    final pen = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final path in paths) {
      canvas.drawPath(path, pen..color = Palette.softGreen);
    }
    for (var i = 0; i <= stroke; i++) {
      final metric = paths[i].computeMetrics().first;
      final fraction = i < stroke ? 1.0 : progress;
      canvas.drawPath(
        metric.extractPath(0, metric.length * fraction),
        pen..color = Palette.ink,
      );
      if (i == stroke) {
        final tip = metric.getTangentForOffset(metric.length * fraction);
        if (tip != null) {
          canvas.drawCircle(tip.position, 2.3, Paint()..color = Palette.orange);
        }
      }
    }
    for (var i = 0; i < paths.length; i++) {
      final start = paths[i]
          .computeMetrics()
          .first
          .getTangentForOffset(0)!
          .position;
      final badge = start + const Offset(-4, -5);
      canvas.drawCircle(badge, 3.7, Paint()..color = Palette.lime);
      final label = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: const TextStyle(fontSize: 5, color: Palette.ink),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(canvas, badge - Offset(label.width / 2, label.height / 2));
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) =>
      oldDelegate.paths != paths ||
      oldDelegate.stroke != stroke ||
      oldDelegate.progress != progress;
}
