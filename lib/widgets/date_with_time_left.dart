import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/widgets/time_left.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateWithTimeLeft extends StatelessWidget {
  const DateWithTimeLeft({super.key, required this.date, this.isWithDate = true});
  final DateTime date;
  final bool isWithDate;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if(isWithDate) Text(DateFormat('dd/MM/yyyy').format(date)),
          Text(getDayName(AppLocalizations.of(context)!, date.weekday)),
          TimeLeft(
            date: date,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
