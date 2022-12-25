import 'package:flutter/material.dart';

abstract class Event {
   Event(
      {Key? key,
      required this.title,
      this.entryDate,
      this.releaseDate,
      this.parasha,
      required this.titleOrig,
    });
  String title; // shabat/ holiday /tefila...
  final DateTime? entryDate;
  final DateTime? releaseDate;
  final String? parasha;
  final String? titleOrig;

  String getReminderBody(String lang);
  String getReminderTitle(String lang);
  String getReminderCandlesTitle(String lang);
  String getReminderHavdalahTitle(String lang);

  String getReminderCandlesBody(int beforeShabatAndHolidaysCandlesHours,
      int beforeShabatAndHolidaysCandlesMinutes, String lang);
  String getReminderHavdalahBody(int afterShabatAndHolidaysCandlesHours,
      int afterShabatAndHolidaysCandlesMinutes, String lang);
}
