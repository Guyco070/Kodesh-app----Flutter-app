import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.children, this.elevation = 3});
  final List<Widget> children;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
