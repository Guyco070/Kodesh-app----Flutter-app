import 'package:flutter/material.dart';

/// Month title with previous/next buttons. The chevrons mirror automatically
/// in RTL, so "previous" always points toward the start of the line.
class CalendarMonthHeader extends StatelessWidget {
  const CalendarMonthHeader({
    super.key,
    required this.title,
    required this.onPrev,
    required this.onNext,
  });

  final String title;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final materialL10n = MaterialLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            tooltip: materialL10n.previousMonthTooltip,
            onPressed: onPrev,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            tooltip: materialL10n.nextMonthTooltip,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
