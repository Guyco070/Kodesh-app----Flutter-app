import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/screens/about.dart';
import 'package:kodesh_app/screens/accessibility_statement_screen.dart';
import 'package:kodesh_app/screens/privacy_policy_screen.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/daf_yomi_screen.dart';
import 'package:kodesh_app/screens/holiday_calendar_screen.dart';
import 'package:kodesh_app/screens/settings_screen.dart';
import 'package:kodesh_app/screens/shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/birkat_hamazon.dart';
import 'package:kodesh_app/screens/tefilot/havdalah.dart';
import 'package:kodesh_app/screens/tefilot/kriyat_shema_al_hamita.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:kodesh_app/providers/home_tab_controller.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/app_drawer/drawer_brand_header.dart';
import 'package:kodesh_app/widgets/app_drawer/drawer_item.dart';
import 'package:kodesh_app/widgets/app_drawer/drawer_section_label.dart';
import 'package:provider/provider.dart';

/// The side menu, as in the design's sidebar: the Kodesh logo, then every
/// prayer, aid and setting in labelled groups on the sunset gradient.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, this.isPermanent = false});

  /// Shown as the always-visible sidebar of wide screens rather than as a
  /// sliding drawer.
  final bool isPermanent;

  static const _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0B2C70),
      Color(0xFF1C3B86),
      Color(0xFF4A2F78),
      Color(0xFF9A4570),
    ],
    stops: [0, 0.28, 0.62, 1],
  );

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    void go(String route) {
      if (!isPermanent) Navigator.of(context).pop();
      Navigator.pushNamed(context, route);
    }

    void goTab(HomeTab tab) {
      if (!isPermanent) Navigator.of(context).pop();
      context.read<HomeTabController>().select(tab);
    }

    final tab = context.watch<HomeTabController>().tab;

    final panel = DecoratedBox(
      decoration: const BoxDecoration(
        gradient: _gradient,
        border: BorderDirectional(
          end: BorderSide(color: KodeshPalette.hairline),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
          children: [
            const DrawerBrandHeader(),
            DrawerItem(
              icon: Icons.home_outlined,
              label: l.home,
              isSelected: tab == HomeTab.home,
              onTap: () => goTab(HomeTab.home),
            ),
            DrawerItem(
              icon: Icons.schedule_outlined,
              label: l.todayTimes,
              isSelected: tab == HomeTab.times,
              onTap: () => goTab(HomeTab.times),
            ),
            DrawerSectionLabel(l.prayersAndBlessings),
            DrawerItem(
              icon: Icons.local_fire_department_outlined,
              label: l.candleLightingOrderMenu,
              onTap: () => go(AdlakatNerot.routeName),
            ),
            DrawerItem(
              icon: Icons.wine_bar_outlined,
              label: l.havdalah,
              onTap: () => go(Havdalah.routeName),
            ),
            DrawerItem(
              icon: Icons.front_hand_outlined,
              label: l.tefilinOrderMenu,
              onTap: () => go(SederAnahatTefilin.routeName),
            ),
            DrawerItem(
              icon: Icons.flare_rounded,
              label: l.hanukkahCandleLightingOrderMenu,
              onTap: () => go(AdlakatNerotChanukah.routeName),
            ),
            DrawerItem(
              icon: Icons.grass_outlined,
              label: l.sederSfiratOmer,
              onTap: () => go(SfiratOmerScreen.routeName),
            ),
            DrawerItem(
              icon: Icons.restaurant_outlined,
              label: l.birkatHamazonMenu,
              onTap: () => go(BirkatHamazon.routeName),
            ),
            DrawerItem(
              icon: Icons.bedtime_outlined,
              label: l.kriyatShemaAlHamitaMenu,
              onTap: () => go(KriyatShemaAlHamita.routeName),
            ),
            DrawerSectionLabel(l.aids),
            DrawerItem(
              icon: Icons.checklist_rtl,
              label: l.choresBeforeShabbatMenu,
              onTap: () => go(ShabatAndHolidaysCheckList.routeName),
            ),
            DrawerItem(
              icon: Icons.explore_outlined,
              label: l.compass,
              onTap: () => go(CompassScreen.routeName),
            ),
            DrawerItem(
              icon: Icons.menu_book_outlined,
              label: l.dafYomiMenu,
              onTap: () => go(DafYomiScreen.routeName),
            ),
            DrawerItem(
              icon: Icons.calendar_month_outlined,
              label: l.holidayCalendarMenu,
              onTap: () => go(HolidayCalendarScreen.routeName),
            ),
            DrawerSectionLabel(l.settings),
            DrawerItem(
              icon: Icons.notifications_none_rounded,
              label: l.settingRemindersMenu,
              isSelected: tab == HomeTab.reminders,
              onTap: () => goTab(HomeTab.reminders),
            ),
            DrawerItem(
              icon: Icons.tune_rounded,
              label: l.settings,
              onTap: () => go(SettingsScreen.routeName),
            ),
            DrawerItem(
              icon: Icons.info_outline_rounded,
              label: l.aboutMenu,
              onTap: () => go(AboutScreen.routeName),
            ),
            DrawerItem(
              icon: Icons.accessibility_new_rounded,
              label: l.accessibilityMenu,
              onTap: () => go(AccessibilityStatementScreen.routeName),
            ),
            DrawerItem(
              icon: Icons.privacy_tip_outlined,
              label: l.privacyMenu,
              onTap: () => go(PrivacyPolicyScreen.routeName),
            ),
          ],
        ),
      ),
    );

    if (isPermanent) {
      return SizedBox(
        width: 280,
        child: Semantics(
          container: true,
          explicitChildNodes: true,
          child: panel,
        ),
      );
    }
    return Drawer(
      width: 300,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      child: panel,
    );
  }
}
