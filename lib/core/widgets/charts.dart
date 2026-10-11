import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Progress ring with a centred child, like the demo's pregnancy and
/// calorie rings.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    required this.child,
    this.size = 104,
    this.stroke = 10,
  });

  final double progress;
  final Widget child;
  final double size, stroke;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(progress.clamp(0, 1), stroke, p.card, p.rose),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(stroke + 4),
            child: FittedBox(fit: BoxFit.scaleDown, child: child),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.progress, this.stroke, this.track, this.color);
  final double progress, stroke;
  final Color track, color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect =
        Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = track;
    canvas.drawArc(rect, 0, math.pi * 2, false, base);
    if (progress > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * progress,
        false,
        base
          ..color = color
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color || old.track != track;
}

/// Simple bar chart with optional dashed target line.
class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.values,
    required this.labels,
    this.target,
    this.height = 150,
    this.semanticLabel,
  });

  final List<double> values;
  final List<String> labels;
  final double? target;
  final double height;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Semantics(
      label: semanticLabel,
      image: true,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _BarPainter(
            values,
            labels,
            target,
            p,
            DefaultTextStyle.of(context).style.fontFamily,
          ),
        ),
      ),
    );
  }
}

class _BarPainter extends CustomPainter {
  _BarPainter(this.values, this.labels, this.target, this.p, this.font);
  final List<double> values;
  final List<String> labels;
  final double? target;
  final Palette p;
  final String? font;

  @override
  void paint(Canvas canvas, Size size) {
    const b = 22.0;
    final w = size.width, h = size.height;
    final max =
        [1.0, ...values, target ?? 0].reduce((a, c) => a > c ? a : c) * 1.1;
    final slot = w / values.length;
    final bw = math.min(16.0, slot * .6);
    final line = Paint()
      ..color = p.line
      ..strokeWidth = 1;
    for (var i = 0; i <= 2; i++) {
      final y = (h - b) * i / 2;
      canvas.drawLine(Offset(0, y), Offset(w, y), line);
    }
    final bar = Paint()..color = p.rose;
    for (var i = 0; i < values.length; i++) {
      final bh = (h - b) * values[i] / max;
      if (bh > 0) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(slot * i + (slot - bw) / 2, h - b - bh, bw, bh),
            const Radius.circular(4),
          ),
          bar,
        );
      }
      if (i < labels.length && labels[i].isNotEmpty) {
        _text(canvas, labels[i], Offset(slot * i + slot / 2, h - 16));
      }
    }
    if (target != null && target! > 0) {
      final y = h - b - (h - b) * target! / max;
      final dash = Paint()
        ..color = p.good
        ..strokeWidth = 1.5;
      for (var x = 0.0; x < w; x += 8) {
        canvas.drawLine(Offset(x, y), Offset(math.min(w, x + 4), y), dash);
      }
    }
  }

  void _text(Canvas canvas, String s, Offset centre) {
    final tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(fontSize: 10, color: p.muted, fontFamily: font),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    tp.paint(canvas, Offset(centre.dx - tp.width / 2, centre.dy));
  }

  @override
  bool shouldRepaint(_BarPainter old) => true;
}

class ChartPoint {
  const ChartPoint(this.x, this.y, [this.label]);
  final double x, y;
  final String? label;
}

/// Line chart with an optional shaded typical-range band and second series.
class LineChart extends StatelessWidget {
  const LineChart({
    super.key,
    required this.points,
    this.second,
    this.band,
    this.height = 160,
    this.axis = true,
    this.semanticLabel,
  });

  final List<ChartPoint> points;
  final List<ChartPoint>? second;
  final (double?, double?)? band;
  final double height;
  final bool axis;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) return const SizedBox.shrink();
    return Semantics(
      label: semanticLabel,
      image: true,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _LinePainter(points, second, band, axis, context.pal),
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter(this.points, this.second, this.band, this.axis, this.p);
  final List<ChartPoint> points;
  final List<ChartPoint>? second;
  final (double?, double?)? band;
  final bool axis;
  final Palette p;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final l = axis ? 34.0 : 6.0;
    final all = [...points, ...?second];
    var lo = all.map((e) => e.y).reduce(math.min);
    var hi = all.map((e) => e.y).reduce(math.max);
    if (band != null) {
      if (band!.$1 != null) lo = math.min(lo, band!.$1!);
      if (band!.$2 != null) hi = math.max(hi, band!.$2!);
    }
    final pad = (hi - lo) * .15 == 0 ? 1.0 : (hi - lo) * .15;
    lo -= pad;
    hi += pad;
    final xs = all.map((e) => e.x);
    final x0 = xs.reduce(math.min), x1 = xs.reduce(math.max);
    double fx(double x) =>
        l + (x1 == x0 ? (w - l) / 2 : (x - x0) / (x1 - x0) * (w - l - 6));
    double fy(double y) => 6 + (h - 26) * (1 - (y - lo) / (hi - lo));
    if (band != null) {
      final top = fy(band!.$2 ?? hi), bottom = fy(band!.$1 ?? lo);
      canvas.drawRect(
        Rect.fromLTRB(l, top, w, bottom),
        Paint()..color = p.goodSoft,
      );
    }
    final grid = Paint()..color = p.line;
    for (var i = 0; i <= 3; i++) {
      final y = 6 + (h - 26) * i / 3;
      canvas.drawLine(Offset(l, y), Offset(w, y), grid);
      if (axis) {
        final v = hi - (hi - lo) * i / 3;
        _text(
          canvas,
          v >= 100 ? v.toStringAsFixed(0) : v.toStringAsFixed(1),
          Offset(0, y - 6),
          false,
        );
      }
    }
    void series(List<ChartPoint> pts, Color c) {
      final sp = [...pts]..sort((a, b) => a.x.compareTo(b.x));
      final path = Path();
      for (var i = 0; i < sp.length; i++) {
        final o = Offset(fx(sp[i].x), fy(sp[i].y));
        i == 0 ? path.moveTo(o.dx, o.dy) : path.lineTo(o.dx, o.dy);
      }
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2
          ..strokeJoin = StrokeJoin.round
          ..color = c,
      );
      final dot = Paint()..color = c;
      for (final e in sp) {
        canvas.drawCircle(Offset(fx(e.x), fy(e.y)), 3.2, dot);
      }
    }

    series(points, p.rose);
    if (second != null) series(second!, p.fertile);
    final lab = points.where((e) => e.label != null).toList()
      ..sort((a, b) => a.x.compareTo(b.x));
    final step = math.max(1, (lab.length / 5).ceil());
    for (var i = 0; i < lab.length; i += step) {
      final x = math.min(w - 20, math.max(l, fx(lab[i].x)));
      _text(canvas, lab[i].label!, Offset(x, h - 16), true);
    }
  }

  void _text(Canvas canvas, String s, Offset at, bool centre) {
    final tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(fontSize: 9.5, color: p.muted),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    tp.paint(canvas, centre ? Offset(at.dx - tp.width / 2, at.dy) : at);
  }

  @override
  bool shouldRepaint(_LinePainter old) => true;
}
