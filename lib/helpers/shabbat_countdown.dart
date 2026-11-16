import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/shabat.dart';

/// Where we stand relative to the next (or current) Shabbat.
class ShabbatCountdown {
  const ShabbatCountdown({
    required this.shabbat,
    required this.inProgress,
    required this.remaining,
    required this.progress,
  });

  final Shabat shabbat;

  /// Candles are lit and havdalah has not come yet.
  final bool inProgress;

  /// Time left until candle lighting, or until havdalah when [inProgress].
  final Duration remaining;

  /// 0..1 for a progress ring: the share of the last week before candle
  /// lighting that has passed, or the share of Shabbat that has passed.
  final double progress;
}

/// Finds the first Shabbat in [events] whose havdalah is after [now] and
/// describes the countdown to it. Returns null when there is none, or when
/// its times are missing.
ShabbatCountdown? shabbatCountdown(List<Event> events, DateTime now) {
  final upcoming =
      events
          .whereType<Shabat>()
          .where(
            (s) =>
                s.entryDate != null &&
                s.releaseDate != null &&
                s.releaseDate!.isAfter(now),
          )
          .toList()
        ..sort((a, b) => a.entryDate!.compareTo(b.entryDate!));
  if (upcoming.isEmpty) return null;

  final s = upcoming.first;
  final entry = s.entryDate!;
  final release = s.releaseDate!;
  final inProgress = !now.isBefore(entry);

  if (inProgress) {
    final total = release.difference(entry).inSeconds;
    final passed = now.difference(entry).inSeconds;
    return ShabbatCountdown(
      shabbat: s,
      inProgress: true,
      remaining: release.difference(now),
      progress: total <= 0 ? 1 : (passed / total).clamp(0.0, 1.0),
    );
  }

  const week = Duration(days: 7);
  final remaining = entry.difference(now);
  return ShabbatCountdown(
    shabbat: s,
    inProgress: false,
    remaining: remaining,
    progress: (1 - remaining.inSeconds / week.inSeconds).clamp(0.0, 1.0),
  );
}
