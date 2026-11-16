import 'package:flutter/material.dart';
import 'package:kodesh_app/helpers/app_logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/helpers/home_summary.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:kodesh_app/services/location_service.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/widgets/settings_bar/glass_pill_button.dart';
import 'package:provider/provider.dart';

/// The glass card over the week's events and the day's times: the shown
/// date with previous/next day, a "back to today" chip when another day is
/// shown, and the display filters. City and the other settings live in
/// `SettingsScreen`; this widget still picks up the device location once.
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _autoDetectIfPermitted(),
    );
  }

  Future<void> _autoDetectIfPermitted() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      await _detectAndSetLocation(showErrorSnackBar: false);
    }
  }

  Future<void> _detectAndSetLocation({bool showErrorSnackBar = true}) async {
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
      } else if (showErrorSnackBar) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.locationNotAvailable),
          ),
        );
      }
    } catch (e, st) {
      logger.w('Location detection failed', error: e, stackTrace: st);
    }
  }

  Future<void> _pickDate(Events events) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: events.startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null) _setStartDate(events, newDate);
  }

  void _setStartDate(Events events, DateTime date) {
    events.setStartDate(
      date,
      setIsLoading: widget.setIsLoading,
      setIsLoadingZmanim: widget.setIsLoadingZmanim,
    );
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<Events>(context, listen: false);
    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();

    final today = DateTime.now();
    final dayOffset = calendarDaysBetween(today, events.startDate);
    final dateLabel = switch (dayOffset) {
      0 =>
        '${l.todayWord} · ${DateFormat.MMMd(locale).format(events.startDate)}',
      1 =>
        '${l.tomorrowWord} · ${DateFormat.MMMd(locale).format(events.startDate)}',
      _ => DateFormat.yMMMEd(locale).format(events.startDate),
    };

    return GlassPanel(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed:
                    () => _setStartDate(
                      events,
                      events.startDate.subtract(const Duration(days: 1)),
                    ),
                tooltip: l.previousDay,
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Expanded(
                child: GlassPillButton(
                  icon: Icons.calendar_month_outlined,
                  label: dateLabel,
                  semanticLabel: l.chooseDate,
                  onTap: () => _pickDate(events),
                ),
              ),
              IconButton(
                onPressed:
                    () => _setStartDate(
                      events,
                      events.startDate.add(const Duration(days: 1)),
                    ),
                tooltip: l.nextDay,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              if (dayOffset != 0)
                ActionChip(
                  avatar: const Icon(Icons.today_outlined, size: 18),
                  label: Text(l.backToToday),
                  onPressed: () => _setStartDate(events, DateTime.now()),
                ),
              FilterChip(
                label: Text(
                  widget.viewState == ViewState.events
                      ? l.onlyShabat
                      : l.fromNowOn,
                ),
                selected: widget.isOnlyShabat,
                onSelected: (_) => widget.updateIsOnlyShabat(),
              ),
              FilterChip(
                label: Text(l.viewHebrewDates),
                selected: widget.isHebrewDate,
                onSelected: (_) => widget.updateIsHebrewDate(),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
