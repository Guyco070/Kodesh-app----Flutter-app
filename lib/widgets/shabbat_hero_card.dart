import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/helpers/shabbat_countdown.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/theme/kodesh_theme.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/widgets/shabbat_hero_card/candle_flames.dart';
import 'package:kodesh_app/widgets/shabbat_hero_card/countdown_ring.dart';

/// The big glass card at the top of the home screen: the parasha, a ring
/// counting down to candle lighting (or to havdalah during Shabbat), and the
/// entry and exit times. Renders nothing when [events] has no upcoming
/// Shabbat with times.
class ShabbatHeroCard extends StatefulWidget {
  const ShabbatHeroCard({super.key, required this.events});

  final List<Event> events;

  @override
  State<ShabbatHeroCard> createState() => _ShabbatHeroCardState();
}

class _ShabbatHeroCardState extends State<ShabbatHeroCard> {
  late Timer _ticker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // The countdown shows minutes, so a refresh every 30 s is enough.
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countdown = shabbatCountdown(widget.events, _now);
    if (countdown == null) return const SizedBox.shrink();

    final l = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final hm = DateFormat.Hm(locale);
    final s = countdown.shabbat;
    final label = countdown.inProgress ? l.shabbatEndsIn : l.candleLightingIn;
    final hours = countdown.remaining.inHours;
    final minutes = countdown.remaining.inMinutes % 60;
    // Count calendar days, so "in 5 days" means five dates from today,
    // whatever the hour now and at candle lighting.
    final target = _now.add(countdown.remaining);
    final days =
        countdown.remaining.inHours < 24
            ? 0
            : DateUtils.dateOnly(
              target,
            ).difference(DateUtils.dateOnly(_now)).inDays;

    final Widget ringCenter =
        days >= 1
            ? Text(
              l.inXDays(days.toString()),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            )
            : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Text(
                    '${hours.toString().padLeft(2, '0')}:'
                    '${minutes.toString().padLeft(2, '0')}',
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                Text(
                  l.hoursColonMinutes,
                  style: const TextStyle(
                    fontSize: 11,
                    color: KodeshPalette.textMuted,
                  ),
                ),
              ],
            );

    return GlassPanel(
      strong: true,
      elevated: true,
      radius: KodeshTheme.heroRadius,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (s.parasha != null)
                      Text(
                        s.parasha!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: KodeshPalette.textMuted,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const CandleFlames(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Semantics(
                label: l.countdownSemantics(label, hours, minutes),
                excludeSemantics: true,
                child: CountdownRing(
                  progress: countdown.progress,
                  color: Colors.white,
                  center: ringCenter,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TimeLine(
                      label: l.shabbatBegins,
                      time: hm.format(s.entryDate!),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1, color: Color(0x4DFFFFFF)),
                    ),
                    _TimeLine(
                      label: l.shabbatEnds,
                      time: hm.format(s.releaseDate!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeLine extends StatelessWidget {
  const _TimeLine({required this.label, required this.time});

  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: KodeshPalette.textMuted),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            time,
            style: const TextStyle(
              fontFeatures: [FontFeature.tabularFigures()],
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
