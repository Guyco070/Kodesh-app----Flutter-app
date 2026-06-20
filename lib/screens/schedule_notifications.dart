import 'package:flutter/material.dart';
import 'package:kodesh_app/animations/expanded_section.dart';
import 'package:kodesh_app/api/notification_api.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/group_card.dart';
import 'package:kodesh_app/widgets/schedule_notifications_widgets/choose_time_before_widget.dart';
import 'package:kodesh_app/widgets/schedule_notifications_widgets/choose_time_in_day_widget.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:provider/provider.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

class ScheduleNotificationsScreen extends StatefulWidget {
  const ScheduleNotificationsScreen({super.key});
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
        const SizedBox(height: 7),
        const Divider(height: 15, thickness: 1.5, indent: 60, endIndent: 60),
        const SizedBox(height: 7),
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
            const Divider(
              height: 32,
              thickness: 1.5,
              indent: 60,
              endIndent: 60,
            ),
            Text(appLocalizations.whatToRemindSettings),
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
            if (!reminders.nerotHanukkah) ...{
              const Divider(height: 32, thickness: 1.5),
            },
            ExpandedSection(
              expand: reminders.nerotHanukkah,
              child: Column(children: nerotHanukkahElements()),
            ),
          ],
        ),
      ];
    }

    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.settingRemindersMenu),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionHeader(
                  title: appLocalizations.beforeShabatAndHolidaysSettengs,
                ),
                const SizedBox(height: 8),
                GroupCard(
                  children: [
                    CuperinoTextCheckSwitch(
                      value: reminders.shabatAndHolidays,
                      onChanged: () => reminders.setShabatAndHolidays(),
                      text: appLocalizations.beforeShabatAndHolidaysSettengs,
                    ),
                    ExpandedSection(
                      expand: reminders.shabatAndHolidays,
                      child: Column(
                        children: shabatAndHolidaysElements(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                _SectionHeader(title: appLocalizations.tefillin),
                const SizedBox(height: 8),
                ChooseTimeInDayWidget(
                  title: appLocalizations.tefillin,
                  subtitle: appLocalizations.remindTeffilinSettingsAt,
                  isExpanded: reminders.tefilin,
                  setIsExpanded: reminders.setTefilin,
                  timeObject: reminders.getTefilinTimeObject,
                  setTime: reminders.setTefilinTime,
                  timeString: reminders.tefilinTime,
                ),

                const SizedBox(height: 24),

                _SectionHeader(title: appLocalizations.roshHodesh),
                const SizedBox(height: 8),
                ChooseTimeInDayWidget(
                  title: appLocalizations.roshHodesh,
                  subtitle: appLocalizations.remindRoshHodeshSettingsAt,
                  isExpanded: reminders.roshChodesh,
                  setIsExpanded: reminders.setRoshChodesh,
                  timeObject: reminders.getRoshChodeshTimeObject,
                  setTime: reminders.setRoshChodeshTime,
                  timeString: reminders.roshChodeshTime,
                  noteText: appLocalizations.roshHodeshReminderWillBeAdvanced,
                ),

                const SizedBox(height: 24),

                _SectionHeader(title: appLocalizations.sfiratOmer),
                const SizedBox(height: 8),
                ChooseTimeInDayWidget(
                  title: appLocalizations.sfiratOmer,
                  subtitle: appLocalizations.remindSfiratOmerSettingsAt,
                  isExpanded: reminders.sfiratOmer,
                  setIsExpanded: reminders.setSfiratOmer,
                  timeObject: reminders.getSfiratOmerTimeObject,
                  setTime: reminders.setSfiratOmerTime,
                  timeString: reminders.sfiratOmerTime,
                ),

                const SizedBox(height: 24),

                _TestNotificationButton(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TestNotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return OutlinedButton.icon(
      onPressed: () async {
        await NotificationApi.showNotification(
          id: 0,
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
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
    return Card(
      child: ListTile(
        title: Text(text),
        subtitle: subText != null ? Text(subText!) : null,
        leading: Checkbox(
          value: value,
          onChanged: (newValue) => onChanged(newValue),
        ),
      ),
    );
  }
}
