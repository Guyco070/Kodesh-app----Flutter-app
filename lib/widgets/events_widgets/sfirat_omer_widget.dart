import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';

class SfiratOmerWidget extends StatelessWidget {
  const SfiratOmerWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
         Text(
            (data as SfiratOmer).sefira['sefira'][
                LanguageChangeProvider.getCurrentLocale.languageCode == 'he'
                    ? 'he'
                    : 'en'],
            style: TextStyle(
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
          child: FittedBox(
              child: Text('${(data as SfiratOmer).sefira['count'][
                LanguageChangeProvider.getCurrentLocale.languageCode == 'he'
                    ? 'he'
                    : 'en']}.',
            style: TextStyle(
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          )),
        ),
        if (data.entryDate != null) entryDateFix(appLocalizations),
      ],
    );
  }

  ListTile entryDateFix(AppLocalizations appLocalizations) {
    return ListTile(
      title: Text(
        DateFormat('dd/MM/yyyy').format(data.entryDate!),
      ),
      trailing: DateWithTimeLeft(date: data.entryDate!, isWithDate: false,),
      subtitle: Text(
        appLocalizations.eventDay,
      ),
      leading: const Icon(Icons.event),
    );
  }
}
