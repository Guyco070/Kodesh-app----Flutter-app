import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';

/// A glass card grouping the rows of one settings section. Spacing between
/// cards is left to the parent.
class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
