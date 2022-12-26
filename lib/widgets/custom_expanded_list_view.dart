import 'package:flutter/material.dart';

class CustomExpandedListView extends StatefulWidget {
  const CustomExpandedListView({super.key, required this.children, this.maxHeight = 300, this.minHeight = 140});
  final List<Widget> children;
  final double minHeight;
  final double maxHeight;
  @override
  State<CustomExpandedListView> createState() => _CutomExpandedListViewState();
}

class _CutomExpandedListViewState extends State<CustomExpandedListView> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0),
                        Colors.black.withOpacity(
                            0.1), //This controls the darkness of the bar
                      ],
                      // stops: [0, 1], if you want to adjust the gradiet this is where you would do it
                    ),
                  ),
                  child: LimitedBox(
                    maxHeight: _isExpanded ? widget.maxHeight : widget.minHeight,
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: widget.children,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 22,
                    ))
              ],
            );
  }
}