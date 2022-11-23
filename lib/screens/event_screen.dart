import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:kodesh_app/widgets/events_widgets/event_factory_widget.dart';
import 'package:kodesh_app/widgets/loading_scaffold.dart';
import 'package:kodesh_app/widgets/settings_bar.dart';
import 'package:provider/provider.dart';
import '../api/notification_api.dart';

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

  late final NotificationApi service;
  @override
  void initState() {
    super.initState();

    var events = Provider.of<Events>(context, listen: false);
    events.getData();
    service = NotificationApi();
    service.initialize();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Events>(context, listen: false)
          .fetchAndSetProducts()
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

              ElevatedButton(
                  onPressed: () async {
                    await service.showNotification(
                        title: 'Guy', body: 'Instant notfication');
                  },
                  child: const Text('Instant notification')),
              ElevatedButton(
                  onPressed: () async {
                    await NotificationApi.showSchedualedNotification(
                          title: 'Guy', body: 'Schedualed notfication',
                          date: DateTime.now().add(const Duration(seconds: 5))
                        );
                  },
                  child: const Text('Schedualed notification'))
            ],
          ),
        ));
  }
}
