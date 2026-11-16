import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/theme/kodesh_fonts.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/theme/kodesh_theme.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/widgets/sfirat_omer_screen/omer_days_grid.dart';

/// The day's Omer count, as in the design: a big day number with the
/// counting formula, then the 49 days as a grid. Part of `SfiratOmerScreen`.
class OmerCountCard extends StatelessWidget {
  const OmerCountCard({super.key, required this.omer, required this.isTonight});

  final SfiratOmer omer;

  /// Whether this is the day counted tonight (else the one counted last
  /// night, i.e. today's).
  final bool isTonight;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    final day = omer.dayNumber!;
    final count = (omer.sefira['count'] as Map?)?[lang == 'he' ? 'he' : 'en'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GlassPanel(
          strong: true,
          elevated: true,
          radius: KodeshTheme.heroRadius,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            children: [
              Text(
                isTonight ? l.omerTonight : l.todayWord,
                style: const TextStyle(
                  fontSize: 13,
                  color: KodeshPalette.textMuted,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$day',
                style: const TextStyle(
                  fontSize: 88,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  letterSpacing: -3,
                ),
              ),
              if (count is String) ...[
                const SizedBox(height: 10),
                Text(
                  count,
                  textAlign: TextAlign.center,
                  textDirection:
                      lang == 'he' ? TextDirection.rtl : TextDirection.ltr,
                  style: const TextStyle(
                    fontFamily: KodeshFonts.prayer,
                    fontSize: 19,
                    height: 1.6,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),
        GlassPanel(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l.omerDaysOfCounting,
                      style: const TextStyle(
                        fontSize: 13,
                        color: KodeshPalette.textMuted,
                      ),
                    ),
                  ),
                  Text(
                    '$day / 49',
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 13,
                      color: KodeshPalette.textMuted,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              OmerDaysGrid(today: day),
            ],
          ),
        ),
      ],
    );
  }
}
