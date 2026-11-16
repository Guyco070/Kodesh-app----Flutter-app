import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// The 49 days of the Omer as seven rows of seven dots: counted days in
/// gold, [today] in white with a soft pulse, the rest faint. Part of
/// `OmerCountCard`; screen readers get the "N / 49" text next to it.
class OmerDaysGrid extends StatefulWidget {
  const OmerDaysGrid({super.key, required this.today});

  final int today;

  @override
  State<OmerDaysGrid> createState() => _OmerDaysGridState();
}

class _OmerDaysGridState extends State<OmerDaysGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _pulse.stop();
    } else if (!_pulse.isAnimating) {
      _pulse.repeat();
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: GridView.count(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (var n = 1; n <= 49; n++)
            if (n == widget.today)
              AnimatedBuilder(
                animation: _pulse,
                builder: (context, _) {
                  final t = _pulse.value;
                  // Ring grows and fades, like the design's pulse.
                  final spread = 6 * (t < .5 ? t * 2 : 2 - t * 2);
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: KodeshPalette.flame.withValues(
                            alpha: 0.8 * (1 - spread / 6),
                          ),
                          spreadRadius: spread,
                        ),
                      ],
                    ),
                  );
                },
              )
            else
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      n < widget.today
                          ? KodeshPalette.flame
                          : const Color(0x33FFFFFF),
                ),
              ),
        ],
      ),
    );
  }
}
