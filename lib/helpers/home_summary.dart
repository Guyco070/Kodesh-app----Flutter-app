import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/molad.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/models/zman.dart';

/// The zman named [key] (a Hebcal key such as `sunset`), or null.
Zman? findZman(List<Zman>? zmanim, String key) {
  if (zmanim == null) return null;
  for (final z in zmanim) {
    if (z.title == key) return z;
  }
  return null;
}

/// Whole calendar days from [from] to [to] (0 when both are the same date).
int calendarDaysBetween(DateTime from, DateTime to) {
  final a = DateTime(from.year, from.month, from.day);
  final b = DateTime(to.year, to.month, to.day);
  return b.difference(a).inDays;
}

/// The first holiday or Rosh Chodesh on or after [now]'s date, skipping
/// Shabbatot, the Omer count and the molad (shown elsewhere).
Event? nextSpecialEvent(List<Event> events, DateTime now) {
  for (final e in events) {
    final date = e.entryDate;
    if (date == null || e is Shabat || e is SfiratOmer || e is Molad) {
      continue;
    }
    if (calendarDaysBetween(now, date) >= 0) return e;
  }
  return null;
}

/// Whether the home greeting is "Shabbat Shalom" (Friday and Shabbat)
/// rather than "Shavua Tov".
bool isShabbatGreetingDay(DateTime now) =>
    now.weekday == DateTime.friday || now.weekday == DateTime.saturday;

/// The Omer count to show now: tomorrow's date is counted tonight, so from
/// noon on this is tomorrow's Omer day; before noon, the one counted last
/// night (today's date). Returns null outside the Omer.
SfiratOmer? currentOmer(List<Event> events, DateTime now) {
  final target = now.hour >= 12 ? now.add(const Duration(days: 1)) : now;
  for (final e in events) {
    if (e is SfiratOmer &&
        e.entryDate != null &&
        calendarDaysBetween(target, e.entryDate!) == 0 &&
        e.dayNumber != null) {
      return e;
    }
  }
  return null;
}
