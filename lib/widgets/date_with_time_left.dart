import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/time_left.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DateWithTimeLeft extends StatelessWidget {
  const DateWithTimeLeft({super.key, required this.date, this.isWithDate = true, this.hebrewDate});
  final DateTime date;
  final bool isWithDate;
  final String? hebrewDate;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 150,
            height: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: ((child, animation) =>
                  ScaleTransition(scale: animation, child: child)),
              child: isWithDate && Provider.of<Events>(context, listen: false).isHebrewDate && hebrewDate == null ? CupertinoActivityIndicator(key: ValueKey<bool>(isWithDate && Provider.of<Events>(context, listen: false).isHebrewDate && hebrewDate == null), radius: 9,) : 
              Text(
                key: ValueKey<bool>(isWithDate && hebrewDate != null),
                isWithDate && hebrewDate != null ?
                 hebrewDate! :
                 DateFormat('dd/MM/yyyy').format(date)),
            ),
          ),
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
