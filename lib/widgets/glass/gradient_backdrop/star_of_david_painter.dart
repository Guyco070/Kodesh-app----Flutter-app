import 'package:flutter/material.dart';

/// Outline of a Star of David (two overlapping triangles), drawn in white.
/// Decorative background element of `GradientBackdrop` on the home screen.
class StarOfDavidPainter extends CustomPainter {
  const StarOfDavidPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide / 100;
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6 * s
          ..strokeJoin = StrokeJoin.round;
    final up =
        Path()
          ..moveTo(50 * s, 8 * s)
          ..lineTo(88 * s, 74 * s)
          ..lineTo(12 * s, 74 * s)
          ..close();
    final down =
        Path()
          ..moveTo(50 * s, 92 * s)
          ..lineTo(12 * s, 26 * s)
          ..lineTo(88 * s, 26 * s)
          ..close();
    canvas.drawPath(up, paint);
    canvas.drawPath(down, paint);
  }

  @override
  bool shouldRepaint(covariant StarOfDavidPainter oldDelegate) => false;
}
