import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/models/zman.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kodesh_app/widgets/animated_long_text.dart';
import 'package:kodesh_app/widgets/time_left.dart';

const types = {
  'chatzotNight': {'Midnight', 'Sunset plus 6 halachic hours'},
  'alotHaShachar': {'Dawn', 'Sun is 16.1° below the horizon in the morning'},
  'misheyakir': {'Earliest talis & tefillin', 'Sun is 11.5° below the horizon in the morning'},
  'misheyakirMachmir': {'Earliest talis & tefillin - stringent', 'Sun is 10.2° below the horizon in the morning'},
  'dawn': {'Civil dawn', 'Sun is 6° below the horizon in the morning'},
  'sunrise': {'Sunrise', 'Upper edge of the Sun appears over the eastern horizon in the morning (0.833° above horizon)'},
  'sofZmanShmaMGA': {'Latest Shema (MGA)', 'Sunrise plus 3 halachic hours, according to Magen Avraham'},
  'sofZmanShma': {'Latest Shema (Gra)', 'Sunrise plus 3 halachic hours, according to the Gra'},
  'sofZmanTfillaMGA': {'Latest Shacharit (MGA)', 'Sunrise plus 4 halachic hours, according to Magen Avraham'},
  'sofZmanTfilla': {'Latest Shacharit (Gra)', 'Sunrise plus 4 halachic hours, according to the Gra'},
  'chatzot': {'Midday', 'Sunrise plus 6 halachic hours'},
  'minchaGedola': {'Earliest Mincha – Mincha Gedola', 'Sunrise plus 6.5 halachic hours'},
  'minchaKetana': {
    'Preferable earliest time to recite Minchah – Mincha Ketana',
    'Sunrise plus 9.5 halachic hours'
  },
  'plagHaMincha': {'Plag haMincha', 'Sunrise plus 10.75 halachic hours'},
  'sunset': {'Sunset', 'When the upper edge of the Sun disappears below the horizon (0.833° below horizon)'},
  'dusk': {'Civil dusk', 'Sun is 6° below the horizon in the evening'},
  'tzeit7083deg': {'Nightfall (3 medium stars) – Tzeit 7.083°', 'When 3 medium stars are observable in the night sky with the naked eye (sun 7.083° below the horizon)'},
  'tzeit85deg': {'Nightfall (3 small stars) – Tzeit 8.5°', 'When 3 small stars are observable in the night sky with the naked eye (sun 8.5° below the horizon)'},
  'tzeit42min': {'Nightfall (Rabbeinu Tam) – Tzeit 42 minutes', 'When 3 medium stars are observable in the night sky with the naked eye (fixed 42 minutes after sunset)'},
  'tzeit50min': {'Nightfall (3 small stars) – Tzeit 50 minutes', 'When 3 small stars are observable in the night sky with the naked eye (fixed 50 minutes after sunset)'},
  'tzeit72min': {'Nightfall (Rabbeinu Tam) – Tzeit 72 minutes', 'When 3 small stars are observable in the night sky with the naked eye (fixed 72 minutes after sunset)'}
};

class ZmanWidget extends StatelessWidget {
  const ZmanWidget({super.key, required this.data});
  final Zman data;

  @override
  Widget build(BuildContext context) {
    // AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isNotYTT = !isYesterdayTodayOrTomorrow(data.date);
    return Card(
      child: ListTile(
          // isThreeLine: true,
          // dense: true,
          title: Text(
            types[data.title]!.elementAt(0),
          ),
          subtitle: AnimatedLongText(
            types[data.title]!.elementAt(1),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                getTime(data.date, null, null),
                style: TextStyle(fontSize: isNotYTT ? 13 : 14),
              ),
              if (isNotYTT)
                Text(DateFormat('dd/MM/yy').format(data.date),
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 11)),
              TimeLeft(
                date: data.date,
                fontSize: isNotYTT ? 11 : null,
              )
            ],
          )),
    );
  }
}
