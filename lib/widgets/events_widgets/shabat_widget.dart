import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ShabatWidget extends StatelessWidget {
  const ShabatWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final bool isHebrewDate = Provider.of<Events>(context).isHebrewDate;

    return Column(
      children: [
        if (data.entryDate != null)
          ListTile(
            title: Text(
              DateFormat('HH:mm').format(data.entryDate!),
            ),
            subtitle: Text(
              appLocalizations.entryAndLightingCandles,
            ),
            trailing: DateWithTimeLeft(date: data.entryDate!, hebrewDate: isHebrewDate ? data.entryHebrewDate : null,),
            leading: const Icon(Icons.fireplace_outlined),
          ),
        if (data.releaseDate != null)
          ListTile(
            title: Text(
              DateFormat('HH:mm').format(data.releaseDate!),
            ),
            subtitle: Text(
              appLocalizations.departureAndHavdalah,
            ),
            trailing: DateWithTimeLeft(date: data.releaseDate!, hebrewDate: isHebrewDate ? data.releaseHebrewDate : null,),
            leading: const Icon(Icons.wine_bar),
          ),
        ListTile(
          title: Text(
            data.parasha!,
          ),
          subtitle: Text(
            appLocalizations.parasha,
          ),
          leading: const Icon(Icons.book_outlined),
        ),
      ],
    );
  }
}
