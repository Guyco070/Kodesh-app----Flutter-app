import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/screens/shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:kodesh_app/screens/tpilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tpilot/seder_anahat_tefilin.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Reminders reminders = Reminders();
    Events events = Events();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => events),
        ChangeNotifierProvider(create: (context) => reminders),
      ],
      child: MaterialApp(
        title: 'Kodesh',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const EventScreen(),
        routes: {
          SchedualNotficationsScreen.routeName: (_) =>
              const SchedualNotficationsScreen(),
          SederAnahatTefilin.routeName:(_) => const SederAnahatTefilin(),
          AdlakatNerot.routeName: (_) => const AdlakatNerot(),
          ShabatAndHolidaysCheckList.routeName: (_) => const ShabatAndHolidaysCheckList(),
        },
      ),
    );
  }
}
