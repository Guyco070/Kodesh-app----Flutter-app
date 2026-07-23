import 'package:kodesh_app/api/l10n/reminders_translates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';

class Holiday extends Event {
  Holiday({
    required super.title,
    super.entryDate,
    super.releaseDate,
    required super.titleOrig,
    required this.subcat,
  });
  String subcat;

  /// Fast begin/end times, populated asynchronously from zmanim for fast days
  /// (Tisha B'Av and the minor fasts). Null for non-fast holidays or until the
  /// zmanim have been fetched.
  DateTime? fastStart;
  DateTime? fastEnd;

  void setFastTimes(DateTime? start, DateTime? end) {
    fastStart = start;
    fastEnd = end;
  }

  /// Whether this holiday is a fast day. Detected via the Hebcal `fast` subcat
  /// or an explicit Tisha B'Av title match (Tisha B'Av can arrive under a
  /// different subcat depending on the year).
  bool get isFast => !_isErev && (subcat == 'fast' || _isTishaBav);

  /// Fasts that begin the previous evening (at sunset) rather than at dawn on
  /// the fast day itself. Only Tisha B'Av among the `fast` items behaves this
  /// way; Yom Kippur is handled separately via candle lighting.
  bool get fastStartsAtNightfall => _isTishaBav;

  bool get _isTishaBav {
    final t = title.toLowerCase();
    final o = titleOrig ?? '';
    return t.contains("tish'a b'av") ||
        t.contains('tisha b') ||
        o.contains('תשעה באב');
  }

  bool get _isErev =>
      title.toLowerCase().contains('erev') ||
      title.contains('ערב') ||
      (titleOrig?.contains('ערב') ?? false);

  @override
  String toString() {
    return '${super.toString()} - title: $title, entryDate: $entryDate, releaseDate: $releaseDate, subcat: $subcat, titleOrig: $titleOrig.\n';
  }

  static createHoliday({
    required candles,
    required parashat,
    required havdalah,
  }) {
    DateTime? date;
    if (candles != null) {
      date = DateTime.tryParse(Events.getDateWithoutTime(candles['date']));
    } else {
      date = DateTime.tryParse(Events.getDateWithoutTime(parashat['date']));
    }

    return Holiday(
      title: parashat['title'],
      entryDate: date,
      releaseDate:
          havdalah != null
              ? DateTime.tryParse(Events.getDateWithoutTime(havdalah['date']))
              : null,
      subcat: parashat['subcat'], // major, minor, modern, shabat, fast
      titleOrig:
          parashat['hebrew'] as String? ??
          parashat['title_orig'] as String?,
    );
  }

  @override
  String getReminderBody(String lang) =>
      (RemindersTranslates.holidayReminderTranslated[lang]!['body']!
              as Function)(entryDate, releaseDate)
          as String;

  @override
  String getReminderTitle(String lang) => title;

  @override
  String getReminderCandlesBody(
    int beforeShabatAndHolidaysCandlesHours,
    int beforeShabatAndHolidaysCandlesMinutes,
    String lang,
  ) =>
      (RemindersTranslates.holidayReminderTranslated[lang]!['candlesBody']!
              as Function)(
            beforeShabatAndHolidaysCandlesHours,
            beforeShabatAndHolidaysCandlesMinutes,
          )
          as String;

  @override
  String getReminderCandlesTitle(lang) =>
      RemindersTranslates.holidayReminderTranslated[lang]!['candlesTitle']!
          as String;

  String getReminderHanukkahCandlesBody(
    int beforeShabatAndHolidaysCandlesHours,
    int beforeShabatAndHolidaysCandlesMinutes,
    String lang,
  ) =>
      (RemindersTranslates
                  .holidayReminderTranslated[lang]!['chnukahCandlesBody']!
              as Function)(
            beforeShabatAndHolidaysCandlesHours,
            beforeShabatAndHolidaysCandlesMinutes,
          )
          as String;

  @override
  String getReminderHavdalahTitle(String lang) =>
      RemindersTranslates.holidayReminderTranslated[lang]!['havdalahTitle']!
          as String;

  @override
  String getReminderHavdalahBody(
    int afterShabatAndHolidaysCandlesHours,
    int afterShabatAndHolidaysCandlesMinutes,
    String lang,
  ) =>
      (RemindersTranslates.holidayReminderTranslated[lang]!['havdalahBody']!
              as Function)(
            afterShabatAndHolidaysCandlesHours,
            afterShabatAndHolidaysCandlesMinutes,
          )
          as String;
}
