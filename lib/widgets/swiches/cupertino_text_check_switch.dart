import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// A settings row: a label with an iOS-style switch at its end. The whole
/// row is tappable and is read as one switch by screen readers.
///
/// With [icon] it gets the tinted icon badge of the design's reminder rows,
/// and [subtitle] adds a short muted line under the label.
class CuperinoTextCheckSwitch extends StatelessWidget {
  const CuperinoTextCheckSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
    this.subtitle,
    this.icon,
    this.iconColor = const Color(0xFF9EC5FF),
  });

  final bool value;
  final Function onChanged;
  final String text;
  final String? subtitle;
  final IconData? icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: InkWell(
        onTap: () => onChanged(),
        // The switch animation is the feedback; a ripple would not fit the
        // rounded card around the row.
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Row(
            children: [
              if (icon != null) ...[
                ExcludeSemantics(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(icon, size: 21, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: KodeshPalette.textMuted,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              CupertinoSwitch(
                activeTrackColor: KodeshPalette.switchOn,
                value: value,
                onChanged: (_) => onChanged(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
