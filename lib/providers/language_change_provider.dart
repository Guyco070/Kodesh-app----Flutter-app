import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeProvider with ChangeNotifier {
  static Locale _currentLocale = const Locale('en');
  static bool isInitialized = false;

  ThemeMode _themeMode = ThemeMode.system;

  Locale get currentLocale => _currentLocale;
  static Locale get getCurrentLocale => _currentLocale;
  ThemeMode get themeMode => _themeMode;

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

  void changeThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode.name);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> prefsKeys = prefs.getKeys();

    if (prefsKeys.contains('language')) {
      _currentLocale = Locale(prefs.getString('language')!);
    }

    if (prefsKeys.contains('themeMode')) {
      final name = prefs.getString('themeMode')!;
      _themeMode = ThemeMode.values.firstWhere(
        (m) => m.name == name,
        orElse: () => ThemeMode.system,
      );
    }

    isInitialized = true;

    notifyListeners();
  }
}
