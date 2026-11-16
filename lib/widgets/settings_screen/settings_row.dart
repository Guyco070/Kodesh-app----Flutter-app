import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// One tappable row of a settings panel: the setting's name at the start,
/// its current value and a chevron at the end. Part of `SettingsScreen`.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.icon,
    this.busy = false,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;
  final IconData? icon;

  /// Shows a small spinner instead of the chevron (e.g. while locating).
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: KodeshPalette.textMuted),
                  const SizedBox(width: 12),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xD9FFFFFF),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  width: 18,
                  child:
                      busy
                          ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: KodeshPalette.textMuted,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
