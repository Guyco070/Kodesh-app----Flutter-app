import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/widgets/compass/custom_rect_tween.dart';

enum CompassIndicatorIcon {
  none,
  top,
  center,
}

class CompassWidget extends StatefulWidget {
  CompassWidget({super.key, this.indicatorType = CompassIndicatorIcon.center});
  CompassIndicatorIcon indicatorType;

  @override
  State<CompassWidget> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassWidget> {
  late StreamSubscription<CompassEvent> stream;
  double? heading = 0;

  @override
  void initState() {
    super.initState();
    stream = FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Icon indicatorIcon() {
      if (heading != null && heading! <= 55.0 && heading! >= 45.0) {
        return const Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.green,
          size: 60,
        );
      } else {
        return const Icon(
          Icons.unpublished_outlined,
          color: Colors.red,
          size: 60,
        );
      }
    }

    return Hero(
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      tag: CompassScreen.routeName,
      child: Center(
          child: OrientationBuilder(
            builder: (context, orientation) => Container(
                  width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 1.3 : MediaQuery.of(context).size.height / 1.3,
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: Colors.black,
              border: Border.all(color: Colors.grey)),
                  child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text('${heading!.ceil()}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),),
          
                if (widget.indicatorType == CompassIndicatorIcon.top && orientation == Orientation.portrait) ...{
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: indicatorIcon(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                },
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                      if (widget.indicatorType == CompassIndicatorIcon.center || orientation != Orientation.portrait)
                        indicatorIcon(),
                    ],
                  ),
                )
              ],
            ),
                  ),
                ),
          )),
    );
  }
}
