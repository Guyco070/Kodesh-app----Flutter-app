import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/theme/kodesh_fonts.dart';

/// The painted compass face of the design: a round glass dial whose
/// cardinal letters turn with the device [heading], and a teal needle with
/// a Star of David badge pointing at [target] (both in degrees from north).
///
/// Without a [target] the needle points north. Decorative for screen
/// readers; the screen states the direction in text.
class CompassDial extends StatelessWidget {
  const CompassDial({
    super.key,
    required this.size,
    required this.heading,
    this.target,
  });

  final double size;
  final double heading;
  final double? target;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0x4DFFFFFF), Color(0x14FFFFFF)],
                ),
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0x66FFFFFF)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x80001E2D),
                    blurRadius: 60,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
            ),
            CustomPaint(
              painter: _DialPainter(
                heading: heading,
                letters: (
                  n: l.compassNorth,
                  e: l.compassEast,
                  s: l.compassSouth,
                  w: l.compassWest,
                ),
                textDirection: Directionality.of(context),
              ),
            ),
            Transform.rotate(
              angle: ((target ?? 0) - heading) * math.pi / 180,
              child: CustomPaint(painter: _NeedlePainter()),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  _DialPainter({
    required this.heading,
    required this.letters,
    required this.textDirection,
  });

  final double heading;
  final ({String n, String e, String s, String w}) letters;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(-heading * math.pi / 180);

    final tick =
        Paint()
          ..color = const Color(0x73FFFFFF)
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;
    final minor =
        Paint()
          ..color = const Color(0x33FFFFFF)
          ..strokeWidth = 1.2
          ..strokeCap = StrokeCap.round;
    for (var deg = 0; deg < 360; deg += 15) {
      final a = deg * math.pi / 180;
      final major = deg % 90 == 0;
      final outer = r - r * 0.045;
      final inner = outer - (major ? r * 0.1 : r * 0.05);
      final dir = Offset(math.sin(a), -math.cos(a));
      canvas.drawLine(dir * inner, dir * outer, major ? tick : minor);
    }

    void letter(String text, double deg, {bool strong = false}) {
      final a = deg * math.pi / 180;
      final pos = Offset(math.sin(a), -math.cos(a)) * (r * 0.7);
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            // A painter has no inherited text style, so name the font.
            fontFamily: KodeshFonts.ui,
            fontSize: r * (strong ? 0.11 : 0.097),
            fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
            color: strong ? Colors.white : const Color(0xB3FFFFFF),
          ),
        ),
        textDirection: textDirection,
      )..layout();
      // Keep letters upright while the dial turns.
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(heading * math.pi / 180);
      painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));
      canvas.restore();
      painter.dispose();
    }

    letter(letters.n, 0, strong: true);
    letter(letters.e, 90);
    letter(letters.s, 180);
    letter(letters.w, 270);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DialPainter old) =>
      old.heading != heading || old.letters != letters;
}

/// Needle drawn pointing up; the widget rotates it to the target.
class _NeedlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 290; // Design units.
    final cx = size.width / 2;
    final cy = size.height / 2;

    // A faceted rhombus like the original needle: each half is split down
    // the middle into a lit and a shaded side, which gives it depth.
    const half = 16.0;
    final tipTop = Offset(cx, 40 * s);
    final tipBottom = Offset(cx, size.height - 40 * s);
    final left = Offset(cx - half * s, cy);
    final right = Offset(cx + half * s, cy);
    final center = Offset(cx, cy);

    void facet(List<Offset> points, Color color) {
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final point in points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path..close(), Paint()..color = color);
    }

    facet([tipTop, left, center], const Color(0xFF5CF2E0));
    facet([tipTop, center, right], const Color(0xFF16A99A));
    facet([tipBottom, center, left], const Color(0xFFE9EEF8));
    facet([tipBottom, right, center], const Color(0xFF9AA9C6));

    // Pivot: a white cap with a dark ring and a small bright centre.
    canvas.drawCircle(center, 9 * s, Paint()..color = const Color(0xFF0B2C70));
    canvas.drawCircle(center, 7 * s, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      2.6 * s,
      Paint()..color = const Color(0xFF2EE6D0),
    );

    // Star of David badge at the tip.
    final badge = Offset(cx, 20 * s);
    canvas.drawCircle(badge, 13 * s, Paint()..color = const Color(0xFFFFD58A));
    canvas.drawCircle(
      badge,
      13 * s,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2 * s
        ..color = Colors.white,
    );
    final star =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6 * s
          ..strokeJoin = StrokeJoin.round
          ..color = const Color(0xFF0B2C70);
    Path triangle(double flip) =>
        Path()
          ..moveTo(badge.dx, badge.dy - 7.5 * s * flip)
          ..lineTo(badge.dx + 6.5 * s, badge.dy + 3.7 * s * flip)
          ..lineTo(badge.dx - 6.5 * s, badge.dy + 3.7 * s * flip)
          ..close();
    canvas.drawPath(triangle(1), star);
    canvas.drawPath(triangle(-1), star);
  }

  @override
  bool shouldRepaint(_NeedlePainter old) => false;
}
