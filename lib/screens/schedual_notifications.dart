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
  bool roshHodesh = false;
  String tefilinTime = '';

  // TextEditingController? tefilinController;

  @override
  void initState() {
    Provider.of<Reminders>(context, listen: false).getData();

    super.initState();
  }

  String getTime(DateTime? dateTime, String? minute, String? hour) {
    if (dateTime != null) {
      hour = '${dateTime.hour}';
      minute = '${dateTime.minute}';
    }

    while (hour!.length < 2 || minute!.length < 2) {
      if (hour.length < 2) {
        hour = '0$hour';
      }
      if (minute!.length < 2) {
        minute = '0$minute';
      }
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

  @override
  Widget build(BuildContext context) {
    var reminders = Provider.of<Reminders>(context);

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
            PopupMenuButton(
              icon: const Icon(Icons.arrow_drop_down),
              itemBuilder: (context) {
                return cities.map((element) {
                  return PopupMenuItem(
                    value: element,
                    child: Text(element.split('|')[0]),
                  );
                }).toList();
              },
              onSelected: (value) {
                reminders.setReminderCity(value);
              },
            ),
            Text(reminders.reminderCity.split('|')[0]),
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
            Card(
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(
                      value: reminders.tefilin,
                      onChanged: (newTefilin) async {
                        reminders.setTefilin(newTefilin!);
                        // tefilinController = TextEditingController(
                        //     text: getTime(
                        //         Provider.of<Events>(context, listen: false)
                        //             .items[0]
                        //             .entryDate as DateTime));
                      }),
                  const Text('תפילין')
                ],
              ),
            ),
            if (reminders.tefilin)
              Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 6, minute: 00),
                          initialEntryMode: TimePickerEntryMode.dialOnly,
                          builder: (context, childWidget) {
                            return MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                    // Using 24-Hour format
                                    alwaysUse24HourFormat: true),
                                // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                child: childWidget!);
                          });
                      if (time != null) {
                        print(time);
                        reminders.setTefilinTime('${time.hour}:${time.minute}');
                      }
                    },
                    child: Text(reminders.tefilinTime),
                  ),
                  Text(
                      'הזכר לי להניח תפילין כל יום בשעה ${reminders.tefilinTime}'),
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
                  reminders.setReminders(context);
                },
                child: const Text('עדכן תזכורות'))
          ],
        ),
      ),
    );
  }
}
