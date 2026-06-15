// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get main => 'Main';

  @override
  String get menu => 'Menu';

  @override
  String get settings => 'Settings';

  @override
  String get prayersAndBlessings => 'Prayers and Blessings';

  @override
  String get aids => 'Aids';

  @override
  String get settingRemindersMenu => 'Setting reminders';

  @override
  String get candleLightingOrderMenu => 'Shabat candle lighting order';

  @override
  String get hanukkahCandleLightingOrderMenu => 'Hanukkah candle lighting';

  @override
  String get sederSfiratOmer => 'Counting of the Omer';

  @override
  String get tefilinOrderMenu => 'Laying of phylacteries';

  @override
  String get noTefilin => 'Do not put on tefillin on this day';

  @override
  String get aboutMenu => 'About';

  @override
  String get choresBeforeShabbatMenu => 'Chores before Shabbat';

  @override
  String get havdalah => 'Havdalah';

  @override
  String get ashkenazVirsion => 'Ashkenaz Virsion';

  @override
  String get mizrahVirsion => 'Mizrah Virsion';

  @override
  String get sfaradVirsion => 'Sfarad Virsion';

  @override
  String get nextWeekEvants => 'Next Week Evants';

  @override
  String get weekEvents => 'Week\'s events';

  @override
  String get todayTimes => 'Today\'s times';

  @override
  String get shabat => 'Shabat';

  @override
  String get loading => 'Loading...';

  @override
  String get onlyShabat => 'View only shabat';

  @override
  String get viewAllEvents => 'View all events';

  @override
  String get viewForeignDates => 'View foreign dates';

  @override
  String get viewHebrewDates => 'View hebrew dates';

  @override
  String get noLaterTimesToShow =>
      'There are no later times to show for this date.';

  @override
  String get fromNowOn => 'From now on';

  @override
  String get currentDate => 'Current date';

  @override
  String get entryAndLightingCandles => 'Entry and lighting candles';

  @override
  String get departureAndHavdalah => 'Departure and havdalah';

  @override
  String get startDate => 'Start date';

  @override
  String get endDate => 'End date';

  @override
  String get eventStartDate => 'Event start date';

  @override
  String get eventEndDate => 'Event end date';

  @override
  String get eventDay => 'Event day';

  @override
  String get parasha => 'Weekly Torah Portion';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String inXDays(String days) {
    return 'In $days days';
  }

  @override
  String xDaysAgo(String days) {
    return '$days days ago';
  }

  @override
  String get noIntrnetMessage =>
      'Sorry, it appears that there is no internet connection, please connect to the internet and press the refresh button.';

  @override
  String get apiErrorMessage =>
      'Sorry, something went wrong while loading data. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get beforeShabatAndHolidaysSettengs => 'Before shabat and holidays';

  @override
  String get city => 'city';

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'hours';

  @override
  String remindMeXhoursAndYMinutesBeforeShbatAndHolidays(
    String hours,
    String minutes,
  ) {
    return 'Remind me $hours hours and $minutes minutes before shabat or holiday';
  }

  @override
  String remindMeXhoursAndYMinutesBeforeNerotHanukkah(
    String hours,
    String minutes,
  ) {
    return 'Remind me $hours hours and $minutes minutes before lighting Hanukkah candles';
  }

  @override
  String get whatToRemindSettings => 'What would you like us to remind you ?';

  @override
  String get plata => 'Shabbat blech';

  @override
  String get plataAction => 'Connect Shabbat blech';

  @override
  String get miham => 'Samovar';

  @override
  String get mihamAction => 'Connect samovar';

  @override
  String get shabbatClock => 'Shabbat clock';

  @override
  String get shabbatClockAction => 'Turn on Shabbat clock';

  @override
  String get candleLighting => 'Candle lighting';

  @override
  String get hanukkahCandleLighting => 'Hanukkah candle lighting';

  @override
  String get candleLightingAction => 'light candles';

  @override
  String get airConditioner => 'Air conditioner';

  @override
  String get airConditionerAction => 'Turn on the air conditioner';

  @override
  String get phone => 'cell phone';

  @override
  String get phoneAction => 'Turn off the cell phone';

  @override
  String get remindCandleLightningSeperateSettings =>
      'Remind me to light candles separately';

  @override
  String remindMeXhoursAndYMinutesBeforeCandlesLighning(
    String hours,
    String minutes,
  ) {
    return 'Remind me to light candles $hours hours and $minutes minutes before shabat or holiday';
  }

  @override
  String remindMeXhoursAndYMinutesAfterShabatForHavdalah(
    String hours,
    String minutes,
  ) {
    return 'Remind me to light candles $hours hours and $minutes minutes after shabat or holiday for Havdalh';
  }

  @override
  String get tefillin => 'Tefillin';

  @override
  String get remindTeffilinSettingsAt =>
      'Remind me to ley on tefillin every day at';

  @override
  String get roshHodesh => 'Rosh Hodesh';

  @override
  String get remindRoshHodeshSettingsAt =>
      'Remind me the day before Rosh Chodesh at';

  @override
  String get roshHodeshReminderWillBeAdvanced =>
      'This reminder will be advanced to weekdays until two o\'clock in the afternoon';

  @override
  String get sfiratOmer => 'Counting of the Omer';

  @override
  String get remindSfiratOmerSettingsAt => 'Remind counting of the Omer at';

  @override
  String get updateRemindersTitle => 'Update reminders';

  @override
  String get all => 'All';

  @override
  String get my => 'My';

  @override
  String get noChroesMessage =>
      'There are no tasks that you asked us to remind you of, this can be changed on the setting reminders page.';

  @override
  String get compass => 'Compass';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get lightMode => 'Light mode';

  @override
  String get systemMode => 'System';

  @override
  String get birkatHamazonMenu => 'Birkat Hamazon';

  @override
  String get kriyatShemaAlHamitaMenu => 'Bedtime Shema';

  @override
  String get addCustomTask => 'Add task';

  @override
  String get taskName => 'Task name';

  @override
  String get add => 'Add';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get customTasksSection => 'My custom tasks';

  @override
  String get deleteTaskTitle => 'Delete task?';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get locationNotAvailable =>
      'Could not detect location. Please check location permissions.';

  @override
  String get detectingLocation => 'Detecting location...';

  @override
  String get dafYomiMenu => 'Daf Yomi';

  @override
  String get holidayCalendarMenu => 'Jewish Holiday Calendar';

  @override
  String get todaysDaf => "Today's Daf";

  @override
  String get noHolidaysFound => 'No holidays found.';

  @override
  String get compassNotSupported => 'Compass is not supported on this device';

  @override
  String get enableCompass => 'Enable Compass';
}
