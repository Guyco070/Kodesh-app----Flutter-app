import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/models/zman.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/widgets/animated_long_text.dart';
import 'package:kodesh_app/widgets/time_left.dart';
import 'package:provider/provider.dart';

class ZmanWidget extends StatelessWidget {
  const ZmanWidget({super.key, required this.data});
  final Zman data;

  @override
  Widget build(BuildContext context) {
    // AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isNotYTT = !isYesterdayTodayOrTomorrow(data.date);
    Events events = Provider.of<Events>(context);

    return Card(
      child: ListTile(
          // isThreeLine: true,
          // dense: true,
          title: Text(
            types[LanguageChangeProvider.getCurrentLocale.languageCode]![
                    data.title]!
                .elementAt(0),
          ),
          subtitle: AnimatedLongText(
            types[LanguageChangeProvider.getCurrentLocale.languageCode]![data.title]!.elementAt(1),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                getTime(data.date, null, null),
                style: TextStyle(fontSize: isNotYTT ? 12 : 14),
              ),

              SizedBox(
                width: 110,
                 child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: ((child, animation) =>
                      ScaleTransition(scale: animation, child: child)),
                  child: 
                  isNotYTT ? 
                    events.isHebrewDate ? 
                      (events.hebrewDates!.isNotEmpty && events.hebrewDates!.containsKey(data.date) ?
                        Text(key: ValueKey<bool>(events.isHebrewDate), events.hebrewDates![data.date]!, style:  TextStyle(color: Colors.grey.shade600, fontSize: 11)) : 
                        const CupertinoActivityIndicator(key: ValueKey<String>('CupertinoActivityIndicator'),radius: 9,)) :
                    Text(key: ValueKey<bool>(events.isHebrewDate), DateFormat('dd/MM/yy').format(data.date), style:  TextStyle(color: Colors.grey.shade600, fontSize: 12)) : Container() 
                 ),
               ),
                
              TimeLeft(
                date: data.date,
                fontSize: isNotYTT ? 11 : null,
              )
            ],
          )),
    );
  }
}


const Map<String, Map<String, Set<String>>> types = {
  'en': {
    'chatzotNight': {'Midnight', 'Sunset plus 6 halachic hours'},
    'alotHaShachar': {'Dawn', 'Sun is 16.1° below the horizon in the morning'},
    'misheyakir': {
      'Earliest talis & tefillin',
      'Sun is 11.5° below the horizon in the morning'
    },
    'misheyakirMachmir': {
      'Earliest talis & tefillin - stringent',
      'Sun is 10.2° below the horizon in the morning'
    },
    'dawn': {'Civil dawn', 'Sun is 6° below the horizon in the morning'},
    'sunrise': {
      'Sunrise',
      'Upper edge of the Sun appears over the eastern horizon in the morning (0.833° above horizon)'
    },
    'sofZmanShmaMGA': {
      'Latest Shema (MGA)',
      'Sunrise plus 3 halachic hours, according to Magen Avraham'
    },
    'sofZmanShma': {
      'Latest Shema (Gra)',
      'Sunrise plus 3 halachic hours, according to the Gra'
    },
    'sofZmanTfillaMGA': {
      'Latest Shacharit (MGA)',
      'Sunrise plus 4 halachic hours, according to Magen Avraham'
    },
    'sofZmanTfilla': {
      'Latest Shacharit (Gra)',
      'Sunrise plus 4 halachic hours, according to the Gra'
    },
    'chatzot': {'Midday', 'Sunrise plus 6 halachic hours'},
    'minchaGedola': {
      'Earliest Mincha – Mincha Gedola',
      'Sunrise plus 6.5 halachic hours'
    },
    'minchaKetana': {
      'Preferable earliest time to recite Minchah – Mincha Ketana',
      'Sunrise plus 9.5 halachic hours'
    },
    'plagHaMincha': {'Plag haMincha', 'Sunrise plus 10.75 halachic hours'},
    'sunset': {
      'Sunset',
      'When the upper edge of the Sun disappears below the horizon (0.833° below horizon)'
    },
    'dusk': {'Civil dusk', 'Sun is 6° below the horizon in the evening'},
    'tzeit7083deg': {
      'Nightfall (3 medium stars) – Tzeit 7.083°',
      'When 3 medium stars are observable in the night sky with the naked eye (sun 7.083° below the horizon)'
    },
    'tzeit85deg': {
      'Nightfall (3 small stars) – Tzeit 8.5°',
      'When 3 small stars are observable in the night sky with the naked eye (sun 8.5° below the horizon)'
    },
    'tzeit42min': {
      'Nightfall (Rabbeinu Tam) – Tzeit 42 minutes',
      'When 3 medium stars are observable in the night sky with the naked eye (fixed 42 minutes after sunset)'
    },
    'tzeit50min': {
      'Nightfall (3 small stars) – Tzeit 50 minutes',
      'When 3 small stars are observable in the night sky with the naked eye (fixed 50 minutes after sunset)'
    },
    'tzeit72min': {
      'Nightfall (Rabbeinu Tam) – Tzeit 72 minutes',
      'When 3 small stars are observable in the night sky with the naked eye (fixed 72 minutes after sunset)'
    }
  },
  'he': {
    'chatzotNight': {'חצות', 'שקיעה ועוד 6 שעות הלכתיות'},
    'alotHaShachar': {'שחר', ' שמש נמצאת 16.1 מעלות מתחת לאופק בבוקר'},
    'misheyakir': {
      'טאליס ותפילין המוקדמים ביותר',
      ' השמש נמצאת 11.5 מעלות מתחת לאופק בבוקר'
    },
    'misheyakirMachmir': {
      'טאליס ותפילין המוקדמים ביותר - מחמירים',
      ' השמש נמצאת 10.2 מעלות מתחת לאופק בבוקר'
    },
    'dawn': {'שחר אזרחי', ' השמש נמצאת 6° מתחת לאופק בבוקר'},
    'sunrise': {
      'זריחה',
      ' הקצה העליון של השמש מופיע מעל האופק המזרחי בבוקר (0.833 מעלות מעל האופק)'
    },
    'sofZmanShmaMGA': {
      'שמע אחרון (מג"א)',
      ' זריחה ועוד 3 שעות הלכתיות לפי מגן אברהם'
    },
    'sofZmanShma': {
      'שמע אחרון (גר"א)',
      ' זריחה ועוד 3 שעות הלכתיות ע"פ הגר"א'
    },
    'sofZmanTfillaMGA': {
      'שחרית אחרונה (מג"א)',
      ' זריחה פלוס 4 שעות הלכתיות לפי מגן אברהם'
    },
    'sofZmanTfilla': {
      'אחרון שחרית (גר"א)',
      ' זריחה ועוד 4 שעות הלכתיות ע"פ הגר"א'
    },
    'chatzot': {'צהריים', ' זריחה ועוד 6 שעות הלכתיות'},
    'minchaGedola': {'מנחה מוקדמת – מנחה גדולה', ' זריחה פלוס 6.5 שעות הלכה'},
    'minchaKetana': {
      'מועד מוקדם יותר לאמירת מנחה – מנחה קטנה',
      ' זריחה ועוד 9.5 שעות הלכתיות'
    },
    'plagHaMincha': {'פלג המנחה', ' זריחה פלוס 10.75 שעות הלכתיות'},
    'sunset': {
      'שקיעה',
      ' כאשר הקצה העליון של השמש נעלם מתחת לאופק (0.833° מתחת לאופק)'
    },
    'dusk': {'דמדומים אזרחיים', ' השמש נמצאת 6° מתחת לאופק בערב'},
    'tzeit7083deg': {
      'לילה (3 כוכבים בינוניים) – Tzeit 7.083°',
      ' כאשר 3 כוכבים בינוניים נראים בשמי הלילה בעין בלתי מזוינת (שמש 7.083° מתחת לאופק)'
    },
    'tzeit85deg': {
      'לילה (3 כוכבים קטנים) – Tzeit 8.5°',
      ' כאשר 3 כוכבים קטנים נראים בשמי הלילה בעין בלתי מזוינת (שמש 8.5° מתחת לאופק)'
    },
    'tzeit42min': {
      'רדדת הלילה (רבינו תם) – צייט 42 דקות',
      ' כאשר 3 כוכבים בינוניים נראים בשמי הלילה בעין בלתי מזוינת (קבוע 42 דקות לאחר השקיעה)'
    },
    'tzeit50min': {
      'לילה (3 כוכבים קטנים) – Tzeit 50 דקות',
      ' כאשר 3 כוכבים קטנים נראים בשמי הלילה בעין בלתי מזוינת (קבוע 50 דקות לאחר השקיעה)'
    },
    'tzeit72min': {
      'רדת הלילה (רבינו תם) – צייט 72 דקות',
      ' כאשר 3 כוכבים קטנים נראים בשמי הלילה בעין בלתי מזוינת (קבוע 72 דקות לאחר השקיעה)'
    },
  }
};