import 'package:flutter/material.dart';

/// One half of the events / zmanim switch. Exposed to assistive technology
/// as a selectable item in a mutually exclusive group, so screen readers
/// announce which view is active instead of reporting a disabled button.
class ViewTypeTab extends StatelessWidget {
  const ViewTypeTab({
    super.key,
    required this.label,
    required this.selected,
    required this.roundedStart,
    required this.onSelected,
  });

  final String label;
  final bool selected;

  /// Whether the rounded corner is on the start (leading) side.
  final bool roundedStart;
  final VoidCallback onSelected;

  static const Color _selectedColor = Color(0xFF003080);
  static const Color _unselectedColor = Color(0xFF1565C0);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(50);
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topStart: roundedStart ? radius : Radius.zero,
                topEnd: roundedStart ? Radius.zero : radius,
              ),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            selected ? _selectedColor : _unselectedColor,
          ),
        ),
        onPressed: selected ? () {} : onSelected,
        child: FittedBox(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
