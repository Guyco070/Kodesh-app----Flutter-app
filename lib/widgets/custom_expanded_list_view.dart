import 'package:flutter/material.dart';
import 'package:kodesh_app/animations/expanded_section.dart';

class CustomExpandedListView extends StatefulWidget {
  const CustomExpandedListView({
    super.key,
    required this.children,
    required this.title,
    this.initiallyExpanded = true,
  });

  final List<Widget> children;
  final String title;
  final bool initiallyExpanded;

  @override
  State<CustomExpandedListView> createState() => _CustomExpandedListViewState();
}

class _CustomExpandedListViewState extends State<CustomExpandedListView>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late final AnimationController _iconController;
  late final Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeIn),
    );
    if (_isExpanded) {
      _iconController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _iconController.forward();
      } else {
        _iconController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        InkWell(
          onTap: _toggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ),
                RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    Icons.expand_more,
                    color: Colors.grey[600],
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(indent: 18, endIndent: 18),
        ExpandedSection(
          expand: _isExpanded,
          child: Column(
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
