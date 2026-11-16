import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/screens/settings_screen.dart';
import 'package:kodesh_app/theme/kodesh_layout.dart';
import 'package:kodesh_app/widgets/glass/glass_round_button.dart';

/// The large header of the four bottom-navigation tabs, as in the design:
/// a small [subtitle] over a big bold [title], with the menu button at the
/// start and the settings button at the end (the same size, so the header
/// is balanced).
///
/// Pushed screens use `CustomAppBar` instead.
class TabHeader extends StatelessWidget implements PreferredSizeWidget {
  const TabHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  /// Width of the tabs' content column, side padding included.
  static const double maxContentWidth = 672;

  @override
  Size get preferredSize => const Size(double.maxFinite, 92);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: preferredSize.height,
          // As wide as the tabs' content, so the title and the buttons line
          // up with the cards on wide screens.
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContentWidth),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    if (!KodeshLayout.hasSidebar(context)) ...[
                      Builder(
                        builder:
                            (context) => GlassRoundButton(
                              onPressed:
                                  () => Scaffold.of(context).openDrawer(),
                              tooltip:
                                  MaterialLocalizations.of(
                                    context,
                                  ).openAppDrawerTooltip,
                              icon: Icons.menu_rounded,
                            ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (subtitle != null && subtitle!.isNotEmpty)
                              Text(
                                subtitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xCCFFFFFF),
                                ),
                              ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                title,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                  height: 1.15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GlassRoundButton(
                      onPressed:
                          () => Navigator.pushNamed(
                            context,
                            SettingsScreen.routeName,
                          ),
                      tooltip: l.settings,
                      icon: Icons.settings_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
