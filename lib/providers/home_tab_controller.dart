import 'package:flutter/foundation.dart';

/// The four top-level areas reachable from the bottom navigation bar.
enum HomeTab { home, times, prayers, reminders }

/// Holds the selected bottom-navigation tab.
///
/// Home and Times are two views of the same screen (`EventScreen`), so the
/// screen reads [tab] to decide whether to show the week's events or today's
/// times.
class HomeTabController extends ChangeNotifier {
  HomeTab _tab = HomeTab.home;

  HomeTab get tab => _tab;

  bool _isDrawerOpen = false;

  /// Whether a tab's side drawer is open. The shell hides the navigation
  /// bar meanwhile, since the bar is painted above the tabs' drawers.
  bool get isDrawerOpen => _isDrawerOpen;

  void setDrawerOpen(bool isOpen) {
    if (isOpen == _isDrawerOpen) return;
    _isDrawerOpen = isOpen;
    notifyListeners();
  }

  void select(HomeTab tab) {
    if (tab == _tab) return;
    _tab = tab;
    notifyListeners();
  }
}
