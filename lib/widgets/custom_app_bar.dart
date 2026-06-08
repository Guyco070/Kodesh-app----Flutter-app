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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
      child: SafeArea(
        child: ListTile(
          horizontalTitleGap: 2,
          leading:
              leading ??
              (!noBackBotton
                  ? IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
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
          trailing: trailing ?? const LimitedBox(), // if no traili
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

