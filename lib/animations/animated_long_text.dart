import 'package:flutter/material.dart';

/// Displays a (potentially long) text that can be collapsed to a single line
/// (with an ellipsis when it overflows) or expanded to show all of it.
///
/// The expanded/collapsed state is controlled by the parent via [expanded].
class AnimatedLongText extends StatelessWidget {
  const AnimatedLongText(this.text, {super.key, required this.expanded});

  final String text;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Text(
        text,
        maxLines: expanded ? null : 1,
        overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }
}
