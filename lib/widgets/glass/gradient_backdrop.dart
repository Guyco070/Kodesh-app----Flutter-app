import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/theme/kodesh_theme.dart';
import 'package:kodesh_app/widgets/glass/gradient_backdrop/drifting_orb.dart';
import 'package:kodesh_app/widgets/glass/gradient_backdrop/star_of_david_painter.dart';

/// The animated background scene behind a screen: a vertical gradient with
/// two slowly drifting glows and a Star of David slowly turning on its
/// diagonal axis.
///
/// Motion stops when the user asked the system to reduce animations.
/// In dark mode a dark veil is laid over the scene.
///
/// Use it through `GlassScaffold`; use it directly only for a full-screen
/// layout that has no scaffold.
class GradientBackdrop extends StatefulWidget {
  const GradientBackdrop({
    super.key,
    required this.backdrop,
    this.followDarkMode = true,
  });

  final KodeshBackdrop backdrop;

  /// False keeps the scene's own colors in dark mode (the splash screen,
  /// which must match the native launch screen).
  final bool followDarkMode;

  @override
  State<GradientBackdrop> createState() => _GradientBackdropState();
}

class _GradientBackdropState extends State<GradientBackdrop>
    with SingleTickerProviderStateMixin {
  // Direction from the star's centre to its upper-right point, as drawn by
  // `StarOfDavidPainter` (centre 50,50 to point 88,26).
  static final double _starAxisAngle = math.atan2(-24, 38);

  // One slow master clock; each glow derives its own phase from it.
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 90),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (reduceMotion) {
      _clock.stop();
    } else if (!_clock.isAnimating) {
      _clock.repeat();
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.backdrop;
    final isDark = widget.followDarkMode && KodeshGlassTheme.isDarkOf(context);

    return ExcludeSemantics(
      child: RepaintBoundary(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: b.colors,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              final orbSize = math.min(w, 520.0) * 0.9;
              return AnimatedBuilder(
                animation: _clock,
                builder: (context, _) {
                  final t = _clock.value * 2 * math.pi;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      DriftingOrb(
                        color: b.orbA,
                        size: orbSize,
                        start: Offset(-orbSize * 0.2, -orbSize * 0.25),
                        drift: const Offset(40, 30),
                        phase: math.sin(t * 6),
                      ),
                      DriftingOrb(
                        color: b.orbB,
                        size: orbSize * 1.1,
                        start: Offset(w - orbSize * 0.75, h * 0.5),
                        drift: const Offset(-50, -20),
                        phase: math.sin(t * 5 + 1),
                      ),
                      if (b.showStar)
                        Positioned(
                          top: h * 0.5 - math.min(w, 460) * 0.55,
                          left: (w - math.min(w, 460)) / 2,
                          width: math.min(w, 460),
                          height: math.min(w, 460),
                          child: Opacity(
                            // Breathes gently while it turns.
                            opacity: 0.17 + 0.05 * math.sin(t * 8),
                            child: Transform.scale(
                              scale: 1 + 0.03 * math.sin(t * 8),
                              // Turns in 3D around the diagonal axis that
                              // joins its upper-right and lower-left points.
                              child: Transform(
                                alignment: Alignment.center,
                                transform:
                                    Matrix4.identity()
                                      ..setEntry(3, 2, 0.0012)
                                      ..rotateZ(_starAxisAngle)
                                      ..rotateX(t * 3)
                                      ..rotateZ(-_starAxisAngle),
                                child: const CustomPaint(
                                  painter: StarOfDavidPainter(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (isDark)
                        const ColoredBox(color: KodeshPalette.darkOverlay),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
