import 'package:flutter/material.dart';

/// Fades its child in while lifting it by [distance] pixels, once, after
/// [delay]. The entrance used for the sections of each screen in the design
/// (stagger sections by ~120 ms).
///
/// Shows the child at once when the system asks to reduce motion.
class RiseIn extends StatefulWidget {
  const RiseIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.distance = 18,
    this.duration = const Duration(milliseconds: 800),
  });

  final Widget child;
  final Duration delay;
  final double distance;
  final Duration duration;

  @override
  State<RiseIn> createState() => _RiseInState();
}

class _RiseInState extends State<RiseIn> with SingleTickerProviderStateMixin {
  static const Curve _curve = Cubic(.2, .8, .2, 1);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.of(context).disableAnimations) {
      _controller.value = 1;
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: _controller, curve: _curve);
    return AnimatedBuilder(
      animation: curved,
      builder:
          (context, child) => Opacity(
            opacity: curved.value,
            child: Transform.translate(
              offset: Offset(0, widget.distance * (1 - curved.value)),
              child: child,
            ),
          ),
      child: widget.child,
    );
  }
}
