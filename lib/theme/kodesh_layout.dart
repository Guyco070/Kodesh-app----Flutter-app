import 'package:flutter/widgets.dart';

/// Layout breakpoints of the design.
abstract final class KodeshLayout {
  /// From this width on (desktop web, landscape tablets) the side menu is
  /// always shown as a sidebar and the bottom navigation bar is hidden.
  static const double sidebarBreakpoint = 1000;

  static bool hasSidebar(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= sidebarBreakpoint;
}
