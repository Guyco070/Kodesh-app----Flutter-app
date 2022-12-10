import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HolidayWidget extends StatelessWidget {
  const HolidayWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (data.entryDate != null) entryDateFix(appLocalizations),
        if (data.releaseDate != null)
          ListTile(
            title: Text(
              DateFormat('HH:mm').format(data.releaseDate!),
            ),
            subtitle: Text(
              appLocalizations.departureAndHavdalah,
            ),
            leading: Text(DateFormat('dd/MM/yyyy').format(data.releaseDate!)),
            trailing: const Icon(Icons.wine_bar),
          ),
      ],
    );
  }

  ListTile entryDateFix(AppLocalizations appLocalizations) {
    
    String time = DateFormat('HH:mm').format(data.entryDate!);
    if (time == '00:00') {
      return ListTile(
        title: Text(DateFormat('dd/MM/yyyy').format(data.entryDate!),
        textAlign: TextAlign.right,
      ),
      trailing: TimeLeft(date: data.entryDate!),
      subtitle: Text(
        appLocalizations.eventDay,
      ),
      leading: const Icon(Icons.event),
    );
    }
    return ListTile(
      title: Text(
        time,
      ),
      subtitle: Text(
        appLocalizations.entryAndLightingCandles,
      ),
      trailing: TimeLeft(date: data.entryDate!),
      leading: const Icon(Icons.fireplace_outlined),
    );
  }
}
