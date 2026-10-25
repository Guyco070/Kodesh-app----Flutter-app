import 'package:flutter/material.dart';

/// On/off display option in the settings bar. A chip with a fixed label and
/// a visible checked state replaces the previous grey text buttons, which
/// failed contrast requirements and did not tell screen readers whether the
/// option was on.
class SettingsFilterChip extends StatelessWidget {
  const SettingsFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onToggle,
  });

  final String label;
  final bool selected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label, overflow: TextOverflow.ellipsis),
      selected: selected,
      onSelected: (_) => onToggle(),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      labelStyle: Theme.of(context).textTheme.labelMedium,
    );
  }
}
