import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/screens/hero_dialog_route.dart';
import 'package:kodesh_app/widgets/compass/compass_widget.dart';
import 'package:kodesh_app/widgets/compass/custom_rect_tween.dart';

class CompassButton extends StatelessWidget {
  final double? heading;

  const CompassButton({super.key, this.heading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
          tag: CompassScreen.routeName,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              HeroDialogRoute(builder: ((context) => CompassWidget())));
        },
        
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: Colors.black,
              border: Border.all(color: Colors.grey)
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/cadrant.png'),
                Transform.rotate(
                    angle: ((heading ?? 0) - 50) * (pi / 180) * -1,
                    child: Image.asset(
                      'assets/compass.png',
                      scale: 1.1,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
