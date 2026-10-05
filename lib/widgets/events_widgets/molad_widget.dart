import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/models/molad.dart';

/// Shows the Molad announcement as a compact note rather than a titled
/// section: the announcement text already says everything, so a separate
/// heading would only repeat it.
class MoladWidget extends StatelessWidget {
  const MoladWidget({super.key, required this.data});
  final Molad data;

  /// The Hebrew text (with nikud) reads better for Hebrew users; everyone else
  /// gets the localized title Hebcal returned for their language.
  String _resolveText(BuildContext context) {
    final isHe = Localizations.localeOf(context).languageCode == 'he';
    if (isHe && data.titleOrig != null && data.titleOrig!.isNotEmpty) {
      return data.titleOrig!;
    }
    return data.title;
  }

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
                _resolveText(context),
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
