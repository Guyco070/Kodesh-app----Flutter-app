import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// A tappable glass pill with an icon and a one-line label that shrinks
/// instead of overflowing. Part of `SettingsBar` (city and date buttons).
class GlassPillButton extends StatelessWidget {
  const GlassPillButton({
    super.key,
    required this.icon,
    required this.label,
    required this.semanticLabel,
    required this.onTap,
    this.trailingIcon,
  });

  final IconData icon;
  final String label;

  /// What the button is for, read before [label] by screen readers.
  final String semanticLabel;
  final VoidCallback onTap;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      value: label,
      excludeSemantics: true,
      onTap: onTap,
      child: Material(
        color: KodeshPalette.glassFillStrong,
        shape: const StadiumBorder(
          side: BorderSide(color: KodeshPalette.glassBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(14, 6, 12, 6),
              child: Row(
                children: [
                  Icon(icon, size: 19, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 4),
                    Icon(trailingIcon, size: 20, color: Colors.white),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
