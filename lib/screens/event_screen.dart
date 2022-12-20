import 'package:flutter/material.dart';
import 'package:kodesh_app/animations/animated_events_list_view.dart';
import 'package:kodesh_app/animations/animated_from_now_on_times_list.dart';
import 'package:kodesh_app/animations/animated_only_shabat.dart';
import 'package:kodesh_app/animations/animated_times_list_view.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/models/zman.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:kodesh_app/widgets/events_widgets/event_factory_widget.dart';
import 'package:kodesh_app/widgets/settings_bar.dart';
import 'package:kodesh_app/widgets/zman_widget.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart';
import '../api/notification_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ViewState {
  events,
  zmanim,
}

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isOnlyShabat = false;
  bool _isTodayTimesFromNow = false;

  String? title;

  bool _isThereInternetConnection = false;

  ViewState _viewState = ViewState.events;

  @override
  void initState() {
    initializeTimeZones();

    super.initState();
    if (NotificationApi.isFirstInit) {
      NotificationApi.initialize();
      NotificationApi.onNotifications.distinct();
      listenNotifictions();
      NotificationApi.isFirstInit = false;
    }
  }

  void listenNotifictions() async {
    NotificationApi.onNotifications.stream.listen(onClickNotification);
  }

  void onClickNotification(String? payload) async {
    if (payload != '') {
      bool isNeedToNavigate = true;

      Navigator.of(context).popUntil((route) {
        isNeedToNavigate = !(route.settings.name == payload);
        return (route.isFirst && route.isCurrent) ||
            route.settings.name == payload;
      }); // pop until route is equal to the payload route or route is the route of first page
      if (isNeedToNavigate) {
        // only if route is not equal to the payload
        Navigator.pushNamed(context, payload!);
      }
    }
  }

  void setIsThereInternetConnection(bool bool) => setState(() {
        _isThereInternetConnection = bool;
      });

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Events>(context, listen: false)
          .fetchAndSetProducts(
              getDataFirst: true,
              lang: Provider.of<LanguageChangeProvider>(context)
                  .currentLocale
                  .languageCode)
          .then((items) {
        setIsThereInternetConnection(items != null);
        setIsLoading(false);
        // getZmanim();
      });
    }

    setState(() {
      _isInit = false;
    });

    super.didChangeDependencies();
  }

  setIsLoading(bool newVal) {
    setState(() {
      _isLoading = newVal;
    });
  }

  SizedBox renderLoading(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _getEventwidgets(
    List<Event> events, bool isOnlyShabat) {
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
    if (isOnlyShabat) return AnimatedOnlyShabatListView(widgets: widgets);
    return AnimatedEventsListView(widgets: widgets);
  }

  void getZmanim() {
    // setIsLoading();
    Provider.of<Events>(context, listen: false)
        .fetchAndSetZmanimProducts(
            // getDataFirst: true,
            lang: Provider.of<LanguageChangeProvider>(context)
                .currentLocale
                .languageCode)
        .then((items) {
      setIsThereInternetConnection(items != null);
      // setIsLoading();
    });
  }

  Widget _getZmanimWidgets(List<Zman> zmanim) {
    List<Widget> widgets = [];
    zmanim.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    DateTime now = DateTime.now();
    for (Zman z in zmanim) {
      if (!_isTodayTimesFromNow || z.date.isAfter(now)) {
        widgets.add(ZmanWidget(data: z));
      }
    }

    if (widgets.isEmpty) {
      widgets.add(SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
              child: Text(AppLocalizations.of(context)!.noLaterTimesToShow))));
    } else {
      widgets.add(const SizedBox(
        height: 10,
      ));
    }
    if (_isTodayTimesFromNow) return AnimatedFromNowOnTimesListView(widgets: widgets);
    return AnimatedTimesListView(widgets: widgets);
  }

  setViewState(ViewState newViewState) {
    setState(() {
      _viewState = newViewState;
    });
  }

  setIsOnlyShabat() {
    Provider.of<Events>(context, listen: false).updateIsOnlyShabat();
    setState(() {
      _isOnlyShabat = !_isOnlyShabat;
    });
  }

  setIsTodayTimesFromNow() {
    // not work if its means it will be empty
    Provider.of<Events>(context, listen: false).updateIsTodayTimesFromNow();
    setState(() {
      _isTodayTimesFromNow = !_isTodayTimesFromNow;
    });
  }

  Widget renderNoInternetConnection(String localErrorMessage) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (2 / 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.signal_cellular_nodata_rounded,
            color: Colors.red,
            size: 25,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            localErrorMessage,
            // 'מצטערים, נראה שאין חיבור לאינטרנט, אנה התחבר ולחץ על כפתור רענון.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    Padding viewSwitch = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: !LanguageChangeProvider.isDirectionRTL(
                                  events.currentLocale.languageCode)
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(50))
                              : const BorderRadius.only(
                                  topRight: Radius.circular(50)))),
                  backgroundColor: _viewState == ViewState.events
                      ? MaterialStatePropertyAll<Color>(
                          Theme.of(context).primaryColor)
                      : MaterialStatePropertyAll<Color>(Colors.blue.shade800),
                ),
                onPressed: _viewState != ViewState.events
                    ? () => setViewState(ViewState.events)
                    : null,
                child: FittedBox(
                  child: Text(
                    appLocalizations.weekEvents,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: _viewState == ViewState.events
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                )),
          ),
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: LanguageChangeProvider.isDirectionRTL(
                                  events.currentLocale.languageCode)
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(50))
                              : const BorderRadius.only(
                                  topRight: Radius.circular(50)))),
                  backgroundColor: _viewState == ViewState.zmanim
                      ? MaterialStatePropertyAll<Color>(
                          Theme.of(context).primaryColor)
                      : MaterialStatePropertyAll<Color>(Colors.blue.shade800),
                ),
                onPressed: _viewState != ViewState.zmanim
                    ? () => setViewState(ViewState.zmanim)
                    : () {},
                child: FittedBox(
                  child: Text(
                    appLocalizations.todayTimes,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: _viewState == ViewState.zmanim
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                )),
          ),
        ],
      ),
    );

    return DefaultScaffold(
        setIsLoading: setIsLoading,
        title: AppLocalizations.of(context)!.main,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SettingsBar(
                isOnlyShabat: _viewState == ViewState.events
                    ? _isOnlyShabat
                    : _isTodayTimesFromNow,
                updateIsOnlyShabat: _viewState == ViewState.events
                    ? setIsOnlyShabat
                    : setIsTodayTimesFromNow,
                setIsLoading: setIsLoading,
                viewState: _viewState,
              ),
              viewSwitch,
              if (events.eventsItems != null) ...{
                if (_isLoading)
                  renderLoading(context)
                else ...{
                  _viewState == ViewState.events
                      ? _getEventwidgets(
                          events.eventsItems!, events.isOnlyShabat)
                      : _getZmanimWidgets(events.zmanimItems!)
                },
              } else ...{
                if (_isLoading)
                  renderLoading(context)
                else
                  renderNoInternetConnection(
                      AppLocalizations.of(context)!.noIntrnetMessage),
              },
              // ElevatedButton(
              //     onPressed: () async {
              //       await NotificationApi.showNotification(
              //           title: 'Guy',
              //           body:
              //               'Instant notfication Instant notification ddddd dasdasd  sadaghrtyj tyj ykluy  cfghb sgh sfgth trgh sdtfgh stdgh stdeh dth serth tgh s',
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
