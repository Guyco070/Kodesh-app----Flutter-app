import 'package:flutter/material.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/screens/sederAnahatTefilin.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:kodesh_app/widgets/events_widgets/event_factory_widget.dart';
import 'package:kodesh_app/widgets/settings_bar.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import '../api/notification_api.dart';
import 'package:timezone/data/latest.dart' as tz;

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isOnlyShabat = false;

  String? title;

  @override
  void initState() {
    super.initState();
    NotificationApi.initialize();
    NotificationApi.onNotifications.distinct();
    if (NotificationApi.isFirstInit) {
      listenNotifictions();
      NotificationApi.isFirstInit = false;
    }
  }

  void listenNotifictions() {
    NotificationApi.onNotifications.stream.listen(onClickNotification);
  }

  void onClickNotification(String? payload) async =>
      await Navigator.pushNamed(context, payload!);

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Events>(context, listen: false)
          .fetchAndSetProducts(getDataFirst: true)
          .then((_) => setIsLoading());
    }

    setState(() {
      _isInit = false;
    });

    super.didChangeDependencies();
  }

  setIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  List<Widget> _getEventwidgets(List<Event> events, bool isOnlyShabat) {
    List<Widget> widgets = [];
    events.sort((a, b) {
      if (a.entryDate != null && b.entryDate != null) {
        return a.entryDate!.compareTo(b.entryDate!);
      }
      return 0;
    });
    for (var e in events) {
      if (isOnlyShabat && e is Shabat) {
        widgets.add(EventFactoryWidget(data: e));
      } else if (!isOnlyShabat) {
        widgets.add(EventFactoryWidget(data: e));
      }
    }
    widgets.add(const SizedBox(
      height: 10,
    ));
    return widgets;
  }

  setIsOnlyShabat() {
    Provider.of<Events>(context, listen: false).updateIsOnlyShabat();
    setState(() {
      _isOnlyShabat = !_isOnlyShabat;
    });
  }

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context);
    return DefaultScaffold(
        title: 'ראשי',
        body: SingleChildScrollView(
          child: Column(
            children: [
              SettingsBar(
                isOnlyShabat: events.isOnlyShabat,
                updateIsOnlyShabat: setIsOnlyShabat,
                setIsLoading: setIsLoading,
              ),
              if (_isLoading)
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(child: CircularProgressIndicator()),
                )
              else
                ..._getEventwidgets(events.items, events.isOnlyShabat),
              // ElevatedButton(
              //     onPressed: () async {
              //       await NotificationApi.showNotification(
              //           title: 'Guy',
              //           body: 'Instant notfication',
              //           payload: SederAnahatTefilin.routeName);
              //     },
              //     child: const Text('Instant notification')),
              // ElevatedButton(
              //     onPressed: () async {
              //       await NotificationApi.showSchedualedNotification2(
              //           title: 'Guy',
              //           body: 'Schedualed notfication',
              //           date: tz.TZDateTime.from(
              //             DateTime.now().add(const Duration(seconds: 1)),
              //             tz.local,
              //           ),
              //           payload: SederAnahatTefilin.routeName);
              //     },
              //     child: const Text('Schedualed notification')),
              // ElevatedButton(
              //     onPressed: () async {
              //       tz.initializeTimeZones();

              //       tz.TZDateTime zonedTime =
              //           tz.TZDateTime.local(2022, 11, 27, 09, 07);
              //       print(zonedTime);
              //       print(tz.TZDateTime.from(
              //           DateTime.now().add(const Duration(seconds: 5)),
              //           tz.local));
              //       print(DateTime.now().add(const Duration(seconds: 5)));
              //     },
              //     child: const Text('date')),
            ],
          ),
        ));
  }
}
