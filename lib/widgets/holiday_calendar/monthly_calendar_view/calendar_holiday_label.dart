import 'package:flutter/material.dart';

/// Pill-shaped holiday name inside a calendar day cell. Major holidays use
/// the primary color; minor ones a softer tone.
class CalendarHolidayLabel extends StatelessWidget {
  const CalendarHolidayLabel({
    super.key,
    required this.text,
    required this.isMajor,
    required this.fontSize,
  });

  final String text;
  final bool isMajor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: isMajor ? colorScheme.primary : colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.25,
          fontWeight: isMajor ? FontWeight.w600 : FontWeight.w500,
          color:
              isMajor
                  ? colorScheme.onPrimary
                  : colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
