import 'package:flutter/material.dart';

/// A soft radial glow placed at [start] and moved by up to [drift] as
/// [phase] swings between -1 and 1. Part of `GradientBackdrop`.
class DriftingOrb extends StatelessWidget {
  const DriftingOrb({
    super.key,
    required this.color,
    required this.size,
    required this.start,
    required this.drift,
    required this.phase,
  });

  final Color color;
  final double size;
  final Offset start;
  final Offset drift;
  final double phase;

  @override
  Widget build(BuildContext context) {
    if (color.a == 0) return const SizedBox.shrink();
    final p = (phase + 1) / 2;
    return Positioned(
      left: start.dx + drift.dx * p,
      top: start.dy + drift.dy * p,
      width: size,
      height: size,
      child: Transform.scale(
        scale: 1 + 0.1 * p,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, color.withValues(alpha: 0)],
              stops: const [0, 0.7],
            ),
          ),
        ),
      ),
    );
  }
}
