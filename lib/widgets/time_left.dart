import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class TimeLeft extends StatelessWidget {
  const TimeLeft({
    Key? key,
    required this.date,
    this.fontSize,
  }) : super(key: key);

  final DateTime date;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    int timeLeft = DateTime.now()
        .difference(DateTime(date.year, date.month, date.day))
        .inDays;
    String text;
    if (timeLeft == 1) {
      text = appLocalizations.yesterday;
    } else if (DateFormat('dd/MM/yy').format(DateTime.now()) ==
        DateFormat('dd/MM/yy').format(date)) {
      text = appLocalizations.today;
    } else if (timeLeft == 0) {
      text = appLocalizations.tomorrow;
    } else if (timeLeft.toString().contains('-')) {
      text = appLocalizations
          .inXDays((timeLeft - 1).toString().replaceFirst('-', ''));
    } else {
      text = appLocalizations.xDaysAgo(timeLeft.toString());
    }
    return Text(
      text,
      style: TextStyle(color: Colors.grey.shade600, fontSize: fontSize ?? 12),
    );
  }
}
