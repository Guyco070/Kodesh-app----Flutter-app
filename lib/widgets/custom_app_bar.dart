import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodesh_app/widgets/glass/glass_round_button.dart';
import 'package:kodesh_app/widgets/tab_header.dart';

/// The transparent top bar of every pushed screen, as in the design: a round
/// glass back button (by default), the title in large bold type beside it,
/// and an optional trailing control at the other end.
///
/// Built on `NavigationToolbar` so the controls stay separate nodes for
/// screen readers. Tab screens use `TabHeader` instead.
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
    final leadingWidget =
        leading ??
        (noBackBotton
            ? null
            : GlassRoundButton(
              onPressed: () => Navigator.maybePop(context),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              icon: Icons.arrow_back_ios_new_rounded,
              iconSize: 18,
            ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: preferredSize.height,
          // As wide as the screens' content column (see TabHeader), so the
          // controls line up with the cards on wide screens.
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: TabHeader.maxContentWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NavigationToolbar(
                  // NavigationToolbar stretches its slots to the full bar height;
                  // centering keeps buttons (and their highlights) round.
                  leading:
                      leadingWidget == null
                          ? null
                          : Center(widthFactor: 1, child: leadingWidget),
                  centerMiddle: false,
                  middle: Semantics(
                    header: true,
                    child: FittedBox(
                      alignment: AlignmentDirectional.centerStart,
                      fit: BoxFit.scaleDown,
                      child:
                          titleWidget ??
                          Text(
                            title,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                              letterSpacing: -0.5,
                            ),
                          ),
                    ),
                  ),
                  trailing:
                      trailing == null
                          ? null
                          : Center(widthFactor: 1, child: trailing),
                  middleSpacing: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 68);
}
