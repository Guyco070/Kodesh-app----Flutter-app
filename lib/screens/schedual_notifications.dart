import 'package:flutter/material.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchedualNotficationsScreen extends StatefulWidget {
  const SchedualNotficationsScreen({super.key});
  static String routeName = '/schedual-notfications';

  @override
  State<SchedualNotficationsScreen> createState() =>
      _SchedualNotficationsScreenState();
}

class _SchedualNotficationsScreenState
    extends State<SchedualNotficationsScreen> {
  bool tefilin = false;
  bool preys = false;
  bool roshChodesh = false;
  String tefilinTime = '';

  bool _isLoading = false;

  // TextEditingController? tefilinController;

  DropdownMenuItem<String> buildMenuItem(Map item, String lang) {
    return DropdownMenuItem(
        value: item['eNameAndCode'],
        child: Text(
          item[lang],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
  }

  buildSelectedMenuItem(String lang) {
    return cities.map<Widget>((Map item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        child: Text(
          item[lang],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var reminders = Provider.of<Reminders>(context);
    var lang = Provider.of<LanguageChangeProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    shabatAndHolidaysThingsToRemindList() {
      return reminders.allShabatAndHolidaysThingsToRemindList(context).map((e) {
        return TextCheckBox(
            value: reminders.shabatAndHolidaysThingsToRemindList.contains(e),
            text: reminders.allShabatAndHolidaysThingsToRemindMap(
                context)[e]!['text'] as String,
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

    shabatAndHolidaysElements() {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocalizations.city,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width / 2.3,
              child: DropdownButtonFormField<String>(
                  isDense: false,
                  decoration: const InputDecoration(
                      isCollapsed: true, enabledBorder: InputBorder.none),
                  selectedItemBuilder: (_) =>
                      buildSelectedMenuItem(lang.currentLocale.languageCode),
                  value: reminders.reminderCity,
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  items: cities
                      .map<DropdownMenuItem<String>>((items) =>
                          buildMenuItem(items, lang.currentLocale.languageCode))
                      .toList(),
                  onChanged: (value) {
                    reminders.setReminderCity(value ?? reminders.reminderCity);
                  }),
            ),
          ],
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  value: reminders.beforeShabatHours,
                  onChanged: (newVal) {
                    reminders.setShabatAndHolidaysShabatHours(newVal);
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
                  value: reminders.beforeShabatMinutes,
                  onChanged: (newVal) {
                    reminders.setShabatAndHolidaysShabatMinutes(newVal);
                  },
                  zeroPad: true,
                ),
              ],
            ),
          ],
        ),
        FittedBox(
            child: Text(
          '${appLocalizations.remindMeXhoursAndYMinutesBeforeShbatAndHolidays(reminders.beforeShabatHours.toString(), reminders.beforeShabatMinutes.toString())}.',
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
          textAlign: TextAlign.center,
        )),
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
        Text(appLocalizations.whatToRemindSettings),
        ...shabatAndHolidaysThingsToRemindList(),
        const SizedBox(
          height: 7,
        ),
        const Divider(height: 15, thickness: 1.5),
        const SizedBox(
          height: 7,
        ),
        CuperinoTextCheckSwitch(
          value: reminders.shabatAndHolidaysCandles,
          onChanged: () => reminders.setShabatAndHolidaysCandles(),
          text: appLocalizations.remindCandleLightningSeperateSettings,
        ),
        if (reminders.shabatAndHolidaysCandles) ...{
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    value: reminders.beforeShabatAndHolidaysCandlesHours,
                    onChanged: (newVal) {
                      reminders.setShabatAndHolidaysCandlesHours(newVal);
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
                    value: reminders.beforeShabatAndHolidaysCandlesMinutes,
                    onChanged: (newVal) {
                      reminders.setShabatAndHolidaysCandlesMinutes(newVal);
                    },
                    zeroPad: true,
                  ),
                ],
              ),
            ],
          ),
          Text(
            '${appLocalizations.remindMeXhoursAndYMinutesBeforeCandlesLighning(reminders.beforeShabatAndHolidaysCandlesHours.toString(), reminders.beforeShabatAndHolidaysCandlesMinutes.toString())}.',
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
            textAlign: TextAlign.center,
          ),
        },
        const SizedBox(
          height: 7,
        ),
        const Divider(height: 15, thickness: 1.5),
        const SizedBox(
          height: 7,
        ),
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
                    CuperinoTextCheckSwitch(
                      value: reminders.shabatAndHolidays,
                      onChanged: () => reminders.setShabatAndHolidays(),
                      text: appLocalizations.beforeShabatAndHolidaysSettengs,
                    ),
                    if (reminders.shabatAndHolidays)
                      ...shabatAndHolidaysElements(),
                    CuperinoTextCheckSwitch(
                        text: appLocalizations.tefillin,
                        value: reminders.tefilin,
                        onChanged: () => reminders.setTefilin()),
                    if (reminders.tefilin)
                      Column(
                        children: [
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(appLocalizations.remindTeffilinSettingsAt),
                                TextButton(
                                  onPressed: () async {
                                    TimeOfDay? time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: reminders
                                                .getTefilinTimeObject.hour,
                                            minute: reminders
                                                .getTefilinTimeObject.minute),
                                        builder: (context, childWidget) {
                                          return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      // Using 24-Hour format
                                                      alwaysUse24HourFormat:
                                                          true),
                                              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                              child: childWidget!);
                                        });
                                    if (time != null) {
                                      reminders.setTefilinTime(getTime(
                                          null,
                                          time.minute.toString(),
                                          time.hour.toString()));
                                    }
                                  },
                                  child: Text(reminders.tefilinTime),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Divider(height: 15, thickness: 1.5),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    CuperinoTextCheckSwitch(
                        text: appLocalizations.roshHodesh,
                        value: reminders.roshChodesh,
                        onChanged: () => reminders.setRoshChodesh()),
                    if (reminders.roshChodesh)
                      Column(
                        children: [
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(appLocalizations
                                    .remindRoshHodeshSettingsAt),
                                TextButton(
                                  onPressed: () async {
                                    TimeOfDay? time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: reminders
                                                .getRoshChodeshTimeObject.hour,
                                            minute: reminders
                                                .getRoshChodeshTimeObject
                                                .minute),
                                        builder: (context, childWidget) {
                                          return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      // Using 24-Hour format
                                                      alwaysUse24HourFormat:
                                                          true),
                                              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                              child: childWidget!);
                                        });
                                    if (time != null) {
                                      reminders.setRoshChodeshTime(getTime(
                                          null,
                                          time.minute.toString(),
                                          time.hour.toString()));
                                    }
                                  },
                                  child: Text(reminders.roshChodeshTime),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "*${appLocalizations.roshHodeshReminderWillBeAdvanced}.",
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 12),
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
                      ),
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
  }) : super(key: key);

  final bool value;
  final String text;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Checkbox(value: value, onChanged: (newValue) => onChanged(newValue)),
          Text(text),
        ],
      ),
    );
  }
}
