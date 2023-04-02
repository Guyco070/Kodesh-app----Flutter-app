import 'package:flutter/material.dart';
import 'package:kodesh_app/animations/animated_events_list_view.dart';
import 'package:kodesh_app/animations/animated_from_now_on_times_list.dart';
import 'package:kodesh_app/animations/animated_only_shabat.dart';
import 'package:kodesh_app/animations/animated_times_list_view.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/models/zman.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:kodesh_app/widgets/events_widgets/event_factory_widget.dart';
import 'package:kodesh_app/widgets/settings_bar.dart';
import 'package:kodesh_app/widgets/swiches/view_type_switch.dart';
import 'package:kodesh_app/widgets/zman_widget.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart';
import '../api/notification_api.dart';
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
  bool _isLoadingZmanim = true;
  bool _isLoadingLang = false;
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
      getAllData();
    }

    setState(() {
      _isInit = false;
    });

    super.didChangeDependencies();
  }

  getAllData() {
    _isLoading = true;
    String lang =
        Provider.of<LanguageChangeProvider>(context).currentLocale.languageCode;
    Provider.of<Events>(context, listen: false)
        .fetchAndSetProducts(getDataFirst: true, lang: lang)
        .then((items) {
      setIsThereInternetConnection(items != null);
      setIsLoading(false);
      getZmanim(lang: lang);
    });
  }

  setIsLoading(bool newVal) {
    setState(() {
      _isLoading = newVal;
    });
  }

  setIsLoadingZmanim(bool newVal) {
    setState(() {
      _isLoadingZmanim = newVal;
    });
  }

  setIsLoadingLang(bool newVal) {
    setState(() {
      _isLoadingLang = newVal;
    });
  }

  SizedBox renderLoading(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _getEventwidgets(List<Event> events, bool isOnlyShabat) {
    List<Widget> widgets = [];
    events.sort((a, b) {
      if (a.entryDate != null && b.entryDate != null) {
        return a.entryDate!.compareTo(b.entryDate!);
      }
      return 0;
    });
    for (var e in events) {
      if (e is Shabat) {
        e.title = e.title == 'Shabat'
            ? AppLocalizations.of(context)!.shabat
            : e.title = !e.title.contains(AppLocalizations.of(context)!.shabat)
                ? '${AppLocalizations.of(context)!.shabat} - ${e.title}'
                : e.title;
      }
      if (isOnlyShabat && (e is Shabat || e.entryDate?.hour != 0)) {
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

  void getZmanim({required String lang}) {
    setIsLoadingZmanim(true);
    Provider.of<Events>(context, listen: false)
        .fetchAndSetZmanimProducts(lang: lang)
        .then((items) {
      setIsLoadingZmanim(false);
    });
  }

  Widget _getZmanimWidgets(List<Zman>? zmanim) {
    List<Widget> widgets = [];
    if (zmanim != null) {
      zmanim.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      DateTime now = DateTime.now();
      var x = {};
      for (Zman z in zmanim) {
        x[z.title] = z.title;
        if (!_isTodayTimesFromNow || z.date.isAfter(now)) {
          widgets.add(ZmanWidget(data: z));
        }
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
    if (_isTodayTimesFromNow) {
      return AnimatedFromNowOnTimesListView(widgets: widgets);
    }
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

    return DefaultScaffold(
        setIsLoading: setIsLoadingLang,
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
                setIsLoadingZmanim: setIsLoadingZmanim,
                viewState: _viewState,
                isHebrewDate: events.isHebrewDate,
                updateIsHebrewDate: events.updateIsHebrewDate,
              ),
              if (LanguageChangeProvider.isInitialized && !_isLoadingLang)
                ViewTypeSwitch(
                    appLocalizations: appLocalizations,
                    viewState: _viewState,
                    setViewState: setViewState),
              if (events.eventsItems != null &&
                  _viewState == ViewState.events) ...{
                if (_isLoading || _isLoadingLang)
                  renderLoading(context)
                else ...{
                  _getEventwidgets(events.eventsItems!, events.isOnlyShabat)
                },
              } else if (events.zmanimItems != null &&
                  _viewState == ViewState.zmanim) ...{
                if (_isLoadingZmanim || _isLoadingLang)
                  renderLoading(context)
                else ...{_getZmanimWidgets(events.zmanimItems)},
              } else ...{
                if (_isLoading || _isLoadingLang)
                  renderLoading(context)
                else
                  renderNoInternetConnection(
                      AppLocalizations.of(context)!.noIntrnetMessage),
              },
            ],
          ),
        ));
  }
}
