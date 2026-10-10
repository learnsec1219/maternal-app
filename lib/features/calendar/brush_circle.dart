import 'dart:ui';

import 'package:flutter/material.dart';

/// A hand-drawn red circle around a saved period day: the stroke draws in,
/// then fades, like the demo. Respects "remove animations".
class BrushCircle extends StatefulWidget {
  const BrushCircle({
    super.key,
    required this.size,
    required this.color,
    this.onDone,
  });

  final double size;
  final Color color;
  final VoidCallback? onDone;

  @override
  State<BrushCircle> createState() => _BrushCircleState();
}

class _BrushCircleState extends State<BrushCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  );

  @override
  void initState() {
    super.initState();
    _c.forward().whenComplete(() => widget.onDone?.call());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) _c.value = .4;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The demo draws a 48x40 brush over a 32px day circle.
    final s = widget.size / 32;
    return Positioned(
      left: -8 * s,
      top: -6 * s,
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, _) {
            final t = _c.value;
            final draw = Curves.easeInOut.transform((t / .4).clamp(0, 1));
            final fade = t <= .4 ? 1.0 : 1 - (t - .4) / .6;
            return Opacity(
              opacity: fade.clamp(0, 1),
              child: CustomPaint(
                size: Size(48 * s, 40 * s),
                painter: _BrushPainter(draw, widget.color),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BrushPainter extends CustomPainter {
  _BrushPainter(this.progress, this.color);
  final double progress;
  final Color color;

  static final Path _path = Path()
    ..moveTo(31, 6.4)
    ..cubicTo(40, 6.8, 46, 12, 45.5, 19.5)
    ..cubicTo(45, 29, 35, 36, 23, 35.8)
    ..cubicTo(11, 35.6, 2.6, 29, 3, 20.5)
    ..cubicTo(3.4, 11, 13, 5.6, 25, 5.2)
    ..cubicTo(32, 5, 38, 6, 44.5, 3.6);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 48, size.height / 40);
    final part = Path();
    for (final PathMetric m in _path.computeMetrics()) {
      part.addPath(m.extractPath(0, m.length * progress), Offset.zero);
    }
    final main = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color;
    canvas.drawPath(part, main);
    canvas.save();
    canvas.translate(.7, -.6);
    canvas.drawPath(
      part,
      main
        ..strokeWidth = 1.1
        ..color = color.withValues(alpha: .55),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BrushPainter old) =>
      old.progress != progress || old.color != color;
}
