import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_fonts.dart';

/// The "KODESH" wordmark in spaced silver serif capitals.
///
/// [shimmer] makes a slow light sweep across the letters (splash screen
/// only); it holds still when the system asks to reduce motion.
class KodeshWordmark extends StatefulWidget {
  const KodeshWordmark({super.key, this.fontSize = 58, this.shimmer = false});

  final double fontSize;
  final bool shimmer;

  @override
  State<KodeshWordmark> createState() => _KodeshWordmarkState();
}

class _KodeshWordmarkState extends State<KodeshWordmark>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  static const _colors = [
    Color(0xFFAAB4C4),
    Color(0xFFF6F9FD),
    Color(0xFF9AA5B6),
    Color(0xFFF6F9FD),
    Color(0xFFAAB4C4),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.shimmer && !MediaQuery.of(context).disableAnimations) {
      if (!_sweep.isAnimating) _sweep.repeat();
    } else {
      _sweep.stop();
    }
  }

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final letterSpacing = widget.fontSize * 0.14;
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _sweep,
        builder:
            (context, child) => ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                // Slide a gradient three times the text width across it.
                final shift = (2 - 3 * _sweep.value) * bounds.width;
                return LinearGradient(
                  colors: _colors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(
                  Rect.fromLTWH(
                    widget.shimmer ? shift - bounds.width : 0,
                    0,
                    widget.shimmer ? bounds.width * 3 : bounds.width,
                    bounds.height,
                  ),
                );
              },
              child: child,
            ),
        child: Padding(
          // Letter spacing also trails the last letter; balance it.
          padding: EdgeInsets.only(left: letterSpacing),
          child: Text(
            'KODESH',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontFamily: KodeshFonts.wordmark,
              fontWeight: FontWeight.w600,
              fontSize: widget.fontSize,
              letterSpacing: letterSpacing,
              height: 1,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
