import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HolidayWidget extends StatelessWidget {
  const HolidayWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isHebrewDate = Provider.of<Events>(context).isHebrewDate;

    return Column(
      children: [
        if (data.entryDate != null) entryDateFix(appLocalizations, isHebrewDate),
        if (data.releaseDate != null)
          ListTile(
            title: Text(DateFormat('HH:mm').format(data.releaseDate!),),
            subtitle: Text(
              appLocalizations.departureAndHavdalah,
            ),
            trailing: DateWithTimeLeft(date: data.releaseDate!, hebrewDate: data.releaseHebrewDate,),
            leading: const Icon(Icons.wine_bar),
          ),
      ],
    );
  }

  ListTile entryDateFix(AppLocalizations appLocalizations, bool isHebrewDate) {
    String time = DateFormat('HH:mm').format(data.entryDate!);
    if (time == '00:00') {
      return ListTile(
        title: 
            Text((data.entryHebrewDate != null && isHebrewDate) ?
               data.entryHebrewDate!:
               DateFormat('dd/MM/yyyy').format(data.entryDate!),
              ),
 
        trailing: DateWithTimeLeft(
          date: data.entryDate!,
          isWithDate: false,
          hebrewDate: isHebrewDate ? data.entryHebrewDate : null,
        ),
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
      trailing: DateWithTimeLeft(date: data.entryDate!, hebrewDate: isHebrewDate ? data.entryHebrewDate : null,),
      leading: const Icon(Icons.fireplace_outlined),
    );
  }
}
