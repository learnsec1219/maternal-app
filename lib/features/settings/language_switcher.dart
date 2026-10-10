import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import 'locale_controller.dart';

/// App-bar language control. Tapping it opens a chat-bubble dropdown where the
/// languages sit in circles joined by a flowing "water" line, 1 → 2 → 3 → 4.
class LanguageSwitcher extends ConsumerStatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  ConsumerState<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends ConsumerState<LanguageSwitcher>
    with TickerProviderStateMixin {
  final _portal = OverlayPortalController();
  final _triggerKey = GlobalKey();
  Rect _anchor = Rect.zero;

  /// Bubble pop-in and the water filling from the first circle to the last.
  late final _open = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 750),
    reverseDuration: const Duration(milliseconds: 200),
  );

  /// Continuous ripple of the water while the bubble is open.
  late final _wave = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  @override
  void dispose() {
    _open.dispose();
    _wave.dispose();
    super.dispose();
  }

  bool get _reduceMotion => MediaQuery.of(context).disableAnimations;

  void _show() {
    _anchor = _triggerRect();
    setState(_portal.show);
    if (_reduceMotion) {
      _open.value = 1;
    } else {
      _open.forward(from: 0);
      _wave.repeat();
    }
  }

  Future<void> _hide() async {
    if (!_portal.isShowing) return;
    if (!_reduceMotion) await _open.reverse();
    _wave.stop();
    if (mounted) setState(_portal.hide);
  }

  Future<void> _select(AppLanguage language) async {
    HapticFeedback.selectionClick();
    ref.read(localeProvider.notifier).set(language.locale);
    // Let the selected circle fill before the bubble closes.
    await Future<void>.delayed(const Duration(milliseconds: 260));
    await _hide();
  }

  @override
  Widget build(BuildContext context) {
    final current = languageFor(ref.watch(localeProvider));
    return OverlayPortal(
      controller: _portal,
      overlayChildBuilder: (_) => _BubbleOverlay(
        anchor: _anchor,
        open: _open,
        wave: _wave,
        current: current,
        onSelect: _select,
        onDismiss: _hide,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: _TriggerPill(
          key: _triggerKey,
          label: current.short,
          expanded: _portal.isShowing,
          onTap: () => _portal.isShowing ? _hide() : _show(),
        ),
      ),
    );
  }

  /// The trigger's rectangle in the overlay's coordinates.
  Rect _triggerRect() {
    final trigger =
        _triggerKey.currentContext!.findRenderObject()! as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    final topLeft = trigger.localToGlobal(Offset.zero, ancestor: overlay);
    return topLeft & trigger.size;
  }
}

class _TriggerPill extends StatelessWidget {
  const _TriggerPill({
    super.key,
    required this.label,
    required this.expanded,
    required this.onTap,
  });

  final String label;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    expanded: expanded,
    label: context.l10n.language,
    child: Material(
      color: Colors.white,
      shape: const StadiumBorder(side: BorderSide(color: AppColors.line)),
      child: InkWell(
        key: const Key('language-switcher'),
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 8, 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.translate_rounded,
                  size: 18,
                  color: AppColors.roseDeep,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.expand_more_rounded,
                    size: 20,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _BubbleOverlay extends StatelessWidget {
  const _BubbleOverlay({
    required this.anchor,
    required this.open,
    required this.wave,
    required this.current,
    required this.onSelect,
    required this.onDismiss,
  });

  /// Where the trigger sits, so the bubble's tail can point at it.
  final Rect anchor;
  final AnimationController open;
  final AnimationController wave;
  final AppLanguage current;
  final ValueChanged<AppLanguage> onSelect;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final pop = CurvedAnimation(
      parent: open,
      curve: const Interval(0, 0.45, curve: Curves.easeOutBack),
      reverseCurve: Curves.easeIn,
    );
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onDismiss,
            child: FadeTransition(
              opacity: open,
              child: const ColoredBox(color: Color(0x0F2E2A2C)),
            ),
          ),
        ),
        Positioned(
          top: anchor.bottom + 6,
          right: MediaQuery.sizeOf(context).width - anchor.right,
          child: FadeTransition(
            opacity: pop,
            child: ScaleTransition(
              scale: pop,
              alignment: const Alignment(0.8, -1),
              child: _Bubble(
                tailInset: anchor.width / 2,
                open: open,
                wave: wave,
                current: current,
                onSelect: onSelect,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.tailInset,
    required this.open,
    required this.wave,
    required this.current,
    required this.onSelect,
  });

  /// Distance of the tail's tip from the bubble's right edge.
  final double tailInset;
  final AnimationController open;
  final AnimationController wave;
  final AppLanguage current;
  final ValueChanged<AppLanguage> onSelect;

  static const nodeSize = 54.0;
  static const gap = 14.0;

  @override
  Widget build(BuildContext context) {
    final fill = CurvedAnimation(
      parent: open,
      curve: const Interval(0.2, 1, curve: Curves.easeInOutCubic),
    );
    final n = appLanguages.length;
    final rowWidth = n * nodeSize + (n - 1) * gap;
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, AppColors.roseSoft],
          ),
          shape: _BubbleBorder(tailInset: tailInset),
          shadows: [
            BoxShadow(
              color: AppColors.roseDeep.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(
          16,
          16 + _BubbleBorder.tailHeight,
          16,
          14,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.language,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.muted,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: rowWidth,
              height: nodeSize,
              child: AnimatedBuilder(
                animation: Listenable.merge([fill, wave]),
                builder: (context, _) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _WaterFlowPainter(
                          count: n,
                          nodeSize: nodeSize,
                          gap: gap,
                          fill: fill.value,
                          phase: wave.value,
                        ),
                      ),
                    ),
                    for (var i = 0; i < n; i++)
                      Positioned(
                        left: i * (nodeSize + gap),
                        top: 0,
                        child: _LanguageNode(
                          key: Key(
                            'language-${appLanguages[i].locale.languageCode}',
                          ),
                          language: appLanguages[i],
                          selected:
                              appLanguages[i].locale.languageCode ==
                              current.locale.languageCode,
                          // Each circle appears as the water reaches it.
                          reveal: ((fill.value * (n - 1) - i) / 0.6 + 1).clamp(
                            0.0,
                            1.0,
                          ),
                          ripple: wave.value,
                          onTap: () => onSelect(appLanguages[i]),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageNode extends StatelessWidget {
  const _LanguageNode({
    super.key,
    required this.language,
    required this.selected,
    required this.reveal,
    required this.ripple,
    required this.onTap,
  });

  final AppLanguage language;
  final bool selected;
  final double reveal;
  final double ripple;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const size = _Bubble.nodeSize;
    final scale = Curves.easeOutBack.transform(reveal);
    return Semantics(
      button: true,
      selected: selected,
      label: language.native,
      excludeSemantics: true,
      child: Opacity(
        opacity: reveal,
        child: Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox.square(
              dimension: size,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  if (selected)
                    // Soft ring spreading out like a ripple on water.
                    Container(
                      width: size * (1 + 0.22 * ripple),
                      height: size * (1 + 0.22 * ripple),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.rose.withValues(
                            alpha: 0.45 * (1 - ripple),
                          ),
                          width: 2,
                        ),
                      ),
                    ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    width: size,
                    height: size,
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: selected
                          ? const RadialGradient(
                              center: Alignment(-0.3, -0.4),
                              colors: [AppColors.rose, AppColors.roseDeep],
                            )
                          : null,
                      color: selected ? null : Colors.white,
                      border: Border.all(
                        color: selected ? AppColors.roseDeep : AppColors.rose,
                        width: 1.5,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        language.short,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : AppColors.roseDeep,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws the water: a faint channel through every circle, the flowing wave
/// filled up to [fill], and a droplet travelling from the first circle to the
/// last.
class _WaterFlowPainter extends CustomPainter {
  _WaterFlowPainter({
    required this.count,
    required this.nodeSize,
    required this.gap,
    required this.fill,
    required this.phase,
  });

  final int count;
  final double nodeSize;
  final double gap;
  final double fill;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final cy = size.height / 2;
    final start = nodeSize / 2;
    final end = size.width - nodeSize / 2;
    final length = end - start;

    canvas.drawLine(
      Offset(start, cy),
      Offset(end, cy),
      Paint()
        ..color = AppColors.predicted.withValues(alpha: 0.6)
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round,
    );

    final filledTo = start + length * fill;
    if (filledTo <= start) return;

    final wave = Path()..moveTo(start, cy);
    for (var x = start; x <= filledTo; x += 2) {
      final y = cy + 3 * math.sin((x - start) / 14 - phase * 2 * math.pi);
      wave.lineTo(x, y);
    }
    canvas.drawPath(
      wave,
      Paint()
        ..shader = const LinearGradient(
          colors: [AppColors.rose, AppColors.roseDeep],
        ).createShader(Rect.fromLTRB(start, 0, end, size.height))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    if (fill >= 1) {
      final dx = start + length * phase;
      final dy = cy + 3 * math.sin((dx - start) / 14 - phase * 2 * math.pi);
      canvas.drawCircle(
        Offset(dx, dy),
        3.5,
        Paint()..color = AppColors.roseDeep.withValues(alpha: 0.8),
      );
    }
  }

  @override
  bool shouldRepaint(_WaterFlowPainter old) =>
      old.fill != fill || old.phase != phase;
}

/// Rounded speech bubble with a small tail at the top-right pointing at the
/// language button.
class _BubbleBorder extends ShapeBorder {
  const _BubbleBorder({required this.tailInset});

  static const radius = 22.0;
  static const tailHeight = 9.0;
  static const tailWidth = 18.0;

  final double tailInset;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final body = Rect.fromLTRB(
      rect.left,
      rect.top + tailHeight,
      rect.right,
      rect.bottom,
    );
    final tipX = rect.right - tailInset;
    final tail = Path()
      ..moveTo(tipX - tailWidth / 2, body.top + 2)
      ..quadraticBezierTo(tipX - 3, body.top - 2, tipX, rect.top)
      ..quadraticBezierTo(
        tipX + 3,
        body.top - 2,
        tipX + tailWidth / 2,
        body.top + 2,
      )
      ..close();
    return Path.combine(
      PathOperation.union,
      Path()..addRRect(
        RRect.fromRectAndRadius(body, const Radius.circular(radius)),
      ),
      tail,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    canvas.drawPath(
      getOuterPath(rect),
      Paint()
        ..color = AppColors.line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  ShapeBorder scale(double t) => this;
}
