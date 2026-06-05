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
import 'package:kodesh_app/api/l10n/app_localizations.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    logger.e('Flutter error',
        error: details.exception, stackTrace: details.stack);
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
        ChangeNotifierProvider(
            create: (_) => LanguageChangeProvider()..getData()),
        ChangeNotifierProvider(create: (_) => Tfilot()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color _seed = Color(0xFF0047AE);

  static final ThemeData _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      primary: _seed,
      brightness: Brightness.light,
    ).copyWith(
      secondary: const Color(0xFF1565C0),
      secondaryContainer: const Color(0xFFD6E4FF),
      onSecondary: Colors.white,
      onSecondaryContainer: const Color(0xFF001E6C),
      tertiary: const Color(0xFF0D47A1),
      tertiaryContainer: const Color(0xFFBBDEFB),
      onTertiary: Colors.white,
      onTertiaryContainer: const Color(0xFF001E6C),
    ),
    useMaterial3: true,
  );

  static final ThemeData _darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      primary: _seed,
      brightness: Brightness.dark,
    ).copyWith(
      surface: const Color(0xFF1A1A2E),
      secondary: const Color(0xFF90CAF9),
      secondaryContainer: const Color(0xFF0D47A1),
      onSecondary: const Color(0xFF003065),
      onSecondaryContainer: const Color(0xFFD6E4FF),
      tertiary: const Color(0xFFBBDEFB),
      tertiaryContainer: const Color(0xFF1565C0),
      onTertiary: const Color(0xFF003065),
      onTertiaryContainer: const Color(0xFFD6E4FF),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF1A1A2E),
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
