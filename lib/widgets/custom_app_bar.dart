import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.titleWidget,
    this.noBackBotton = false,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? titleWidget;
  final bool noBackBotton;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        Theme.of(context).appBarTheme.backgroundColor ??
        Theme.of(context).colorScheme.surface;
    final isDark =
        ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: bgColor,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: Material(
        color: bgColor,
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: preferredSize.height,
            // NavigationToolbar instead of ListTile: ListTile merges all of
            // its children into one accessibility node, which glued the page
            // title to the language/back buttons for screen readers.
            child: NavigationToolbar(
              middleSpacing: 8,
              leading:
                  leading ??
                  (!noBackBotton
                      ? IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        tooltip:
                            MaterialLocalizations.of(context).backButtonTooltip,
                        icon: const Icon(Icons.chevron_left_outlined),
                      )
                      : null),
              middle: Semantics(
                header: true,
                child: FittedBox(
                  child:
                      titleWidget ??
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                ),
              ),
              // Cap the side widgets so an expanding child (the language
              // dropdown) can't take over the whole toolbar.
              trailing:
                  trailing == null
                      ? null
                      : ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 160),
                        child: trailing,
                      ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
