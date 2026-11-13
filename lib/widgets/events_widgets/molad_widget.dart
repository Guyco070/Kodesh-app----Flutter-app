import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/models/molad.dart';

/// Shows the Molad announcement as a compact note rather than a titled
/// section: the announcement text already says everything, so a separate
/// heading would only repeat it.
///
/// [Molad.title] is already localized by Hebcal (events are fetched in the UI
/// language), so it is shown as-is. [Molad.titleOrig] holds only a short
/// Hebrew form ("מולד חשון") and is not used here.
class MoladWidget extends StatelessWidget {
  const MoladWidget({super.key, required this.data});
  final Molad data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: AppLocalizations.of(context)!.molad,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.nights_stay_outlined,
              size: 20,
              color: colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                data.title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
