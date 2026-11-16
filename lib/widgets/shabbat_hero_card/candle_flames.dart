import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// Two small flickering candle flames. Decorative; part of
/// `ShabbatHeroCard`. Holds still when the system asks to reduce motion.
class CandleFlames extends StatefulWidget {
  const CandleFlames({super.key});

  @override
  State<CandleFlames> createState() => _CandleFlamesState();
}

class _CandleFlamesState extends State<CandleFlames>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final t = _c.value * 2 * math.pi;
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Flame(height: 24, t: t),
              const SizedBox(width: 6),
              _Flame(height: 28, t: t + 2.1),
            ],
          );
        },
      ),
    );
  }
}

class _Flame extends StatelessWidget {
  const _Flame({required this.height, required this.t});

  final double height;
  final double t;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.bottomCenter,
      transform:
          Matrix4.identity()
            ..scaleByDouble(
              1 - 0.05 * math.sin(t * 2),
              1 + 0.08 * math.sin(t * 3),
              1,
              1,
            )
            ..rotateZ(0.04 * math.sin(t)),
      child: Container(
        width: 10,
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.elliptical(5, 16),
            bottom: Radius.elliptical(5, 8),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [KodeshPalette.flameLight, KodeshPalette.flameDeep],
          ),
          boxShadow: [BoxShadow(color: Color(0xE6FFAA46), blurRadius: 8)],
        ),
      ),
    );
  }
}
