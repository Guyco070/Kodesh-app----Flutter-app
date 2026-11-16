import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/gradient_backdrop.dart';

/// A `Scaffold` painted on the animated gradient of the liquid-glass design.
///
/// Every screen uses this instead of a bare `Scaffold`, so each route paints
/// its own opaque background (page transitions stay clean). Pick the
/// [backdrop] that matches the area of the app the screen belongs to.
class GlassScaffold extends StatelessWidget {
  const GlassScaffold({
    super.key,
    required this.body,
    this.backdrop = KodeshBackdrop.home,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBody = false,
    this.onDrawerChanged,
  });

  final Widget body;
  final KodeshBackdrop backdrop;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool extendBody;

  /// Called when [drawer] opens or closes.
  final DrawerCallback? onDrawerChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: GradientBackdrop(backdrop: backdrop)),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          drawer: drawer,
          onDrawerChanged: onDrawerChanged,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          extendBody: extendBody,
          body: body,
        ),
      ],
    );
  }
}
