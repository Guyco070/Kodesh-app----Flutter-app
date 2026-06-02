import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/helpers/app_logger.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/screens/about.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/schedule_notifications.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/havdalah.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    logger.e('Flutter error', error: details.exception, stackTrace: details.stack);
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e('Uncaught async error', error: error, stackTrace: stack);
    return true;
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Events()),
        ChangeNotifierProvider(create: (_) => Reminders()),
        ChangeNotifierProvider(create: (_) => LanguageChangeProvider()..getData()),
        ChangeNotifierProvider(create: (_) => Tfilot()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const MaterialColor _primaryColor = MaterialColor(
    0xFF0047AE,
    <int, Color>{
      50: Color(0xFF0047AE),
      100: Color(0xFF0047AE),
      200: Color(0xFF0047AE),
      300: Color(0xFF0047AE),
      400: Color(0xFF0047AE),
      500: Color(0xFF0047AE),
      600: Color(0xFF0047AE),
      700: Color(0xFF0047AE),
      800: Color(0xFF0047AE),
      900: Color(0xFF0047AE),
    },
  );

  static final ThemeData _lightTheme = ThemeData(
    primarySwatch: _primaryColor,
    brightness: Brightness.light,
  );

  static final ThemeData _darkTheme = ThemeData(
    primarySwatch: _primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1A1A2E),
    cardColor: const Color(0xFF16213E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F3460),
      foregroundColor: Colors.white,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF16213E),
    ),
  );

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
      home: const EventScreen(),
      routes: {
        ScheduleNotificationsScreen.routeName: (_) =>
            const ScheduleNotificationsScreen(),
        SederAnahatTefilin.routeName: (_) => SederAnahatTefilin(),
        AdlakatNerot.routeName: (_) => AdlakatNerot(),
        ShabatAndHolidaysCheckList.routeName: (_) =>
            const ShabatAndHolidaysCheckList(),
        CompassScreen.routeName: (_) => const CompassScreen(),
        AdlakatNerotChanukah.routeName: (_) => AdlakatNerotChanukah(),
        SfiratOmerScreen.routeName: (_) => SfiratOmerScreen(),
        Havdalah.routeName: (_) => Havdalah(),
        AboutScreen.routeName: (_) => const AboutScreen(),
      },
    );
  }
}
