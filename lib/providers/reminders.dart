import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/api/notification_api.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/models/rosh_chodesh.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/screens/Shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/tfilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tfilot/seder_anahat_tefilin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  bool shabatAndHolidaysCandles = false;
  int beforeShabatAndHolidaysCandlesMinutes = 5;
  int beforeShabatAndHolidaysCandlesHours = 0;

  String tefilinTime = '06:00';
  String roshChodeshTime = '06:00';

  List<String> allShabatAndHolidaysThingsToRemindList(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return [
      'Shabbat blech',
      'Samovar',
      'Shabbat clock',
      'Candle lighting',
      'Air conditioner'
    ];
  }

  Map<String, Map<String, Object>> allShabatAndHolidaysThingsToRemindMap(
      BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return {
      'Shabbat blech': {
        'icon': Icons.heat_pump,
        'action': appLocalizations.plataAction,
        'text': appLocalizations.plata
      },
      'Samovar': {
        'icon': Icons.coffee_maker_outlined,
        'action': appLocalizations.mihamAction,
        'text': appLocalizations.miham
      },
      'Shabbat clock': {
        'icon': Icons.lock_clock_outlined,
        'action': appLocalizations.shabbatClockAction,
        'text': appLocalizations.shabbatClock
      },
      'Candle lighting': {
        'icon': Icons.ac_unit_outlined,
        'action': appLocalizations.airConditionerAction,
        'text': appLocalizations.airConditioner
      },
      'Air conditioner': {
        'icon': Icons.fireplace_outlined,
        'action': appLocalizations.candleLightingAction,
        'text': appLocalizations.candleLighting
      },
    };
  }

  List<String> shabatAndHolidaysThingsToRemindList = [
    'Shabbat blech',
    'Samovar'
  ];

  List<String> shabatAndHolidaysThingsToRemindListCreate(context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return [
      appLocalizations.plata,
      appLocalizations.miham,
    ];
  }

  List<Map<String, Object>> notValues = [];

  Reminders(BuildContext context) {
    getData(context);
  }

  setReminderCity(String newCity) {
    reminderCity = newCity;
    notifyListeners();
  }

  setRoshChodesh({bool? newRoshChodesh}) {
    if (newRoshChodesh != null) {
      roshChodesh = newRoshChodesh;
    } else {
      roshChodesh = !roshChodesh;
    }
    notifyListeners();
  }

  setShabatAndHolidays({bool? newShabatAndHolidays}) {
    if (newShabatAndHolidays != null) {
      shabatAndHolidays = newShabatAndHolidays;
    } else {
      shabatAndHolidays = !shabatAndHolidays;
    }
    notifyListeners();
  }

  setShabatAndHolidaysThingsToRemindList(
      {required List<String> newShabatAndHolidaysThingsToRemindList}) {
    shabatAndHolidaysThingsToRemindList =
        newShabatAndHolidaysThingsToRemindList;
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

  setShabatAndHolidaysCandles({bool? newShabatAndHolidaysCandles}) {
    if (newShabatAndHolidaysCandles != null) {
      shabatAndHolidaysCandles = newShabatAndHolidaysCandles;
    } else {
      shabatAndHolidaysCandles = !shabatAndHolidaysCandles;
    }
    notifyListeners();
  }

  setShabatAndHolidaysCandlesMinutes(int newBeforeShabatCandlesMinutes) {
    beforeShabatAndHolidaysCandlesMinutes = newBeforeShabatCandlesMinutes;
    notifyListeners();
  }

  setShabatAndHolidaysCandlesHours(int newBeforeShabatCandlesHours) {
    beforeShabatAndHolidaysCandlesHours = newBeforeShabatCandlesHours;
    notifyListeners();
  }

  void setTefilin({bool? newTefilin}) {
    if (newTefilin != null) {
      tefilin = newTefilin;
    } else {
      tefilin = !tefilin;
    }
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

  getData(BuildContext context) async {
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

    if (prefsKeys.contains('shabatAndHolidaysThingsToRemindList')) {
      shabatAndHolidaysThingsToRemindList =
          prefs.getStringList('shabatAndHolidaysThingsToRemindList')!;
    } else {
      shabatAndHolidaysThingsToRemindList =
          shabatAndHolidaysThingsToRemindListCreate(context);
    }

    if (prefsKeys.contains('shabatAndHolidaysCandles')) {
      shabatAndHolidaysCandles = prefs.getBool('shabatAndHolidaysCandles')!;
    }

    if (prefsKeys.contains('beforeShabatAndHolidaysCandlesHours')) {
      beforeShabatAndHolidaysCandlesHours =
          prefs.getInt('beforeShabatAndHolidaysCandlesHours')!;
    }

    if (prefsKeys.contains('beforeShabatAndHolidaysCandlesMinutes')) {
      beforeShabatAndHolidaysCandlesMinutes =
          prefs.getInt('beforeShabatAndHolidaysCandlesMinutes')!;
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

    setReminders(context: context);
  }

  updateAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('shabatAndHolidays', shabatAndHolidays);
    prefs.setInt('beforeShabatHours', beforeShabatHours);
    prefs.setInt('beforeShabatMinutes', beforeShabatMinutes);

    prefs.setString('reminderCity', reminderCity);

    prefs.setBool('tefilin', tefilin);
    prefs.setBool('roshChodesh', roshChodesh);

    if (shabatAndHolidays) {
      prefs.setStringList('shabatAndHolidaysThingsToRemindList',
          shabatAndHolidaysThingsToRemindList);
    }

    prefs.setBool('shabatAndHolidaysCandles', shabatAndHolidaysCandles);
    prefs.setInt('beforeShabatAndHolidaysCandlesHours',
        beforeShabatAndHolidaysCandlesHours);
    prefs.setInt('beforeShabatAndHolidaysCandlesMinutes',
        beforeShabatAndHolidaysCandlesMinutes);

    if (tefilin) prefs.setString('tefilinTime', tefilinTime);
    if (roshChodesh) prefs.setString('roshChodeshTime', roshChodeshTime);
  }

  Future<void> setReminders(
      {bool update = false, required BuildContext context}) async {
    if (update) {
      updateAll();
    }

    NotificationApi.cancelAll();
    id = 0;

    List<TZDateTime> tefilinDates = [];
    List<int> tzToRemove = [];
    if (tefilin) tefilinDates = await setRemindersForTefilin();
    Events events = Events();
    if (await events.isThereInternetConnection()) {
      Map<String, dynamic> extractData =
          await events.tryFetch(cityToTake: reminderCity, isToday: true);

      List<Event> items = Events.getEventsItemsFromMap(extractData['items']);
      final DateTime now = DateTime.now();
      // items.add(Shabat(
      //     title: 'שבת',
      //     parasha: 'פָּרָשַׁת וַיִּשְׁלַח',
      //     entryDate: DateTime.now().add(const Duration(minutes: 2)),
      //     releaseDate: DateTime.now().add(const Duration(minutes: 10))));
      notValues = [];
      for (Event e in items) {
        if (shabatAndHolidays) {
          if (e is Shabat) {
            DateTime? x = e.entryDate!.subtract(Duration(
                hours: beforeShabatHours, minutes: beforeShabatMinutes));

            if (now.isBefore(x)) {
              String body = 'ביקשת שנזכיר לך כמה מטלות לפני שבת.\n';
              // for (int i = 0;
              //     i < shabatAndHolidaysThingsToRemindList.length;
              //     i++) {
              //   print('allShabatAndHolidaysThingsToRemindMap');
              //   print(shabatAndHolidaysThingsToRemindList[i]);
              //   print(allShabatAndHolidaysThingsToRemindMap(
              //       context)[shabatAndHolidaysThingsToRemindList[i]]);
              //   body +=
              //       '\n${i + 1}. ${(allShabatAndHolidaysThingsToRemindMap(context))..[shabatAndHolidaysThingsToRemindList[i]]!['action']}';
              // }

              body +=
                  '.\nהדלקת נרות בשעה ${DateFormat('HH:mm').format(e.entryDate!)}.';

              if (e.releaseDate != null) {
                body +=
                    '\nזמן הבדלה: ${DateFormat('dd/MM/yy - hh:mm').format(e.releaseDate!)}.';
              }

              notValues.add({
                'id': id,
                'title': 'שבת שלום מאפליקציית קודש',
                'body': body,
                'date': x,
                'payload': ShabatAndHolidaysCheckList.routeName
              });
              id++;
            }

            if (shabatAndHolidaysCandles) {
              x = e.entryDate!.subtract(Duration(
                  hours: beforeShabatAndHolidaysCandlesHours,
                  minutes: beforeShabatAndHolidaysCandlesMinutes));

              if (now.isBefore(x)) {
                String body =
                    'בעוד $beforeShabatAndHolidaysCandlesHours שעות ו-$beforeShabatAndHolidaysCandlesMinutes דקות תכנס השבת , לא לשכוח להדליק נרות.';

                notValues.add({
                  'id': id,
                  'title': 'שבת שלום מאפליקציית קודש - זמן להדלקת נרות',
                  'body': body,
                  'date': x,
                  'payload': AdlakatNerot.routeName,
                });
                id++;
              }
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
              String body = 'ביקשת שנזכיר לך:';
              for (int i = 0;
                  i < shabatAndHolidaysThingsToRemindList.length;
                  i++) {
                if (e.subcat == 'major') {
                  body +=
                      '\n${i + 1}. ${allShabatAndHolidaysThingsToRemindMap(context)[shabatAndHolidaysThingsToRemindList[i]]!['text']}';
                }
              }
              if (DateFormat('HH:mm').format(e.entryDate!) != '00:00') {
                body +=
                    '.\nהדלקת נרות בשעה ${DateFormat('HH:mm').format(e.entryDate!)}.';
              }

              if (e.releaseDate != null) {
                body +=
                    '\nזמן הבדלה: ${DateFormat('dd/MM/yy - hh:mm').format(e.releaseDate!)}.';
              }

              notValues.add({
                'id': id,
                'title': e.title,
                'body': body,
                'date': x,
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
              // 'tzDateTime': TZDateTime.from(dayBefore, local)
            });
            id++;
            for (TZDateTime tz in tefilinDates) {
              String tefTzFormated = DateFormat('dd/MM/yy').format(tz);
              if ((e.entryDate != null &&
                        DateFormat('dd/MM/yy').format(e.entryDate!) ==
                            tefTzFormated) ||
                    (e.releaseDate != null &&
                        DateFormat('dd/MM/yy').format(e.releaseDate!) ==
                            tefTzFormated)) {
                  Map<String, Object> toChange = notValues
                      .firstWhere((element) => element['date'] == tefTzFormated);
                  toChange['body'] = '${toChange['body']}\nלא לשכוח היום ראש חודש.';
                  notValues[toChange['id'] as int] = toChange;
              }
            }
          }
        }

        //else if(shabatAndHolidays && e is Shabat){ // tefila

        // }else if(shabatAndHolidays && e is Shabat){ // נרורת חנוכה ???

        // }else if(shabatAndHolidays && e is Shabat){ // ספירת העומר ???

        // }
      }
    }

    for (Map<String, Object> e in notValues) {
      await NotificationApi.showSchedualedNotification(
        id: e['id'] as int,
        title: e['title'] as String,
        body: e['body'] as String,
        date: e['date'] as DateTime,
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
      notValues.add({
        'id': id,
        'title': 'תפילין',
        'body': 'הגיע הזמן להניח תפילין!',
        'date': tz,
        'payload': SederAnahatTefilin.routeName
      });
      id++;
    }

    // for (TZDateTime tz in tefilinDates) {
    //   await NotificationApi.showSchedualedNotification(
    //           id: id,
    //           title: 'תפילין',
    //           body: 'הגיע הזמן להניח תפילין!',
    //           date: tz,
    //           payload: SederAnahatTefilin.routeName)
    //       .then((value) => id++);
    // }
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
