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
  String get settings => 'Ajustes';

  @override
  String get prayersAndBlessings => 'Oraciones y bendiciones';

  @override
  String get aids => 'Herramientas';

  @override
  String get settingRemindersMenu => 'Configuración de recordatorios';

  @override
  String get candleLightingOrderMenu => 'Orden de encendido de velas de Shabat';

  @override
  String get hanukkahCandleLightingOrderMenu => 'Encendido de velas de Janucá';

  @override
  String get sederSfiratOmer => 'Cuenta del Omer';

  @override
  String get tefilinOrderMenu => 'Orden de colocación de filacterias';

  @override
  String get noTefilin => 'No se ponen tefilín en este día';

  @override
  String get aboutMenu => 'Acerca de';

  @override
  String get choresBeforeShabbatMenu => 'Tareas antes de Shabat';

  @override
  String get havdalah => 'Havdalá';

  @override
  String get ashkenazVirsion => 'Versión Ashkenaz';

  @override
  String get mizrahVirsion => 'Versión Mizrají';

  @override
  String get sfaradVirsion => 'Versión Sfaradí';

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
  String get onlyShabat => 'Ver solo Shabat';

  @override
  String get viewAllEvents => 'Ver todos los eventos';

  @override
  String get viewForeignDates => 'Ver fechas del calendario civil';

  @override
  String get viewHebrewDates => 'Ver fechas hebreas';

  @override
  String get noLaterTimesToShow =>
      'No hay horas posteriores para mostrar esta fecha.';

  @override
  String get fromNowOn => 'De aquí en adelante';

  @override
  String get currentDate => 'Fecha actual';

  @override
  String get entryAndLightingCandles => 'Entrada y encendido de velas';

  @override
  String get departureAndHavdalah => 'Salida y Havdalá';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get endDate => 'Fecha final';

  @override
  String get eventStartDate => 'Fecha de inicio del evento';

  @override
  String get eventEndDate => 'Fecha de finalización del evento';

  @override
  String get eventDay => 'Día del evento';

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
  String get today => 'Hoy';

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
    return 'Hace $days días';
  }

  @override
  String get noIntrnetMessage =>
      'Lo sentimos, parece que no hay conexión a Internet. Por favor conéctese y presione el botón de actualizar.';

  @override
  String get apiErrorMessage =>
      'Lo sentimos, ocurrió un error al cargar los datos. Por favor intente de nuevo.';

  @override
  String get retry => 'Reintentar';

  @override
  String get beforeShabatAndHolidaysSettengs => 'Antes del Shabat y festivos';

  @override
  String get city => 'Ciudad';

  @override
  String get minutes => 'minutos';

  @override
  String get hours => 'horas';

  @override
  String remindMeXhoursAndYMinutesBeforeShbatAndHolidays(
    String hours,
    String minutes,
  ) {
    return 'Recordarme $hours horas y $minutes minutos antes del Shabat o festivo';
  }

  @override
  String remindMeXhoursAndYMinutesBeforeNerotHanukkah(
    String hours,
    String minutes,
  ) {
    return 'Recordarme $hours horas y $minutes minutos antes del encendido de velas de Janucá';
  }

  @override
  String get whatToRemindSettings => '¿Qué te gustaría que te recordáramos?';

  @override
  String get plata => 'Blech de Shabat';

  @override
  String get plataAction => 'Conectar Blech de Shabat';

  @override
  String get miham => 'Samovar';

  @override
  String get mihamAction => 'Conectar samovar';

  @override
  String get shabbatClock => 'Reloj de Shabat';

  @override
  String get shabbatClockAction => 'Encender el reloj de Shabat';

  @override
  String get candleLighting => 'Encendido de velas';

  @override
  String get hanukkahCandleLighting => 'Encendido de velas de Janucá';

  @override
  String get candleLightingAction => 'Encender las velas';

  @override
  String get airConditioner => 'Aire acondicionado';

  @override
  String get airConditionerAction => 'Encender el aire acondicionado';

  @override
  String get phone => 'Teléfono celular';

  @override
  String get phoneAction => 'Apagar el teléfono celular';

  @override
  String get remindCandleLightningSeperateSettings =>
      'Recordarme encender las velas por separado';

  @override
  String remindMeXhoursAndYMinutesBeforeCandlesLighning(
    String hours,
    String minutes,
  ) {
    return 'Recordarme encender las velas $hours horas y $minutes minutos antes del Shabat o festivo';
  }

  @override
  String remindMeXhoursAndYMinutesAfterShabatForHavdalah(
    String hours,
    String minutes,
  ) {
    return 'Recordarme hacer Havdalá $hours horas y $minutes minutos después del Shabat o festivo';
  }

  @override
  String get tefillin => 'Tefilín';

  @override
  String get remindTeffilinSettingsAt =>
      'Recordarme poner tefilín todos los días a las';

  @override
  String get roshHodesh => 'Rosh Jodesh';

  @override
  String get remindRoshHodeshSettingsAt =>
      'Recordarme el día antes de Rosh Jodesh a las';

  @override
  String get roshHodeshReminderWillBeAdvanced =>
      'Este recordatorio se adelantará a los días laborables antes de las dos de la tarde del viernes.';

  @override
  String get sfiratOmer => 'Cuenta del Omer';

  @override
  String get remindSfiratOmerSettingsAt => 'Recordarme contar el Omer a las';

  @override
  String get updateRemindersTitle => 'Actualizar recordatorios';

  @override
  String get all => 'Todos';

  @override
  String get my => 'Mis';

  @override
  String get noChroesMessage =>
      'No hay tareas que nos haya pedido que le recordemos. Puede cambiarlo en la página de configuración de recordatorios.';

  @override
  String get compass => 'Brújula';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get systemMode => 'Sistema';

  @override
  String get birkatHamazonMenu => 'Birkat Hamazón';

  @override
  String get kriyatShemaAlHamitaMenu => 'Shemá antes de dormir';

  @override
  String get addCustomTask => 'Agregar tarea';

  @override
  String get taskName => 'Nombre de la tarea';

  @override
  String get add => 'Agregar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get customTasksSection => 'Mis tareas personales';

  @override
  String get deleteTaskTitle => '¿Eliminar tarea?';

  @override
  String get useMyLocation => 'Usar mi ubicación';

  @override
  String get locationNotAvailable =>
      'No se pudo detectar la ubicación. Verifica los permisos de ubicación.';

  @override
  String get detectingLocation => 'Detectando ubicación...';

  @override
  String get dafYomiMenu => 'Daf Yomi';

  @override
  String get holidayCalendarMenu => 'Calendario de Fiestas Judías';

  @override
  String get todaysDaf => 'El Daf de Hoy';

  @override
  String get noHolidaysFound => 'No se encontraron fiestas.';

  @override
  String get compassNotSupported =>
      'La brújula no es compatible con este dispositivo';

  @override
  String get enableCompass => 'Activar brújula';

  @override
  String get search => 'Buscar...';

  @override
  String get noSearchResults => 'No se encontraron resultados';

  @override
  String get zmanimDisplayModeTooltip => 'Opciones de visualización';

  @override
  String get zmanimDisplayMultiExpand => 'Contraído (expandir varios)';

  @override
  String get zmanimDisplaySingleExpand => 'Contraído (uno a la vez)';

  @override
  String get zmanimDisplayExpandedByDefault => 'Expandido';

  @override
  String get selectDateRange => 'Seleccionar rango de fechas';

  @override
  String get dateRangeFrom => 'Desde';

  @override
  String get dateRangeTo => 'Hasta';

  @override
  String get listView => 'Lista';

  @override
  String get monthlyView => 'Mensual';

  @override
  String get torahReading => 'Lectura de la Torá';

  @override
  String get haftarah => 'Haftará';

  @override
  String get mevarchimShabat => 'Shabat Mevarchim';

  @override
  String blessingMonth(String months) {
    return 'Bendición: $months';
  }

  @override
  String get molad => 'Luna Nueva (Molad)';
}
