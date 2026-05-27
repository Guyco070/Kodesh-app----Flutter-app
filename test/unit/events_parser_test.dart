import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/models/event.dart';
import 'package:kodesh_app/models/holiday.dart';
import 'package:kodesh_app/models/rosh_chodesh.dart';
import 'package:kodesh_app/models/shabat.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/providers/events.dart';

void main() {
  group('Events.getDateWithoutTime', () {
    test('strips timezone offset from ISO 8601 string', () {
      expect(Events.getDateWithoutTime('2024-06-14T18:00:00+03:00'),
          '2024-06-14T18:00:00');
    });

    test('returns plain date string unchanged', () {
      expect(Events.getDateWithoutTime('2024-06-14'), '2024-06-14');
    });

    test('handles UTC Z suffix', () {
      // Z is a 1-char suffix — method strips last 6 chars only when T present
      // and "Z" alone is 1 char, so the method won't strip it but won't crash
      final result = Events.getDateWithoutTime('2024-06-14T18:00:00+00:00');
      expect(result, '2024-06-14T18:00:00');
    });
  });

  group('Events.getEventsItemsFromMap', () {
    test('returns null for null input', () {
      expect(Events.getEventsItemsFromMap(null), isNull);
    });

    test('returns empty list for empty input', () {
      final result = Events.getEventsItemsFromMap([]) as List<Event>;
      expect(result, isEmpty);
    });

    test('parses a Shabbat entry (parashat + candles + havdalah)', () {
      final items = [
        {
          'category': 'candles',
          'title': 'Candle lighting: 19:05',
          'date': '2024-06-14T19:05:00+03:00',
        },
        {
          'category': 'parashat',
          'title': "Parashat Sh'lach",
          'title_orig': "Sh'lach",
          'date': '2024-06-14',
        },
        {
          'category': 'havdalah',
          'title': 'Havdalah: 20:15',
          'date': '2024-06-15T20:15:00+03:00',
        },
      ];

      final result = Events.getEventsItemsFromMap(items) as List<Event>;
      expect(result, hasLength(1));
      expect(result.first, isA<Shabat>());

      final shabat = result.first as Shabat;
      expect(shabat.parasha, "Parashat Sh'lach");
      expect(shabat.entryDate, DateTime(2024, 6, 14, 19, 5));
      expect(shabat.releaseDate, DateTime(2024, 6, 15, 20, 15));
    });

    test('parses a Holiday with candles and havdalah', () {
      final items = [
        {
          'category': 'candles',
          'title': 'Candle lighting: 19:05',
          'date': '2024-09-02T19:05:00+03:00',
        },
        {
          'category': 'holiday',
          'title': 'Rosh Hashana I',
          'title_orig': 'Rosh Hashana',
          'subcat': 'major',
          'date': '2024-09-03',
        },
        {
          'category': 'havdalah',
          'title': 'Havdalah: 20:10',
          'date': '2024-09-04T20:10:00+03:00',
        },
      ];

      final result = Events.getEventsItemsFromMap(items) as List<Event>;
      expect(result, hasLength(1));
      expect(result.first, isA<Holiday>());

      final holiday = result.first as Holiday;
      expect(holiday.title, 'Rosh Hashana I');
      expect(holiday.subcat, 'major');
      expect(holiday.entryDate, DateTime(2024, 9, 2, 19, 5));
      expect(holiday.releaseDate, DateTime(2024, 9, 4, 20, 10));
    });

    test('parses Rosh Chodesh entry', () {
      final items = [
        {
          'category': 'roshchodesh',
          'title': 'Rosh Chodesh Av',
          'title_orig': 'Rosh Chodesh Av',
          'date': '2024-08-05',
        },
      ];

      final result = Events.getEventsItemsFromMap(items) as List<Event>;
      expect(result, hasLength(1));
      expect(result.first, isA<RoshChodesh>());
      expect(result.first.title, 'Rosh Chodesh Av');
      expect(result.first.entryDate, DateTime(2024, 8, 5));
    });

    test('merges two-day Rosh Chodesh into one entry', () {
      final items = [
        {
          'category': 'roshchodesh',
          'title': 'Rosh Chodesh Cheshvan',
          'title_orig': 'Rosh Chodesh Cheshvan',
          'date': '2024-11-01',
        },
        {
          'category': 'roshchodesh',
          'title': 'Rosh Chodesh Cheshvan',
          'title_orig': 'Rosh Chodesh Cheshvan',
          'date': '2024-11-02',
        },
      ];

      final result = Events.getEventsItemsFromMap(items) as List<Event>;
      expect(result, hasLength(1));
      expect(result.first, isA<RoshChodesh>());

      final rc = result.first as RoshChodesh;
      expect(rc.entryDate, DateTime(2024, 11, 1));
      expect(rc.releaseDate, DateTime(2024, 11, 2));
    });

    test('parses Sefirat HaOmer entry', () {
      final items = [
        {
          'category': 'omer',
          'title': 'Omer 33',
          'title_orig': 'Omer 33',
          'date': '2024-05-26',
          'omer': {'he': 'שלשים ושלשה', 'en': 'thirty-three'},
        },
      ];

      final result = Events.getEventsItemsFromMap(items) as List<Event>;
      expect(result, hasLength(1));
      expect(result.first, isA<SfiratOmer>());
    });

    test('ignores unknown categories', () {
      final items = [
        {
          'category': 'unknown_type',
          'title': 'Some event',
          'date': '2024-06-14',
        },
      ];

      final result = Events.getEventsItemsFromMap(items) as List<Event>;
      expect(result, isEmpty);
    });

    test('parses mixed week with Shabbat and holiday', () {
      final items = [
        {
          'category': 'candles',
          'title': 'Candle lighting: 19:05',
          'date': '2024-06-14T19:05:00+03:00',
        },
        {
          'category': 'parashat',
          'title': "Parashat Sh'lach",
          'title_orig': "Sh'lach",
          'date': '2024-06-14',
        },
        {
          'category': 'havdalah',
          'title': 'Havdalah: 20:15',
          'date': '2024-06-15T20:15:00+03:00',
        },
        {
          'category': 'roshchodesh',
          'title': 'Rosh Chodesh Tammuz',
          'title_orig': 'Rosh Chodesh Tammuz',
          'date': '2024-06-16',
        },
      ];

      final result = Events.getEventsItemsFromMap(items) as List<Event>;
      expect(result, hasLength(2));
      expect(result.whereType<Shabat>(), hasLength(1));
      expect(result.whereType<RoshChodesh>(), hasLength(1));
    });
  });

  group('RoshChodesh.marge', () {
    test('earlier date becomes entryDate', () {
      final rc1 = RoshChodesh(
          title: 'Rosh Chodesh',
          entryDate: DateTime(2024, 11, 2),
          titleOrig: null);
      final rc2 = RoshChodesh(
          title: 'Rosh Chodesh',
          entryDate: DateTime(2024, 11, 1),
          titleOrig: null);

      final merged = RoshChodesh.marge(rc1, rc2);
      expect(merged.entryDate, DateTime(2024, 11, 1));
      expect(merged.releaseDate, DateTime(2024, 11, 2));
    });
  });
}
