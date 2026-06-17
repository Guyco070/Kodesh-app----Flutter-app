import 'package:kodesh_app/models/event.dart';

class Molad extends Event {
  Molad({
    required super.title,
    required super.entryDate,
    super.titleOrig,
  });

  factory Molad.fromMap(Map<String, dynamic> item) {
    return Molad(
      title: item['title'] as String? ?? '',
      entryDate: DateTime.tryParse(
        (item['date'] as String? ?? '').split('T').first,
      ),
      titleOrig: item['hebrew'] as String?,
    );
  }

  @override
  String getReminderBody(String lang) => '';

  @override
  String getReminderTitle(String lang) => '';

  @override
  String getReminderCandlesTitle(String lang) => '';

  @override
  String getReminderHavdalahTitle(String lang) => '';

  @override
  String getReminderCandlesBody(int h, int m, String lang) => '';

  @override
  String getReminderHavdalahBody(int h, int m, String lang) => '';
}
