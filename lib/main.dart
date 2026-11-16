import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/helpers/app_logger.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/screens/about.dart';
import 'package:kodesh_app/screens/settings_screen.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/schedule_notifications.dart';
import 'package:kodesh_app/screens/app_start.dart';
import 'package:kodesh_app/providers/home_tab_controller.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/havdalah.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:kodesh_app/screens/tefilot/birkat_hamazon.dart';
import 'package:kodesh_app/screens/tefilot/kriyat_shema_al_hamita.dart';
import 'package:kodesh_app/screens/daf_yomi_screen.dart';
import 'package:kodesh_app/screens/holiday_calendar_screen.dart';
import 'package:kodesh_app/theme/kodesh_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    logger.e(
      'Flutter error',
      error: details.exception,
      stackTrace: details.stack,
    );
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e('Uncaught async error', error: error, stackTrace: stack);
    return true;
  };

  // Load the saved language before the first frame. Otherwise the first
  // events fetch can go out with the default 'en' locale while preferences
  // are still loading, and Hebcal returns English titles for a Hebrew UI.
  final languageProvider = LanguageChangeProvider();
  await languageProvider.getData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Events()),
        ChangeNotifierProvider(create: (_) => Reminders()),
        ChangeNotifierProvider.value(value: languageProvider),
        ChangeNotifierProvider(create: (_) => Tfilot()),
        ChangeNotifierProvider(create: (_) => HomeTabController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ThemeData _lightTheme = KodeshTheme.build(isDark: false);
  static final ThemeData _darkTheme = KodeshTheme.build(isDark: true);

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeProvider>(context);
    return MaterialApp(
      locale: langProvider.currentLocale,
      title: 'Kodesh',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: langProvider.themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: const AppStart(),
      routes: {
        SettingsScreen.routeName: (_) => const SettingsScreen(),
        ScheduleNotificationsScreen.routeName:
            (_) => const ScheduleNotificationsScreen(),
        SederAnahatTefilin.routeName: (_) => SederAnahatTefilin(),
        AdlakatNerot.routeName: (_) => AdlakatNerot(),
        ShabatAndHolidaysCheckList.routeName:
            (_) => const ShabatAndHolidaysCheckList(),
        CompassScreen.routeName: (_) => const CompassScreen(),
        AdlakatNerotChanukah.routeName: (_) => AdlakatNerotChanukah(),
        SfiratOmerScreen.routeName: (_) => SfiratOmerScreen(),
        Havdalah.routeName: (_) => Havdalah(),
        BirkatHamazon.routeName: (_) => BirkatHamazon(),
        KriyatShemaAlHamita.routeName: (_) => KriyatShemaAlHamita(),
        DafYomiScreen.routeName: (_) => const DafYomiScreen(),
        HolidayCalendarScreen.routeName: (_) => const HolidayCalendarScreen(),
        AboutScreen.routeName: (_) => const AboutScreen(),
      },
    );
  }
}
