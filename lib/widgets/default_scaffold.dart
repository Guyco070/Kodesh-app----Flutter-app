import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/app_drawer.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({super.key, required this.title, required this.body});
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: Text(
            title,
            textDirection: TextDirection.rtl,
          ),
          centerTitle: true,
        ),
        body: body,
        persistentFooterAlignment: AlignmentDirectional.topCenter,
      );
  }
}
