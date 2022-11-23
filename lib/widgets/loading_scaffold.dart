import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';

class LoadingScaffold extends StatefulWidget {
  const LoadingScaffold({super.key});

  @override
  State<LoadingScaffold> createState() => _LoadingScaffoldState();
}

class _LoadingScaffoldState extends State<LoadingScaffold> {
  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(title: 'טוען...', body: Center(child: CircularProgressIndicator()));
  }
}