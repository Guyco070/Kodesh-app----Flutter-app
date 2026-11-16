import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

/// Credits the external data providers the app relies on. Hebcal (CC BY 4.0)
/// and OpenStreetMap (ODbL) both require visible attribution.
class DataSourcesAttribution extends StatelessWidget {
  const DataSourcesAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        Text(
          l10n.dataSourcesTitle,
          textAlign: TextAlign.center,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        for (final line in [
          l10n.dataSourcesHebcal,
          l10n.dataSourcesOsm,
          l10n.dataSourcesSefaria,
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
