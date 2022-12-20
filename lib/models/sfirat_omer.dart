import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/reminders_translates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';

class SfiratOmer extends Event {
  SfiratOmer({
    required super.title,
    super.entryDate,
    required this.sefira,
    super.titleOrig,
  });
  Map sefira;

  @override
  String toString() {
    return '${super.toString()} - title: $title, entryDate: $entryDate, titleOrig: $titleOrig.\n';
  }

  static createSfiratOmer({required candles, required parashat}) {
    DateTime? date;
    if (candles != null) {
      date = DateTime.tryParse(Events.getDateWithoutTime(candles['date']));
    } else {
      date = DateTime.tryParse(Events.getDateWithoutTime(parashat['date']));
    }
    return SfiratOmer(
      title: parashat['title'],
      entryDate: date,
      sefira: parashat['omer'],
      titleOrig: parashat['titleOrig'],
    );
  }

  @override
  String getReminderBody(String lang) => (RemindersTranslates
      .roshHodeshReminderTranslated[lang]!['body']!)(entryDate!, title);

  @override
  String getReminderTitle(String lang) =>
      '$title - ${DateFormat('dd/MM/yy').format(entryDate!)}';

  @override
  String getReminderCandlesBody(int beforeShabatAndHolidaysCandlesHours,
          int beforeShabatAndHolidaysCandlesMinutes, String lang) =>
      'No need';

  @override
  String getReminderCandlesTitle(String lang) => 'No need';
}
