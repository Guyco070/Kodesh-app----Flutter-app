import 'package:flutter/material.dart';
import 'package:kodesh_app/animations/expanded_section.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/group_card.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';

class ChooseTimeInDayWidget extends StatelessWidget {
  const ChooseTimeInDayWidget({
    Key? key,
    required this.isExpanded,
    required this.setIsExpanded,
    required this.timeObject,
    required this.setTime,
    required this.timeString,
    this.noteText,
    required this.title,
    required this.subtitle,
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
        GroupCard(
          children: [
            CuperinoTextCheckSwitch(
              text: title,
              value: isExpanded,
              onChanged: () => setIsExpanded(),
            ),
            ExpandedSection(
              expand: isExpanded,
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(subtitle),
                    TextButton(
                      onPressed: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: timeObject.hour,
                            minute: timeObject.minute,
                          ),
                          builder: (context, childWidget) {
                            return MediaQuery(
                              data: MediaQuery.of(
                                context,
                              ).copyWith(alwaysUse24HourFormat: true),
                              child: childWidget!,
                            );
                          },
                        );
                        if (time != null) {
                          setTime(
                            getTime(
                              null,
                              time.minute.toString(),
                              time.hour.toString(),
                            ),
                          );
                        }
                      },
                      child: Text(timeString),
                    ),
                  ],
                ),
              ),
            ),
            if (noteText != null)
              FittedBox(
                child: Text(
                  "*$noteText.",
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        const SizedBox(height: 7),
        const Divider(height: 15, thickness: 1.5),
        const SizedBox(height: 7),
      ],
    );
  }
}
