import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Localized weekday headers, Sunday first (e.g. "Sun"/"יום א׳"/"dom").
class CalendarWeekdayRow extends StatelessWidget {
  const CalendarWeekdayRow({super.key, required this.localeTag});

  final String localeTag;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final format = DateFormat.E(localeTag);
    // 2023-01-01 was a Sunday; take the seven days that follow it.
    final sunday = DateTime(2023, 1, 1);

    return Row(
      children: List.generate(7, (i) {
        final isShabbat = i == 6;
        return Expanded(
          child: Center(
            child: Text(
              format.format(sunday.add(Duration(days: i))),
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color:
                    isShabbat
                        ? colorScheme.primary
                        : colorScheme.onSurface.withAlpha(170),
              ),
            ),
          ),
        );
      }),
    );
  }
}
