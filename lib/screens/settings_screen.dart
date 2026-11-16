import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/api/l10n/l10n.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/helpers/city_display.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/services/location_service.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/city_picker.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
import 'package:kodesh_app/widgets/glass_segmented_choice.dart';
import 'package:kodesh_app/widgets/settings_screen/settings_row.dart';
import 'package:kodesh_app/widgets/settings_screen/settings_section.dart';
import 'package:kodesh_app/widgets/swiches/cupertino_text_check_switch.dart';
import 'package:provider/provider.dart';

/// App settings, opened from the gear button of every tab: city and start
/// date, language, appearance and date display.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLocating = false;

  Future<void> _pickCity(Events events, String langCode) async {
    final selected = await showSearch<Map?>(
      context: context,
      delegate: CitySearchDelegate(cities: cities, lang: langCode),
    );
    if (!mounted) return;
    if (selected != null && selected['eNameAndCode'] != events.city) {
      await events.setCity(selected['eNameAndCode'] as String);
      if (mounted) setState(() {});
    }
  }

  Future<void> _useMyLocation(Events events) async {
    setState(() => _isLocating = true);
    try {
      final cityCode = await LocationService.detectNearestCity();
      if (!mounted) return;
      if (cityCode == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.locationNotAvailable),
          ),
        );
      } else if (cityCode != events.city) {
        await events.setCity(cityCode);
      }
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _pickDate(Events events) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: events.startDate,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (!mounted || picked == null) return;
    events.setStartDate(picked, setIsLoading: null, setIsLoadingZmanim: null);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final lang = context.watch<LanguageChangeProvider>();
    final events = context.watch<Events>();
    final reminders = context.watch<Reminders>();
    final langCode = lang.currentLocale.languageCode;
    final locale = Localizations.localeOf(context).toLanguageTag();

    final cityName = cityLabel(events.city, langCode, cities);
    final startDateText =
        DateUtils.isSameDay(events.startDate, DateTime.now())
            ? l.todayWord
            : DateFormat.yMMMEd(locale).format(events.startDate);

    return GlassScaffold(
      backdrop: KodeshBackdrop.settings,
      appBar: CustomAppBar(title: l.settings),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: TabHeader.maxContentWidth,
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              24 + MediaQuery.of(context).viewPadding.bottom,
            ),
            children: [
              SettingsSection(
                title: l.location,
                children: [
                  SettingsRow(
                    label: l.city,
                    value: cityName,
                    onTap: () => _pickCity(events, langCode),
                  ),
                  SettingsRow(
                    label: l.useMyLocation,
                    value: '',
                    icon: Icons.my_location_rounded,
                    busy: _isLocating,
                    onTap: _isLocating ? null : () => _useMyLocation(events),
                  ),
                  SettingsRow(
                    label: l.startDate,
                    value: startDateText,
                    onTap: () => _pickDate(events),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SettingsSection(
                title: l.languageTitle,
                framed: false,
                children: [
                  GlassSegmentedChoice<String>(
                    semanticLabel: l.languageTitle,
                    options: {
                      for (final loc in L10n.all)
                        loc.languageCode:
                            L10n.names[loc.languageCode]!['locale']!,
                    },
                    selected: langCode,
                    onSelected: (value) {
                      if (value == langCode) return;
                      lang.changeLocale(value);
                      events.changeLocale(value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SettingsSection(
                title: l.appearance,
                framed: false,
                children: [
                  GlassSegmentedChoice<ThemeMode>(
                    semanticLabel: l.appearance,
                    options: {
                      ThemeMode.system: l.systemMode,
                      ThemeMode.light: l.lightMode,
                      ThemeMode.dark: l.darkMode,
                    },
                    selected: lang.themeMode,
                    onSelected: lang.changeThemeMode,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SettingsSection(
                title: l.display,
                children: [
                  CuperinoTextCheckSwitch(
                    value: events.isHebrewDate,
                    onChanged: events.updateIsHebrewDate,
                    text: l.viewHebrewDates,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SettingsSection(
                title: l.notifications,
                children: [
                  CuperinoTextCheckSwitch(
                    value: reminders.notificationSound,
                    onChanged:
                        () => reminders.setNotificationSound(
                          !reminders.notificationSound,
                        ),
                    text: l.notificationSound,
                    subtitle: l.notificationSoundSubtitle,
                    icon: Icons.volume_up_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
