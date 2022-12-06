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
    print(parashat['subcat']);
    return Holiday(
      title: parashat['title'],
      entryDate: date,
      releaseDate: havdalah != null
          ? DateTime.tryParse(Events.getDateWithoutTime(havdalah['date']))
          : null,
      subcat: parashat['subcat'], // major, modern
    );
  }
}
