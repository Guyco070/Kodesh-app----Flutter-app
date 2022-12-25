import 'package:intl/intl.dart';

class RemindersTranslates {  
  static final shabatReminderTranslated = {
    'en': {
      'title': 'Shabbat Shalom',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body =
            'You asked us to remind you of some chores before Shabbat, click to watch.\n';

        body += 'Candle lighting at ${DateFormat('HH:mm').format(entryDate)}.';

        if (releaseDate != null) {
          body +=
              '\nHavdalah time: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'Shabbat Shalom - candle lighting time',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'In $beforeShabatAndHolidaysCandlesHours hours and $beforeShabatAndHolidaysCandlesMinutes minutes Shabbat will come, don\'t forget to light candles.',
    },
    'he': {
      'title': 'שבת שלום',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body = 'ביקשת שנזכיר לך כמה מטלות לפני שבת, לחץ כדי לצפות.\n';
        body += 'הדלקת נרות בשעה ${DateFormat('HH:mm').format(entryDate)}.';

        if (releaseDate != null) {
          body +=
              '\nזמן הבדלה: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'שבת שלום - זמן להדלקת נרות',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'בעוד $beforeShabatAndHolidaysCandlesHours שעות ו-$beforeShabatAndHolidaysCandlesMinutes דקות תכנס השבת , לא לשכוח להדליק נרות.',
    },
    'es': {
      'title': 'Shabat shalom',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body =
            'Nos pediste que te recordáramos algunas tareas antes de Shabat, haz clic para ver.\n';

        body +=
            'Encendido de velas en ${DateFormat('HH:mm').format(entryDate)}.';

        if (releaseDate != null) {
          body +=
              '\nTiempo de Havdalá: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'Shabat Shalom - tiempo de encendido de velas',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'en $beforeShabatAndHolidaysCandlesHours horas y-$beforeShabatAndHolidaysCandlesMinutes minutos llegará Shabat, no olvides encender velas.',
    },
    'ru': {
      'title': 'Шаббат шалом',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body =
            'Вы просили напомнить вам о некоторых делах перед Шаббатом, нажмите, чтобы посмотреть.\n';

        body += 'Зажигание свечи на ${DateFormat('HH:mm').format(entryDate)}.';

        if (releaseDate != null) {
          body +=
              '\nВремя Хавдалы: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'Шаббат Шалом - время зажигания свечей',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'в $beforeShabatAndHolidaysCandlesHours часы а также-$beforeShabatAndHolidaysCandlesMinutes минуты Шаббат придет, не забудьте зажечь свечи.',
    },
  };

  static final holidayReminderTranslated = {
    'en': {
      // 'title': 'Shabbat Shalom',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body = 'You asked us to remind you:\n';

        if (DateFormat('HH:mm').format(entryDate) != '00:00') {
          body +=
              'Candle lighting at ${DateFormat('HH:mm').format(entryDate)}.';
        }
        if (releaseDate != null) {
          body +=
              '\nHavdalah time: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'Holiday candle lighting time',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'In ${beforeShabatAndHolidaysCandlesHours != 0 ? '$beforeShabatAndHolidaysCandlesHours hours and ' : ''}$beforeShabatAndHolidaysCandlesMinutes minutes the holiday will come, don\'t forget to light candles.',
      'chnukahCandlesBody' : (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'In ${beforeShabatAndHolidaysCandlesHours != 0 ? '$beforeShabatAndHolidaysCandlesHours hours and ' : ''}$beforeShabatAndHolidaysCandlesMinutes minutes it\'s time to light Hanukkah candles will come, don\'t forget to light candles.',
    },
    'he': {
      // 'title': 'שבת שלום',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body = 'ביקשת שנזכיר לך:\n';
        if (DateFormat('HH:mm').format(entryDate) != '00:00') {
          body += 'הדלקת נרות בשעה ${DateFormat('HH:mm').format(entryDate)}.';
        }
        if (releaseDate != null) {
          body +=
              '\nזמן הבדלה: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'זמן להדלקת נרות החג',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'בעוד ${beforeShabatAndHolidaysCandlesHours != 0 ? '$beforeShabatAndHolidaysCandlesHours שעות ו-' : ''}$beforeShabatAndHolidaysCandlesMinutes דקות יכנס החג, לא לשכוח להדליק נרות.',
      'chnukahCandlesBody' : (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'בעוד ${beforeShabatAndHolidaysCandlesHours != 0 ? '$beforeShabatAndHolidaysCandlesHours שעות ו-' : ''}$beforeShabatAndHolidaysCandlesMinutes דקות זמן להדלקת נרות חנוכה, לא לשכוח להדליק נרות.',
    },
    'es': {
      // 'title': 'Shabat shalom',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body = 'Nos pediste que te recordáramos:\n';
        if (DateFormat('HH:mm').format(entryDate) != '00:00') {
          body +=
              'Encendido de velas en ${DateFormat('HH:mm').format(entryDate)}.';
        }
        if (releaseDate != null) {
          body +=
              '\nTiempo de Havdalá: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'Tiempo de encendido de velas navideñas',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'en ${beforeShabatAndHolidaysCandlesHours != 0 ? '$beforeShabatAndHolidaysCandlesHours horas y-' : ''}$beforeShabatAndHolidaysCandlesMinutes minutos llegarán las vacaciones, no olvides encender velas.',
      'chnukahCandlesTitle' : '', // TODO
      'chnukahCandlesBody' : '', // TODO
    },
    'ru': {
      // 'title': 'Шаббат шалом',
      'body': (DateTime entryDate, DateTime? releaseDate) {
        String body = 'Вы просили напомнить вам:\n';
        if (DateFormat('HH:mm').format(entryDate) != '00:00') {
          body +=
              'Зажигание свечи на ${DateFormat('HH:mm').format(entryDate)}.';
        }
        if (releaseDate != null) {
          body +=
              '\nВремя Хавдалы: ${DateFormat('dd/MM/yy - hh:mm').format(releaseDate)}.';
        }
        return body;
      },
      'candlesTitle': 'Время зажжения праздничных свечей',
      'candlesBody': (int beforeShabatAndHolidaysCandlesHours,
              int beforeShabatAndHolidaysCandlesMinutes) =>
          'в ${beforeShabatAndHolidaysCandlesHours != 0 ? '$beforeShabatAndHolidaysCandlesHours часы а также-' : ''}$beforeShabatAndHolidaysCandlesMinutes минуты праздник придет, не забудьте зажечь свечи.',
      'chnukahCandlesTitle' : '', // TODO
      'chnukahCandlesBody' : '', // TODO
    },
  };

  static final roshHodeshReminderTranslated = {
    'en': {
      // 'title': 'English',
      'body': (DateTime entryDate, String title) =>
          'On the date ${DateFormat('dd/MM/yy').format(entryDate)} - $title',
    },
    'he': {
      // 'title': 'עברית',
      'body': (DateTime entryDate, String title) =>
          'בתאריך ${DateFormat('dd/MM/yy').format(entryDate)} - $title',
    },
    'es': {
      // 'title': 'español',
      'body': (DateTime entryDate, String title) =>
          'En la cita ${DateFormat('dd/MM/yy').format(entryDate)} - $title',
    },
    'ru': {
      // 'title': 'ру́сский язы́к',
      'body': (DateTime entryDate, String title) =>
          'В день ${DateFormat('dd/MM/yy').format(entryDate)} - $title',
    },
  };

  static final tefilinReminderTranslated = {
    'en': {
      'title': 'Phylacteries',
      'body': 'Time to lay down phylacteries!',
      'roshHodeshTitle': 'Phylacteries + Rosh Chodesh',
      'roshHodeshBody':
          'Time to lay down phylacteries!\nDon\'t forget, today is Rosh Chodesh.',
    },
    'he': {
      'title': 'תפילין',
      'body': 'הגיע הזמן להניח תפילין!',
      'roshHodeshTitle': 'תפילין + ראש חודש',
      'roshHodeshBody': 'הגיע הזמן להניח תפילין!\nלא לשכוח, היום ראש חודש.',
    },
    'es': {
      'title': 'filacterias',
      'body': '¡Es hora de establecer filacterias!',
      'roshHodeshTitle': 'filacterias + Rosh Jodesh',
      'roshHodeshBody':
          '¡Es hora de establecer filacterias!\nNo lo olvides, hoy es Rosh Jodesh.',
    },
    'ru': {
      'title': 'филактерии',
      'body': 'Время сложить филактерии!',
      'roshHodeshTitle': 'филактерии + Рош Ходеш',
      'roshHodeshBody':
          'Время сложить филактерии!\nНе забывайте, что сегодня Рош Ходеш.',
    },
  };
}
