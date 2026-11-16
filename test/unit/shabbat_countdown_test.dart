import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/helpers/shabbat_countdown.dart';
import 'package:kodesh_app/models/shabat.dart';

Shabat _shabat(DateTime entry, DateTime release) => Shabat(
  title: 'Shabat',
  parasha: 'Toldot',
  entryDate: entry,
  releaseDate: release,
  titleOrig: null,
);

void main() {
  final entry = DateTime(2026, 11, 13, 16, 21);
  final release = DateTime(2026, 11, 14, 17, 19);

  test('returns null when there is no Shabbat', () {
    expect(shabbatCountdown([], DateTime(2026, 11, 13)), isNull);
  });

  test('counts down to candle lighting before Shabbat', () {
    final now = DateTime(2026, 11, 13, 14, 7);
    final c = shabbatCountdown([_shabat(entry, release)], now)!;
    expect(c.inProgress, isFalse);
    expect(c.remaining, const Duration(hours: 2, minutes: 14));
    expect(c.progress, greaterThan(0.9));
  });

  test('counts down to havdalah during Shabbat', () {
    final now = DateTime(2026, 11, 14, 12, 0);
    final c = shabbatCountdown([_shabat(entry, release)], now)!;
    expect(c.inProgress, isTrue);
    expect(c.remaining, release.difference(now));
    expect(c.progress, inInclusiveRange(0.0, 1.0));
  });

  test('skips a Shabbat that has already ended', () {
    final next = _shabat(
      entry.add(const Duration(days: 7)),
      release.add(const Duration(days: 7)),
    );
    final now = DateTime(2026, 11, 15, 10);
    final c = shabbatCountdown([_shabat(entry, release), next], now)!;
    expect(c.shabbat, same(next));
  });
}
