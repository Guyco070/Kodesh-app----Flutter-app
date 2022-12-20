import 'package:flutter/cupertino.dart';

class SlideInAnimation extends StatefulWidget {
  const SlideInAnimation({super.key, required this.widget});
  final Widget widget;

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _offsetAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(parent: _animationController, curve: Curves.elasticIn));
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)),
        duration: const Duration(seconds: 3),
        builder: ((context, value, child) => SlideTransition(
              position: _offsetAnimation,
              child: widget.widget,
            )));
  }
}
