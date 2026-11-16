import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// A 48×48 round glass icon button with a tooltip (also its screen-reader
/// label): back buttons, header actions and the prayer text-size controls.
class GlassRoundButton extends StatelessWidget {
  const GlassRoundButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.iconSize = 22,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: iconSize),
      style: IconButton.styleFrom(
        fixedSize: const Size(48, 48),
        foregroundColor: Colors.white,
        disabledForegroundColor: KodeshPalette.textMuted,
        backgroundColor: KodeshPalette.glassFill,
        side: const BorderSide(color: KodeshPalette.glassBorder),
      ),
    );
  }
}
