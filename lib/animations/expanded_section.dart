import 'package:flutter/cupertino.dart';

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  const ExpandedSection({super.key, this.expand = false, required this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    // Jump to initial state immediately, no animation on first render
    expandController.value = widget.expand ? 1.0 : 0.0;
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expand != widget.expand) {
      if (widget.expand) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: widget.child,
    );
  }
}
