import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

/// Renders the begin/end times of a fast day (Tisha B'Av or a minor fast).
///
/// The times are populated asynchronously from zmanim, so while they are still
/// loading (or if they are unavailable, e.g. offline) this falls back to
/// showing the fast date only.
class FastTimesSection extends StatelessWidget {
  const FastTimesSection({
    super.key,
    required this.data,
    required this.isHebrewDate,
  });

  final Holiday data;
  final bool isHebrewDate;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final start = data.fastStart;
    final end = data.fastEnd;

    if (start == null && end == null) {
      return ListTile(
        title: Text(
          (data.entryHebrewDate != null && isHebrewDate)
              ? data.entryHebrewDate!
              : DateFormat('dd/MM/yyyy').format(data.entryDate!),
        ),
        subtitle: Text(appLocalizations.eventDay),
        trailing: DateWithTimeLeft(
          date: data.entryDate!,
          isWithDate: false,
          hebrewDate: isHebrewDate ? data.entryHebrewDate : null,
        ),
        leading: const Icon(Icons.event),
      );
    }

    return Column(
      children: [
        if (start != null)
          ListTile(
            title: Text(DateFormat('HH:mm').format(start)),
            subtitle: Text(appLocalizations.fastBegins),
            trailing: DateWithTimeLeft(
              date: start,
              hebrewDate: isHebrewDate ? data.entryHebrewDate : null,
            ),
            leading: const Icon(Icons.no_food),
          ),
        if (end != null)
          ListTile(
            title: Text(DateFormat('HH:mm').format(end)),
            subtitle: Text(appLocalizations.fastEnds),
            trailing: DateWithTimeLeft(
              date: end,
              hebrewDate: isHebrewDate ? data.entryHebrewDate : null,
            ),
            leading: const Icon(Icons.restaurant),
          ),
      ],
    );
  }
}
