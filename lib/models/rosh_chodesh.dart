import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/reminders_translates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';

class RoshChodesh extends Event {
  RoshChodesh({required super.title, super.entryDate, super.releaseDate, super.titleOrig,});

  @override
  String toString() {
    return '${super.toString()} - title: $title, entryDate: $entryDate, titleOrig: $titleOrig.\n';
  }

  static createRoshChodesh(
      {required candles, required parashat, required havdalah}) {
    DateTime? date;
    if (candles != null) {
      date = DateTime.tryParse(Events.getDateWithoutTime(candles['date']));
    } else {
      date = DateTime.tryParse(Events.getDateWithoutTime(parashat['date']));
    }
    return RoshChodesh(
      title: parashat['title'],
      entryDate: date,
    );
  }

  static RoshChodesh marge(RoshChodesh rs1, RoshChodesh rs2) {
    if (rs1.entryDate!.isBefore(rs2.entryDate!)) {
      return RoshChodesh(
          title: rs1.title,
          entryDate: rs1.entryDate,
          releaseDate: rs2.entryDate);
    }
    return RoshChodesh(
        title: rs1.title, entryDate: rs2.entryDate, releaseDate: rs1.entryDate);
  }

  @override
  String getReminderBody(String lang) =>  (RemindersTranslates.roshHodeshReminderTranslated[lang]!['body']!)(entryDate!, title);

  @override
  String getReminderTitle(String lang) => '$title - ${DateFormat('dd/MM/yy').format(entryDate!)}';

  @override
  String getReminderCandlesBody(int beforeShabatAndHolidaysCandlesHours, int beforeShabatAndHolidaysCandlesMinutes, String lang) => 'No need';

  @override
  String getReminderCandlesTitle(String lang) => 'No need';
  
  @override
  String getReminderHavdalahTitle(String lang) => 'No need';

  @override
  String getReminderHavdalahBody(int afterShabatAndHolidaysCandlesHours, int afterShabatAndHolidaysCandlesMinutes, String lang) => 'No need';
}
