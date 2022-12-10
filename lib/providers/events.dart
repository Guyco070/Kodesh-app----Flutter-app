import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:http/http.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/models/rosh_chodesh.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/widgets/events_widgets/holiday_widget.dart';
import 'package:kodesh_app/widgets/events_widgets/rosh_chodesh_widget.dart';
import 'package:kodesh_app/widgets/events_widgets/shabat_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Events with ChangeNotifier {
  List<Event>? _items = [];
  String city = 'IL-Jerusalem|281184';
  DateTime startDate = DateTime.now();
  bool isOnlyShabat = false;
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  void changeLocale(String locale, {Function? setIsLoading}) async {
    if(_currentLocale.languageCode != locale){
      _currentLocale = Locale(locale);
      if (setIsLoading != null) setIsLoading();

      fetchAndSetProducts().then((value) {
        if (setIsLoading != null) setIsLoading();
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

  List<Event>? get items {
    return _items == null ? null : [..._items!];
  }

  setCity(String newCity, {Function? setIsLoading}) async {
    city = newCity;
    if (setIsLoading != null) setIsLoading();

    fetchAndSetProducts().then((value) {
      if (setIsLoading != null) setIsLoading();
    });

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', city);
  }

  updateIsOnlyShabat() async {
    isOnlyShabat = !isOnlyShabat;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnlyShabat', isOnlyShabat);
  }

  setStartDate(DateTime newDate, {required Function? setIsLoading}) {
    startDate = newDate;
    if (setIsLoading != null) setIsLoading();

    fetchAndSetProducts().then((value) {
      if (setIsLoading != null) setIsLoading();
    });
    notifyListeners();
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
    if (prefsKeys.contains('language')) {
      _currentLocale = Locale(prefs.getString('language')!);
    }

    notifyListeners();
  }

  tryFetch({String? cityToTake, String lang = 'en' , bool isToday = false}) async {
    cityToTake ??= city;
    var response;
    var url = Uri.parse(isToday
        ? 'https://www.hebcal.com/shabbat?cfg=json&zip=${cityToTake.split('|')[1]}&lg=${_currentLocale.languageCode}'
        : 'https://www.hebcal.com/shabbat?cfg=json&gy=${startDate.year}&gm=${startDate.month}&gd=${startDate.day}&zip=${cityToTake.split('|')[1]}&lg=${_currentLocale.languageCode}');
    response = await get(url);
    if ((jsonDecode(response.body) as Map<String, dynamic>)
        .keys
        .contains('error')) {
      url = Uri.parse(isToday
          ? 'https://www.hebcal.com/shabbat?cfg=json&city=${cityToTake.split('|')[0]}&lg=${_currentLocale.languageCode}'
          : 'https://www.hebcal.com/shabbat?cfg=json&gy=${startDate.year}&gm=${startDate.month}&gd=${startDate.day}&city=${cityToTake.split('|')[0]}&lg=${_currentLocale.languageCode}');
      response = await get(url);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<Event>?> fetchAndSetProducts(
      {bool filterByUser = false,
      bool getDataFirst = false,
      String lang = 'en' ,
      void Function(bool bool)? setIsThereInternetConnection}) async {
    if (getDataFirst) await getData();
    if (await isThereInternetConnection()) {
      try {
        final extractData = await tryFetch(lang: lang);
        _items = [];
        _items = getEventsItemsFromMap(extractData['items'] as List);
        notifyListeners();
        return _items;
      } catch (error) {
        rethrow;
      }
    } else {
      _items = null;
      notifyListeners();
      return _items;
    }
  }

  static getEventsItemsFromMap(items) {
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
      }
    }
    // Shabat newS = Shabat.createShabat(
    //         candles: {'date': DateTime.now().add(Duration(minutes: 31, hours: 2)).toString()}, parashat: {'title': 'ddddd'}, havdalah: {'date': DateTime.now().add(Duration(seconds: 2)).toString()}); // try for ome more minute from now
    // tempItems.add(newS);

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
  }
}
