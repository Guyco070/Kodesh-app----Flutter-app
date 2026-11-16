import 'package:flutter/material.dart';

/// Brand colors of the "liquid glass" design (Kodesh Modern UI canvas).
///
/// Content is always drawn in white on a dark gradient, in both light and
/// dark mode. Dark mode only darkens the gradient with [darkOverlay].
abstract final class KodeshPalette {
  static const Color logoBlue = Color(0xFF0B2C70);
  static const Color splashBlue = Color(0xFF294C85);
  static const Color flagBlue = Color(0xFF0038B8);
  static const Color silver = Color(0xFF9AA5B6);
  static const Color flame = Color(0xFFFFD58A);
  static const Color flameDeep = Color(0xFFFFA94D);
  static const Color flameLight = Color(0xFFFFF3B0);
  static const Color sentenceBlue = Color(0xFFA9CCFF);
  static const Color switchOn = Color(0xFF34C759);

  /// Translucent white fills used by glass surfaces.
  static const Color glassFill = Color(0x29FFFFFF); // 16%
  static const Color glassFillStrong = Color(0x47FFFFFF); // 28%
  static const Color glassBorder = Color(0x59FFFFFF); // 35%
  static const Color glassHighlight = Color(0x80FFFFFF); // 50%
  static const Color hairline = Color(0x29FFFFFF); // 16%

  /// Secondary text on glass (white at ~80%).
  static const Color textMuted = Color(0xCCFFFFFF);

  /// Laid over every gradient in dark mode.
  static const Color darkOverlay = Color(0x94020512); // rgba(2,5,18,.58)

  /// Solid surfaces for menus, dialogs, sheets and the drawer.
  static const Color navySurface = Color(0xFF14295E);
  static const Color navySurfaceDark = Color(0xFF0C1532);
}

/// The background scene of a screen. Each area of the app has its own mood,
/// as in the design: blue for home, sky for times, green for reminders,
/// indigo for prayers, amber for the Omer, graphite for settings, sunset for the web pages.
enum KodeshBackdrop {
  splash(
    colors: [Color(0xFF35568F), Color(0xFF16397D), Color(0xFF0B2C70)],
    orbA: Color(0x8C82AAFF),
    orbB: Color(0x47FFD58A),
    // Must match the native launch screen, which has no star.
    showStar: false,
  ),
  home(
    colors: [Color(0xFF0B2C70), Color(0xFF0A3FA8), Color(0xFF3F7BE0)],
    orbA: Color(0x8CFFFFFF),
    orbB: Color(0xB378AAFF),
  ),
  zmanim(
    colors: [Color(0xFF0F2A55), Color(0xFF2F6FB5), Color(0xFF9FD0F2)],
    orbA: Color(0xFFFFF0A8),
    orbB: Color(0xFF5FD1FF),
  ),
  reminders(
    colors: [Color(0xFF10241F), Color(0xFF1F5A50), Color(0xFF7BB89A)],
    orbA: Color(0xFF3EE6B0),
    orbB: Color(0xFFFFE29A),
  ),
  prayers(
    colors: [Color(0xFF141A3D), Color(0xFF2B2F72), Color(0xFF6A5BB0)],
    orbA: Color(0xFFFFD58A),
    orbB: Color(0xFF8F7BFF),
  ),
  prayerText(
    colors: [Color(0xFF1B1740), Color(0xFF2D2358), Color(0xFF5B3A74)],
    orbA: Color(0xFFFFB86B),
    orbB: Color(0x00000000),
  ),
  omer(
    colors: [Color(0xFF2A1A0E), Color(0xFF7A4A1F), Color(0xFFE8A951)],
    orbA: Color(0xFFFFF0A8),
    orbB: Color(0xFFFF9B54),
  ),
  compass(
    colors: [Color(0xFF06141F), Color(0xFF0B3A4A), Color(0xFF1C7F84)],
    orbA: Color(0x00000000),
    orbB: Color(0xFF2EE6D0),
  ),
  settings(
    colors: [Color(0xFF1D1D24), Color(0xFF3A3A52), Color(0xFF6D6A8F)],
    orbA: Color(0x00000000),
    orbB: Color(0xFF8F7BFF),
  ),
  sunset(
    colors: [
      Color(0xFF0B2C70),
      Color(0xFF1C3B86),
      Color(0xFF4A2F78),
      Color(0xFF9A4570),
    ],
    orbA: Color(0x8C82AAFF),
    orbB: Color(0xFFFFB86B),
  );

  const KodeshBackdrop({
    required this.colors,
    required this.orbA,
    required this.orbB,
    this.showStar = true,
  });

  /// Gradient stops from top to bottom.
  final List<Color> colors;

  /// Soft glow drifting near the top start corner.
  final Color orbA;

  /// Soft glow drifting near the bottom end corner.
  final Color orbB;

  /// Whether a slowly turning Star of David outline sits behind the content
  /// (every screen but the splash).
  final bool showStar;
}
