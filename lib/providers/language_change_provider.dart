import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeProvider with ChangeNotifier {
  static Locale _currentLocale = const Locale('en');
  static bool isInitialized = false;

  Locale get currentLocale => _currentLocale;
  static Locale get getCurrentLocale => _currentLocale;

  static bool isDirectionRTL(String? langCode) {
    return Bidi.isRtlLanguage(langCode ?? _currentLocale.languageCode);
  }

  void changeLocale(String locale) async {
    isInitialized = false;
    
    if (_currentLocale.languageCode != locale) {
      _currentLocale = Locale(locale);
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('language', locale);
    }

    isInitialized = true;
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> prefsKeys = prefs.getKeys();

    if (prefsKeys.contains('language')) {
      _currentLocale = Locale(prefs.getString('language')!);
    }

    isInitialized = true;

    notifyListeners();
  }
}
