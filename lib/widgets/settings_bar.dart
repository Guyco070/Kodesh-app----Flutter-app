import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as df;
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:kodesh_app/services/location_service.dart';
import 'package:kodesh_app/widgets/city_picker.dart';
import 'package:provider/provider.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

import '../helpers/dates.dart';

class SettingsBar extends StatefulWidget {
  const SettingsBar({
    super.key,
    required this.isOnlyShabat,
    required this.updateIsOnlyShabat,
    required this.setIsLoading,
    required this.setIsLoadingZmanim,
    required this.viewState,
    required this.isHebrewDate,
    required this.updateIsHebrewDate,
  });

  final bool isOnlyShabat;
  final Function updateIsOnlyShabat;
  final Function setIsLoading;
  final Function setIsLoadingZmanim;
  final ViewState viewState;
  final bool isHebrewDate;
  final Function updateIsHebrewDate;

  @override
  State<SettingsBar> createState() => _SettingsBarState();
}

class _SettingsBarState extends State<SettingsBar> {
  bool _isExpanded = true;
  bool _isDetectingLocation = false;

  Future<void> _detectAndSetLocation() async {
    setState(() => _isDetectingLocation = true);
    try {
      final cityCode = await LocationService.detectNearestCity();
      if (!mounted) return;
      if (cityCode != null) {
        final events = Provider.of<Events>(context, listen: false);
        if (cityCode != events.city) {
          events.setCity(
            cityCode,
            setIsLoading: widget.setIsLoading,
            setIsLoadingZmanim: widget.setIsLoadingZmanim,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.locationNotAvailable),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDetectingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context, listen: false);
    var lang = Provider.of<LanguageChangeProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return TweenAnimationBuilder(
      duration: const Duration(seconds: 3),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, val, child) {
        return Opacity(
          opacity: val,
          child: Container(
            padding: EdgeInsets.all((val - 1) * -20),
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
            child: Column(
              children: [
                if (!_isExpanded) const SizedBox(height: 15),
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {
                                      final langCode =
                                          lang.currentLocale.languageCode;
                                      final selected = await showSearch<Map?>(
                                        context: context,
                                        delegate: CitySearchDelegate(
                                          cities: cities,
                                          lang: langCode,
                                        ),
                                      );
                                      if (selected != null &&
                                          selected['eNameAndCode'] !=
                                              events.city) {
                                        events.setCity(
                                          selected['eNameAndCode'] as String,
                                          setIsLoading: widget.setIsLoading,
                                          setIsLoadingZmanim:
                                              widget.setIsLoadingZmanim,
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              cities.firstWhere(
                                                    (c) =>
                                                        c['eNameAndCode'] ==
                                                        events.city,
                                                    orElse: () => cities.first,
                                                  )[lang
                                                      .currentLocale
                                                      .languageCode] ??
                                                  events.city,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 21,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                _isDetectingLocation
                                    ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CupertinoActivityIndicator(),
                                    )
                                    : IconButton(
                                      icon: Icon(
                                        Icons.my_location,
                                        size: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      padding: EdgeInsets.zero,
                                      onPressed: _detectAndSetLocation,
                                      tooltip:
                                          AppLocalizations.of(
                                            context,
                                          )!.useMyLocation,
                                    ),
                              ],
                            ),
                            VerticalDivider(
                              color: Theme.of(context).primaryColor,
                              indent: 10,
                              endIndent: 10,
                              width: 40,
                              thickness: 2,
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: events.startDate,
                                  firstDate: DateTime.now().subtract(
                                    const Duration(days: 365),
                                  ),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (newDate != null) {
                                  events.setStartDate(
                                    newDate,
                                    setIsLoading: widget.setIsLoading,
                                    setIsLoadingZmanim:
                                        widget.setIsLoadingZmanim,
                                  );
                                }
                              },
                              icon: const Icon(Icons.calendar_month_outlined),
                              label: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder:
                                    ((child, animation) => ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    )),
                                child: Text(
                                  key: ValueKey<String>(
                                    df.DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(events.startDate),
                                  ),
                                  df.DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(events.startDate),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isExpanded)
                  Align(
                    alignment: Alignment(
                      LanguageChangeProvider.isDirectionRTL(
                            events.currentLocale.languageCode,
                          )
                          ? -1
                          : 1,
                      5,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed:
                                () => events.setStartDate(
                                  events.startDate.subtract(
                                    const Duration(days: 1),
                                  ),
                                  setIsLoading: widget.setIsLoading,
                                  setIsLoadingZmanim: widget.setIsLoadingZmanim,
                                ),
                            icon: const Icon(Icons.remove, size: 20),
                          ),
                          IconButton(
                            onPressed:
                                () => events.setStartDate(
                                  events.startDate.add(const Duration(days: 1)),
                                  setIsLoading: widget.setIsLoading,
                                  setIsLoadingZmanim: widget.setIsLoadingZmanim,
                                ),
                            icon: const Icon(Icons.add, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextButton(
                          onPressed: () => widget.updateIsOnlyShabat(),
                          child: Text(
                            widget.viewState == ViewState.events
                                ? widget.isOnlyShabat
                                    ? appLocalizations.onlyShabat
                                    : appLocalizations.viewAllEvents
                                : appLocalizations.fromNowOn,
                            style: TextStyle(
                              color:
                                  widget.isOnlyShabat
                                      ? Colors.blue
                                      : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => widget.updateIsHebrewDate(),
                          child: Text(
                            widget.isHebrewDate
                                ? appLocalizations.viewForeignDates
                                : appLocalizations.viewHebrewDates,
                            style: TextStyle(
                              color:
                                  widget.isHebrewDate
                                      ? Colors.blue
                                      : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: _isExpanded ? 22 : 20,
                        onPressed: () {
                          DateTime today = DateTime.now();
                          if (events.eventsItems == null ||
                              df.DateFormat('dd/MM/yy').format(today) !=
                                  df.DateFormat(
                                    'dd/MM/yy',
                                  ).format(events.startDate)) {
                            events.setStartDate(
                              DateTime.now(),
                              setIsLoading: widget.setIsLoading,
                              setIsLoadingZmanim: widget.setIsLoadingZmanim,
                            );
                          }
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        '${appLocalizations.currentDate}: ',
                        style: const TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 130,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder:
                              ((child, animation) => ScaleTransition(
                                scale: animation,
                                child: child,
                              )),
                          child: Row(
                            key: ValueKey<String>(
                              events.isHebrewDate
                                  ? events.hebrewDates == null ||
                                          events.hebrewDates!.isEmpty
                                      ? '  '
                                      : events
                                          .hebrewDates![getDateTimeSetToZero(
                                        DateTime.now(),
                                      )]!
                                  : df.DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(DateTime.now()),
                            ),
                            children: [
                              if (events.isHebrewDate &&
                                  (events.hebrewDates == null ||
                                      events.hebrewDates!.isEmpty)) ...{
                                Text(
                                  events.isHebrewDate
                                      ? events.hebrewDates == null ||
                                              events.hebrewDates!.isEmpty
                                          ? '  '
                                          : events
                                              .hebrewDates![getDateTimeSetToZero(
                                            DateTime.now(),
                                          )]!
                                      : df.DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(DateTime.now()),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const CupertinoActivityIndicator(),
                              } else ...{
                                Text(
                                  events.isHebrewDate &&
                                          events.hebrewDates != null &&
                                          events.hebrewDates!.isNotEmpty
                                      ? events
                                          .hebrewDates![getDateTimeSetToZero(
                                        DateTime.now(),
                                      )]!
                                      : df.DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(DateTime.now()),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              },
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
