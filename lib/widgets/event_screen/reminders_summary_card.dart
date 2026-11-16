import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/providers/home_tab_controller.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:provider/provider.dart';

/// The home row that shows how many reminders are on and opens the
/// Reminders tab. Part of `EventScreen`.
class RemindersSummaryCard extends StatelessWidget {
  const RemindersSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final r = context.watch<Reminders>();
    final flags = [r.shabatAndHolidays, r.tefilin, r.roshChodesh, r.sfiratOmer];
    final on = flags.where((f) => f).length;

    void open() => context.read<HomeTabController>().select(HomeTab.reminders);

    return GlassPanel(
      padding: EdgeInsets.zero,
      child: Semantics(
        button: true,
        label: l.openReminders,
        child: InkWell(
          onTap: open,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18, 14, 14, 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.remindersActive,
                        style: const TextStyle(
                          fontSize: 12,
                          color: KodeshPalette.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l.remindersActiveCount(on, flags.length),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const ExcludeSemantics(
                  child: SizedBox.square(
                    dimension: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x42FFFFFF),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
