import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numberpicker/numberpicker.dart';

class ChooseTimeBeforeWidget extends StatelessWidget {
  const ChooseTimeBeforeWidget({
    Key? key,
    required this.setHours,
    required this.setMinutess,
    required this.hoursValue,
    required this.minutesValue, this.helpText, this.localizedHelpText,
  }) : super(key: key);

  final int hoursValue;
  final int minutesValue;
  final Function setHours;
  final Function setMinutess;
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
                      color: Theme.of(context).primaryColor, fontSize: 16),
                ),
                NumberPicker(
                  minValue: 00,
                  maxValue: 24,
                  value: hoursValue,
                  onChanged: (newVal) {
                    setHours(newVal);
                  },
                  zeroPad: true,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  appLocalizations.minutes,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                ),
                NumberPicker(
                  minValue: 00,
                  maxValue: 59,
                  value: minutesValue,
                  onChanged: (newVal) {
                    setMinutess(newVal);
                  },
                  zeroPad: true,
                ),
              ],
            ),
          ],
        ),
        if(localizedHelpText != null) FittedBox(
            child: Text(
          '${localizedHelpText!(hoursValue.toString(), minutesValue.toString())}.',
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
          textAlign: TextAlign.center,
        )),
      ],
    );
  }
}