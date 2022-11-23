import 'package:flutter/material.dart';

abstract class Event {
  const Event({Key? key, required this.title, this.entryDate, this.releaseDate, this.parasha});
  final String title; // shabat/ holiday /tefila...
  final DateTime? entryDate;
  final DateTime? releaseDate;
  final String? parasha;
}
