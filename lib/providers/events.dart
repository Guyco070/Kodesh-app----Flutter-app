import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:http/http.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/models/rosh_chodesh.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/models/zman.dart';
import 'package:kodesh_app/widgets/events_widgets/holiday_widget.dart';
import 'package:kodesh_app/widgets/events_widgets/rosh_chodesh_widget.dart';
import 'package:kodesh_app/widgets/events_widgets/sfirat_omer_widget.dart';
import 'package:kodesh_app/widgets/events_widgets/shabat_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Events with ChangeNotifier {
  List<Event>? _eventsItems = [];
  List<Zman>? _zmanimItems = [];
  String city = 'IL-Jerusalem|281184';
  DateTime startDate = DateTime.now();
  bool isOnlyShabat = false;
  bool isTodayTimesFromNow = false;

  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  Future<void> changeLocale(String locale, {Function? setIsLoading}) async {
    if (_currentLocale.languageCode != locale) {
      _currentLocale = Locale(locale);

      if (setIsLoading != null) setIsLoading(true);

      fetchAndSetProducts().then((value) {
        if (setIsLoading != null) setIsLoading(false);
      });
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('language', locale);
    }
  }

  static const eventTypes = [
    'candles',
    'havdalah',
    'parashat',
    'holiday',
    'roshchodesh',
  ];

  List<Event>? get eventsItems {
    return _eventsItems == null ? null : [..._eventsItems!];
  }

  List<Zman>? get zmanimItems {
    return _zmanimItems == null ? null : [..._zmanimItems!];
  }

  setCity(String newCity, {Function? setIsLoading}) async {
    city = newCity;
    if (setIsLoading != null) setIsLoading(true);

    fetchAndSetProducts().then((value) {
      if (setIsLoading != null) setIsLoading(false);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', city);
  }

  updateIsOnlyShabat() async {
    isOnlyShabat = !isOnlyShabat;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnlyShabat', isOnlyShabat);
  }

  updateIsTodayTimesFromNow() async {
    isTodayTimesFromNow = !isTodayTimesFromNow;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isTodayTimesFromNow', isTodayTimesFromNow);
  }

  setStartDate(DateTime newDate, {required Function? setIsLoading}) {
    startDate = newDate;
    if (setIsLoading != null) setIsLoading(true);

    fetchAndSetProducts().then((value) {
      if (setIsLoading != null) setIsLoading(false);
    });
  }

  Future<bool> isThereInternetConnection() async =>
      await InternetConnectionChecker().hasConnection;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> prefsKeys = prefs.getKeys();

    if (prefsKeys.contains('city')) {
      city = prefs.getString('city')!;
    }
    if (prefsKeys.contains('isOnlyShabat')) {
      isOnlyShabat = prefs.getBool('isOnlyShabat')!;
    }
    if (prefsKeys.contains('isTodayTimesFromNow')) {
      isTodayTimesFromNow = prefs.getBool('isTodayTimesFromNow')!;
    }
    if (prefsKeys.contains('language')) {
      _currentLocale = Locale(prefs.getString('language')!);
    }

    notifyListeners();
  }

  tryFetch({String? cityToTake, String? lang, bool isToday = false}) async {
    cityToTake ??= city;
    var response;
    var url = Uri.parse(isToday
        ? 'https://www.hebcal.com/shabbat?cfg=json&o=on&zip=${cityToTake.split('|')[1]}&lg=${lang ?? _currentLocale.languageCode}'
        : 'https://www.hebcal.com/shabbat?cfg=json&o=on&gy=${startDate.year}&gm=${startDate.month}&gd=${startDate.day}&zip=${cityToTake.split('|')[1]}&lg=${lang ?? _currentLocale.languageCode}');
    // print(url);
    response = await get(url);
    if ((jsonDecode(response.body) as Map<String, dynamic>)
        .keys
        .contains('error')) {
      url = Uri.parse(isToday
          ? 'https://www.hebcal.com/shabbat?cfg=json&o=on&city=${cityToTake.split('|')[0]}&lg=${lang ?? _currentLocale.languageCode}'
          : 'https://www.hebcal.com/shabbat?cfg=json&o=on&gy=${startDate.year}&gm=${startDate.month}&gd=${startDate.day}&city=${cityToTake.split('|')[0]}&lg=${lang ?? _currentLocale.languageCode}');
      // print(url);

      response = await get(url);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<Event>?> fetchAndSetProducts(
      {bool filterByUser = false,
      bool getDataFirst = false,
      String lang = 'en',
      void Function(bool bool)? setIsThereInternetConnection}) async {
    if (getDataFirst) await getData();

    if (await isThereInternetConnection()) {
      try {
        final extractData = await tryFetch();
        // print(extractData);
        _eventsItems = [];
        _eventsItems = getEventsItemsFromMap(extractData['items'] as List);
        await fetchAndSetZmanimProducts(lang: _currentLocale.languageCode);
        notifyListeners();
        return _eventsItems;
      } catch (error) {
        rethrow;
      }
    } else {
      _eventsItems = null;
      _zmanimItems = null;
      notifyListeners();
      return _eventsItems;
    }
  }

  static getEventsItemsFromMap(items) {
    if (items == null) return null;
    List<Event> tempItems = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i]['category'] == 'parashat') {
        int tempI = i - 1;
        while (tempI != -1 && items[tempI]['category'] != 'candles') {
          tempI--;
        }
        Shabat newS = Shabat.createShabat(
            title: items[tempI + 1]['title'] != items[i]['title']
                ? items[tempI + 1]['title']
                : null,
            candles: items[tempI],
            parashat: items[i],
            havdalah: items[i + 1]);
        tempItems.add(newS);
      } else if (items[i]['category'] == 'holiday') {
        if (i == 0) {
          tempItems.add(Holiday.createHoliday(
              candles: null,
              parashat: items[i],
              havdalah: items[i + 1]['category'] == 'havdalah'
                  ? items[i + 1]
                  : null));
        } else if (i == items.length - 1) {
          tempItems.add(Holiday.createHoliday(
              candles: null, parashat: items[i], havdalah: null));
        } else {
          if (items[i + 1]['category'] == 'havdalah') {
            tempItems.add(Holiday.createHoliday(
                candles:
                    items[i - 1]['category'] == 'candles' ? items[i - 1] : null,
                parashat: items[i],
                havdalah: items[i + 1]['category'] == 'havdalah'
                    ? items[i + 1]
                    : null));
          } else {
            tempItems.add(Holiday.createHoliday(
                candles: null,
                parashat: items[i],
                havdalah: items[i + 1]['category'] == 'havdalah'
                    ? items[i + 1]
                    : null));
          }
        }
      } else if (items[i]['category'] == 'roshchodesh') {
        RoshChodesh newRs = RoshChodesh.createRoshChodesh(
            candles: null, parashat: items[i], havdalah: null);
        int? index;
        for (Event e in tempItems) {
          if (e is RoshChodesh) {
            newRs = RoshChodesh.marge(newRs, e);
            index = tempItems.indexOf(e);
          }
        }
        if (index != null) tempItems.removeAt(index);
        tempItems.add(newRs);
      } else if (items[i]['category'] == 'omer') {
        tempItems.add(SfiratOmer.createSfiratOmer(
              candles: null,
              parashat: items[i],
            ));
      }
    }

    // Shabat newS = Shabat.createShabat(candles: {
    //   'date': DateTime.now().subtract(const Duration(days: 1)).toString()
    // }, parashat: {
    //   'title': 'ddddd'
    // }, havdalah: {
    //   'date': DateTime.now().add(const Duration(seconds: 2)).toString()
    // }); // try for ome more minute from now
    // tempItems.add(newS);
    // Holiday newH = Holiday(title: 'חג', subcat: 'major', entryDate: DateTime.now().add(const Duration(days: 1),), releaseDate: DateTime.now().add(const Duration(days: 1))); // try
    // tempItems.add(newH);
    List<int> toRemove = [];
    for (int i = 0; i < tempItems.length; i++) {
      for (Event x in tempItems) {
        if (tempItems[i] != x && tempItems[i].title == x.title) {
          if (tempItems[i].entryDate!.minute == 0 &&
              tempItems[i].entryDate!.hour == 0) {
            toRemove.add(i);
          }
        }
      }
    }

    List<Event> aftetrFiltering = [];
    for (int i = 0; i < tempItems.length; i++) {
      if (!toRemove.contains(i)) {
        aftetrFiltering.add(tempItems[i]);
      }
    }
    return aftetrFiltering;
  }

  tryFetchZmanim(
      {String? cityToTake, String? lang, bool isToday = false}) async {
    cityToTake ??= city;
    var response;
    var url = Uri.parse(isToday
        ? 'https://www.hebcal.com/zmanim?cfg=json&zip=${cityToTake.split('|')[1]}&lg=${lang ?? _currentLocale.languageCode}'
        : 'https://www.hebcal.com/zmanim?cfg=json&date=${getDushedFormatedDate(startDate)}&zip=${cityToTake.split('|')[1]}&lg=${lang ?? _currentLocale.languageCode}');
    response = await get(url);
    if ((jsonDecode(response.body) as Map<String, dynamic>)
        .keys
        .contains('error')) {
      url = Uri.parse(isToday
          ? 'https://www.hebcal.com/zmanim?cfg=json&city=${cityToTake.split('|')[0]}&lg=${lang ?? _currentLocale.languageCode}'
          : 'https://www.hebcal.com/zmanim?cfg=json&date=${getDushedFormatedDate(startDate)}&city=${cityToTake.split('|')[0]}&lg=${lang ?? _currentLocale.languageCode}');
      response = await get(url);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<Zman>?> fetchAndSetZmanimProducts(
      {bool filterByUser = false,
      bool getDataFirst = false,
      String lang = 'en',
      void Function(bool bool)? setIsThereInternetConnection}) async {
    if (getDataFirst) await getData();
    // if (await isThereInternetConnection()) {
    try {
      final extractData = await tryFetchZmanim();
      _zmanimItems = [];
      _zmanimItems =
          getZmanimItemsFromMap(extractData['times'] as Map<String, dynamic>);
      // notifyListeners();
      return _zmanimItems;
    } catch (error) {
      rethrow;
    }
    // } else {
    //   _zmanimItems = null;
    //   notifyListeners();
    //   return _zmanimItems;
    // }
  }

  static getZmanimItemsFromMap(Map<String, dynamic> items) {
    List<Zman> tempItems = [];
    for (var i in items.keys) {
      DateTime? date = DateTime.tryParse(getDateWithoutTime(items[i]));
      if (date != null) tempItems.add(Zman(i, date));
    }
    return tempItems;
  }

  static getDateWithoutTime(String date) {
    if (date.contains('T')) {
      date = date.substring(0, date.length - 6).toString();
    }
    return date;
  }

  static Widget? eventsFactoryMethod(Event event) {
    if (event is Shabat) return ShabatWidget(data: event);
    if (event is Holiday) return HolidayWidget(data: event);
    if (event is RoshChodesh) return RoshChodeshWidget(data: event);
    if (event is SfiratOmer) return SfiratOmerWidget(data: event);
  }
}
