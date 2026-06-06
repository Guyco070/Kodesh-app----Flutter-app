import 'package:flutter/material.dart';
import 'package:kodesh_app/animations/expanded_section.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
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
  bool tefilin = false;
  bool preys = false;
  bool roshChodesh = false;
  String tefilinTime = '';

  bool _isLoading = false;

  // TextEditingController? tefilinController;

  @override
  Widget build(BuildContext context) {
    var reminders = Provider.of<Reminders>(context);
    var lang = Provider.of<LanguageChangeProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    var devider = Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        height: 7,
        decoration: BoxDecoration(
            border: const Border(
              top: BorderSide(width: 1, color: Colors.grey),
              bottom: BorderSide(width: 1, color: Colors.grey),
            ),
            color: Theme.of(context).cardColor));

    shabatAndHolidaysThingsToRemindList() {
      return reminders.allShabatAndHolidaysThingsToRemindList(context).map((e) {
        Map<String, Object> element = reminders.allShabatAndHolidaysThingsToRemindMap(context)[e]!;
        return TextCheckBox(
            value: reminders.shabatAndHolidaysThingsToRemindList.contains(e),
            text: element['text'] as String,
            subText: (element['text'] as String) != (element['action'] as String) ? element['action'] as String : null,
            onChanged: (isCheked) {
              isCheked
                  ? reminders.shabatAndHolidaysThingsToRemindList.add(e)
                  : reminders.shabatAndHolidaysThingsToRemindList.remove(e);
              reminders.setShabatAndHolidaysThingsToRemindList(
                  newShabatAndHolidaysThingsToRemindList:
                      reminders.shabatAndHolidaysThingsToRemindList);
            });
      }).toList();
    }

    nerotHanukkahElements() {
      return [
        const SizedBox(
          height: 7,
        ),
        const Divider(
          height: 15,
          thickness: 1.5,
          indent: 60,
          endIndent: 60,
        ),
        const SizedBox(
          height: 7,
        ),
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
        GroupCard(children: [
          ChooseTimeBeforeWidget(
            hoursValue: reminders.beforeShabatHours,
            minutesValue: reminders.beforeShabatMinutes,
            setHours: reminders.setShabatAndHolidaysShabatHours,
            setMinutes: reminders.setShabatAndHolidaysShabatMinutes,
            localizedHelpText: appLocalizations
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
        ]),

        const Divider(
          height: 32,
          thickness: 1.5,
          indent: 15,
          endIndent: 15,
        ),

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
                localizedHelpText: appLocalizations
                    .remindMeXhoursAndYMinutesBeforeCandlesLighning,
              ),
            ),
          ],
        ),

        const Divider(
          height: 32,
          thickness: 1.5,
          indent: 15,
          endIndent: 15,
        ),

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
                  localizedHelpText: (String hours, String minutes) =>
                      appLocalizations
                          .remindMeXhoursAndYMinutesAfterShabatForHavdalah(
                              hours, minutes)),
            ),
          ],
        ),

        const Divider(
          height: 32,
          thickness: 1.5,
          indent: 15,
          endIndent: 15,
        ),

        GroupCard(children: [
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
        ])

        // devider,
      ];
    }

    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.settingRemindersMenu),
      body: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GroupCard(
                      children: [
                        CuperinoTextCheckSwitch(
                          value: reminders.shabatAndHolidays,
                          onChanged: () => reminders.setShabatAndHolidays(),
                          text:
                              appLocalizations.beforeShabatAndHolidaysSettengs,
                        ),
                        ExpandedSection(
                          expand: reminders.shabatAndHolidays,
                          child: Column(children: shabatAndHolidaysElements()),
                        ),
                      ],
                    ),

                    if (!reminders.shabatAndHolidays) ...{
                      const Divider(height: 32, thickness: 1.5),
                    },
                    // tefillin - start
                    ChooseTimeInDayWidget(
                      title: appLocalizations.tefillin,
                      subtitle: appLocalizations.remindTeffilinSettingsAt,
                      isExpanded: reminders.tefilin,
                      setIsExpanded: reminders.setTefilin,
                      timeObject: reminders.getTefilinTimeObject,
                      setTime: reminders.setTefilinTime,
                      timeString: reminders.tefilinTime,
                    ),
                    // tefillin - end

                    // rosh hodesh - start
                    ChooseTimeInDayWidget(
                      title: appLocalizations.roshHodesh,
                      subtitle: appLocalizations.remindRoshHodeshSettingsAt,
                      isExpanded: reminders.roshChodesh,
                      setIsExpanded: reminders.setRoshChodesh,
                      timeObject: reminders.getRoshChodeshTimeObject,
                      setTime: reminders.setRoshChodeshTime,
                      timeString: reminders.roshChodeshTime,
                      noteText:
                          appLocalizations.roshHodeshReminderWillBeAdvanced,
                    ),
                    // rosh hodesh - end

                    // sfirat omer - start
                    ChooseTimeInDayWidget(
                      title: appLocalizations.sfiratOmer,
                      subtitle: appLocalizations.remindSfiratOmerSettingsAt,
                      isExpanded: reminders.sfiratOmer,
                      setIsExpanded: reminders.setSfiratOmer,
                      timeObject: reminders.getSfiratOmerTimeObject,
                      setTime: reminders.setSfiratOmerTime,
                      timeString: reminders.sfiratOmerTime,
                    ),
                    // sfirat omer - end

                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          reminders
                              .setReminders(update: true)
                              .then((value) => setState(() {
                                    _isLoading = false;
                                  }));
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(appLocalizations.updateRemindersTitle))
                  ],
                ),
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
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text(text),
            subtitle: subText != null ? Text(subText!) : null,
            leading: Checkbox(value: value, onChanged: (newValue) => onChanged(newValue)),
          ),
        ),
      ],
    );
  }
}
