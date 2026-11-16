import 'package:flutter/material.dart';

/// A small heading over a group of side-menu items. Part of `AppDrawer`.
class DrawerSectionLabel extends StatelessWidget {
  const DrawerSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 16, 14, 6),
      child: Semantics(
        header: true,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Color(0xB3FFFFFF),
          ),
        ),
      ),
    );
  }
}
