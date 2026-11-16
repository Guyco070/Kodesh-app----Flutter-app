import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';

/// A titled glass panel of settings. [children] are separated by hairlines.
/// With [framed] false the children sit directly under the title, for
/// controls that are already glass themselves (e.g. a segmented choice).
/// Part of `SettingsScreen`.
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
    this.framed = true,
  });

  final String title;
  final List<Widget> children;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 18, bottom: 8),
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: KodeshPalette.textMuted,
              ),
            ),
          ),
        ),
        if (framed)
          GlassPanel(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  if (i > 0) const Divider(height: 1),
                  children[i],
                ],
              ],
            ),
          )
        else
          ...children,
      ],
    );
  }
}
