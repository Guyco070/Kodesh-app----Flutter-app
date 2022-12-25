import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';

class ChooseTimeInDayWidget extends StatelessWidget {
  const ChooseTimeInDayWidget({
    Key? key,
    required this.isExpanded,
    required this.setIsExpanded,
    required this.timeObject,
    required this.setTime,
    required this.timeString,
    this.noteText, required this.title, required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  final bool isExpanded;
  final Function setIsExpanded;
  final Time timeObject;
  final Function setTime;
  final String timeString;
  final String? noteText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CuperinoTextCheckSwitch(
            text: title,
            value: isExpanded,
            onChanged: () => setIsExpanded()),
        if (isExpanded)
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(subtitle),
                TextButton(
                  onPressed: () async {
                    TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                            hour: timeObject.hour, minute: timeObject.minute),
                        builder: (context, childWidget) {
                          return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                  // Using 24-Hour format
                                  alwaysUse24HourFormat: true),
                              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                              child: childWidget!);
                        });
                    if (time != null) {
                      setTime(getTime(
                          null, time.minute.toString(), time.hour.toString()));
                    }
                  },
                  child: Text(timeString),
                ),
              ],
            ),
          ),
        if (noteText != null)
          Text(
            "*$noteText.",
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
            textAlign: TextAlign.center,
          ), // todo: fix it to be syncronize with shabat and holidays
        const SizedBox(
          height: 7,
        ),
        const Divider(height: 15, thickness: 1.5),
        const SizedBox(
          height: 7,
        ),
      ],
    );
  }
}