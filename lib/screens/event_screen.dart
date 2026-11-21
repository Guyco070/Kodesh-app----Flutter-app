import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:kodesh_app/animations/animated_events_list_view.dart';
import 'package:kodesh_app/animations/animated_only_shabat.dart';
import 'package:kodesh_app/animations/animated_zmanim_list.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/models/zman.dart';
import 'package:kodesh_app/models/zmanim_display_mode.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:kodesh_app/widgets/events_widgets/event_factory_widget.dart';
import 'package:kodesh_app/widgets/settings_bar.dart';
import 'package:kodesh_app/providers/home_tab_controller.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass_bottom_nav.dart';
import 'package:kodesh_app/widgets/shabbat_hero_card.dart';
import 'package:kodesh_app/widgets/zman_widget.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart';
import 'package:flutter/foundation.dart';
import '../api/notification_api.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/helpers/geolocation_helper.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/helpers/city_display.dart';
import 'package:kodesh_app/helpers/dates.dart';
import 'package:kodesh_app/helpers/home_summary.dart';
import 'package:kodesh_app/widgets/event_screen/home_stat_tile.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/widgets/event_screen/reminders_summary_card.dart';

const Set<String> _kValidNotificationRoutes = {
  '/schedule-notifications',
  '/seder_anahat_tefilin',
  '/adlakat_nerot',
  '/shabat_and_holidays_check_list',
  '/compass_screen',
  '/adlakat_nerot_chanuca',
  '/sfirat_omer_screen',
  '/havdalah',
  '/about',
};

enum ViewState { events, zmanim }

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
  String _zmanimSearchQuery = '';
  final TextEditingController _zmanimSearchController = TextEditingController();

  /// Keys of zmanim rows the user explicitly toggled. Interpreted relative to
  /// the active [ZmanimDisplayMode]: for collapsed modes a key means "expanded";
  /// for [ZmanimDisplayMode.expandedByDefault] a key means "collapsed".
  final Set<String> _expandedKeys = {};

  String? title;

  /// Home and Times are two tabs of the bottom navigation bar that both
  /// show this screen.
  ViewState get _viewState =>
      context.read<HomeTabController>().tab == HomeTab.times
          ? ViewState.zmanim
          : ViewState.events;

  @override
  void dispose() {
    _zmanimSearchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      initializeTimeZones();
      if (NotificationApi.isFirstInit) {
        NotificationApi.initialize();
        NotificationApi.onNotifications.distinct();
        listenNotifictions();
        NotificationApi.isFirstInit = false;
      }
    } else {
      _requestWebGeolocation();
    }
  }

  void _requestWebGeolocation() async {
    final location = await requestGeolocation();
    if (location != null && mounted) {
      Provider.of<Events>(
        context,
        listen: false,
      ).setWebLocation(location.lat, location.lng, location.tzid);
    }
  }

  void listenNotifictions() async {
    NotificationApi.onNotifications.stream.listen(onClickNotification);
  }

  void onClickNotification(String? payload) async {
    if (payload == null || payload.isEmpty) return;
    if (!_kValidNotificationRoutes.contains(payload)) return;

    bool isNeedToNavigate = true;
    Navigator.of(context).popUntil((route) {
      isNeedToNavigate = !(route.settings.name == payload);
      return (route.isFirst && route.isCurrent) ||
          route.settings.name == payload;
    });
    if (isNeedToNavigate) {
      Navigator.pushNamed(context, payload);
    }
  }

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
    Provider.of<Events>(
      context,
      listen: false,
    ).fetchAndSetProducts(getDataFirst: true, lang: lang).then((items) {
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
    bool isFirst = true;
    for (var e in events) {
      if (e is Shabat) {
        e.title =
            e.title == 'Shabat'
                ? AppLocalizations.of(context)!.shabat
                : e.title =
                    !e.title.contains(AppLocalizations.of(context)!.shabat)
                        ? '${AppLocalizations.of(context)!.shabat} - ${e.title}'
                        : e.title;
      }
      if (isOnlyShabat && (e is Shabat || e.entryDate?.hour != 0)) {
        widgets.add(EventFactoryWidget(data: e, isFirst: isFirst));
        isFirst = false;
      } else if (!isOnlyShabat) {
        widgets.add(EventFactoryWidget(data: e, isFirst: isFirst));
        isFirst = false;
      }
    }
    widgets.add(const SizedBox(height: 10));
    if (isOnlyShabat) return AnimatedOnlyShabatListView(widgets: widgets);
    return AnimatedEventsListView(widgets: widgets);
  }

  void getZmanim({required String lang}) {
    setIsLoadingZmanim(true);
    Provider.of<Events>(
      context,
      listen: false,
    ).fetchAndSetZmanimProducts(lang: lang).then((items) {
      setIsLoadingZmanim(false);
    });
  }

  String _zmanLabel(ZmanimDisplayMode mode, AppLocalizations l) {
    switch (mode) {
      case ZmanimDisplayMode.multiExpand:
        return l.zmanimDisplayMultiExpand;
      case ZmanimDisplayMode.singleExpand:
        return l.zmanimDisplaySingleExpand;
      case ZmanimDisplayMode.expandedByDefault:
        return l.zmanimDisplayExpandedByDefault;
    }
  }

  String _zmanKey(Zman z) => '${z.title}_${z.date.toIso8601String()}';

  bool _isZmanExpanded(String key, ZmanimDisplayMode mode) {
    if (mode == ZmanimDisplayMode.expandedByDefault) {
      return !_expandedKeys.contains(key);
    }
    return _expandedKeys.contains(key);
  }

  void _toggleZman(String key, ZmanimDisplayMode mode) {
    setState(() {
      final wasSet = _expandedKeys.contains(key);
      if (mode == ZmanimDisplayMode.singleExpand) {
        _expandedKeys.clear();
        if (!wasSet) _expandedKeys.add(key);
      } else {
        if (wasSet) {
          _expandedKeys.remove(key);
        } else {
          _expandedKeys.add(key);
        }
      }
    });
  }

  Widget _buildZmanimSearchField(ZmanimDisplayMode mode) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _zmanimSearchController,
              onChanged: (v) => setState(() => _zmanimSearchQuery = v),
              decoration: InputDecoration(
                hintText: appLocalizations.search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _zmanimSearchQuery.isNotEmpty
                        ? IconButton(
                          tooltip: AppLocalizations.of(context)!.clearSearch,
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _zmanimSearchController.clear();
                            setState(() => _zmanimSearchQuery = '');
                          },
                        )
                        : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<ZmanimDisplayMode>(
            icon: const Icon(Icons.tune),
            style: IconButton.styleFrom(
              fixedSize: const Size(48, 48),
              backgroundColor: KodeshPalette.glassFill,
              side: const BorderSide(color: KodeshPalette.glassBorder),
            ),
            tooltip: appLocalizations.zmanimDisplayModeTooltip,
            initialValue: mode,
            onSelected: (selected) {
              Provider.of<Events>(
                context,
                listen: false,
              ).updateZmanimDisplayMode(selected);
              setState(_expandedKeys.clear);
            },
            itemBuilder:
                (context) =>
                    ZmanimDisplayMode.values
                        .map(
                          (m) => PopupMenuItem<ZmanimDisplayMode>(
                            value: m,
                            child: Row(
                              children: [
                                Icon(
                                  m == mode
                                      ? Icons.check
                                      : Icons.check_box_outline_blank,
                                  size: 18,
                                  color:
                                      m == mode
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.primary
                                          : Colors.transparent,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(_zmanLabel(m, appLocalizations)),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
          ),
        ],
      ),
    );
  }

  Widget _getZmanimWidgets(List<Zman>? zmanim, ZmanimDisplayMode mode) {
    final appLocalizations = AppLocalizations.of(context)!;
    List<Widget> widgets = [];
    if (zmanim != null) {
      zmanim.sort((a, b) => a.date.compareTo(b.date));
      final now = DateTime.now();
      final query = _zmanimSearchQuery.trim().toLowerCase();
      for (Zman z in zmanim) {
        if (_isTodayTimesFromNow && !z.date.isAfter(now)) continue;
        if (query.isNotEmpty) {
          final langMap =
              types[Provider.of<LanguageChangeProvider>(
                context,
                listen: false,
              ).currentLocale.languageCode] ??
              types['en']!;
          final labels = langMap[z.title] ?? {z.title, ''};
          final title = labels.elementAt(0).toLowerCase();
          final subtitle =
              labels.length > 1 ? labels.elementAt(1).toLowerCase() : '';
          if (!title.contains(query) && !subtitle.contains(query)) continue;
        }
        final key = _zmanKey(z);
        widgets.add(
          ZmanWidget(
            key: ValueKey(key),
            data: z,
            isExpanded: _isZmanExpanded(key, mode),
            onToggle: () => _toggleZman(key, mode),
            showDivider: widgets.isNotEmpty,
          ),
        );
      }
    }

    if (widgets.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Text(
            _zmanimSearchQuery.isNotEmpty
                ? appLocalizations.noSearchResults
                : appLocalizations.noLaterTimesToShow,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GlassPanel(
        elevated: true,
        radius: 32,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: AnimatedZmanimList(widgets: widgets),
      ),
    );
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
          Icon(
            Icons.signal_cellular_nodata_rounded,
            color: Theme.of(context).colorScheme.error,
            size: 25,
          ),
          const SizedBox(height: 20),
          Text(
            localErrorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              getAllData();
            },
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }

  /// "City · date" under the tab title: today's Hebrew date on Home, the
  /// shown day on Times.
  String _headerSubtitle(Events events, bool isTimesTab) {
    final langCode =
        context.read<LanguageChangeProvider>().currentLocale.languageCode;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final city = cityLabel(events.city, langCode, cities);
    final String date;
    if (isTimesTab) {
      date = DateFormat.MMMMEEEEd(locale).format(events.startDate);
    } else {
      final today = DateTime.now();
      date =
          events.hebrewDates?[getDateTimeSetToZero(today)] ??
          DateFormat.MMMMd(locale).format(today);
    }
    return '$city · $date';
  }

  Widget _dayControls(Events events) {
    return SettingsBar(
      isOnlyShabat:
          _viewState == ViewState.events ? _isOnlyShabat : _isTodayTimesFromNow,
      updateIsOnlyShabat:
          _viewState == ViewState.events
              ? setIsOnlyShabat
              : setIsTodayTimesFromNow,
      setIsLoading: setIsLoading,
      setIsLoadingZmanim: setIsLoadingZmanim,
      viewState: _viewState,
      isHebrewDate: events.isHebrewDate,
      updateIsHebrewDate: events.updateIsHebrewDate,
    );
  }

  /// Sunset today and the next holiday / Rosh Chodesh, side by side.
  Widget _statTiles(Events events, AppLocalizations l) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = DateTime.now();
    final sunset = findZman(events.zmanimItems, 'sunset');
    final special = nextSpecialEvent(events.eventsItems ?? const [], now);

    final Widget second;
    if (special != null) {
      final days = calendarDaysBetween(now, special.entryDate!);
      second = HomeStatTile(
        icon: Icons.nightlight_outlined,
        iconColor: const Color(0xFFE3E9F2),
        label: special.title,
        value: switch (days) {
          0 => l.todayWord,
          1 => l.tomorrowWord,
          _ => l.inDaysCount(days),
        },
      );
    } else {
      second = HomeStatTile(
        icon: Icons.calendar_today_outlined,
        iconColor: const Color(0xFFE3E9F2),
        label: l.currentDate,
        value:
            events.hebrewDates?[getDateTimeSetToZero(now)] ??
            DateFormat.MMMMd(locale).format(now),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: HomeStatTile(
              icon: Icons.wb_twilight_outlined,
              iconColor: const Color(0xFFFFE3AD),
              label: l.sunsetToday,
              value:
                  sunset != null && DateUtils.isSameDay(sunset.date, now)
                      ? DateFormat.Hm(locale).format(sunset.date)
                      : '—',
              onTap:
                  () => context.read<HomeTabController>().select(HomeTab.times),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: second),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context);
    AppLocalizations l = AppLocalizations.of(context)!;
    final isTimesTab = context.watch<HomeTabController>().tab == HomeTab.times;
    final isLoading =
        isTimesTab
            ? (_isLoadingZmanim || _isLoadingLang)
            : (_isLoading || _isLoadingLang);

    Widget section(Widget child) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: child,
    );

    final List<Widget> children;
    if (!isTimesTab && events.eventsItems != null) {
      children = [
        if (isLoading)
          renderLoading(context)
        else ...[
          section(ShabbatHeroCard(events: events.eventsItems!)),
          section(_statTiles(events, l)),
          if (!kIsWeb) section(const RemindersSummaryCard()),
          section(_dayControls(events)),
          _getEventwidgets(events.eventsItems!, events.isOnlyShabat),
        ],
      ];
    } else if (isTimesTab && events.zmanimItems != null) {
      children = [
        section(_dayControls(events)),
        if (isLoading)
          renderLoading(context)
        else ...[
          _buildZmanimSearchField(events.zmanimDisplayMode),
          _getZmanimWidgets(events.zmanimItems, events.zmanimDisplayMode),
        ],
      ];
    } else {
      children = [
        if (isLoading)
          renderLoading(context)
        else
          renderNoInternetConnection(
            events.eventsError != null ? l.apiErrorMessage : l.noIntrnetMessage,
          ),
      ];
    }

    return DefaultScaffold(
      backdrop: isTimesTab ? KodeshBackdrop.zmanim : KodeshBackdrop.home,
      title:
          isTimesTab
              ? l.todayTimes
              : (isShabbatGreetingDay(DateTime.now())
                  ? l.greetingShabbat
                  : l.greetingWeek),
      subtitle: _headerSubtitle(events, isTimesTab),
      body: RefreshIndicator(
        onRefresh: () async {
          String lang =
              Provider.of<LanguageChangeProvider>(
                context,
                listen: false,
              ).currentLocale.languageCode;
          await Provider.of<Events>(
            context,
            listen: false,
          ).fetchAndSetProducts(lang: lang, forceRefresh: true);
          await Provider.of<Events>(
            context,
            listen: false,
          ).fetchAndSetZmanimProducts(lang: lang, forceRefresh: true);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: 8,
            bottom: glassBottomNavClearance(context),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: TabHeader.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
