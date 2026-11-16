import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
import 'package:kodesh_app/animations/expanded_section.dart';
import 'package:kodesh_app/api/notification_api.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/glass_bottom_nav.dart';
import 'package:kodesh_app/widgets/group_card.dart';
import 'package:kodesh_app/widgets/schedule_notifications_widgets/choose_time_before_widget.dart';
import 'package:kodesh_app/widgets/schedule_notifications_widgets/choose_time_in_day_widget.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:provider/provider.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

class ScheduleNotificationsScreen extends StatefulWidget {
  const ScheduleNotificationsScreen({super.key, this.isTab = false});

  /// Shown as a tab of the home shell: no back button, and room at the
  /// bottom for the floating navigation bar.
  final bool isTab;
  static String routeName = '/schedule-notifications';

  @override
  State<ScheduleNotificationsScreen> createState() =>
      _ScheduleNotificationsScreenState();
}

class _ScheduleNotificationsScreenState
    extends State<ScheduleNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    var reminders = Provider.of<Reminders>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    shabatAndHolidaysThingsToRemindList() {
      return reminders.allShabatAndHolidaysThingsToRemindList(context).map((e) {
        Map<String, Object> element =
            reminders.allShabatAndHolidaysThingsToRemindMap(context)[e]!;
        return TextCheckBox(
          value: reminders.shabatAndHolidaysThingsToRemindList.contains(e),
          text: element['text'] as String,
          subText:
              (element['text'] as String) != (element['action'] as String)
                  ? element['action'] as String
                  : null,
          onChanged: (isCheked) {
            isCheked
                ? reminders.shabatAndHolidaysThingsToRemindList.add(e)
                : reminders.shabatAndHolidaysThingsToRemindList.remove(e);
            reminders.setShabatAndHolidaysThingsToRemindList(
              newShabatAndHolidaysThingsToRemindList:
                  reminders.shabatAndHolidaysThingsToRemindList,
            );
          },
        );
      }).toList();
    }

    nerotHanukkahElements() {
      return [
        const Divider(height: 16),
        ChooseTimeBeforeWidget(
          hoursValue: reminders.beforeNerotHanukkahHours,
          minutesValue: reminders.beforeNerotHanukkahMinutes,
          setHours: reminders.setNerotHanukkahHours,
          setMinutes: reminders.setNerotHanukkahMinutes,
          localizedHelpText:
              appLocalizations.remindMeXhoursAndYMinutesBeforeNerotHanukkah,
        ),
      ];
    }

    shabatAndHolidaysElements() {
      return [
        const SizedBox(height: 4),
        GroupCard(
          children: [
            ChooseTimeBeforeWidget(
              hoursValue: reminders.beforeShabatHours,
              minutesValue: reminders.beforeShabatMinutes,
              setHours: reminders.setShabatAndHolidaysShabatHours,
              setMinutes: reminders.setShabatAndHolidaysShabatMinutes,
              localizedHelpText:
                  appLocalizations
                      .remindMeXhoursAndYMinutesBeforeShbatAndHolidays,
            ),
            const Divider(height: 24),
            Text(
              appLocalizations.whatToRemindSettings,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            ...shabatAndHolidaysThingsToRemindList(),
          ],
        ),

        const SizedBox(height: 12),

        GroupCard(
          children: [
            CuperinoTextCheckSwitch(
              value: reminders.shabatAndHolidaysCandles,
              onChanged: () => reminders.setShabatAndHolidaysCandles(),
              text: appLocalizations.remindCandleLightningSeperateSettings,
            ),
            ExpandedSection(
              expand: reminders.shabatAndHolidaysCandles,
              child: ChooseTimeBeforeWidget(
                hoursValue: reminders.beforeShabatAndHolidaysCandlesHours,
                minutesValue: reminders.beforeShabatAndHolidaysCandlesMinutes,
                setHours: reminders.setShabatAndHolidaysCandlesHours,
                setMinutes: reminders.setShabatAndHolidaysCandlesMinutes,
                localizedHelpText:
                    appLocalizations
                        .remindMeXhoursAndYMinutesBeforeCandlesLighning,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        GroupCard(
          children: [
            CuperinoTextCheckSwitch(
              value: reminders.havdalah,
              onChanged: () => reminders.setHavdalah(),
              text: appLocalizations.havdalah,
            ),
            ExpandedSection(
              expand: reminders.havdalah,
              child: ChooseTimeBeforeWidget(
                hoursValue: reminders.afterShabatHavdalahHours,
                minutesValue: reminders.afterShabatHavdalahMinutes,
                setHours: reminders.setAfterShabatHavdalahHours,
                setMinutes: reminders.setAfterShabatHavdalahMinutes,
                localizedHelpText:
                    (String hours, String minutes) => appLocalizations
                        .remindMeXhoursAndYMinutesAfterShabatForHavdalah(
                          hours,
                          minutes,
                        ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        GroupCard(
          children: [
            CuperinoTextCheckSwitch(
              value: reminders.nerotHanukkah,
              onChanged: () => reminders.setNerotHanukkah(),
              text: appLocalizations.hanukkahCandleLighting,
            ),
            ExpandedSection(
              expand: reminders.nerotHanukkah,
              child: Column(children: nerotHanukkahElements()),
            ),
          ],
        ),
      ];
    }

    final body = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: TabHeader.maxContentWidth),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            widget.isTab ? glassBottomNavClearance(context) : 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (kIsWeb) ...[
                _WebNotificationsNotice(
                  text: appLocalizations.notificationsNotAvailableOnWeb,
                ),
                const SizedBox(height: 16),
              ],
              GroupCard(
                children: [
                  CuperinoTextCheckSwitch(
                    value: reminders.shabatAndHolidays,
                    onChanged: () => reminders.setShabatAndHolidays(),
                    text: appLocalizations.beforeShabatAndHolidaysSettengs,
                    icon: Icons.local_fire_department_outlined,
                    iconColor: const Color(0xFFFFB86B),
                    subtitle:
                        reminders.shabatAndHolidays
                            ? appLocalizations.reminderBeforeEntry(
                              '${reminders.beforeShabatHours}:${reminders.beforeShabatMinutes.toString().padLeft(2, '0')}',
                            )
                            : null,
                  ),
                  ExpandedSection(
                    expand: reminders.shabatAndHolidays,
                    child: Column(children: shabatAndHolidaysElements()),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              ChooseTimeInDayWidget(
                title: appLocalizations.tefillin,
                icon: Icons.front_hand_outlined,
                iconColor: const Color(0xFF9EC5FF),
                subtitle: appLocalizations.remindTeffilinSettingsAt,
                isExpanded: reminders.tefilin,
                setIsExpanded: reminders.setTefilin,
                timeObject: reminders.getTefilinTimeObject,
                setTime: reminders.setTefilinTime,
                timeString: reminders.tefilinTime,
              ),

              const SizedBox(height: 12),
              ChooseTimeInDayWidget(
                title: appLocalizations.roshHodesh,
                icon: Icons.nightlight_outlined,
                iconColor: const Color(0xFFC3B5FF),
                subtitle: appLocalizations.remindRoshHodeshSettingsAt,
                isExpanded: reminders.roshChodesh,
                setIsExpanded: reminders.setRoshChodesh,
                timeObject: reminders.getRoshChodeshTimeObject,
                setTime: reminders.setRoshChodeshTime,
                timeString: reminders.roshChodeshTime,
                noteText: appLocalizations.roshHodeshReminderWillBeAdvanced,
              ),

              const SizedBox(height: 12),
              ChooseTimeInDayWidget(
                title: appLocalizations.sfiratOmer,
                icon: Icons.grass_outlined,
                iconColor: const Color(0xFFFF9FB8),
                subtitle: appLocalizations.remindSfiratOmerSettingsAt,
                isExpanded: reminders.sfiratOmer,
                setIsExpanded: reminders.setSfiratOmer,
                timeObject: reminders.getSfiratOmerTimeObject,
                setTime: reminders.setSfiratOmerTime,
                timeString: reminders.sfiratOmerTime,
              ),

              const SizedBox(height: 20),
              _TestNotificationButton(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );

    if (widget.isTab) {
      return DefaultScaffold(
        backdrop: KodeshBackdrop.reminders,
        title: appLocalizations.navReminders,
        subtitle: appLocalizations.remindersSubtitle,
        body: body,
      );
    }
    return GlassScaffold(
      backdrop: KodeshBackdrop.reminders,
      appBar: CustomAppBar(title: appLocalizations.settingRemindersMenu),
      body: body,
    );
  }
}

class _TestNotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return OutlinedButton.icon(
      onPressed:
          kIsWeb
              ? null
              : () async {
                await NotificationApi.showNotification(
                  id: NotificationApi.testNotificationId,
                  title: l.testNotificationTitle,
                  body: l.testNotificationBody,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l.testNotificationSent)),
                  );
                }
              },
      icon: const Icon(Icons.notifications_active_outlined),
      label: Text(l.sendTestNotification),
    );
  }
}

class _WebNotificationsNotice extends StatelessWidget {
  const _WebNotificationsNotice({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class TextCheckBox extends StatelessWidget {
  const TextCheckBox({
    Key? key,
    required this.value,
    required this.text,
    required this.onChanged,
    this.subText,
  }) : super(key: key);

  final bool value;
  final String text;
  final Function onChanged;
  final String? subText;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: (newValue) => onChanged(newValue),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      title: Text(text),
      subtitle: subText != null ? Text(subText!) : null,
    );
  }
}
