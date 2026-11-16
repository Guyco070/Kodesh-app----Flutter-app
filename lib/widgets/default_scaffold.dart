import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/home_tab_controller.dart';
import 'package:kodesh_app/theme/kodesh_layout.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/app_drawer.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:provider/provider.dart';

/// The scaffold of a bottom-navigation tab: the side menu, the large
/// [TabHeader] (menu · subtitle and title · settings) and the tab's
/// background scene.
class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.backdrop = KodeshBackdrop.home,
    this.floatingActionButton,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final Widget? floatingActionButton;

  /// Background scene of the screen.
  final KodeshBackdrop backdrop;

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      backdrop: backdrop,
      drawer: KodeshLayout.hasSidebar(context) ? null : const AppDrawer(),
      onDrawerChanged: context.read<HomeTabController>().setDrawerOpen,
      appBar: TabHeader(title: title, subtitle: subtitle),
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }
}
