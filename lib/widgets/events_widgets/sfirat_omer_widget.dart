import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/date_with_time_left.dart';
import 'package:provider/provider.dart';

class SfiratOmerWidget extends StatelessWidget {
  const SfiratOmerWidget({super.key, required this.data});
  final Event data;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final bool isHebrewDate = Provider.of<Events>(context).isHebrewDate;
    final langCode =
        Provider.of<LanguageChangeProvider>(context).currentLocale.languageCode;

    return Column(
      children: [
        Text(
          (data as SfiratOmer).sefira['sefira'][langCode == 'he' ? 'he' : 'en'],
          style: TextStyle(color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
          child: FittedBox(
            child: Text(
              '${(data as SfiratOmer).sefira['count'][langCode == 'he' ? 'he' : 'en']}.',
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (data.entryDate != null)
          entryDateFix(appLocalizations, isHebrewDate),
      ],
    );
  }

  ListTile entryDateFix(AppLocalizations appLocalizations, bool isHebrewDate) {
    return ListTile(
      title: Text(DateFormat('dd/MM/yyyy').format(data.entryDate!)),
      trailing: DateWithTimeLeft(
        date: data.entryDate!,
        isWithDate: false,
        hebrewDate: isHebrewDate ? data.entryHebrewDate : null,
      ),
      subtitle: Text(appLocalizations.eventDay),
      leading: const Icon(Icons.event),
    );
  }
}
