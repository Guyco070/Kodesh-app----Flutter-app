import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/helpers/dates.dart';

void main() {
  group('isYesterdayTodayOrTomorrow', () {
    test('returns true for today', () {
      expect(isYesterdayTodayOrTomorrow(DateTime.now()), isTrue);
    });

    test('returns true for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(isYesterdayTodayOrTomorrow(yesterday), isTrue);
    });

    test('returns true for tomorrow', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(isYesterdayTodayOrTomorrow(tomorrow), isTrue);
    });

    test('returns false for two days ago', () {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      expect(isYesterdayTodayOrTomorrow(twoDaysAgo), isFalse);
    });

    test('returns false for two days from now', () {
      final twoDaysFromNow = DateTime.now().add(const Duration(days: 2));
      expect(isYesterdayTodayOrTomorrow(twoDaysFromNow), isFalse);
    });

    test('ignores time-of-day when comparing', () {
      final tomorrowMidnight = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1,
        23,
        59,
      );
      expect(isYesterdayTodayOrTomorrow(tomorrowMidnight), isTrue);
    });
  });

  group('isToday', () {
    test('returns true for current DateTime', () {
      expect(isToday(DateTime.now()), isTrue);
    });

    test('returns false for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(isToday(yesterday), isFalse);
    });

    test('returns false for tomorrow', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(isToday(tomorrow), isFalse);
    });
  });

  group('getSingleElementZeroAdded', () {
    test('pads single digit with leading zero', () {
      expect(getSingleElementZeroAdded('5'), '05');
    });

    test('leaves two-digit string unchanged', () {
      expect(getSingleElementZeroAdded('12'), '12');
    });

    test('pads empty string to 00', () {
      expect(getSingleElementZeroAdded(''), '00');
    });
  });

  group('getTime', () {
    test('formats DateTime to HH:mm', () {
      final dt = DateTime(2024, 6, 14, 9, 5);
      expect(getTime(dt, null, null), '09:05');
    });

    test('formats hour and minute strings directly', () {
      expect(getTime(null, '7', '8'), '08:07');
    });

    test('zero-pads both hour and minute', () {
      expect(getTime(null, '0', '0'), '00:00');
    });
  });

  group('getDateTimeSetToZero', () {
    test('strips hours, minutes, seconds from a DateTime', () {
      final dt = DateTime(2024, 6, 14, 18, 30, 45);
      final result = getDateTimeSetToZero(dt);
      expect(result, DateTime(2024, 6, 14));
    });
  });

  group('getDushedFormatedDate', () {
    test('formats date as YYYY-MM-DD with zero-padding', () {
      final dt = DateTime(2024, 6, 4);
      expect(getDushedFormatedDate(dt), '2024-06-04');
    });

    test('formats two-digit month and day unchanged', () {
      final dt = DateTime(2024, 12, 31);
      expect(getDushedFormatedDate(dt), '2024-12-31');
    });
  });
}
