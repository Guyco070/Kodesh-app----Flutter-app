import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/api/notification_api.dart';
import 'package:kodesh_app/providers/reminders.dart';

void main() {
  group('NotificationApi.scheduleDailyDateTime', () {
    test('returns a DateTime with the requested hour and minute', () {
      final result = NotificationApi.scheduleDailyDateTime(8, 30);
      expect(result.hour, 8);
      expect(result.minute, 30);
      expect(result.second, 0);
    });

    test('result is always in the future', () {
      final result = NotificationApi.scheduleDailyDateTime(0, 0);
      // 00:00 today is always in the past (unless it's exactly midnight), so
      // it should be scheduled for tomorrow.
      expect(result.isAfter(DateTime.now()), isTrue);
    });

    test('target time later today is scheduled for today', () {
      final now = DateTime.now();
      // Pick a time 2 hours from now (safe margin)
      final future = now.add(const Duration(hours: 2));
      final result = NotificationApi.scheduleDailyDateTime(
        future.hour,
        future.minute,
      );
      expect(result.day, now.day);
      expect(result.month, now.month);
      expect(result.year, now.year);
    });

    test('past time today is pushed to tomorrow', () {
      // 00:00 is always in the past
      final result = NotificationApi.scheduleDailyDateTime(0, 0);
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(result.day, tomorrow.day);
    });
  });

  group('Reminders.tefilinNextDate', () {
    test('advances by 1 day on a regular weekday (Monday)', () {
      // 2024-06-10 is a Monday (weekday == 1)
      final monday = DateTime(2024, 6, 10, 8, 0);
      expect(monday.weekday, DateTime.monday);
      final next = Reminders.tefilinNextDate(monday);
      expect(next.weekday, DateTime.tuesday);
      expect(next.difference(monday).inDays, 1);
    });

    test('advances by 1 day on a Thursday', () {
      // 2024-06-13 is a Thursday (weekday == 4)
      final thursday = DateTime(2024, 6, 13, 8, 0);
      expect(thursday.weekday, DateTime.thursday);
      final next = Reminders.tefilinNextDate(thursday);
      expect(next.weekday, DateTime.friday);
    });

    test('advances by 2 days on a Friday, skipping Shabbat', () {
      // 2024-06-14 is a Friday (weekday == 5)
      final friday = DateTime(2024, 6, 14, 8, 0);
      expect(friday.weekday, DateTime.friday);
      final next = Reminders.tefilinNextDate(friday);
      expect(next.weekday, DateTime.sunday);
      expect(next.difference(friday).inDays, 2);
    });

    test('result is never Saturday', () {
      // Run for 14 consecutive days to ensure no Saturday appears
      DateTime current = DateTime(2024, 6, 10); // Monday
      for (int i = 0; i < 14; i++) {
        current = Reminders.tefilinNextDate(current);
        expect(
          current.weekday,
          isNot(DateTime.saturday),
          reason: 'tefilinNextDate should never land on Shabbat',
        );
      }
    });

    test('preserves the time of day', () {
      final friday = DateTime(2024, 6, 14, 7, 30);
      final next = Reminders.tefilinNextDate(friday);
      expect(next.hour, 7);
      expect(next.minute, 30);
    });
  });
}
