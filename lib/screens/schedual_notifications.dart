import 'package:flutter/material.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/reminders.dart';
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

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item.split('|')[0],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
  }

  buildSelectedMenuItem() {
    return cities.map<Widget>((String item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        child: Text(
          item.split('|')[0],
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

    Card checkWidget({
      required String title,
      required bool value,
      required void Function(bool newValue) setter,
    }) {
      return Card(
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Checkbox(
                value: value,
                onChanged: (newTefilin) async {
                  setter(newTefilin!);
                }),
            Text(title)
          ],
        ),
      );
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
                      borderRadius: BorderRadius.circular(10),),
                  width: MediaQuery.of(context).size.width / 2.3,
              child: DropdownButtonFormField<String>(
                isDense: false,
                decoration: const InputDecoration(
                    isCollapsed: true, enabledBorder: InputBorder.none),
                selectedItemBuilder: (_) => buildSelectedMenuItem(),
                value: reminders.reminderCity,
                isExpanded: true,
                alignment: AlignmentDirectional.center,
                items: cities.map<DropdownMenuItem<String>>(buildMenuItem).toList(),
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
        Text(
            'הזכר לי ${reminders.beforeShabatHours} שעות ו- ${reminders.beforeShabatMinutes} דקות לפני שבת'),
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
      appBar: AppBar(
        title: const Text('קביעת תזכורות'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(
                      value: reminders.shabatAndHolidays,
                      onChanged: (newShabatAndHolidays) {
                        reminders.setShabatAndHolidays(newShabatAndHolidays!);
                      }),
                  const Text('לפני שבתות וחגים')
                ],
              ),
            ),
            if (reminders.shabatAndHolidays) ...shabatAndHolidaysElements(),
            checkWidget(
                title: 'תפילין',
                value: reminders.tefilin,
                setter: reminders.setTefilin),
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
                            reminders.setTefilinTime(getTime(null,
                                time.minute.toString(), time.hour.toString()));
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
            checkWidget(
                title: 'ראש חודש',
                value: reminders.roshChodesh,
                setter: reminders.setRoshChodesh),
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
                                  hour: reminders.getRoshChodeshTimeObject.hour,
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
                            reminders.setRoshChodeshTime(getTime(null,
                                time.minute.toString(), time.hour.toString()));
                          }
                        },
                        child: Text(reminders.roshChodeshTime),
                      ),
                      const Text('הזכר לי יום לפני ראש חודש בשעה'),
                    ],
                  ),
                  Text('תזכורת זו תוקדם לימי חול עד השעה שתיים בצהריים בשישי *',
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
                  reminders.setReminders(update: true);
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('עדכן תזכורות'))
          ],
        ),
      ),
    );
  }
}
