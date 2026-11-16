import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';

/// A small glass tile on the home screen: a tinted icon over a short label
/// and a bold value (e.g. "Sunset today · 16:38"). Part of `EventScreen`.
class HomeStatTile extends StatelessWidget {
  const HomeStatTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 26, color: iconColor),
          const SizedBox(height: 18),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: KodeshPalette.textMuted,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              value,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.2,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
    return MergeSemantics(
      child: GlassPanel(
        padding: EdgeInsets.zero,
        child: onTap == null ? content : InkWell(onTap: onTap, child: content),
      ),
    );
  }
}
