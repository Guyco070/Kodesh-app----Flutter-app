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

  /// [_eventsItems] : contains the asked week's events.
  List<Zman>? _zmanimItems = [];

  /// [_zmanimItems] : contains today's times.
  String city = 'IL-Jerusalem|281184';

  /// [city] : the city that the user chose for the events times.
  DateTime startDate = DateTime.now();

  /// [startDate] : represent the first date that the user want to see the events from. (until week later)
  bool isOnlyShabat = false;

  /// [isOnlyShabat] : if false - the user will see the details of all of the events at the week. else, the user will see only Shabat's details.
  bool isTodayTimesFromNow = false;

  /// [isTodayTimesFromNow] : if false - the user will see all of today's times. else, the user will see only the times from current moment to the end of the day.
  bool isHebrewDate = false;

  /// [isHebrewDate] : if false - the dates will view in Gregorian Date format. else, the dates will view in Hebrew Date format.
  Map<DateTime, String>? _hebrewDates = {};

  /// [_hebrewDates] : if isHebrewDate is true, fill in the Hebrew dates that correspond to the Gregorian dates of the events. Fill by fetching from an appropriate API.

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

  Map<DateTime, String>? get hebrewDates {
    return _hebrewDates == null ? null : {..._hebrewDates!};
  }

  /// Changing the [city] and adjusting the events and times to the selected city
  setCity(String newCity,
      {Function? setIsLoading, Function? setIsLoadingZmanim}) async {
    city = newCity;
    if (setIsLoading != null) setIsLoading(true);

    fetchAndSetProducts().then((value) {
      if (setIsLoading != null) setIsLoading(false);
    });

    if (setIsLoadingZmanim != null) setIsLoadingZmanim(true);

    fetchAndSetZmanimProducts().then((value) {
      if (setIsLoadingZmanim != null) setIsLoadingZmanim(false);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', city);
  }

  /// update [isOnlyShabat] value
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

  updateIsHebrewDate() async {
    isHebrewDate = !isHebrewDate;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isHebrewDate', isHebrewDate);
  }

  setStartDate(DateTime newDate,
      {required Function? setIsLoading,
      required Function? setIsLoadingZmanim}) {
    startDate = newDate;
    if (setIsLoading != null) setIsLoading(true);

    fetchAndSetProducts().then((value) {
      if (setIsLoading != null) setIsLoading(false);
    });

    if (setIsLoadingZmanim != null) setIsLoadingZmanim(true);

    fetchAndSetZmanimProducts().then((value) {
      if (setIsLoadingZmanim != null) setIsLoadingZmanim(false);
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
    if (prefsKeys.contains('isHebrewDate')) {
      isHebrewDate = prefs.getBool('isHebrewDate')!;
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
    Response response;
    var url = Uri.parse(isToday
        ? 'https://www.hebcal.com/shabbat?cfg=json&o=on&zip=${cityToTake.split('|')[1]}&lg=${lang ?? _currentLocale.languageCode}'
        : 'https://www.hebcal.com/shabbat?cfg=json&o=on&gy=${startDate.year}&gm=${startDate.month}&gd=${startDate.day}&zip=${cityToTake.split('|')[1]}&lg=${lang ?? _currentLocale.languageCode}');
    response = await get(url);
    if ((jsonDecode(response.body) as Map<String, dynamic>)
        .keys
        .contains('error')) {
      url = Uri.parse(isToday
          ? 'https://www.hebcal.com/shabbat?cfg=json&o=on&city=${cityToTake.split('|')[0]}&lg=${lang ?? _currentLocale.languageCode}'
          : 'https://www.hebcal.com/shabbat?cfg=json&o=on&gy=${startDate.year}&gm=${startDate.month}&gd=${startDate.day}&city=${cityToTake.split('|')[0]}&lg=${lang ?? _currentLocale.languageCode}');
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
        _eventsItems = [];
        _eventsItems = getEventsItemsFromMap(extractData['items'] as List);

        fetchAndSetHebrewDatesProducts();
        notifyListeners();

        return _eventsItems;
      } catch (error) {
        rethrow;
      }
    } else {
      _eventsItems = null;
      _zmanimItems = null;
      _hebrewDates = null;
      notifyListeners();
      return _eventsItems;
    }
  }

  static getEventsItemsFromMap(List? items) {
    dynamic searchHavdalah(List items, int index) {
      while (index < items.length) {
        if (items[index]['category'] == 'havdalah') {
          return items[index];
        }
        index++;
      }
    }

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
            havdalah: searchHavdalah(items, i));
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
                    : searchHavdalah(items, i)));
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
    List<int> toRemove = [];
    for (int i = 0; i < tempItems.length; i++) {
      for (Event x in tempItems) {
        if (tempItems[i] != x && tempItems[i].title == x.title && tempItems[i].runtimeType == x.runtimeType) {
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
    Response response;
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
    try {
      final extractData = await tryFetchZmanim();
      _zmanimItems = [];
      _zmanimItems =
          getZmanimItemsFromMap(extractData['times'] as Map<String, dynamic>);
      notifyListeners();
      return _zmanimItems;
    } catch (error) {
      rethrow;
    }
  }

  static getZmanimItemsFromMap(Map<String, dynamic> items) {
    List<Zman> tempItems = [];
    for (var i in items.keys) {
      DateTime? date = DateTime.tryParse(getDateWithoutTime(items[i]));
      if (date != null) tempItems.add(Zman(i, date));
    }
    return tempItems.isEmpty ? null : tempItems;
  }

  Future<dynamic> tryFetchHebrewDates(
      {String? cityToTake, String? lang, bool isToday = false}) async {
    cityToTake ??= city;
    Response response;
    DateTime now = DateTime.now();
    var url = Uri.parse(
        'https://www.hebcal.com/converter?cfg=json&start=${getDushedFormatedDate(now.isBefore(startDate) ? now.subtract(const Duration(days: 1)) : startDate.subtract(const Duration(days: 1)))}&&end=${getDushedFormatedDate(now.add(const Duration(days: 10)))}');
    response = await get(url);

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<DateTime, String>?> fetchAndSetHebrewDatesProducts(
      {bool filterByUser = false,
      bool getDataFirst = false,
      void Function(bool bool)? setIsThereInternetConnection}) async {
    try {
      tryFetchHebrewDates().then((extractData) {
        _hebrewDates = {};
        _hebrewDates = getHebrewDatesItemsFromMap(
            extractData['hdates'] as Map<String, dynamic>);
        notifyListeners();
      });

      return _hebrewDates;
    } catch (error) {
      rethrow;
    }
  }

  getHebrewDatesItemsFromMap(Map<String, dynamic> items) {
    Map<DateTime, String> tempItems = {};
    DateTime? now = DateTime.now();

    if (_currentLocale.languageCode == 'he') {
      tempItems[getDateTimeSetToZero(now)] =
          items[getDushedFormatedDate(now)]['hebrew'];
    } else {
      String dushedDate = getDushedFormatedDate(now);
      tempItems[getDateTimeSetToZero(now)] =
          '${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
    }
    if (_eventsItems != null) {
      for (Event e in _eventsItems!) {
        if (e.entryDate != null) {
          String dushedDate = getDushedFormatedDate(e.entryDate!);
          if (_currentLocale.languageCode == 'he') {
            tempItems[e.entryDate!] = items[dushedDate]['hebrew'];
          } else {
            tempItems[e.entryDate!] =
                '${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
          }
          e.setEntryHebrewDate(tempItems[e.entryDate!]);
        }

        if (e.releaseDate != null) {
          String dushedDate = getDushedFormatedDate(e.releaseDate!);
          if (_currentLocale.languageCode == 'he') {
            tempItems[e.releaseDate!] = items[dushedDate]['hebrew'];
          } else {
            tempItems[e.releaseDate!] =
                '${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
          }
          e.setReleaseHebrewDate(tempItems[e.releaseDate!]);
        }
      }
    }
    if (_zmanimItems != null) {
      for (Zman e in _zmanimItems!) {
        String dushedDate = getDushedFormatedDate(e.date);
        if (_currentLocale.languageCode == 'he') {
          tempItems[e.date] = items[dushedDate]['hebrew'];
        } else {
          tempItems[e.date] =
              '${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
        }
      }
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
