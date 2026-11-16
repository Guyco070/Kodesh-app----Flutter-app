import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/helpers/home_summary.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/models/zman.dart';

void main() {
  group('calendarDaysBetween', () {
    test('counts dates, not 24-hour periods', () {
      expect(
        calendarDaysBetween(
          DateTime(2026, 11, 15, 22, 0),
          DateTime(2026, 11, 20, 16, 0),
        ),
        5,
      );
    });

    test('is zero on the same date', () {
      expect(
        calendarDaysBetween(
          DateTime(2026, 11, 20, 1),
          DateTime(2026, 11, 20, 23),
        ),
        0,
      );
    });
  });

  test('findZman returns the zman with the key, or null', () {
    final zmanim = [
      Zman('sunrise', DateTime(2026, 11, 15, 6)),
      Zman('sunset', DateTime(2026, 11, 15, 16, 38)),
    ];
    expect(findZman(zmanim, 'sunset')?.date.minute, 38);
    expect(findZman(zmanim, 'dusk'), isNull);
    expect(findZman(null, 'sunset'), isNull);
  });

  test('Shabbat greeting on Friday and Saturday only', () {
    expect(isShabbatGreetingDay(DateTime(2026, 11, 20)), isTrue); // Fri
    expect(isShabbatGreetingDay(DateTime(2026, 11, 21)), isTrue); // Sat
    expect(isShabbatGreetingDay(DateTime(2026, 11, 15)), isFalse); // Sun
  });

  group('currentOmer', () {
    SfiratOmer omer(int day, DateTime date) => SfiratOmer(
      title: 'day $day',
      entryDate: date,
      sefira: const {},
      titleOrig: 'Omer $day',
    );
    final events = [
      omer(12, DateTime(2026, 4, 14)),
      omer(13, DateTime(2026, 4, 15)),
    ];

    test('in the evening shows the day counted tonight', () {
      expect(currentOmer(events, DateTime(2026, 4, 14, 20))?.dayNumber, 13);
    });

    test('in the morning shows the day counted last night', () {
      expect(currentOmer(events, DateTime(2026, 4, 14, 8))?.dayNumber, 12);
    });

    test('is null outside the Omer', () {
      expect(currentOmer(events, DateTime(2026, 6, 1, 8)), isNull);
    });
  });
}
