import 'package:flutter/material.dart';

abstract class Event {
  const Event(
      {Key? key,
      required this.title,
      this.entryDate,
      this.releaseDate,
      this.parasha});
  final String title; // shabat/ holiday /tefila...
  final DateTime? entryDate;
  final DateTime? releaseDate;
  final String? parasha;
  
  String getReminderBody(String lang);
  String getReminderTitle(String lang);
  String getReminderCandlesTitle(String lang);

  String getReminderCandlesBody(int beforeShabatAndHolidaysCandlesHours,
      int beforeShabatAndHolidaysCandlesMinutes, String lang);
}
