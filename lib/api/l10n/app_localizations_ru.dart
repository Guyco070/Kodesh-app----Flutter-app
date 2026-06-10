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
  String get settings => 'Настройки';

  @override
  String get prayersAndBlessings => 'Молитвы и благословения';

  @override
  String get aids => 'Инструменты';

  @override
  String get settingRemindersMenu => 'Настройка напоминаний';

  @override
  String get candleLightingOrderMenu => 'Порядок зажжения свечей';

  @override
  String get hanukkahCandleLightingOrderMenu => 'Зажжение свечей Хануки';

  @override
  String get sederSfiratOmer => 'Счёт Омера';

  @override
  String get tefilinOrderMenu => 'Порядок закладки филактерий';

  @override
  String get noTefilin => 'В этот день тфилин не надевают';

  @override
  String get aboutMenu => 'О приложении';

  @override
  String get choresBeforeShabbatMenu => 'Дела перед Шаббатом';

  @override
  String get havdalah => 'Авдала';

  @override
  String get ashkenazVirsion => 'Ашкеназская версия';

  @override
  String get mizrahVirsion => 'Мизрахская версия';

  @override
  String get sfaradVirsion => 'Сефардская версия';

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
  String get viewAllEvents => 'Смотреть все события';

  @override
  String get viewForeignDates => 'Смотреть даты гражданского календаря';

  @override
  String get viewHebrewDates => 'Смотреть еврейские даты';

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
  String get wednesday => 'Среда';

  @override
  String get thursday => 'Четверг';

  @override
  String get friday => 'Пятница';

  @override
  String get saturday => 'Суббота';

  @override
  String get sunday => 'Воскресенье';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

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
      'Извините, произошла ошибка при загрузке данных. Пожалуйста, попробуйте ещё раз.';

  @override
  String get retry => 'Повторить';

  @override
  String get beforeShabatAndHolidaysSettengs => 'Перед Шаббатом и праздниками';

  @override
  String get city => 'Город';

  @override
  String get minutes => 'минуты';

  @override
  String get hours => 'часы';

  @override
  String remindMeXhoursAndYMinutesBeforeShbatAndHolidays(
    String hours,
    String minutes,
  ) {
    return 'Напомнить мне $hours часов и $minutes минут до Шаббата или праздника';
  }

  @override
  String remindMeXhoursAndYMinutesBeforeNerotHanukkah(
    String hours,
    String minutes,
  ) {
    return 'Напомни мне $hours часов и $minutes минут до зажжения свечей Хануки';
  }

  @override
  String get whatToRemindSettings =>
      'Что бы вы хотели, чтобы мы вам напомнили?';

  @override
  String get plata => 'Шаббат Блеч';

  @override
  String get plataAction => 'Подключить Шаббат Блеч';

  @override
  String get miham => 'Самовар';

  @override
  String get mihamAction => 'Подключить самовар';

  @override
  String get shabbatClock => 'Часы Шаббата';

  @override
  String get shabbatClockAction => 'Включить часы Шаббата';

  @override
  String get candleLighting => 'Зажжение свечей';

  @override
  String get hanukkahCandleLighting => 'Зажжение свечей Хануки';

  @override
  String get candleLightingAction => 'Зажечь свечи';

  @override
  String get airConditioner => 'Кондиционер';

  @override
  String get airConditionerAction => 'Включить кондиционер';

  @override
  String get phone => 'Мобильный телефон';

  @override
  String get phoneAction => 'Выключить мобильный телефон';

  @override
  String get remindCandleLightningSeperateSettings =>
      'Напомни мне зажечь свечи отдельно';

  @override
  String remindMeXhoursAndYMinutesBeforeCandlesLighning(
    String hours,
    String minutes,
  ) {
    return 'Напомни мне зажечь свечи $hours часа и $minutes минут до Шаббата или праздника';
  }

  @override
  String remindMeXhoursAndYMinutesAfterShabatForHavdalah(
    String hours,
    String minutes,
  ) {
    return 'Напомни мне совершить авдалу $hours часов и $minutes минут после Шаббата или праздника';
  }

  @override
  String get tefillin => 'Тфилин';

  @override
  String get remindTeffilinSettingsAt =>
      'Напомните мне возлагать тфилин каждый день в';

  @override
  String get roshHodesh => 'Рош Ходеш';

  @override
  String get remindRoshHodeshSettingsAt => 'Напомни мне за день до Рош Ходеш в';

  @override
  String get roshHodeshReminderWillBeAdvanced =>
      'Это напоминание будет перенесено на будние дни до двух часов дня пятницы.';

  @override
  String get sfiratOmer => 'Счёт Омера';

  @override
  String get remindSfiratOmerSettingsAt => 'Напомни мне считать Омер в';

  @override
  String get updateRemindersTitle => 'Обновить напоминания';

  @override
  String get all => 'Все';

  @override
  String get my => 'Мои';

  @override
  String get noChroesMessage =>
      'Нет задач, о которых вы просили напомнить, это можно изменить на странице настроек напоминаний.';

  @override
  String get compass => 'Компас';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get lightMode => 'Светлый режим';

  @override
  String get systemMode => 'Системная';

  @override
  String get birkatHamazonMenu => 'Биркат Хамазон';

  @override
  String get kriyatShemaAlHamitaMenu => 'Шма перед сном';

  @override
  String get addCustomTask => 'Добавить задачу';

  @override
  String get taskName => 'Название задачи';

  @override
  String get add => 'Добавить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get customTasksSection => 'Мои задачи';

  @override
  String get deleteTaskTitle => 'Удалить задачу?';

  @override
  String get useMyLocation => 'Использовать моё местоположение';

  @override
  String get locationNotAvailable =>
      'Не удалось определить местоположение. Проверьте разрешения.';

  @override
  String get detectingLocation => 'Определение местоположения...';

  @override
  String get dafYomiMenu => 'Daf Yomi';

  @override
  String get holidayCalendarMenu => 'Jewish Holiday Calendar';

  @override
  String get todaysDaf => "Today's Daf";

  @override
  String get noHolidaysFound => 'No holidays found.';

  @override
  String get torahReading => 'Torah Reading';

  @override
  String get haftarah => 'Haftarah';

  @override
  String get mevarchimShabat => 'Shabbat Mevarchim';

  @override
  String blessingMonth(String months) => 'Blessing: $months';

  @override
  String get molad => 'New Moon (Molad)';
}
