import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/api/notification_api.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reminders with ChangeNotifier {
  bool shabatAndHolidays = false;
  bool tefilin = false;
  bool preys = false;
  bool roshHodesh = false;

  String reminderCity = 'IL-Jerusalem|281184';
  String city = 'IL-Jerusalem|281184';
  int beforeShabatMinutes = 0;
  int beforeShabatHours = 0;

  String tefilinTime = '06:00';

  setReminderCity(String newCity) {
    reminderCity = newCity;
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

  setReminders(BuildContext context) async {
    NotificationApi.cancelAll();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('shabatAndHolidays', shabatAndHolidays);
    prefs.setString('reminderCity', reminderCity);
    prefs.setInt('beforeShabatHours', beforeShabatHours);
    prefs.setInt('beforeShabatMinutes', beforeShabatMinutes);

    prefs.setBool('tefilin', tefilin);
    if(tefilin) {
      prefs.setString('tefilinTime', tefilinTime);
    }

    Events events = Provider.of<Events>(context, listen: false);
    Map<String, dynamic> extractData =
        await events.tryFetch(cityToTake: reminderCity, isToday: true);

    List<Event> items = Events.getEventsItemsFromMap(extractData['items']);
    int id = 0;
    final DateTime now = DateTime.now();
    for (Event e in items) {
      if (shabatAndHolidays) {
        if (e is Shabat) {
          DateTime? x = e.entryDate!.subtract(
              Duration(hours: beforeShabatHours, minutes: beforeShabatMinutes));
          // print(x);
          // print(DateFormat('HH:mm').format(x));
          if (now.isBefore(x)) {
            await NotificationApi.showSchedualedNotification(
                id: id,
                title: 'שבת שלום מאפליקציית קודש',
                body:
                    'אל תשכח להדליק מיחם ולחבר פלטה, ההדלקת נרות בשעה ${DateFormat('HH:mm').format(e.entryDate!)}',
                date: x);
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
          // print(x);
          // print(DateFormat('HH:mm').format(e.entryDate!) == '00:00');
          if (now.isBefore(x)) {
            await NotificationApi.showSchedualedNotification(
                id: id,
                title: 'חג שמח מאפליקציית קודש',
                body:
                    'אל תשכח להדליק מיחם ולחבר פלטה, ההדלקת נרות בשעה ${DateFormat('HH:mm').format(e.entryDate!)}',
                date: x);
            id++;
          }
        }
      }
      // else if(shabatAndHolidays && e is Shabat){ // rosh chodesh

      // }else if(shabatAndHolidays && e is Shabat){ // tefila

      // }else if(shabatAndHolidays && e is Shabat){ // tefilin

      // } // נרורת חנוכה ???
    }
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
    notifyListeners();
  }
}
