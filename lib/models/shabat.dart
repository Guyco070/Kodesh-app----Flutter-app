import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/events.dart';

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
        entryDate: DateTime.tryParse(Events.getDateWithoutTime(candles['date'])),
        releaseDate: DateTime.tryParse(Events.getDateWithoutTime(havdalah['date'])));
  }
}
