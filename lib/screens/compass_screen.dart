import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
import 'package:kodesh_app/widgets/compass/compass_widget.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});
  static String routeName = '/compass_screen';

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      backdrop: KodeshBackdrop.compass,
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.compass),
      body: const CompassWidget(indicatorType: CompassIndicatorIcon.top),
    );
  }
}
