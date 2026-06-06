import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/api/l10n/reminders_translates.dart';

void main() {
  const langs = ['en', 'he', 'es', 'ru'];
  final sampleDate = DateTime(2024, 6, 14, 19, 5);
  final sampleRelease = DateTime(2024, 6, 15, 20, 15);

  group('RemindersTranslates.shabatReminderTranslated', () {
    for (final lang in langs) {
      test('[$lang] title is non-empty string', () {
        final title =
            RemindersTranslates.shabatReminderTranslated[lang]!['title'];
        expect(title, isA<String>());
        expect((title as String).isNotEmpty, isTrue);
      });

      test('[$lang] body closure returns non-empty string', () {
        final bodyFn =
            RemindersTranslates.shabatReminderTranslated[lang]!['body']
                as Function;
        final result = bodyFn(sampleDate, sampleRelease) as String;
        expect(result.isNotEmpty, isTrue);
      });

      test('[$lang] body closure handles null releaseDate', () {
        final bodyFn =
            RemindersTranslates.shabatReminderTranslated[lang]!['body']
                as Function;
        final result = bodyFn(sampleDate, null) as String;
        expect(result.isNotEmpty, isTrue);
      });

      test('[$lang] candlesTitle is non-empty string', () {
        final t =
            RemindersTranslates.shabatReminderTranslated[lang]!['candlesTitle']
                as String;
        expect(t.isNotEmpty, isTrue);
      });

      test('[$lang] candlesBody closure returns non-empty string', () {
        final fn =
            RemindersTranslates.shabatReminderTranslated[lang]!['candlesBody']
                as Function;
        expect((fn(1, 30) as String).isNotEmpty, isTrue);
        expect((fn(0, 20) as String).isNotEmpty, isTrue);
      });

      test('[$lang] havdalahTitle is non-empty string', () {
        final t = RemindersTranslates
            .shabatReminderTranslated[lang]!['havdalahTitle'];
        if (t != null) expect((t as String).isNotEmpty, isTrue);
      });

      test('[$lang] havdalahBody closure returns non-empty string', () {
        final fn =
            RemindersTranslates.shabatReminderTranslated[lang]!['havdalahBody'];
        if (fn != null) {
          expect(((fn as Function)(0, 45) as String).isNotEmpty, isTrue);
        }
      });
    }
  });

  group('RemindersTranslates.holidayReminderTranslated', () {
    for (final lang in langs) {
      test('[$lang] body closure returns non-empty string', () {
        final fn =
            RemindersTranslates.holidayReminderTranslated[lang]!['body']
                as Function;
        expect((fn(sampleDate, sampleRelease) as String).isNotEmpty, isTrue);
        expect((fn(sampleDate, null) as String).isNotEmpty, isTrue);
      });

      test('[$lang] candlesTitle is non-empty string', () {
        final t =
            RemindersTranslates.holidayReminderTranslated[lang]!['candlesTitle']
                as String;
        expect(t.isNotEmpty, isTrue);
      });

      test('[$lang] candlesBody closure returns non-empty string', () {
        final fn =
            RemindersTranslates.holidayReminderTranslated[lang]!['candlesBody']
                as Function;
        expect((fn(0, 30) as String).isNotEmpty, isTrue);
        expect((fn(2, 0) as String).isNotEmpty, isTrue);
      });

      test('[$lang] chnukahCandlesBody closure returns non-empty string', () {
        final fn =
            RemindersTranslates
                    .holidayReminderTranslated[lang]!['chnukahCandlesBody']
                as Function;
        expect((fn(0, 30) as String).isNotEmpty, isTrue);
        expect((fn(1, 15) as String).isNotEmpty, isTrue);
      });

      test('[$lang] havdalahTitle is non-empty string', () {
        final t = RemindersTranslates
            .holidayReminderTranslated[lang]!['havdalahTitle'];
        if (t != null) expect((t as String).isNotEmpty, isTrue);
      });

      test('[$lang] havdalahBody closure returns non-empty string', () {
        final fn = RemindersTranslates
            .holidayReminderTranslated[lang]!['havdalahBody'];
        if (fn != null) {
          expect(((fn as Function)(0, 10) as String).isNotEmpty, isTrue);
        }
      });
    }
  });

  group('RemindersTranslates.roshHodeshReminderTranslated', () {
    for (final lang in langs) {
      test('[$lang] body closure returns non-empty string', () {
        final fn =
            RemindersTranslates.roshHodeshReminderTranslated[lang]!['body']
                as Function;
        final result = fn(sampleDate, 'Rosh Chodesh Av') as String;
        expect(result.isNotEmpty, isTrue);
        expect(result.contains('Rosh Chodesh Av'), isTrue);
      });
    }
  });

  group('RemindersTranslates.tefilinReminderTranslated', () {
    for (final lang in langs) {
      test('[$lang] title is non-empty string', () {
        final t =
            RemindersTranslates.tefilinReminderTranslated[lang]!['title']
                as String;
        expect(t.isNotEmpty, isTrue);
      });

      test('[$lang] body is non-empty string', () {
        final b =
            RemindersTranslates.tefilinReminderTranslated[lang]!['body']
                as String;
        expect(b.isNotEmpty, isTrue);
      });

      test('[$lang] roshHodeshTitle is non-empty string', () {
        final t =
            RemindersTranslates
                    .tefilinReminderTranslated[lang]!['roshHodeshTitle']
                as String;
        expect(t.isNotEmpty, isTrue);
      });

      test('[$lang] roshHodeshBody is non-empty string', () {
        final b =
            RemindersTranslates
                    .tefilinReminderTranslated[lang]!['roshHodeshBody']
                as String;
        expect(b.isNotEmpty, isTrue);
      });
    }
  });
}
