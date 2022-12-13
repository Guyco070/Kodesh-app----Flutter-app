import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/reminders_translates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';

class Holiday extends Event {
  Holiday({
    required super.title,
    super.entryDate,
    super.releaseDate,
    required this.subcat,
  });
  String subcat;

  @override
  String toString() {
    return '${super.toString()} - title: $title, entryDate: $entryDate, releaseDate: $releaseDate, subcat: $subcat.\n';
  }

  static createHoliday(
      {required candles, required parashat, required havdalah}) {
    DateTime? date;
    if (candles != null) {
      date = DateTime.tryParse(Events.getDateWithoutTime(candles['date']));
    } else {
      date = DateTime.tryParse(Events.getDateWithoutTime(parashat['date']));
    }

    return Holiday(
      title: parashat['title'],
      entryDate: date,
      releaseDate: havdalah != null
          ? DateTime.tryParse(Events.getDateWithoutTime(havdalah['date']))
          : null,
      subcat: parashat['subcat'], // major, minor, modern, shabat, fast
    );
  }

  @override
  String getReminderBody(String lang) => (RemindersTranslates.holidayReminderTranslated[lang]!['body']! as Function)(entryDate, releaseDate) as String;
  

  @override
  String getReminderTitle(String lang) => title;

  @override
  String getReminderCandlesBody(int beforeShabatAndHolidaysCandlesHours, int beforeShabatAndHolidaysCandlesMinutes, String lang) => (RemindersTranslates.holidayReminderTranslated[lang]!['candlesBody']! as Function)(beforeShabatAndHolidaysCandlesHours, beforeShabatAndHolidaysCandlesMinutes) as String;

  @override
  String getReminderCandlesTitle(lang) => RemindersTranslates.holidayReminderTranslated[lang]!['candlesTitle']! as String;
}
