import 'package:flutter/material.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/appBar.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

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

  String getTime(DateTime? dateTime, String? minute, String? hour) {
    if (dateTime != null) {
      hour = '${dateTime.hour}';
      minute = '${dateTime.minute}';
    }

    while (hour!.length < 2 || minute!.length < 2) {
      hour = getSingleElementTime(hour);
      minute = getSingleElementTime(minute!);
    }
    return '$hour:$minute';
  }

  String getSingleElementTime(String timeEl) {
    while (timeEl.length < 2) {
      if (timeEl.length < 2) {
        timeEl = '0$timeEl';
      }
    }
    return timeEl;
  }

  DropdownMenuItem<String> buildMenuItem(Map item) {
    return DropdownMenuItem(
        value: item['eNameAndCode'],
        child: Text(
          item['hName'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
  }

  buildSelectedMenuItem() {
    return cities.map<Widget>((Map item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        child: Text(
          (item['hName'] as String).split('|')[0],
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

    shabatAndHolidaysThingsToRemindList() {
      return reminders.allShabatAndHolidaysThingsToRemindList.map((e) {
        return TextCheckBox(
            value: reminders.shabatAndHolidaysThingsToRemindList.contains(e),
            text: e,
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
          textDirection: TextDirection.rtl,
          children: [
            Text(
              'עיר',
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
                  selectedItemBuilder: (_) => buildSelectedMenuItem(),
                  value: reminders.reminderCity,
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  items: cities
                      .map<DropdownMenuItem<String>>(buildMenuItem)
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
                  'שעות',
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
                  'דקות',
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
                'הזכר לי ${reminders.beforeShabatHours} שעות ו- ${reminders.beforeShabatMinutes} דקות לפני שבת או חג')),
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
        const Text('מה תרצה שנזכיר לך ?'),
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
          text: 'הזכר לי להדליק נרות בנפרד',
        ),
        if (reminders.shabatAndHolidaysCandles) ...{
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'שעות',
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
                    'דקות',
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
          FittedBox(
              child: Text(
                  'הזכר לי להדליק נרות ${reminders.beforeShabatAndHolidaysCandlesHours} שעות ו- ${reminders.beforeShabatAndHolidaysCandlesMinutes} דקות לפני שבת או חג')),
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
      appBar: getRightBackAppBar(context, 'קביעת תזכורות'),
      body: _isLoading ? SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(child: CircularProgressIndicator()),
    ) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CuperinoTextCheckSwitch(
                value: reminders.shabatAndHolidays,
                onChanged: () => reminders.setShabatAndHolidays(),
                text: 'לפני שבתות וחגים',
              ),
              if (reminders.shabatAndHolidays) ...shabatAndHolidaysElements(),
              CuperinoTextCheckSwitch(
                  text: 'תפילין',
                  value: reminders.tefilin,
                  onChanged: () => reminders.setTefilin()),
              if (reminders.tefilin)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: reminders.getTefilinTimeObject.hour,
                                    minute:
                                        reminders.getTefilinTimeObject.minute),
                                builder: (context, childWidget) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          // Using 24-Hour format
                                          alwaysUse24HourFormat: true),
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
                        const Text('הזכר לי להניח תפילין כל יום בשעה'),
                      ],
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
                  text: 'ראש חודש',
                  value: reminders.roshChodesh,
                  onChanged: () => reminders.setRoshChodesh()),
              if (reminders.roshChodesh)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour:
                                        reminders.getRoshChodeshTimeObject.hour,
                                    minute: reminders
                                        .getRoshChodeshTimeObject.minute),
                                builder: (context, childWidget) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          // Using 24-Hour format
                                          alwaysUse24HourFormat: true),
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
                        const Text('הזכר לי יום לפני ראש חודש בשעה'),
                      ],
                    ),
                    Text(
                        'תזכורת זו תוקדם לימי חול עד השעה שתיים בצהריים בשישי *',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize:
                                12)), // todo: fix it to be syncronize with shabat and holidays
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
                    reminders.setReminders(update: true).then((value) => setState(() {
                      _isLoading = false;
                    }));
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text('עדכן תזכורות'))
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
        textDirection: TextDirection.rtl,
        children: [
          Checkbox(value: value, onChanged: (newValue) => onChanged(newValue)),
          Text(text),
        ],
      ),
    );
  }
}
