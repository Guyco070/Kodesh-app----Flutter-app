// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'español';

  @override
  String get main => 'Principal';

  @override
  String get menu => 'Menú';

  @override
  String get settings => 'Settings';

  @override
  String get prayersAndBlessings => 'Prayers and Blessings';

  @override
  String get aids => 'Aids';

  @override
  String get settingRemindersMenu => 'Configuración de recordatorios';

  @override
  String get candleLightingOrderMenu => 'Orden de encendido de velas';

  @override
  String get hanukkahCandleLightingOrderMenu => 'Hanukkah candle lighting';

  @override
  String get sederSfiratOmer => 'Counting of the Omer';

  @override
  String get tefilinOrderMenu => 'Orden de colocación de filacterias';

  @override
  String get noTefilin => 'Do not put on tefillin on this day';

  @override
  String get aboutMenu => 'About';

  @override
  String get choresBeforeShabbatMenu => 'Tareas antes de Shabat';

  @override
  String get havdalah => 'Havdalah';

  @override
  String get ashkenazVirsion => 'Ashkenaz Virsion';

  @override
  String get mizrahVirsion => 'Mizrah Virsion';

  @override
  String get sfaradVirsion => 'Sfarad Virsion';

  @override
  String get nextWeekEvants => 'Eventos de la próxima semana';

  @override
  String get weekEvents => 'Eventos de la semana';

  @override
  String get todayTimes => 'Tiempos de hoy';

  @override
  String get shabat => 'Shabat';

  @override
  String get loading => 'Cargando...';

  @override
  String get onlyShabat => 'Ver solo shabat';

  @override
  String get viewAllEvents => 'View all events';

  @override
  String get viewForeignDates => 'View foreign dates';

  @override
  String get viewHebrewDates => 'View hebrew dates';

  @override
  String get noLaterTimesToShow =>
      'No hay horas posteriores para mostrar esta fecha.';

  @override
  String get fromNowOn => 'De aquí en adelante';

  @override
  String get currentDate => 'Fecha actual';

  @override
  String get entryAndLightingCandles => 'Entrada y encendido de velas.';

  @override
  String get departureAndHavdalah => 'Salida y havdalá';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get endDate => 'Fecha final';

  @override
  String get eventStartDate => 'Fecha de inicio del evento';

  @override
  String get eventEndDate => 'Fecha de finalización del evento';

  @override
  String get eventDay => 'día del evento';

  @override
  String get parasha => 'Porción semanal de la Torá';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get today => 'Este Dia';

  @override
  String get yesterday => 'Ayer';

  @override
  String get tomorrow => 'Mañana';

  @override
  String inXDays(String days) {
    return 'En $days días';
  }

  @override
  String xDaysAgo(String days) {
    return 'hace $days días';
  }

  @override
  String get noIntrnetMessage =>
      'Lo sentimos, parece que no hay conexión a Internet, conéctese a Internet y presione el botón Actualizar.';

  @override
  String get apiErrorMessage =>
      'Sorry, something went wrong while loading data. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get beforeShabatAndHolidaysSettengs => 'Antes del shabat y festivos';

  @override
  String get city => 'ciudad';

  @override
  String get minutes => 'minutos';

  @override
  String get hours => 'horas';

  @override
  String remindMeXhoursAndYMinutesBeforeShbatAndHolidays(
      String hours, String minutes) {
    return 'Recordarme $hours horas y $minutes minutos antes del shabat o festivo';
  }

  @override
  String remindMeXhoursAndYMinutesBeforeNerotHanukkah(
      String hours, String minutes) {
    return 'Remind me $hours hours and $minutes minutes before lighting Hanukkah candles';
  }

  @override
  String get whatToRemindSettings => '¿Qué te gustaría que te recordáramos?';

  @override
  String get plata => 'blanqueamiento de Shabat';

  @override
  String get plataAction => 'Conectar blej de Shabat';

  @override
  String get miham => 'Samovar';

  @override
  String get mihamAction => 'conectar samovar';

  @override
  String get shabbatClock => 'reloj de shabat';

  @override
  String get shabbatClockAction => 'Enciende el reloj de Shabat';

  @override
  String get candleLighting => 'encendido de velas';

  @override
  String get hanukkahCandleLighting => 'Hanukkah candle lighting';

  @override
  String get candleLightingAction => 'luz de las velas';

  @override
  String get airConditioner => 'Aire acondicionado';

  @override
  String get airConditionerAction => 'Enciende el aire acondicionado';

  @override
  String get phone => 'cell phone';

  @override
  String get phoneAction => 'Turn off the cell phone';

  @override
  String get remindCandleLightningSeperateSettings =>
      'Recuérdame encender las velas por separado';

  @override
  String remindMeXhoursAndYMinutesBeforeCandlesLighning(
      String hours, String minutes) {
    return 'Recuérdame encender las velas $hours horas y $minutes minutos antes del shabat o festivo';
  }

  @override
  String remindMeXhoursAndYMinutesAfterShabatForHavdalah(
      String hours, String minutes) {
    return 'Remind me to light candles $hours hours and $minutes minutes after shabat or holiday for Havdalh';
  }

  @override
  String get tefillin => 'Tefilín';

  @override
  String get remindTeffilinSettingsAt =>
      'Recuérdame leer sobre tefilín todos los días a las';

  @override
  String get roshHodesh => 'Rosh Jodesh';

  @override
  String get remindRoshHodeshSettingsAt =>
      'Recuérdame el día antes de Rosh Jodesh en';

  @override
  String get roshHodeshReminderWillBeAdvanced =>
      'Este recordatorio se adelantará a los días laborables hasta las dos de la tarde.';

  @override
  String get sfiratOmer => 'Counting of the Omer';

  @override
  String get remindSfiratOmerSettingsAt => 'Remind counting of the Omer at';

  @override
  String get updateRemindersTitle => 'Actualizar recordatorios';

  @override
  String get all => 'Todos';

  @override
  String get my => 'Mi';

  @override
  String get noChroesMessage =>
      'No hay tareas que nos haya pedido que le recordemos, esto se puede cambiar en la página de configuración de recordatorios.';

  @override
  String get compass => 'Compass';
}
