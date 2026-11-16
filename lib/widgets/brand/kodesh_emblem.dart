import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

/// The Kodesh symbol: two Shabbat candles in turned candlesticks, a challah
/// and a kiddush cup in silver, with gently flickering flames.
///
/// The silver drawing is `assets/brand/emblem_body.png`, rendered from
/// `assets/brand/emblem_source.svg` (the same drawing as the app icon and
/// launch screen); only the flames are painted here, so they can move.
///
/// Used on the splash screen, the drawer header and the About page. The
/// flames hold still when the system asks to reduce motion or when
/// [animate] is false.
class KodeshEmblem extends StatefulWidget {
  const KodeshEmblem({
    super.key,
    this.width = 150,
    this.animate = true,
    this.excludeFromSemantics = false,
  });

  final double width;
  final bool animate;

  /// Set when a visible "KODESH" wordmark already names the symbol.
  final bool excludeFromSemantics;

  /// Width / height of the drawing (the SVG viewBox is 780 × 700).
  static const double aspectRatio = 780 / 700;

  @override
  State<KodeshEmblem> createState() => _KodeshEmblemState();
}

class _KodeshEmblemState extends State<KodeshEmblem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flicker = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(KodeshEmblem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  void _syncAnimation() {
    final still = !widget.animate || MediaQuery.of(context).disableAnimations;
    if (still) {
      _flicker.stop();
    } else if (!_flicker.isAnimating) {
      _flicker.repeat();
    }
  }

  @override
  void dispose() {
    _flicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawing = SizedBox(
      width: widget.width,
      height: widget.width / KodeshEmblem.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/brand/emblem_body.png',
            fit: BoxFit.fill,
            filterQuality: FilterQuality.medium,
            excludeFromSemantics: true,
          ),
          RepaintBoundary(
            child: CustomPaint(painter: _FlamesPainter(_flicker)),
          ),
        ],
      ),
    );
    if (widget.excludeFromSemantics) return ExcludeSemantics(child: drawing);
    return Semantics(
      image: true,
      label: AppLocalizations.of(context)!.kodeshEmblemLabel,
      child: drawing,
    );
  }
}

/// One flicker pose: horizontal/vertical scale, rotation and skew (degrees).
typedef _Pose = ({double t, double sx, double sy, double rot, double skew});

/// Paints the two candle flames over the silver drawing, in the SVG's
/// coordinates (viewBox origin 40,60, size 780 × 700).
class _FlamesPainter extends CustomPainter {
  _FlamesPainter(this.flicker) : super(repaint: flicker);

  final Animation<double> flicker;

  static const List<_Pose> _poses = [
    (t: 0, sx: 1, sy: 1, rot: -2, skew: 0),
    (t: .18, sx: .93, sy: 1.1, rot: 2, skew: 4),
    (t: .38, sx: 1.05, sy: .94, rot: -3, skew: -3),
    (t: .58, sx: .96, sy: 1.12, rot: 1, skew: 3),
    (t: .78, sx: 1.04, sy: .96, rot: -1, skew: -4),
    (t: 1, sx: 1, sy: 1, rot: -2, skew: 0),
  ];

  static _Pose _poseAt(double t) {
    for (var i = 0; i < _poses.length - 1; i++) {
      final a = _poses[i], b = _poses[i + 1];
      if (t <= b.t) {
        final k = Curves.easeInOut.transform((t - a.t) / (b.t - a.t));
        double lerp(double x, double y) => x + (y - x) * k;
        return (
          t: t,
          sx: lerp(a.sx, b.sx),
          sy: lerp(a.sy, b.sy),
          rot: lerp(a.rot, b.rot),
          skew: lerp(a.skew, b.skew),
        );
      }
    }
    return _poses.last;
  }

  static const _flame = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFFFF8F3A),
      Color(0xFFFFA445),
      Color(0xFFFFBF5C),
      Color(0xFFFFDD8C),
      Color(0xFFFFF3B0),
    ],
    stops: [0, .25, .5, .75, 1],
  );

  static const double _flameTop = 82;
  static const double _flameBottom = 156;

  Path _flamePath(double cx) =>
      Path()
        ..moveTo(cx, _flameTop)
        ..cubicTo(cx + 22, 108, cx + 26, 130, cx, _flameBottom)
        ..cubicTo(cx - 26, 130, cx - 22, 108, cx, _flameTop)
        ..close();

  Path _corePath(double cx) =>
      Path()
        ..moveTo(cx, 118)
        ..cubicTo(cx + 8, 128, cx + 9, 138, cx, 148)
        ..cubicTo(cx - 9, 138, cx - 8, 128, cx, 118)
        ..close();

  void _paintFlame(Canvas canvas, double cx, double phase) {
    final pose = _poseAt((flicker.value + phase) % 1);

    // Warm halo; it breathes with the flame's height.
    final halo = Rect.fromCenter(
      center: Offset(cx, 128),
      width: 88,
      height: 112 * pose.sy,
    );
    canvas.drawOval(
      halo,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0x8CFFB24D), Color(0x00FFB24D)],
        ).createShader(halo),
    );

    final path = _flamePath(cx);
    canvas.save();
    // Flicker around the bottom center of the flame, as in the design.
    canvas.translate(cx, _flameBottom);
    canvas.rotate(pose.rot * math.pi / 180);
    canvas.transform(
      (Matrix4.identity()
            ..setEntry(0, 1, math.tan(pose.skew * math.pi / 180))
            ..scaleByDouble(pose.sx, pose.sy, 1, 1))
          .storage,
    );
    canvas.translate(-cx, -_flameBottom);
    canvas.drawPath(
      path,
      Paint()..shader = _flame.createShader(path.getBounds()),
    );
    canvas.drawPath(_corePath(cx), Paint()..color = const Color(0xD9FFFBE6));
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 780, size.height / 700);
    canvas.translate(-40, -60);
    _paintFlame(canvas, 135, 0);
    // The second flame runs 1.2 s behind the first.
    _paintFlame(canvas, 264, 1.2 / 1.7);
  }

  @override
  bool shouldRepaint(_FlamesPainter oldDelegate) => false;
}
