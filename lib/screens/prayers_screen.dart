import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/daf_yomi_screen.dart';
import 'package:kodesh_app/screens/holiday_calendar_screen.dart';
import 'package:kodesh_app/screens/shabat_and_holidays_check_list.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot.dart';
import 'package:kodesh_app/screens/tefilot/adlakat_nerot_chanukah.dart';
import 'package:kodesh_app/screens/tefilot/birkat_hamazon.dart';
import 'package:kodesh_app/screens/tefilot/havdalah.dart';
import 'package:kodesh_app/screens/tefilot/kriyat_shema_al_hamita.dart';
import 'package:kodesh_app/screens/tefilot/seder_anahat_tefilin.dart';
import 'package:kodesh_app/screens/tefilot/sfirat_omer_screen.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/widgets/glass_bottom_nav.dart';
import 'package:kodesh_app/widgets/glass_segmented_choice.dart';
import 'package:kodesh_app/widgets/prayers_screen/prayer_link_tile.dart';
import 'package:kodesh_app/widgets/prayers_screen/tool_tile.dart';
import 'package:provider/provider.dart';

/// The "Prayers" tab: nusach picker, the list of prayer texts and a grid of
/// aids (checklist, compass, daf yomi, calendar).
class PrayersScreen extends StatelessWidget {
  const PrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final tfilot = context.watch<Tfilot>();
    void open(String route) => Navigator.pushNamed(context, route);

    final prayers = <(IconData, Color, String, String)>[
      (
        Icons.local_fire_department_outlined,
        const Color(0xFFFFB86B),
        l.candleLightingOrderMenu,
        AdlakatNerot.routeName,
      ),
      (
        Icons.wine_bar_outlined,
        const Color(0xFF7FE0C0),
        l.havdalah,
        Havdalah.routeName,
      ),
      (
        Icons.front_hand_outlined,
        const Color(0xFF9EC5FF),
        l.tefilinOrderMenu,
        SederAnahatTefilin.routeName,
      ),
      (
        Icons.light_outlined,
        KodeshPalette.flame,
        l.hanukkahCandleLightingOrderMenu,
        AdlakatNerotChanukah.routeName,
      ),
      (
        Icons.grass_outlined,
        const Color(0xFFFF9FB8),
        l.sederSfiratOmer,
        SfiratOmerScreen.routeName,
      ),
      (
        Icons.restaurant_outlined,
        const Color(0xFFC3B5FF),
        l.birkatHamazonMenu,
        BirkatHamazon.routeName,
      ),
      (
        Icons.bedtime_outlined,
        const Color(0xFF8FB4FF),
        l.kriyatShemaAlHamitaMenu,
        KriyatShemaAlHamita.routeName,
      ),
    ];

    final tools = <(IconData, Color, String, String)>[
      (
        Icons.checklist_rtl,
        const Color(0xFF7FE0C0),
        l.choresBeforeShabbatMenu,
        ShabatAndHolidaysCheckList.routeName,
      ),
      (
        Icons.explore_outlined,
        const Color(0xFF9EC5FF),
        l.compass,
        CompassScreen.routeName,
      ),
      (
        Icons.auto_stories_outlined,
        KodeshPalette.flame,
        l.dafYomiMenu,
        DafYomiScreen.routeName,
      ),
      (
        Icons.calendar_month_outlined,
        const Color(0xFFFF9FB8),
        l.holidayCalendarMenu,
        HolidayCalendarScreen.routeName,
      ),
    ];

    return DefaultScaffold(
      backdrop: KodeshBackdrop.prayers,
      title: l.navPrayers,
      subtitle: l.prayersSubtitle,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: TabHeader.maxContentWidth,
          ),
          child: ListView(
            primary: true,
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              glassBottomNavClearance(context),
            ),
            children: [
              GlassSegmentedChoice<Nosah>(
                semanticLabel: l.prayerVersion,
                options: Map<Nosah, String>.from(nosahTranslate(context)),
                selected: tfilot.getNosah,
                onSelected: tfilot.updateNosah,
              ),
              const SizedBox(height: 14),
              GlassPanel(
                strong: true,
                elevated: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 4,
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < prayers.length; i++)
                      PrayerLinkTile(
                        icon: prayers[i].$1,
                        tint: prayers[i].$2,
                        title: prayers[i].$3,
                        showDivider: i < prayers.length - 1,
                        onTap: () => open(prayers[i].$4),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Semantics(
                header: true,
                child: Padding(
                  // Lines up with the text inside the tiles below.
                  padding: const EdgeInsetsDirectional.only(
                    start: 16,
                    bottom: 10,
                  ),
                  child: Text(
                    l.aids,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: KodeshPalette.textMuted,
                    ),
                  ),
                ),
              ),
              // Two tiles per row; both tiles of a row share its height.
              for (var i = 0; i < tools.length; i += 2)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: i + 2 < tools.length ? 12 : 0,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var j = i; j < i + 2; j++) ...[
                          if (j > i) const SizedBox(width: 12),
                          Expanded(
                            child:
                                j < tools.length
                                    ? ToolTile(
                                      icon: tools[j].$1,
                                      accent: tools[j].$2,
                                      label: tools[j].$3,
                                      onTap: () => open(tools[j].$4),
                                    )
                                    : const SizedBox.shrink(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
