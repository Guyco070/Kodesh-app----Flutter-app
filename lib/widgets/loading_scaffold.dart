import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/default_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingScaffold extends StatefulWidget {
  const LoadingScaffold({super.key});

  @override
  State<LoadingScaffold> createState() => _LoadingScaffoldState();
}

class _LoadingScaffoldState extends State<LoadingScaffold> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(title: AppLocalizations.of(context)!.loading, body: const Center(child: CircularProgressIndicator()));
  }
}