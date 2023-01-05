import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kodesh_app/providers/events.dart';

String getDayName(AppLocalizations appLocalizations, weekDay) {
  return {
    1: appLocalizations.monday,
    2: appLocalizations.tuesday,
    3: appLocalizations.wednesday,
    4: appLocalizations.thursday,
    5: appLocalizations.friday,
    6: appLocalizations.saturday,
    7: appLocalizations.sunday
  }[weekDay]!;
}

getDushedFormatedDate(DateTime date) {
  return '${date.year}-${getSingleElementZeroAdded(date.month.toString())}-${getSingleElementZeroAdded(date.day.toString())}';
}

String getSingleElementZeroAdded(String dateOrtimeEl) {
  while (dateOrtimeEl.length < 2) {
    if (dateOrtimeEl.length < 2) {
      dateOrtimeEl = '0$dateOrtimeEl';
    }
  }
  return dateOrtimeEl;
}

String getTime(DateTime? dateTime, String? minute, String? hour) {
  if (dateTime != null) {
    hour = '${dateTime.hour}';
    minute = '${dateTime.minute}';
  }

  while (hour!.length < 2 || minute!.length < 2) {
    hour = getSingleElementZeroAdded(hour);
    minute = getSingleElementZeroAdded(minute!);
  }
  return '$hour:$minute';
}

bool isToday(DateTime date) {
  DateTime now = DateTime.now();
  return date.day == now.day &&
      date.month == now.month &&
      date.year == now.year;
}

bool isYesterdayTodayOrTomorrow(DateTime date) {
  int timeLeft = DateTime.now()
      .difference(DateTime(date.year, date.month, date.day))
      .inDays;
  return timeLeft == 0 || timeLeft == 1;
}

DateTime getDateTimeSetToZero(DateTime date) {
  return DateTime(
    date.year,
    date.month,
    date.day,
  );
}

// getf() {
//   Map x = {};
//   DateTime date = DateTime.now().subtract(Duration(days: 2));
//   for (int i = 0; i < 7; i++) {
//     x[date.weekday] = DateFormat('EEEE').format(date);
//     date = date.add(const Duration(days: 1));
//   }
//   print(x);
// }
