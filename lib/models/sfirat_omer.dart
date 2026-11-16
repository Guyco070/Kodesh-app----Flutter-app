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

  /// The day of the Omer (1–49), read from Hebcal's untranslated title
  /// ("Omer 12"), or null when it is missing.
  int? get dayNumber {
    final match = RegExp(r'\d+').firstMatch(titleOrig ?? '');
    final day = match == null ? null : int.tryParse(match.group(0)!);
    return day != null && day >= 1 && day <= 49 ? day : null;
  }

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
      // Hebcal sends the untranslated title as 'title_orig' ("Omer 12").
      titleOrig: parashat['title_orig'] ?? parashat['titleOrig'],
    );
  }

  @override
  String getReminderBody(String lang) => (RemindersTranslates
      .roshHodeshReminderTranslated[lang]!['body']!)(entryDate!, title);

  @override
  String getReminderTitle(String lang) =>
      '$title - ${DateFormat('dd/MM/yy').format(entryDate!)}';

  @override
  String getReminderCandlesBody(
    int beforeShabatAndHolidaysCandlesHours,
    int beforeShabatAndHolidaysCandlesMinutes,
    String lang,
  ) => 'No need';

  @override
  String getReminderCandlesTitle(String lang) => 'No need';

  @override
  String getReminderHavdalahTitle(String lang) => 'No need';

  @override
  String getReminderHavdalahBody(
    int afterShabatAndHolidaysCandlesHours,
    int afterShabatAndHolidaysCandlesMinutes,
    String lang,
  ) => 'No need';
}
