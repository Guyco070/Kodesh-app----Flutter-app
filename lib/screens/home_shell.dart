import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_layout.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/app_drawer.dart';
import 'package:kodesh_app/providers/home_tab_controller.dart';
import 'package:kodesh_app/screens/event_screen.dart';
import 'package:kodesh_app/screens/prayers_screen.dart';
import 'package:kodesh_app/screens/schedule_notifications.dart';
import 'package:kodesh_app/widgets/glass_bottom_nav.dart';
import 'package:provider/provider.dart';

/// The app's root: the three top-level screens kept alive side by side, with
/// the floating glass navigation bar over them.
///
/// Home and Times are both `EventScreen`, which reads the selected tab from
/// [HomeTabController].
class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeTabController>();
    final index = switch (controller.tab) {
      HomeTab.home || HomeTab.times => 0,
      HomeTab.prayers => 1,
      HomeTab.reminders => 2,
    };

    final tabs = IndexedStack(
      index: index,
      children: [
        // Hidden tabs stay alive but stop animating their backgrounds.
        TickerMode(enabled: index == 0, child: const EventScreen()),
        TickerMode(enabled: index == 1, child: const PrayersScreen()),
        TickerMode(
          enabled: index == 2,
          child: const ScheduleNotificationsScreen(isTab: true),
        ),
      ],
    );

    // Wide screens: the side menu stays open as a sidebar and replaces the
    // bottom bar, as in the design's web layout.
    if (KodeshLayout.hasSidebar(context)) {
      return Scaffold(
        backgroundColor: KodeshPalette.logoBlue,
        body: Row(
          children: [const AppDrawer(isPermanent: true), Expanded(child: tabs)],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: tabs,
      // The tabs' drawers are painted under this bar, so hide it while one
      // is open.
      bottomNavigationBar: IgnorePointer(
        ignoring: controller.isDrawerOpen,
        child: AnimatedSlide(
          offset: controller.isDrawerOpen ? const Offset(0, 1.5) : Offset.zero,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: ExcludeSemantics(
            excluding: controller.isDrawerOpen,
            child: GlassBottomNav(
              selected: controller.tab,
              onSelected: controller.select,
            ),
          ),
        ),
      ),
    );
  }
}
