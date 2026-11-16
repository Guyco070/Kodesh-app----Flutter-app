import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Circular progress ring with a centered caption, used by
/// `ShabbatHeroCard` for the time left until candle lighting / havdalah.
class CountdownRing extends StatelessWidget {
  const CountdownRing({
    super.key,
    required this.progress,
    required this.center,
    this.size = 132,
    this.color = Colors.white,
  });

  /// 0..1, how much of the ring is lit.
  final double progress;
  final Widget center;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(progress: progress.clamp(0, 1), color: color),
        child: Center(
          child: Padding(padding: const EdgeInsets.all(16), child: center),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 9.0;
    final rect = Offset.zero & size;
    final ring = rect.deflate(stroke / 2);
    final track =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.22)
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke;
    final lit =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = stroke;
    canvas.drawArc(ring, 0, 2 * math.pi, false, track);
    canvas.drawArc(ring, -math.pi / 2, 2 * math.pi * progress, false, lit);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.color != color;
}
