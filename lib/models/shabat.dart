import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/api/l10n/reminders_translates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/reminders.dart';

class Shabat extends Event {
  Shabat(
      {required super.title,
      required super.parasha,
      required super.entryDate,
      required super.releaseDate});

  @override
  String toString() {
    return '${super.toString()} - title: $title, parasha: $parasha, entryDate: $entryDate, releaseDate: $releaseDate.\n';
  }

  static Shabat createShabat({
    String? title,
    required Map<String, dynamic> candles,
    required Map<String, dynamic> parashat,
    required Map<String, dynamic> havdalah,
  }) {
    return Shabat(
        title: title ?? 'Shabat',
        parasha: parashat['title'],
        entryDate:
            DateTime.tryParse(Events.getDateWithoutTime(candles['date'])),
        releaseDate:
            DateTime.tryParse(Events.getDateWithoutTime(havdalah['date'])));
  }

  @override
  String getReminderBody(String lang) => (RemindersTranslates.shabatReminderTranslated[lang]!['body']! as Function)(entryDate, releaseDate) as String;
  

  @override
  String getReminderTitle(String lang) => RemindersTranslates.shabatReminderTranslated[lang]!['title']! as String;

  @override
  String getReminderCandlesBody(int beforeShabatAndHolidaysCandlesHours, int beforeShabatAndHolidaysCandlesMinutes, String lang) => (RemindersTranslates.shabatReminderTranslated[lang]!['candlesBody']! as Function)(beforeShabatAndHolidaysCandlesHours, beforeShabatAndHolidaysCandlesMinutes) as String;

  @override
  String getReminderCandlesTitle(String lang) => RemindersTranslates.shabatReminderTranslated[lang]!['candlesTitle']! as String;
}
