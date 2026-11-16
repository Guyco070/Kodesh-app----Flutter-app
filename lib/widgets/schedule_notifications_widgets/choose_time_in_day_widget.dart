import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
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
    this.icon,
    this.iconColor = const Color(0xFF9EC5FF),
  }) : super(key: key);

  /// Badge of the row, as in the design.
  final IconData? icon;
  final Color iconColor;

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
    return GroupCard(
      children: [
        CuperinoTextCheckSwitch(
          text: title,
          icon: icon,
          iconColor: iconColor,
          subtitle:
              isExpanded
                  ? AppLocalizations.of(context)!.reminderAtTime(timeString)
                  : null,
          value: isExpanded,
          onChanged: () => setIsExpanded(),
        ),
        ExpandedSection(
          expand: isExpanded,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
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
                  child: Text(
                    timeString,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (noteText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "*$noteText",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
