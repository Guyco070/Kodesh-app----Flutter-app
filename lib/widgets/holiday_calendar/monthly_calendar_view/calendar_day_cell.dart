import 'package:flutter/material.dart';
import 'package:kodesh_app/models/hebcal_holiday.dart';
import 'package:kodesh_app/widgets/holiday_calendar/monthly_calendar_view/calendar_holiday_label.dart';

/// One day in the month grid: the day number plus up to two holiday labels.
class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    super.key,
    required this.day,
    required this.holidays,
    required this.languageCode,
    required this.isToday,
    required this.dayFontSize,
    required this.labelFontSize,
    this.onTap,
  });

  static const int maxVisibleLabels = 2;

  final int day;
  final List<HebcalHoliday> holidays;
  final String languageCode;
  final bool isToday;
  final double dayFontSize;
  final double labelFontSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasHolidays = holidays.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Material(
        color:
            isToday
                ? colorScheme.primaryContainer
                : hasHolidays
                ? colorScheme.surfaceContainerHighest.withAlpha(110)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3, 4, 3, 3),
            child: Column(
              children: [
                Text(
                  '$day',
                  style: TextStyle(
                    fontSize: dayFontSize,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                    color:
                        isToday
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                ...holidays
                    .take(maxVisibleLabels)
                    .map(
                      (h) => CalendarHolidayLabel(
                        text: h.displayName(languageCode),
                        isMajor: h.isMajor,
                        fontSize: labelFontSize,
                      ),
                    ),
                if (holidays.length > maxVisibleLabels)
                  Text(
                    '+${holidays.length - maxVisibleLabels}',
                    style: TextStyle(
                      fontSize: labelFontSize,
                      color: colorScheme.onSurface.withAlpha(160),
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
