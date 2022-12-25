import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {

  MaterialColor mycolor = const MaterialColor(0xFF0047AE, <int, Color>{
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

    Reminders reminders = Reminders(context);
    Events events = Events();
    LanguageChangeProvider lang = LanguageChangeProvider();
    lang.getData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => events),
        ChangeNotifierProvider(create: (context) => reminders),
        ChangeNotifierProvider(create: (context) => lang),
        ChangeNotifierProvider(create: (context) => Tfilot()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          locale: Provider.of<LanguageChangeProvider>(context).currentLocale,
          title: 'Kodesh',
          theme: ThemeData(
            primarySwatch: mycolor,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: const EventScreen(),
          routes: {
            SchedualNotficationsScreen.routeName: (_) =>
                const SchedualNotficationsScreen(),
            SederAnahatTefilin.routeName: (_) => SederAnahatTefilin(),
            AdlakatNerot.routeName: (_) => AdlakatNerot(),
            ShabatAndHolidaysCheckList.routeName: (_) =>
                const ShabatAndHolidaysCheckList(),
            CompassScreen.routeName: (_) =>
                const CompassScreen(),
            AdlakatNerotChanukah.routeName: (_) =>
                AdlakatNerotChanukah(),
            SfiratOmerScreen.routeName: (_) =>
                SfiratOmerScreen(),
          },
        );
      }),
    );
  }
}
