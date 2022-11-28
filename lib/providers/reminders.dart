import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/api/notification_api.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/models/rosh_chodesh.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/screens/sederAnahatTefilin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart';

class Reminders with ChangeNotifier {
  int id = 0;
  bool shabatAndHolidays = false;
  bool tefilin = false;
  bool preys = false;
  bool roshChodesh = false;

  String reminderCity = 'IL-Jerusalem|281184';
  String city = 'IL-Jerusalem|281184';
  int beforeShabatMinutes = 0;
  int beforeShabatHours = 0;

  String tefilinTime = '06:00';
  String roshChodeshTime = '06:00';

  List<Map<String, Object>> notValues = [];

  Reminders() {
    getData();
  }

  setReminderCity(String newCity) {
    reminderCity = newCity;
    notifyListeners();
  }

  setRoshChodesh(bool newRoshChodesh) {
    roshChodesh = newRoshChodesh;
    notifyListeners();
  }

  setShabatAndHolidays(bool newShabatAndHolidaysy) {
    shabatAndHolidays = newShabatAndHolidaysy;
    notifyListeners();
  }

  setShabatAndHolidaysShabatMinutes(int newBeforeShabatMinutes) {
    beforeShabatMinutes = newBeforeShabatMinutes;
    notifyListeners();
  }

  setShabatAndHolidaysShabatHours(int newBeforeShabatHours) {
    beforeShabatHours = newBeforeShabatHours;
    notifyListeners();
  }

  void setTefilin(bool newTefilin) {
    tefilin = newTefilin;
    notifyListeners();
  }

  void setTefilinTime(String newTefilinTime) {
    tefilinTime = newTefilinTime;
    notifyListeners();
  }

  void setRoshChodeshTime(String newRoshChodeshTime) {
    roshChodeshTime = newRoshChodeshTime;
    notifyListeners();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> prefsKeys = prefs.getKeys();

    if (prefsKeys.contains('shabatAndHolidays')) {
      shabatAndHolidays = prefs.getBool('shabatAndHolidays')!;
    }

    if (prefsKeys.contains('city')) {
      city = prefs.getString('city')!;
    }

    if (prefsKeys.contains('reminderCity')) {
      reminderCity = prefs.getString('reminderCity')!;
    } else {
      reminderCity = city;
    }

    if (prefsKeys.contains('beforeShabatHours')) {
      beforeShabatHours = prefs.getInt('beforeShabatHours')!;
    }

    if (prefsKeys.contains('beforeShabatMinutes')) {
      beforeShabatMinutes = prefs.getInt('beforeShabatMinutes')!;
    }

    if (prefsKeys.contains('tefilin')) {
      tefilin = prefs.getBool('tefilin')!;
    }

    if (prefsKeys.contains('tefilinTime')) {
      tefilinTime = prefs.getString('tefilinTime')!;
    }

    if (prefsKeys.contains('roshChodesh')) {
      roshChodesh = prefs.getBool('roshChodesh')!;
    }

    if (prefsKeys.contains('roshChodeshTime')) {
      roshChodeshTime = prefs.getString('roshChodeshTime')!;
    }
    notifyListeners();

    setReminders();
  }

  updateAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('shabatAndHolidays', shabatAndHolidays);
    prefs.setString('reminderCity', reminderCity);
    prefs.setInt('beforeShabatHours', beforeShabatHours);
    prefs.setInt('beforeShabatMinutes', beforeShabatMinutes);

    prefs.setBool('tefilin', tefilin);
    prefs.setBool('roshChodesh', roshChodesh);

    if (tefilin) prefs.setString('tefilinTime', tefilinTime);
    if (roshChodesh) prefs.setString('roshChodeshTime', roshChodeshTime);
  }

  setReminders({bool update = false}) async {
    if (update) {
      updateAll();
    }

    NotificationApi.cancelAll();
    id = 0;

    List<TZDateTime> tefilinDates = [];
    List<int> tzToRemove = [];
    if (tefilin) tefilinDates = await setRemindersForTefilin();

    Map<String, dynamic> extractData =
        await Events().tryFetch(cityToTake: reminderCity, isToday: true);

    List<Event> items = Events.getEventsItemsFromMap(extractData['items']);
    final DateTime now = DateTime.now();

    notValues = [];
    for (Event e in items) {
      if (shabatAndHolidays) {
        if (e is Shabat) {
          DateTime? x = e.entryDate!.subtract(
              Duration(hours: beforeShabatHours, minutes: beforeShabatMinutes));

          if (now.isBefore(x)) {
            String body =
                'אל תשכח להדליק מיחם ולחבר פלטה. ההדלקת נרות בשעה ${DateFormat('HH:mm').format(e.entryDate!)}.';
            if (e.releaseDate != null) {
              body +=
                  '\nזמן הבדלה: ${DateFormat('dd/MM/yy - hh:mm').format(e.releaseDate!)}';
            }

            notValues.add({
              'id': id,
              'title': 'שבת שלום מאפליקציית קודש',
              'body': body,
              'date': x,
              'tzDateTime': TZDateTime.from(x, local)
            });
            id++;
          }
        } else if (e is Holiday) {
          DateTime? x;
          if (DateFormat('HH:mm').format(e.entryDate!) == '00:00') {
            x = DateTime(e.entryDate!.year, e.entryDate!.month,
                e.entryDate!.day - 1, 20, 0);
          } else {
            x = e.entryDate!.subtract(Duration(
                hours: beforeShabatHours, minutes: beforeShabatMinutes));
          }

          if (now.isBefore(x)) {
            String body =
                'אל תשכח להדליק מיחם ולחבר פלטה. ההדלקת נרות בשעה ${DateFormat('HH:mm').format(e.entryDate!)}.';
            if (e.releaseDate != null) {
              body +=
                  '\nזמן הבדלה: ${DateFormat('dd/MM/yy - hh:mm').format(e.releaseDate!)}';
            }

            notValues.add({
              'id': id,
              'title': 'חג שמח ${e.title} מאפליקציית קודש',
              'body': body,
              'date': x,
              'tzDateTime': TZDateTime.from(x, local)
            });
            id++;
          }
          if (tefilinDates.isNotEmpty && e.releaseDate != null) {
            tzToRemove.add(tefilinDates.indexOf(tefilinDates[0]));
            for (TZDateTime tz in tefilinDates) {
              if (tz.isAfter(e.entryDate!) &&
                  tz.day == e.entryDate!.day &&
                  tz.month == e.entryDate!.month &&
                  tz.year == e.entryDate!.year) {
                TZDateTime temp = tz.add(const Duration(days: 1));

                while (temp.isBefore(e.releaseDate!)) {
                  tzToRemove.add(tefilinDates.indexOf(temp));
                  temp = temp.add(const Duration(days: 1));
                }
              }
            }
          }
        }
      }

      if (roshChodesh && e is RoshChodesh) {
        // rosh chodesh
        DateTime dayBefore = DateTime(
                e.entryDate!.year,
                e.entryDate!.month,
                e.entryDate!.day,
                getRoshChodeshTimeObject.hour,
                getRoshChodeshTimeObject.minute)
            .subtract(const Duration(days: 1));

        if (dayBefore.weekday == 5 || dayBefore.weekday == 6) {
          DateTime twoOc = DateTime(e.entryDate!.year, e.entryDate!.month,
                  e.entryDate!.day, 14, 0)
              .subtract(const Duration(days: 1));
          if (dayBefore.isAfter(twoOc)) {
            dayBefore = dayBefore
                .subtract(Duration(days: dayBefore.weekday == 5 ? 1 : 2));
          } else {
            dayBefore = dayBefore.subtract(const Duration(days: 1));
          }
        }

        if (now.isBefore(dayBefore)) {
          notValues.add({
            'id': id,
            'title':
                '${e.title} - ${DateFormat('dd/MM/yy').format(e.entryDate!)}',
            'body':
                'ביקשת שנזכיר לך שבתאריך ${DateFormat('HH:mm').format(e.entryDate!)} יתקיים ${e.title}',
            'date': dayBefore,
            'tzDateTime': TZDateTime.from(dayBefore, local)
          });
          id++;
        }
      }

      //else if(shabatAndHolidays && e is Shabat){ // tefila

      // }else if(shabatAndHolidays && e is Shabat){ // נרורת חנוכה ???

      // }else if(shabatAndHolidays && e is Shabat){ // ספירת העומר ???

      // }
    }

    for (Map<String, Object> e in notValues) {
      await NotificationApi.showSchedualedNotification(
        id: e['id'] as int,
        title: e['title'] as String,
        body: e['body'] as String,
        date: e['date'] as DateTime,
        tzDateTime: e['tzDateTime'] as TZDateTime,
        payload: e['payload'] as String?,
      );
    }

    for (int i in tzToRemove) {
      // remove holidays dates
      NotificationApi.cancel(i);
    }
  }

  Future<List<TZDateTime>> setRemindersForTefilin() async {
    TZDateTime first = NotificationApi.schedualeDaily(getTefilinTimeObject);

    final DateTime now = DateTime.now();
    final tzNow = TZDateTime(
        local, now.year, now.month, now.day, now.hour, now.minute, now.second);

    if (tzNow.isAfter(first)) {
      first = first.add(const Duration(days: 1));
    }
    if (first.weekday == 6) first = first.add(const Duration(days: 1));

    final tefilinDates = [
      first,
    ];

    for (int i = 0; i < 7; i++) {
      TZDateTime tz = tefilinDates.last
          .add(Duration(days: tefilinDates.last.weekday == 5 ? 2 : 1));
      tefilinDates.add(tz);
      // notValues.add({
      //           'id': id,
      //           'title': 'תפילין',
      //           'body': 'הגיע הזמן להניח תפילין!',
      //           'date': tz,
      //           'tzDateTime': tz,
      //           'payload': SederAnahatTefilin.routeName
      //         });

    }

    for (TZDateTime tz in tefilinDates) {
      await NotificationApi.showSchedualedNotification(
              id: id,
              title: 'תפילין',
              body: 'הגיע הזמן להניח תפילין!',
              date: tz,
              tzDateTime: tz,
              payload: SederAnahatTefilin.routeName)
          .then((value) => id++);
    }
    return tefilinDates;
  }

  Time get getTefilinTimeObject {
    int hour = int.parse(tefilinTime.split(':')[0]);
    int minutes = int.parse(tefilinTime.split(':')[1]);
    return Time(hour, minutes);
  }

  Time get getRoshChodeshTimeObject {
    int hour = int.parse(roshChodeshTime.split(':')[0]);
    int minutes = int.parse(roshChodeshTime.split(':')[1]);
    return Time(hour, minutes);
  }
}
