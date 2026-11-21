import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/animations/hero_dialog_route.dart';
import 'package:kodesh_app/widgets/compass/compass_widget.dart';
import 'package:kodesh_app/widgets/compass/compass_dial.dart';
import 'package:kodesh_app/widgets/compass/custom_rect_tween.dart';

class CompassButton extends StatelessWidget {
  final double? heading;

  const CompassButton({super.key, this.heading});

  @override
  Widget build(BuildContext context) {
    // 4 + 40 + 4 = the 48 px of the back button at the other end.
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Hero(
        tag: CompassScreen.routeName,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Semantics(
          button: true,
          label: AppLocalizations.of(context)!.compass,
          excludeSemantics: true,
          onTap: () => _open(context),
          child: GestureDetector(
            onTap: () => _open(context),
            child: CompassDial(size: 40, heading: heading ?? 0),
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context) {
    Navigator.of(
      context,
    ).push(HeroDialogRoute(builder: ((context) => CompassWidget())));
  }
}
