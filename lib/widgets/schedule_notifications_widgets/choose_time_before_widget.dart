import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:numberpicker/numberpicker.dart';

class ChooseTimeBeforeWidget extends StatelessWidget {
  const ChooseTimeBeforeWidget({
    Key? key,
    required this.setHours,
    required this.setMinutes,
    required this.hoursValue,
    required this.minutesValue,
    this.helpText,
    this.localizedHelpText,
  }) : super(key: key);

  final int hoursValue;
  final int minutesValue;
  final Function setHours;
  final Function setMinutes;
  final Function? localizedHelpText;

  final String? helpText;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            Column(
              children: [
                Text(
                  appLocalizations.hours,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                NumberPicker(
                  minValue: 00,
                  maxValue: 23,
                  value: hoursValue,
                  onChanged: (newVal) {
                    setHours(newVal);
                  },
                  zeroPad: true,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: KodeshPalette.textMuted,
                  ),
                  selectedTextStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  appLocalizations.minutes,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                NumberPicker(
                  minValue: 00,
                  maxValue: 59,
                  value: minutesValue,
                  onChanged: (newVal) {
                    setMinutes(newVal);
                  },
                  zeroPad: true,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: KodeshPalette.textMuted,
                  ),
                  selectedTextStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (localizedHelpText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '${localizedHelpText!(hoursValue.toString(), minutesValue.toString())}.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
