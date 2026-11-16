import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/brand/kodesh_emblem.dart';
import 'package:kodesh_app/widgets/brand/kodesh_wordmark.dart';

/// The Kodesh symbol and wordmark at the top of the side menu. Part of
/// `AppDrawer`.
class DrawerBrandHeader extends StatelessWidget {
  const DrawerBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: 'Kodesh',
      child: const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(14, 8, 14, 18),
        child: Row(
          children: [
            KodeshEmblem(width: 50, excludeFromSemantics: true),
            SizedBox(width: 12),
            KodeshWordmark(fontSize: 28),
          ],
        ),
      ),
    );
  }
}
