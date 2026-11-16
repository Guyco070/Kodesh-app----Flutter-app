import 'package:flutter/material.dart';

/// The thin glass track with a light sweeping across it under the splash
/// logo. Indeterminate: the app does not know how long loading will take.
class SplashLoadingBar extends StatefulWidget {
  const SplashLoadingBar({super.key, required this.semanticLabel});

  final String semanticLabel;

  @override
  State<SplashLoadingBar> createState() => _SplashLoadingBarState();
}

class _SplashLoadingBarState extends State<SplashLoadingBar>
    with SingleTickerProviderStateMixin {
  static const double _width = 140;
  static const double _glowWidth = 60;

  late final AnimationController _sweep = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _sweep.value = 0.5;
    } else if (!_sweep.isAnimating) {
      _sweep.repeat();
    }
  }

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: SizedBox(
          width: _width,
          height: 6,
          child: ColoredBox(
            color: const Color(0x2EFFFFFF),
            child: AnimatedBuilder(
              animation: _sweep,
              builder: (context, _) {
                final eased = Curves.easeInOut.transform(_sweep.value);
                // Travels from beyond one end of the track to the other.
                final x = (_width + _glowWidth) * (1 - eased) - _glowWidth;
                return Stack(
                  children: [
                    Positioned(
                      left: x,
                      top: 0,
                      bottom: 0,
                      width: _glowWidth,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0x00FFFFFF),
                              Colors.white,
                              Color(0x00FFFFFF),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
