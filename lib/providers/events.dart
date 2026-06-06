import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/helpers/app_logger.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
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
  String? _eventsError;
  String? _zmanimError;

  DateTime? _lastEventsFetch;
  DateTime? _lastZmanimFetch;
  static const Duration _fetchTtl = Duration(minutes: 30);

  double? _webLat;
  double? _webLng;
  String? _webTzid;

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

  List<Event>? get eventsItems =>
      _eventsItems == null ? null : [..._eventsItems!];

  List<Zman>? get zmanimItems =>
      _zmanimItems == null ? null : [..._zmanimItems!];

  String? get eventsError => _eventsError;
  String? get zmanimError => _zmanimError;

  Map<DateTime, String>? get hebrewDates {
    return _hebrewDates == null ? null : {..._hebrewDates!};
  }

  void setWebLocation(double lat, double lng, String tzid) {
    _webLat = lat;
    _webLng = lng;
    _webTzid = tzid;
    _lastEventsFetch = null;
    _lastZmanimFetch = null;
    _detectCityFromCoords(lat, lng);
    fetchAndSetProducts(forceRefresh: true);
    fetchAndSetZmanimProducts(forceRefresh: true);
  }

  Future<void> _detectCityFromCoords(double lat, double lng) async {
    try {
      final url = Uri.https('nominatim.openstreetmap.org', '/reverse', {
        'lat': lat.toStringAsFixed(6),
        'lon': lng.toStringAsFixed(6),
        'format': 'json',
        'zoom': '10',
      });
      final response = await get(
        url,
        headers: {'User-Agent': 'KodeshApp/1.0 (gaico070@gmail.com)'},
      );
      if (response.statusCode != 200) return;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final address = data['address'] as Map<String, dynamic>?;
      if (address == null) return;

      final countryCode = (address['country_code'] as String?)?.toUpperCase();
      final cityName =
          (address['city'] ??
                  address['town'] ??
                  address['municipality'] ??
                  address['village'] ??
                  address['county'])
              as String?;

      if (countryCode == null || cityName == null) return;

      final prefix = '$countryCode-';
      Map<String, dynamic>? bestMatch;
      int bestScore = -1;

      for (final c in cities) {
        final enName = c['en'] as String? ?? '';
        if (!enName.startsWith(prefix)) continue;
        final namePart = enName.substring(prefix.length).toLowerCase();
        final target = cityName.toLowerCase();

        int score = 0;
        if (namePart == target) {
          score = 100;
        } else if (target.contains(namePart) || namePart.contains(target)) {
          score = 70;
        } else if (target.startsWith(namePart) || namePart.startsWith(target)) {
          score = 50;
        }
        if (score > bestScore) {
          bestScore = score;
          bestMatch = c;
        }
      }

      if (bestMatch != null && bestScore > 0) {
        city = bestMatch['eNameAndCode'] as String;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('city', city);
        notifyListeners();
      }
    } catch (e) {
      logger.w('Reverse geocoding failed', error: e);
    }
  }

  /// Changing the [city] and adjusting the events and times to the selected city
  setCity(
    String newCity, {
    Function? setIsLoading,
    Function? setIsLoadingZmanim,
  }) async {
    city = newCity;
    if (setIsLoading != null) setIsLoading(true);

    fetchAndSetProducts(forceRefresh: true).then((value) {
      if (setIsLoading != null) setIsLoading(false);
    });

    if (setIsLoadingZmanim != null) setIsLoadingZmanim(true);

    fetchAndSetZmanimProducts(forceRefresh: true).then((value) {
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

  setStartDate(
    DateTime newDate, {
    required Function? setIsLoading,
    required Function? setIsLoadingZmanim,
  }) {
    startDate = newDate;
    if (setIsLoading != null) setIsLoading(true);

    fetchAndSetProducts(forceRefresh: true).then((value) {
      if (setIsLoading != null) setIsLoading(false);
    });

    if (setIsLoadingZmanim != null) setIsLoadingZmanim(true);

    fetchAndSetZmanimProducts(forceRefresh: true).then((value) {
      if (setIsLoadingZmanim != null) setIsLoadingZmanim(false);
    });
  }

  Future<bool> isThereInternetConnection() async =>
      await InternetConnection().hasInternetAccess;

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
    final parts = cityToTake.split('|');
    final geoId = parts.length > 1 ? parts[1] : '';
    final cityName = parts[0];
    final lg = lang ?? _currentLocale.languageCode;

    Map<String, String> base = {'cfg': 'json', 'o': 'on', 'lg': lg};
    if (!isToday) {
      base.addAll({
        'gy': startDate.year.toString(),
        'gm': startDate.month.toString(),
        'gd': startDate.day.toString(),
      });
    }

    Uri url;
    if (_webLat != null && _webLng != null) {
      url = Uri.https('www.hebcal.com', '/shabbat', {
        ...base,
        'latitude': _webLat!.toString(),
        'longitude': _webLng!.toString(),
        'tzid': _webTzid ?? 'UTC',
      });
    } else {
      url = Uri.https('www.hebcal.com', '/shabbat', {...base, 'zip': geoId});
    }
    var response = await get(url);
    if ((jsonDecode(response.body) as Map<String, dynamic>).keys.contains(
      'error',
    )) {
      url = Uri.https('www.hebcal.com', '/shabbat', {
        ...base,
        'city': cityName,
      });
      logger.d('Retrying shabbat fetch with city name');
      response = await get(url);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<Event>?> fetchAndSetProducts({
    bool filterByUser = false,
    bool getDataFirst = false,
    bool forceRefresh = false,
    String lang = 'en',
    void Function(bool bool)? setIsThereInternetConnection,
  }) async {
    if (getDataFirst) await getData();

    if (!forceRefresh &&
        _eventsItems != null &&
        _eventsItems!.isNotEmpty &&
        _lastEventsFetch != null &&
        DateTime.now().difference(_lastEventsFetch!) < _fetchTtl) {
      return _eventsItems;
    }

    _eventsError = null;

    if (await isThereInternetConnection()) {
      try {
        final extractData = await tryFetch();
        final items = extractData['items'] as List;
        _eventsItems = getEventsItemsFromMap(items);
        _lastEventsFetch = DateTime.now();
        _cacheEventsItems(items);
        notifyListeners();
        fetchAndSetHebrewDatesProducts();
        return _eventsItems;
      } catch (error, st) {
        logger.e('Failed to fetch events', error: error, stackTrace: st);
        _eventsItems = null;
        _eventsError = error.toString();
        notifyListeners();
        return null;
      }
    } else {
      final cached = await _loadCachedEventsItems();
      if (cached != null) {
        _eventsItems = cached;
        _zmanimItems = null;
        _hebrewDates = null;
        notifyListeners();
        return _eventsItems;
      }
      _eventsItems = null;
      _zmanimItems = null;
      _hebrewDates = null;
      notifyListeners();
      return null;
    }
  }

  Future<void> _cacheEventsItems(List items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cachedEventsJson_$city', jsonEncode(items));
    } catch (e) {
      logger.w('Failed to cache events', error: e);
    }
  }

  Future<List<Event>?> _loadCachedEventsItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('cachedEventsJson_$city');
      if (cached == null) return null;
      final items = jsonDecode(cached) as List;
      logger.i('Loaded ${items.length} events from cache');
      return getEventsItemsFromMap(items) as List<Event>?;
    } catch (e) {
      logger.w('Failed to load cached events', error: e);
      return null;
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
          // go back and search for shaabat candles lightning time
          tempI--;
        }
        Shabat newS = Shabat.createShabat(
          title:
              items[tempI + 1]['title'] != items[i]['title']
                  ? items[tempI + 1]['title']
                  : null,
          candles: items[tempI],
          parashat: items[i],
          havdalah: searchHavdalah(items, i),
        );

        tempItems.add(newS);
      } else if (items[i]['category'] == 'holiday') {
        if (i == 0) {
          tempItems.add(
            Holiday.createHoliday(
              candles: null,
              parashat: items[i],
              havdalah:
                  items[i + 1]['category'] == 'havdalah' ? items[i + 1] : null,
            ),
          );
        } else if (i == items.length - 1) {
          tempItems.add(
            Holiday.createHoliday(
              candles: null,
              parashat: items[i],
              havdalah: null,
            ),
          );
        } else {
          if (items[i + 1]['category'] == 'havdalah') {
            tempItems.add(
              Holiday.createHoliday(
                candles:
                    items[i - 1]['category'] == 'candles' ? items[i - 1] : null,
                parashat: items[i],
                havdalah:
                    items[i + 1]['category'] == 'havdalah'
                        ? items[i + 1]
                        : null,
              ),
            );
          } else {
            tempItems.add(
              Holiday.createHoliday(
                candles: null,
                parashat: items[i],
                havdalah:
                    items[i + 1]['category'] == 'havdalah'
                        ? items[i + 1]
                        : null,
              ),
            );
          }
        }
      } else if (items[i]['category'] == 'roshchodesh') {
        RoshChodesh newRs = RoshChodesh.createRoshChodesh(
          candles: null,
          parashat: items[i],
          havdalah: null,
        );
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
        tempItems.add(
          SfiratOmer.createSfiratOmer(candles: null, parashat: items[i]),
        );
      }
    }
    List<int> toRemove = [];
    for (int i = 0; i < tempItems.length; i++) {
      for (Event x in tempItems) {
        if (tempItems[i] != x &&
            tempItems[i].title == x.title &&
            tempItems[i].runtimeType == x.runtimeType) {
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

  tryFetchZmanim({
    String? cityToTake,
    String? lang,
    bool isToday = false,
  }) async {
    cityToTake ??= city;
    final parts = cityToTake.split('|');
    final geoId = parts.length > 1 ? parts[1] : '';
    final cityName = parts[0];
    final lg = lang ?? _currentLocale.languageCode;

    Map<String, String> base = {'cfg': 'json', 'lg': lg};
    if (!isToday) base['date'] = getDushedFormatedDate(startDate);

    Uri url;
    if (_webLat != null && _webLng != null) {
      url = Uri.https('www.hebcal.com', '/zmanim', {
        ...base,
        'latitude': _webLat!.toString(),
        'longitude': _webLng!.toString(),
        'tzid': _webTzid ?? 'UTC',
      });
    } else {
      url = Uri.https('www.hebcal.com', '/zmanim', {...base, 'zip': geoId});
    }
    var response = await get(url);
    if ((jsonDecode(response.body) as Map<String, dynamic>).keys.contains(
      'error',
    )) {
      url = Uri.https('www.hebcal.com', '/zmanim', {...base, 'city': cityName});
      response = await get(url);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<Zman>?> fetchAndSetZmanimProducts({
    bool filterByUser = false,
    bool getDataFirst = false,
    bool forceRefresh = false,
    String lang = 'en',
    void Function(bool bool)? setIsThereInternetConnection,
  }) async {
    if (!forceRefresh &&
        _zmanimItems != null &&
        _zmanimItems!.isNotEmpty &&
        _lastZmanimFetch != null &&
        DateTime.now().difference(_lastZmanimFetch!) < _fetchTtl) {
      return _zmanimItems;
    }

    _zmanimError = null;
    try {
      final extractData = await tryFetchZmanim();
      _zmanimItems = getZmanimItemsFromMap(
        extractData['times'] as Map<String, dynamic>,
      );
      _lastZmanimFetch = DateTime.now();
      notifyListeners();
      return _zmanimItems;
    } catch (error, st) {
      logger.e('Failed to fetch zmanim', error: error, stackTrace: st);
      _zmanimItems = null;
      _zmanimError = error.toString();
      notifyListeners();
      return null;
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

  Future<dynamic> tryFetchHebrewDates({
    String? cityToTake,
    String? lang,
    bool isToday = false,
  }) async {
    cityToTake ??= city;
    Response response;
    DateTime now = DateTime.now();
    // Start from the earlier of today or startDate; end 14 days after startDate
    // to cover the full displayed week even when viewing future weeks.
    final rangeStart =
        now.isBefore(startDate)
            ? now.subtract(const Duration(days: 1))
            : startDate.subtract(const Duration(days: 1));
    final rangeEnd = startDate.add(const Duration(days: 14));
    var url = Uri.https('www.hebcal.com', '/converter', {
      'cfg': 'json',
      'start': getDushedFormatedDate(rangeStart),
      'end': getDushedFormatedDate(rangeEnd),
    });
    response = await get(url);

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<void> fetchAndSetHebrewDatesProducts() async {
    try {
      final extractData = await tryFetchHebrewDates();
      _hebrewDates = getHebrewDatesItemsFromMap(
        extractData['hdates'] as Map<String, dynamic>,
      );
      notifyListeners();
    } catch (error, st) {
      logger.w(
        'Failed to fetch Hebrew dates (non-critical)',
        error: error,
        stackTrace: st,
      );
    }
  }

  getHebrewDatesItemsFromMap(Map<String, dynamic> items) {
    Map<DateTime, String> tempItems = {};
    DateTime? now = DateTime.now();

    if (LanguageChangeProvider.getCurrentLocale.languageCode == 'he') {
      tempItems[getDateTimeSetToZero(now)] =
          items[getDushedFormatedDate(now)]['hebrew'];
    } else {
      String dushedDate = getDushedFormatedDate(now);
      tempItems[getDateTimeSetToZero(now)] =
          '‎${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
    }
    if (_eventsItems != null) {
      for (Event e in _eventsItems!) {
        if (e.entryDate != null) {
          String dushedDate = getDushedFormatedDate(e.entryDate!);
          if (LanguageChangeProvider.getCurrentLocale.languageCode == 'he') {
            tempItems[e.entryDate!] = items[dushedDate]['hebrew'];
          } else {
            tempItems[e.entryDate!] =
                '‎${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
          }
          e.setEntryHebrewDate(tempItems[e.entryDate!]);
        }

        if (e.releaseDate != null) {
          String dushedDate = getDushedFormatedDate(e.releaseDate!);
          if (LanguageChangeProvider.getCurrentLocale.languageCode == 'he') {
            tempItems[e.releaseDate!] = items[dushedDate]['hebrew'];
          } else {
            tempItems[e.releaseDate!] =
                '‎${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
          }
          e.setReleaseHebrewDate(tempItems[e.releaseDate!]);
        }
      }
    }
    if (_zmanimItems != null) {
      for (Zman e in _zmanimItems!) {
        String dushedDate = getDushedFormatedDate(e.date);
        if (LanguageChangeProvider.getCurrentLocale.languageCode == 'he') {
          tempItems[e.date] = items[dushedDate]['hebrew'];
        } else {
          tempItems[e.date] =
              '‎${items[dushedDate]['hd']} ${items[dushedDate]['hm']} ${items[dushedDate]['hy']}';
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
    return null;
  }
}
