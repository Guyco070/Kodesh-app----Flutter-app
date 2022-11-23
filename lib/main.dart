import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/screens/schedual_notifications.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (context) =>  Events()),
          ChangeNotifierProvider(create: (context) =>  Reminders()),
        ],
      child: MaterialApp(
        title: 'Kodesh',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const EventScreen(),
        routes: {
          SchedualNotficationsScreen.routeName:(context) => const SchedualNotficationsScreen(),
        },
      ),
    );
  }
}
