import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:kodesh_app/widgets/compass/compass_widget.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});
  static String routeName = '/compass_screen';

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  late StreamSubscription<CompassEvent> stream;
  double? heading = 0;

  @override
  void initState() {
    super.initState();
    stream = FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.compass,
        ),
        body: CompassWidget(indicatorType: CompassIndicatorIcon.top,));
  }
}
