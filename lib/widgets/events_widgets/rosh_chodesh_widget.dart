import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RoshChodeshWidget extends StatelessWidget {
  const RoshChodeshWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    print(data);
    return Column(
      children: [
        if (data.releaseDate == null && data.entryDate != null)
          dateFix('oe', context)
        else if (data.entryDate != null)
          dateFix('e', context),
        if (data.releaseDate != null) dateFix('r', context),
      ],
    );
  }

  ListTile dateFix(String type, BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final bool isHebrewDate = Provider.of<Events>(context).isHebrewDate;
    var date;
    if (isHebrewDate) {
      date = type == 'oe' || type == 'e'
          ? data.entryHebrewDate
          : data.releaseHebrewDate;
    } else {
      date = type == 'oe' || type == 'e' ? data.entryDate! : data.releaseDate!;
    }
    String subtitle = type == 'oe'
        ? appLocalizations.eventEndDate
        : type == 'e'
            ? appLocalizations.startDate
            : appLocalizations.endDate;
    IconData icon = type == 'oe'
        ? Icons.calendar_month_outlined
        : type == 'e'
            ? Icons.first_page
            : Icons.last_page;
    return ListTile(
      title: isHebrewDate ? date != null ?
      Text(date,) : const CupertinoActivityIndicator(radius: 9,)
      : Text(
        DateFormat('dd/MM/yyyy').format(date),
      ),
      trailing: DateWithTimeLeft(
        date: data.entryDate!,
        isWithDate: false,
        hebrewDate: isHebrewDate ? data.entryHebrewDate : null,
      ),
      subtitle: Text(
        subtitle,
      ),
      leading: Icon(icon),
    );
  }
}
