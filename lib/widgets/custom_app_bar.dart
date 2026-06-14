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
    final topPadding = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: bgColor,
        statusBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            isDark ? Brightness.dark : Brightness.light,
      ),
      child: Container(
        color: bgColor,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: SizedBox(
            height: preferredSize.height,
            child: ListTile(
              horizontalTitleGap: 2,
              leading:
                  leading ??
                  (!noBackBotton
                      ? IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(Icons.chevron_left_outlined),
                      )
                      : null),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Center(
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
                ],
              ),
              trailing: trailing ?? const LimitedBox(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
