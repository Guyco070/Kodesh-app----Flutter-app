import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/language_change_provider.dart';

/// Renders a list of zmanim widgets in a [Column] where each item slides in
/// once when it first appears.
///
/// Each child must carry a unique [Key]. Because items are keyed, rebuilding
/// with a filtered list (e.g. while searching) preserves already-shown items —
/// they do not re-run their entry animation — while newly-matching items slide
/// in. Items that are filtered out are simply removed (no exit animation).
class AnimatedZmanimList extends StatelessWidget {
  const AnimatedZmanimList({super.key, required this.widgets});

  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widgets.length; i++)
          _SlideInItem(
            // Reuse the child's own key so reconciliation preserves state.
            key: widgets[i].key,
            index: i,
            child: widgets[i],
          ),
      ],
    );
  }
}

class _SlideInItem extends StatefulWidget {
  const _SlideInItem({
    super.key,
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  State<_SlideInItem> createState() => _SlideInItemState();
}

class _SlideInItemState extends State<_SlideInItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    final begin = Offset(LanguageChangeProvider.isDirectionRTL(null) ? -1 : 1, 0);
    _offset = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    // Stagger the entry animation by item index, capped so later items in a
    // long/filtered list still appear promptly.
    final delayMs = (widget.index * 50).clamp(0, 600);
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
