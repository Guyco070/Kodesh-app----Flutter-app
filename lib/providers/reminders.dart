import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/api/l10n/reminders_translates.dart';
import 'package:kodesh_app/api/notification_api.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/models/rosh_chodesh.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/screens/Shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Reminders with ChangeNotifier {
  int id = 0;
  bool shabatAndHolidays = false;
  bool nerotHanukkah = false;
  bool sfiratOmer = false;
  bool tefilin = false;
  bool preys = false;
  bool roshChodesh = false;

  String reminderCity = 'IL-Jerusalem|281184';
  String city = 'IL-Jerusalem|281184';
  int beforeShabatMinutes = 0;
  int beforeShabatHours = 0;

  int beforeNerotHanukkahMinutes = 0;
  int beforeNerotHanukkahHours = 0;

  bool shabatAndHolidaysCandles = false;
  int beforeShabatAndHolidaysCandlesMinutes = 5;
  int beforeShabatAndHolidaysCandlesHours = 0;

  String tefilinTime = '06:00';
  String roshChodeshTime = '06:00';
  String sfiratOmerTime = '06:00';

  List<Map<String, Object>> notValues = [];

  Reminders(BuildContext context) {
    getData(context);
  }

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

  setNerotHanukkah({bool? newNerotHanukkah}) {
    if (newNerotHanukkah != null) {
      nerotHanukkah = newNerotHanukkah;
    } else {
      nerotHanukkah = !nerotHanukkah;
    }
    notifyListeners();
  }

  setSfiratOmer({bool? newSfiratOmer}) {
    if (newSfiratOmer != null) {
      sfiratOmer = newSfiratOmer;
    } else {
      sfiratOmer = !sfiratOmer;
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

  setNerotHanukkahMinutes(int newBeforeNerotHanukkahMinutes) {
    beforeNerotHanukkahMinutes = newBeforeNerotHanukkahMinutes;
    notifyListeners();
  }

  setNerotHanukkahHours(int newBeforeNerotHanukkahHours) {
    beforeNerotHanukkahHours = newBeforeNerotHanukkahHours;
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

  void setSfiratOmerTime(String newSfiratOmerTime) {
    sfiratOmerTime = newSfiratOmerTime;
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

    if (prefsKeys.contains('sfiratOmer')) {
      sfiratOmer = prefs.getBool('sfiratOmer')!;
    }

    if (prefsKeys.contains('sfiratOmerTime')) {
      sfiratOmerTime = prefs.getString('sfiratOmerTime')!;
    }

    if (prefsKeys.contains('nerotHanukkah')) {
      nerotHanukkah = prefs.getBool('nerotHanukkah')!;
    }

    if (prefsKeys.contains('beforeNerotHanukkahHours')) {
      beforeNerotHanukkahHours = prefs.getInt('beforeNerotHanukkahHours')!;
    }

    if (prefsKeys.contains('beforeNerotHanukkahMinutes')) {
      beforeNerotHanukkahMinutes = prefs.getInt('beforeNerotHanukkahMinutes')!;
    }

    notifyListeners();

    setReminders();
  }

  updateAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('shabatAndHolidays', shabatAndHolidays);
    prefs.setInt('beforeShabatHours', beforeShabatHours);
    prefs.setInt('beforeShabatMinutes', beforeShabatMinutes);

    prefs.setString('reminderCity', reminderCity);

    prefs.setBool('tefilin', tefilin);
    prefs.setBool('roshChodesh', roshChodesh);
    prefs.setBool('sfiratOmer', sfiratOmer);

    prefs.setBool('nerotHanukkah', nerotHanukkah);
    prefs.setInt('beforeNerotHanukkahHours', beforeNerotHanukkahHours);
    prefs.setInt('beforeNerotHanukkahMinutes', beforeNerotHanukkahMinutes);

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
    if (roshChodesh) prefs.setString('sfiratOmerTime', sfiratOmerTime);
  }

  Future<void> setReminders({bool update = false, String? lang}) async {
    if (update) {
      updateAll();
    }

    if (lang == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Set<String> prefsKeys = prefs.getKeys();
      if (prefsKeys.contains('language')) {
        lang = prefs.getString('language')!;
      } else {
        lang = 'en';
      }
    }

    NotificationApi.cancelAll();
    id = 0;

    List<DateTime> tefilinDates = [];
    List<int> tzToRemove = [];
    notValues = [];
    if (tefilin) tefilinDates = await setRemindersForTefilin(lang);

    Events events = Events();
    if (await events.isThereInternetConnection()) {
      Map<String, dynamic> extractData = await events.tryFetch(
          cityToTake: reminderCity, isToday: true, lang: lang);
      List<Event> items = Events.getEventsItemsFromMap(extractData['items']);
      final DateTime now = DateTime.now();
      // items.add(Shabat(
      //     title: 'שבת',
      //     parasha: 'פָּרָשַׁת וַיִּשְׁלַח',
      //     entryDate: DateTime.now().add(const Duration(minutes: 3)),
      //     releaseDate: DateTime.now().add(const Duration(minutes: 10))));

      // items.add(Holiday(
      //     title: 'חג',
      //     entryDate: DateTime.now().add(const Duration(minutes: 3)),
      //     releaseDate: DateTime.now().add(const Duration(minutes: 10)),
      //     subcat: 'major'));

      // items.add(RoshChodesh(
      //     title: 'ראש חודש',
      //     entryDate: DateTime.now().add(const Duration(days: 1, seconds: 1)),
      //     releaseDate: DateTime.now().add(const Duration(days: 1, minutes: 10)),
      //     ));

      for (Event e in items) {
        if (shabatAndHolidays && e is! RoshChodesh && e is! SfiratOmer) {
          // if Shabat or Holiday
          DateTime? x;
          if (e is Holiday) {
            if (DateFormat('HH:mm').format(e.entryDate!) == '00:00') {
              x = DateTime(e.entryDate!.year, e.entryDate!.month,
                  e.entryDate!.day - 1, 20, 0);
            } else {
              x = e.entryDate!.subtract(Duration(
                  hours: beforeShabatHours, minutes: beforeShabatMinutes));
            }
          } else {
            x = e.entryDate!.subtract(Duration(
                hours: beforeShabatHours, minutes: beforeShabatMinutes));
          }

          if (nerotHanukkah && e.title.contains('Chanukah') ||
              (e.titleOrig != null && e.titleOrig!.contains('Chanukah'))) {
            // reminder to light Chanukah candles
            x = e.entryDate!.subtract(Duration(
                hours: beforeNerotHanukkahHours,
                minutes: beforeNerotHanukkahMinutes));

            if (now.isBefore(x)) {
              notValues.add({
                'id': id,
                'title': e.title.replaceFirst('Chanukah', 'Hanukkah'),
                'body': (e as Holiday).getReminderHanukkahCandlesBody(
                    beforeNerotHanukkahHours, beforeNerotHanukkahMinutes, lang),
                'date': x,
                'payload': AdlakatNerotChanukah.routeName,
              });
              id++;
            }
          } else if (now.isBefore(x)) {
            // reminder for chores before shabat
            notValues.add({
              'id': id,
              'title': e.getReminderTitle(lang),
              'body': e.getReminderBody(lang),
              'date': x,
              'payload': ShabatAndHolidaysCheckList.routeName
            });
            id++;

            if (shabatAndHolidaysCandles && e is Shabat ||
                (e is Holiday && e.subcat == 'major')) {
              // reminder for Hanukkah

              // shabat or holiday
              // reminder to light shabat candles
              x = e.entryDate!.subtract(Duration(
                  hours: beforeShabatAndHolidaysCandlesHours,
                  minutes: beforeShabatAndHolidaysCandlesMinutes));
              if (now.isBefore(x)) {
                notValues.add({
                  'id': id,
                  'title': e.getReminderCandlesTitle(lang),
                  'body': e.getReminderCandlesBody(
                      beforeShabatAndHolidaysCandlesHours,
                      beforeShabatAndHolidaysCandlesMinutes,
                      lang),
                  'date': x,
                  'payload': AdlakatNerot.routeName,
                });
              }
              id++;
            }
          }
        }

        if (e is Holiday &&
            !(e.title.contains('Chanukah') ||
                (e.titleOrig != null && e.titleOrig!.contains('Chanukah')))) {
          // removing tefillin reminders from holidays
          if (tefilinDates.isNotEmpty && e.releaseDate != null) {
            tzToRemove.add(tefilinDates.indexOf(tefilinDates[0]));
            for (DateTime dt in tefilinDates) {
              if (dt.isAfter(e.entryDate!) &&
                  dt.day == e.entryDate!.day &&
                  dt.month == e.entryDate!.month &&
                  dt.year == e.entryDate!.year) {
                DateTime temp = dt.add(const Duration(days: 1));

                while (temp.isBefore(e.releaseDate!)) {
                  tzToRemove.add(tefilinDates.indexOf(temp));
                  temp = temp.add(const Duration(days: 1));
                }
              }
            }
          }
        } else if (roshChodesh && e is RoshChodesh) {
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
              'title': e.getReminderTitle(lang),
              'body': e.getReminderBody(lang),
              'date': dayBefore,
            });
            id++;
          }

          for (DateTime tz in tefilinDates) {
            String tefTzFormated = DateFormat('dd/MM/yy').format(tz);
            if ((e.entryDate != null &&
                    DateFormat('dd/MM/yy').format(e.entryDate!) ==
                        tefTzFormated) ||
                (e.releaseDate != null &&
                    DateFormat('dd/MM/yy').format(e.releaseDate!) ==
                        tefTzFormated)) {
              Map<String, Object> toChange = notValues.firstWhere((element) =>
                  DateFormat('dd/MM/yy').format(element['date'] as DateTime) ==
                  tefTzFormated);

              toChange['title'] = RemindersTranslates
                      .tefilinReminderTranslated[lang]!['roshHodeshTitle']
                  as String;
              toChange['body'] = RemindersTranslates
                  .tefilinReminderTranslated[lang]!['roshHodeshBody'] as String;
              notValues[toChange['id'] as int] = toChange;
            }
          }
        } else if (sfiratOmer && e is SfiratOmer) {
          notValues.add({
            'id': id,
            'title': e.title,
            'body': e.sefira['sefira']
                [currentLocal.languageCode == 'he' ? 'he' : 'en'],
            'date': DateTime(
                e.entryDate!.year,
                e.entryDate!.month,
                e.entryDate!.day,
                getSfiratOmerTimeObject.hour,
                getSfiratOmerTimeObject.minute),
            'payload': SfiratOmerScreen.routeName,
          });
          id++;
        }

        //else if(shabatAndHolidays && e is Shabat){ // tefila
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

  Future<List<DateTime>> setRemindersForTefilin(String lang) async {
    DateTime first =
        NotificationApi.schedualeDailyDateTime(getTefilinTimeObject);
    final tzNow = DateTime.now();

    if (tzNow.isAfter(first)) {
      first = first.add(const Duration(days: 1));
    }
    if (first.weekday == 6) first = first.add(const Duration(days: 1));

    final tefilinDates = [
      first,
    ];

    String title =
        RemindersTranslates.tefilinReminderTranslated[lang]!['title'] as String;
    String body =
        RemindersTranslates.tefilinReminderTranslated[lang]!['body'] as String;
    notValues.add({
      'id': id,
      'title': title,
      'body': body,
      'date': first,
      'payload': SederAnahatTefilin.routeName
    });
    id++;
    for (int i = 0; i < 7; i++) {
      DateTime tz = tefilinDates.last
          .add(Duration(days: tefilinDates.last.weekday == 5 ? 2 : 1));
      tefilinDates.add(tz);
      notValues.add({
        'id': id,
        'title': title,
        'body': body,
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

  Time get getSfiratOmerTimeObject {
    int hour = int.parse(sfiratOmerTime.split(':')[0]);
    int minutes = int.parse(sfiratOmerTime.split(':')[1]);
    return Time(hour, minutes);
  }
}
