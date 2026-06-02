// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'ру́сский язы́к';

  @override
  String get main => 'главный';

  @override
  String get menu => 'Меню';

  @override
  String get settings => 'Settings';

  @override
  String get prayersAndBlessings => 'Prayers and Blessings';

  @override
  String get aids => 'Aids';

  @override
  String get settingRemindersMenu => 'Настройка напоминаний';

  @override
  String get candleLightingOrderMenu => 'Порядок зажжения свечей';

  @override
  String get hanukkahCandleLightingOrderMenu => 'Hanukkah candle lighting';

  @override
  String get sederSfiratOmer => 'Counting of the Omer';

  @override
  String get tefilinOrderMenu => 'Порядок закладки филактерий';

  @override
  String get noTefilin => 'Do not put on tefillin on this day';

  @override
  String get aboutMenu => 'About';

  @override
  String get choresBeforeShabbatMenu => 'Дела перед Шаббатом';

  @override
  String get havdalah => 'Havdalah';

  @override
  String get ashkenazVirsion => 'Ashkenaz Virsion';

  @override
  String get mizrahVirsion => 'Mizrah Virsion';

  @override
  String get sfaradVirsion => 'Sfarad Virsion';

  @override
  String get nextWeekEvants => 'События следующей недели';

  @override
  String get weekEvents => 'События недели';

  @override
  String get todayTimes => 'Сегодняшнее время';

  @override
  String get shabat => 'Шаббат';

  @override
  String get loading => 'Загрузка...';

  @override
  String get onlyShabat => 'Смотреть только Шаббат';

  @override
  String get viewAllEvents => 'View all events';

  @override
  String get viewForeignDates => 'View foreign dates';

  @override
  String get viewHebrewDates => 'View hebrew dates';

  @override
  String get noLaterTimesToShow =>
      'Более поздние времена для этой даты отсутствуют.';

  @override
  String get fromNowOn => 'Впредь';

  @override
  String get currentDate => 'Текущая дата';

  @override
  String get entryAndLightingCandles => 'Вход и зажигание свечей';

  @override
  String get departureAndHavdalah => 'Отъезд и авдала';

  @override
  String get startDate => 'Дата начала';

  @override
  String get endDate => 'Дата окончания';

  @override
  String get eventStartDate => 'Дата начала мероприятия';

  @override
  String get eventEndDate => 'Дата окончания мероприятия';

  @override
  String get eventDay => 'День события';

  @override
  String get parasha => 'Недельная глава Торы';

  @override
  String get monday => 'Понедельник';

  @override
  String get tuesday => 'Вторник';

  @override
  String get wednesday => 'среда';

  @override
  String get thursday => 'Четверг';

  @override
  String get friday => 'пятница';

  @override
  String get saturday => 'суббота';

  @override
  String get sunday => 'Воскресенье';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчерашний день';

  @override
  String get tomorrow => 'Завтра';

  @override
  String inXDays(String days) {
    return 'Через $days дней';
  }

  @override
  String xDaysAgo(String days) {
    return '$days дней назад';
  }

  @override
  String get noIntrnetMessage =>
      'Извините, кажется, что нет подключения к Интернету. Пожалуйста, подключитесь к Интернету и нажмите кнопку обновления.';

  @override
  String get apiErrorMessage =>
      'Sorry, something went wrong while loading data. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get beforeShabatAndHolidaysSettengs => 'Перед Шаббатом и праздниками';

  @override
  String get city => 'город';

  @override
  String get minutes => 'минуты';

  @override
  String get hours => 'часы';

  @override
  String remindMeXhoursAndYMinutesBeforeShbatAndHolidays(
      String hours, String minutes) {
    return 'Напомнить мне $hours часов и $minutes минут до Шаббата или праздника';
  }

  @override
  String remindMeXhoursAndYMinutesBeforeNerotHanukkah(
      String hours, String minutes) {
    return 'Remind me $hours hours and $minutes minutes before lighting Hanukkah candles';
  }

  @override
  String get whatToRemindSettings =>
      'Что бы вы хотели, чтобы мы вам напомнили?';

  @override
  String get plata => 'Шаббат отбеливать';

  @override
  String get plataAction => 'Подключить Шаббат Блеч';

  @override
  String get miham => 'Самовар';

  @override
  String get mihamAction => 'Подключить самовар';

  @override
  String get shabbatClock => 'Шаббат часы';

  @override
  String get shabbatClockAction => 'Включите Шаббат часы';

  @override
  String get candleLighting => 'Освещение свечей';

  @override
  String get hanukkahCandleLighting => 'Hanukkah candle lighting';

  @override
  String get candleLightingAction => 'לзажечь свечи';

  @override
  String get airConditioner => 'Кондиционер';

  @override
  String get airConditionerAction => 'Включите кондиционер';

  @override
  String get phone => 'cell phone';

  @override
  String get phoneAction => 'Turn off the cell phone';

  @override
  String get remindCandleLightningSeperateSettings =>
      'Напомни мне зажечь свечи отдельно';

  @override
  String remindMeXhoursAndYMinutesBeforeCandlesLighning(
      String hours, String minutes) {
    return 'Напомни мне зажечь свечи $hours часа и $minutes минут до Шаббата или праздника';
  }

  @override
  String remindMeXhoursAndYMinutesAfterShabatForHavdalah(
      String hours, String minutes) {
    return 'Remind me to light candles $hours hours and $minutes minutes after shabat or holiday for Havdalh';
  }

  @override
  String get tefillin => 'тфилин';

  @override
  String get remindTeffilinSettingsAt =>
      'Напомните мне возлагать тфилин каждый день в';

  @override
  String get roshHodesh => 'Рош Ходеш';

  @override
  String get remindRoshHodeshSettingsAt => 'Напомни мне за день до Рош Ходеш в';

  @override
  String get roshHodeshReminderWillBeAdvanced =>
      'Это напоминание будет перенесено на будние дни до двух часов дня.';

  @override
  String get sfiratOmer => 'Counting of the Omer';

  @override
  String get remindSfiratOmerSettingsAt => 'Remind counting of the Omer at';

  @override
  String get updateRemindersTitle => 'Обновить напоминания';

  @override
  String get all => 'Все';

  @override
  String get my => 'Мой';

  @override
  String get noChroesMessage =>
      'Нет задач, о которых вы просили напомнить, это можно изменить на странице настроек напоминаний.';

  @override
  String get compass => 'Compass';
}
