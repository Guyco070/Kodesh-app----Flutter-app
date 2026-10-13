import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/hebcal_holiday.dart';

/// Bottom sheet listing every holiday on a tapped day, with full names.
class HolidayDaySheet extends StatelessWidget {
  const HolidayDaySheet({
    super.key,
    required this.date,
    required this.holidays,
  });

  final DateTime date;
  final List<HebcalHoliday> holidays;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMEEEEd(locale.toLanguageTag()).format(date),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...holidays.map(
              (h) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.star_rounded,
                  color: h.isMajor ? colorScheme.primary : colorScheme.outline,
                ),
                title: Text(h.displayName(locale.languageCode)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
