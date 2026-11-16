import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/providers/home_tab_controller.dart';
import 'package:kodesh_app/theme/kodesh_layout.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/widgets/glass_bottom_nav/glass_nav_item.dart';

/// The floating, blurred pill-shaped navigation bar of the home shell
/// (Home · Times · Prayers · Reminders).
///
/// Place it in `GlassScaffold.bottomNavigationBar` with `extendBody: true`
/// so content scrolls under the glass.
class GlassBottomNav extends StatelessWidget {
  const GlassBottomNav({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final HomeTab selected;
  final ValueChanged<HomeTab> onSelected;

  static const double barHeight = 60;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final items = <(HomeTab, IconData, String)>[
      (HomeTab.home, Icons.home_outlined, l.navHome),
      (HomeTab.times, Icons.schedule_outlined, l.navTimes),
      (HomeTab.prayers, Icons.menu_book_outlined, l.navPrayers),
      (HomeTab.reminders, Icons.notifications_none_outlined, l.navReminders),
    ];

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Semantics(
              container: true,
              explicitChildNodes: true,
              label: l.mainNavigation,
              child: GlassPanel(
                blur: true,
                elevated: true,
                // Darker than other glass, as in the design, so the
                // content scrolling under the bar does not compete with it.
                color: const Color(0x7306194B),
                radius: barHeight / 2,
                padding: const EdgeInsets.all(6),
                child: SizedBox(
                  height: barHeight - 12,
                  child: Row(
                    children: [
                      for (final (tab, icon, label) in items)
                        Expanded(
                          child: GlassNavItem(
                            icon: icon,
                            label: label,
                            isSelected: tab == selected,
                            onTap: () => onSelected(tab),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Space to leave at the bottom of scrolling content so its last item is
/// not hidden under [GlassBottomNav].
///
/// Reads the device inset from the window itself: inside the tabs' own
/// scaffolds the inherited `MediaQuery` has already had it removed, which
/// left the last rows half hidden under the bar.
double glassBottomNavClearance(BuildContext context) {
  final deviceInset =
      MediaQueryData.fromView(View.of(context)).viewPadding.bottom;
  // Wide screens have a sidebar instead of the bar.
  if (KodeshLayout.hasSidebar(context)) return deviceInset + 24;
  // The bar sits at least 12 px above the bottom, or on the device inset.
  final barBottom = deviceInset > 12 ? deviceInset : 12.0;
  return barBottom + GlassBottomNav.barHeight + 24;
}
