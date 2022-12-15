import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/models/zman.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/time_left.dart';

// const types = {
//   'chatzotNight ': 'Sunset plus 6 halachic hours',
//   'alotHaShachar  ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
//   'chatzotNight ': 'Sunset',
// }
class ZmanWidget extends StatelessWidget {
  const ZmanWidget({super.key, required this.data});
  final Zman data;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isNotYTT = !isYesterdayTodayOrTomorrow(data.date);
    return Card(
      child: ListTile(
        title: Text(data.title,),
        subtitle: Text(
          appLocalizations.entryAndLightingCandles,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(getTime(data.date, null, null), style: TextStyle(fontSize: isNotYTT ? 13 : 14),),
            if(isNotYTT) Text(DateFormat('dd/MM/yy').format(data.date), style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            TimeLeft(date: data.date, fontSize: isNotYTT ? 11 : null,)
          ],
        )
      ),
    );
  }
}
