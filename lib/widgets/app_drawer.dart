import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';
import 'package:kodesh_app/screens/shabat_and_holidays_check_list.dart';
import 'package:provider/provider.dart';
import 'package:kodesh_app/screens/about.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/schedule_notifications.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/havdalah.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:kodesh_app/screens/tefilot/birkat_hamazon.dart';
import 'package:kodesh_app/screens/tefilot/kriyat_shema_al_hamita.dart';
import 'package:kodesh_app/screens/daf_yomi_screen.dart';
import 'package:kodesh_app/screens/holiday_calendar_screen.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/custom_expanded_list_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int? _openSection;

  void _toggle(int index) {
    setState(() {
      _openSection = _openSection == index ? null : index;
    });
  }

  ThemeMode _nextThemeMode(ThemeMode current) => switch (current) {
        ThemeMode.system => ThemeMode.light,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
      };

  IconData _nextThemeIcon(ThemeMode current) => switch (current) {
        ThemeMode.system => Icons.brightness_auto_outlined,
        ThemeMode.light => Icons.light_mode_outlined,
        ThemeMode.dark => Icons.dark_mode_outlined,
      };

  String _nextThemeLabel(ThemeMode current, appLocalizations) =>
      switch (current) {
        ThemeMode.system => appLocalizations.systemMode,
        ThemeMode.light => appLocalizations.lightMode,
        ThemeMode.dark => appLocalizations.darkMode,
      };

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final langProvider = Provider.of<LanguageChangeProvider>(context);

    return Drawer(
      child: Column(
        children: [
          CustomAppBar(title: appLocalizations.menu),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomExpandedListView(
                    title: appLocalizations.prayersAndBlessings,
                    isExpanded: _openSection == 0,
                    onToggle: () => _toggle(0),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.fireplace_outlined),
                        title: Text(appLocalizations.candleLightingOrderMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          AdlakatNerot.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.wine_bar),
                        title: Text(appLocalizations.havdalah),
                        onTap: () => Navigator.pushNamed(
                          context,
                          Havdalah.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_reaction_outlined),
                        title: Text(appLocalizations.tefilinOrderMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          SederAnahatTefilin.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.fireplace),
                        title: Text(
                          appLocalizations.hanukkahCandleLightingOrderMenu,
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          AdlakatNerotChanukah.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.content_cut),
                        title: Text(appLocalizations.sederSfiratOmer),
                        onTap: () => Navigator.pushNamed(
                          context,
                          SfiratOmerScreen.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.restaurant_outlined),
                        title: Text(appLocalizations.birkatHamazonMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          BirkatHamazon.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.bedtime_outlined),
                        title: Text(appLocalizations.kriyatShemaAlHamitaMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          KriyatShemaAlHamita.routeName,
                        ),
                      ),
                    ],
                  ),
                  CustomExpandedListView(
                    title: appLocalizations.aids,
                    isExpanded: _openSection == 1,
                    onToggle: () => _toggle(1),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.checklist_rtl),
                        title: Text(appLocalizations.choresBeforeShabbatMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          ShabatAndHolidaysCheckList.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.compass_calibration_outlined),
                        title: Text(appLocalizations.compass),
                        onTap: () => Navigator.pushNamed(
                          context,
                          CompassScreen.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.menu_book_outlined),
                        title: Text(appLocalizations.dafYomiMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          DafYomiScreen.routeName,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_month_outlined),
                        title: Text(appLocalizations.holidayCalendarMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          HolidayCalendarScreen.routeName,
                        ),
                      ),
                    ],
                  ),
                  CustomExpandedListView(
                    title: appLocalizations.settings,
                    isExpanded: _openSection == 2,
                    onToggle: () => _toggle(2),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.watch_later_outlined),
                        title: Text(appLocalizations.settingRemindersMenu),
                        onTap: () => Navigator.pushNamed(
                          context,
                          ScheduleNotificationsScreen.routeName,
                        ),
                      ),
                      ListTile(
                        leading: Icon(_nextThemeIcon(langProvider.themeMode)),
                        title: Text(
                          _nextThemeLabel(
                            langProvider.themeMode,
                            appLocalizations,
                          ),
                        ),
                        onTap: () => langProvider.changeThemeMode(
                          _nextThemeMode(langProvider.themeMode),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          const Divider(indent: 18, endIndent: 18),
          SafeArea(
            top: false,
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(appLocalizations.aboutMenu),
              onTap: () => Navigator.pushNamed(context, AboutScreen.routeName),
            ),
          ),
        ],
      ),
    );
  }
}
