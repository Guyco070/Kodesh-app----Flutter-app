import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateWithTimeLeft extends StatelessWidget {
  const DateWithTimeLeft({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat('dd/MM/yyyy').format(date)),
        TimeLeft(date: date),
      ],
    );
  }
}

class TimeLeft extends StatelessWidget {
  const TimeLeft({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    
    int timeLeft = DateTime.now().difference(DateTime(date.year, date.month, date.day)).inDays;
    String text;
    if(DateFormat('dd/MM/yy').format(DateTime.now()) == DateFormat('dd/MM/yy').format(date)){
      text = 'היום';
    }
    else if (timeLeft == 0){
      text = appLocalizations.tomorrow;
    } else if(timeLeft.toString().contains('-')) {
      // text = 'בעוד ${(timeLeft - 1).toString().replaceFirst('-', '')} ימים';
      text = appLocalizations.inXDays((timeLeft - 1).toString().replaceFirst('-', ''));
    } else {
      // text = 'לפני ${(timeLeft + 1).toString()} ימים';
      text = appLocalizations.xDaysAgo((timeLeft + 1).toString());
    }
    return Text(
      text,
      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
    );
  }
}
