import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kodesh_app/screens/compass_screen.dart';
import 'package:kodesh_app/services/compass_service.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/compass/custom_rect_tween.dart';
import 'package:kodesh_app/widgets/compass/compass_dial.dart';
import 'package:kodesh_app/widgets/compass/pulsing_ring.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/helpers/western_wall_bearing.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    if (!isCompassAvailable) {
      setState(() {});
      return;
    }
    if (needsPermissionRequest) {
      setState(() {});
      return;
    }
    await _startListening();
  }

  Future<void> _startListening() async {
    _stream = getCompassStream().listen((h) {
      if (mounted) setState(() => heading = h);
    });
    if (mounted)
      setState(() {
        _permissionGranted = true;
      });
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
            const Icon(
              Icons.explore_outlined,
              size: 64,
              color: KodeshPalette.textMuted,
            ),
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

    final target = bearingFromCity(context.watch<Events>().city) ?? 50;
    final h = heading ?? 0;
    // Smallest angle between where the device points and the target.
    final off = ((target - h + 540) % 360) - 180;
    final isAligned = off.abs() <= 5;

    return Hero(
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      tag: CompassScreen.routeName,
      child: Material(
        type: MaterialType.transparency,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final dialSize = (math.min(
                      constraints.maxWidth,
                      constraints.maxHeight.isFinite
                          ? constraints.maxHeight - 160
                          : constraints.maxWidth,
                    ) -
                    48)
                .clamp(200.0, 420.0);
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                16,
                24,
                16,
                24 + MediaQuery.of(context).viewPadding.bottom,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: PulsingRing(
                          size: dialSize,
                          color:
                              isAligned
                                  ? KodeshPalette.switchOn
                                  : const Color(0xFF2EE6D0),
                          child: CompassDial(
                            size: dialSize,
                            heading: h,
                            target: target,
                          ),
                        ),
                      ),
                      if (widget.indicatorType !=
                          CompassIndicatorIcon.none) ...[
                        const SizedBox(height: 28),
                        GlassPanel(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: MergeSemantics(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appLocalizations.direction,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: KodeshPalette.textMuted,
                                        ),
                                      ),
                                      Text(
                                        '${target.round()}°',
                                        textDirection: TextDirection.ltr,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  isAligned
                                      ? Icons.check_circle_rounded
                                      : Icons.explore_outlined,
                                  size: 36,
                                  color:
                                      isAligned
                                          ? KodeshPalette.switchOn
                                          : KodeshPalette.textMuted,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
