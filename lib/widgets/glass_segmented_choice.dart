import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// A "pick one" control drawn as a glass track with a lit pill on the
/// selected option (nusach, language, view type...).
///
/// The selected option stays focusable and is announced as selected; it is
/// never a disabled button.
class GlassSegmentedChoice<T> extends StatelessWidget {
  const GlassSegmentedChoice({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.semanticLabel,
  });

  /// Value → visible label, in display order.
  final Map<T, String> options;
  final T selected;
  final ValueChanged<T> onSelected;

  /// Name of the whole group for screen readers.
  final String? semanticLabel;

  static const double _fontSize = 14;
  static const double _minFontSize = 11;
  static const double _segmentPadding = 16;

  /// One font size for every label, so the segments look alike: the
  /// largest size (up to 14) at which the longest label fits on one line,
  /// but not below 11 — below that, labels wrap to two lines instead.
  double _sharedFontSize(BuildContext context, double trackWidth) {
    if (!trackWidth.isFinite || options.isEmpty) return _fontSize;
    final available = trackWidth / options.length - _segmentPadding;
    var widest = 0.0;
    for (final label in options.values) {
      final painter = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: Directionality.of(context),
        textScaler: MediaQuery.textScalerOf(context),
        maxLines: 1,
      )..layout();
      if (painter.width > widest) widest = painter.width;
      painter.dispose();
    }
    if (widest <= available) return _fontSize;
    final fitted = _fontSize * available / widest;
    return fitted < _minFontSize ? _fontSize : fitted;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: ShapeDecoration(
          color: KodeshPalette.glassFill,
          shape: const StadiumBorder(
            side: BorderSide(color: KodeshPalette.glassBorder),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fontSize = _sharedFontSize(context, constraints.maxWidth);
            return Row(
              children: [
                for (final entry in options.entries)
                  Expanded(
                    child: _Segment(
                      label: entry.value,
                      fontSize: fontSize,
                      isSelected: entry.key == selected,
                      onTap: () => onSelected(entry.key),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.fontSize,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final double fontSize;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      inMutuallyExclusiveGroup: true,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            constraints: const BoxConstraints(minHeight: 44),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: isSelected ? KodeshPalette.glassFillStrong : null,
              shadows:
                  isSelected
                      ? const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ]
                      : null,
            ),
            child: Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
