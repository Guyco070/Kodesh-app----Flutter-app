import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';

class RoshChodesh extends Event {
  RoshChodesh({required super.title, super.entryDate, super.releaseDate});

  @override
  String toString() {
    return '${super.toString()} - title: $title, entryDate: $entryDate.\n';
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
}
