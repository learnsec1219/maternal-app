import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_theme.dart';

/// The demo's round kick button: a baby footprint that presses in, sends a
/// ripple ring outwards and floats a "+1" so each tap is clearly counted.
class KickButton extends StatefulWidget {
  const KickButton({super.key, required this.label, required this.onTap});

  final String label;

  /// Returns true when the tap was counted (false when it was guarded).
  final bool Function() onTap;

  @override
  State<KickButton> createState() => _KickButtonState();
}

class _KickButtonState extends State<KickButton> with TickerProviderStateMixin {
  late final _press = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 90),
    reverseDuration: const Duration(milliseconds: 220),
  );
  late final _burst = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );
  bool _lastCounted = true;

  @override
  void dispose() {
    _press.dispose();
    _burst.dispose();
    super.dispose();
  }

  void _tap() {
    final counted = widget.onTap();
    HapticFeedback.mediumImpact();
    setState(() => _lastCounted = counted);
    _press.forward().then((_) => _press.reverse());
    _burst.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Semantics(
      button: true,
      label: widget.label,
      excludeSemantics: true,
      child: GestureDetector(
        key: const Key('kick-tap'),
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _press.forward(),
        onTapCancel: () => _press.reverse(),
        onTap: _tap,
        child: SizedBox(
          width: 250,
          height: 250,
          child: AnimatedBuilder(
            animation: Listenable.merge([_press, _burst]),
            builder: (context, _) {
              final b = _burst.value;
              final active = _burst.isAnimating;
              final scale = 1 - 0.08 * _press.value;
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (active)
                    Container(
                      width: 210 + 40 * b,
                      height: 210 + 40 * b,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: p.rose.withValues(alpha: (1 - b) * 0.6),
                          width: 6,
                        ),
                      ),
                    ),
                  Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.lerp(p.roseSoft, p.roseTint, _press.value),
                        border: Border.all(color: p.line, width: 12),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: 150,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomPaint(
                                key: const Key('kick-foot'),
                                size: const Size(63, 72),
                                painter: FootprintPainter(p.rose, p.onRose),
                              ),
                              const SizedBox(height: 8),
                              Text(widget.label, textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (active && _lastCounted)
                    Positioned(
                      top: 30 - 30 * b,
                      child: Opacity(
                        opacity: (1 - b).clamp(0, 1),
                        child: Text(
                          '+1',
                          style: TextStyle(
                            color: p.rose,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// The demo's footprint (viewBox 84×96): a sole, five toes and a plus mark.
class FootprintPainter extends CustomPainter {
  FootprintPainter(this.color, this.mark);

  final Color color, mark;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 84, size.height / 96);
    final fill = Paint()..color = color;
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(39, 61), width: 42, height: 68),
      fill,
    );
    for (final (x, y, r) in [
      (67.0, 17.0, 9.0),
      (52.0, 10.0, 7.0),
      (38.0, 8.0, 6.3),
      (25.0, 11.0, 5.5),
      (14.0, 17.0, 4.6),
    ]) {
      canvas.drawCircle(Offset(x, y), r, fill);
    }
    final line = Paint()
      ..color = mark
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(30, 56), const Offset(48, 56), line);
    canvas.drawLine(const Offset(39, 47), const Offset(39, 65), line);
  }

  @override
  bool shouldRepaint(FootprintPainter old) =>
      old.color != color || old.mark != mark;
}
