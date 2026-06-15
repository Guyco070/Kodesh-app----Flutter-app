import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/services/compass_service.dart';
import 'package:kodesh_app/widgets/compass/custom_rect_tween.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

enum CompassIndicatorIcon { none, top, center }

class CompassWidget extends StatefulWidget {
  const CompassWidget({
    super.key,
    this.indicatorType = CompassIndicatorIcon.center,
  });
  final CompassIndicatorIcon indicatorType;

  @override
  State<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  StreamSubscription<double?>? _stream;
  double? heading = 0;
  bool _permissionGranted = false;
  bool _permissionChecked = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    if (!isCompassAvailable) {
      setState(() => _permissionChecked = true);
      return;
    }
    if (needsPermissionRequest) {
      setState(() => _permissionChecked = true);
      return;
    }
    await _startListening();
  }

  Future<void> _startListening() async {
    _stream = getCompassStream().listen((h) {
      if (mounted) setState(() => heading = h);
    });
    if (mounted) setState(() { _permissionGranted = true; _permissionChecked = true; });
  }

  Future<void> _requestAndStart() async {
    final granted = await requestPermission();
    if (granted) {
      await _startListening();
    }
  }

  @override
  void dispose() {
    _stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (!isCompassAvailable) {
      return Center(
        child: Text(
          appLocalizations.compassNotSupported,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (needsPermissionRequest && !_permissionGranted) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.explore_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.sensors),
              label: Text(appLocalizations.enableCompass),
              onPressed: _requestAndStart,
            ),
          ],
        ),
      );
    }

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
          builder:
              (context, orientation) => Container(
                width:
                    orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width / 1.3
                        : MediaQuery.of(context).size.height / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.black,
                  border: Border.all(color: Colors.grey),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.indicatorType == CompassIndicatorIcon.top &&
                          orientation == Orientation.portrait) ...{
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: indicatorIcon(),
                        ),
                        const SizedBox(height: 20.0),
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
                              ),
                            ),
                            if (widget.indicatorType ==
                                    CompassIndicatorIcon.center ||
                                orientation != Orientation.portrait)
                              indicatorIcon(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
