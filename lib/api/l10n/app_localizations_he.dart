// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get language => 'עברית';

  @override
  String get main => 'ראשי';

  @override
  String get menu => 'תפריט';

  @override
  String get settings => 'הגדרות';

  @override
  String get prayersAndBlessings => 'תפילות וברכות';

  @override
  String get aids => 'עזרים';

  @override
  String get settingRemindersMenu => 'קביעת תזכורות';

  @override
  String get candleLightingOrderMenu => 'סדר הדלקת נרות שבת';

  @override
  String get hanukkahCandleLightingOrderMenu => 'סדר הדלקת נרות חנוכה';

  @override
  String get sederSfiratOmer => 'ברכת ספירת העומר';

  @override
  String get tefilinOrderMenu => 'סדר הנחת תפילין';

  @override
  String get noTefilin => 'ביום זה אין להניח תפילין';

  @override
  String get aboutMenu => 'אודות';

  @override
  String get choresBeforeShabbatMenu => 'מטלות לפני שבת';

  @override
  String get havdalah => 'הבדלה';

  @override
  String get ashkenazVirsion => 'נוסח אשכנז';

  @override
  String get mizrahVirsion => 'נוסח מזרח';

  @override
  String get sfaradVirsion => 'נוסח ספרד';

  @override
  String get nextWeekEvants => 'אירועי השבוע הקרוב';

  @override
  String get weekEvents => 'אירועי השבוע';

  @override
  String get todayTimes => 'זמני היום';

  @override
  String get shabat => 'שבת';

  @override
  String get loading => 'טוען...';

  @override
  String get onlyShabat => 'הצג רק שבת';

  @override
  String get viewAllEvents => 'הצג את כל האירועים';

  @override
  String get viewForeignDates => 'הצג תאריכים לועזיים';

  @override
  String get viewHebrewDates => 'הצג תאריכים עבריים';

  @override
  String get noLaterTimesToShow => 'אין זמנים מעכשיו והלאה להצגה עבור תאריך זה';

  @override
  String get fromNowOn => 'מעכשיו והלאה';

  @override
  String get currentDate => 'תאריך נוכחי';

  @override
  String get entryAndLightingCandles => 'כניסה והדלקת נרות';

  @override
  String get departureAndHavdalah => 'יציאה והבדלה';

  @override
  String get startDate => 'תאריך התחלה';

  @override
  String get endDate => 'תאריך סיום';

  @override
  String get eventStartDate => 'תאריך תחילת האירוע';

  @override
  String get eventEndDate => 'תאריך סיום האירוע';

  @override
  String get eventDay => 'תאריך האירוע';

  @override
  String get parasha => 'פרשת שבוע';

  @override
  String get monday => 'שני';

  @override
  String get tuesday => 'שלישי';

  @override
  String get wednesday => 'רביעי';

  @override
  String get thursday => 'חמישי';

  @override
  String get friday => 'שישי';

  @override
  String get saturday => 'שבת';

  @override
  String get sunday => 'ראשון';

  @override
  String get today => 'היום';

  @override
  String get yesterday => 'אתמול';

  @override
  String get tomorrow => 'מחר';

  @override
  String inXDays(String days) {
    return 'בעוד $days ימים';
  }

  @override
  String xDaysAgo(String days) {
    return 'לפני $days ימים';
  }

  @override
  String get noIntrnetMessage =>
      'מצטערים, נראה כי אין חיבור לאינטרנט, בבקשה התחבר לאינטרנט ולחץ על כפתור רענון.';

  @override
  String get apiErrorMessage =>
      'מצטערים, אירעה שגיאה בטעינת הנתונים. אנא נסה שוב.';

  @override
  String get retry => 'נסה שוב';

  @override
  String get beforeShabatAndHolidaysSettengs => 'לפני שבתות וחגים';

  @override
  String get city => 'עיר';

  @override
  String get minutes => 'דקות';

  @override
  String get hours => 'שעות';

  @override
  String remindMeXhoursAndYMinutesBeforeShbatAndHolidays(
    String hours,
    String minutes,
  ) {
    return 'הזכר לי $hours שעות ו- $minutes דקות לפני שבת או חג';
  }

  @override
  String remindMeXhoursAndYMinutesBeforeNerotHanukkah(
    String hours,
    String minutes,
  ) {
    return 'הזכר לי $hours שעות ו- $minutes דקות לפני הדלקת נרות חנוכה';
  }

  @override
  String get whatToRemindSettings => 'מה תרצה שנזכיר לך ?';

  @override
  String get plata => 'פלטה';

  @override
  String get plataAction => 'לחבר פלטה';

  @override
  String get miham => 'מיחם';

  @override
  String get mihamAction => 'לחבר מיחם';

  @override
  String get shabbatClock => 'שעון שבת';

  @override
  String get shabbatClockAction => 'להפעיל שעון שבת';

  @override
  String get candleLighting => 'הדלקת נרות';

  @override
  String get hanukkahCandleLighting => 'הדלקת נרות חנוכה';

  @override
  String get candleLightingAction => 'להדליק נרות';

  @override
  String get airConditioner => 'מזגן';

  @override
  String get airConditionerAction => 'להדליק מזגן';

  @override
  String get phone => 'פלאפון';

  @override
  String get phoneAction => 'לכבות את הפלאפון';

  @override
  String get remindCandleLightningSeperateSettings =>
      'הזכר לי בנפרד להדליק נרות';

  @override
  String remindMeXhoursAndYMinutesBeforeCandlesLighning(
    String hours,
    String minutes,
  ) {
    return 'הזכר לי להדליק נרות $hours שעות ו- $minutes דקות לפני שבת או חג';
  }

  @override
  String remindMeXhoursAndYMinutesAfterShabatForHavdalah(
    String hours,
    String minutes,
  ) {
    return 'הזכר לי להדליק נרות $hours שעות ו- $minutes דקות אחרי שבת או חג להבדלה';
  }

  @override
  String get tefillin => 'תפילין';

  @override
  String get remindTeffilinSettingsAt => 'הזכר לי להניח תפילין כל יום בשעה';

  @override
  String get roshHodesh => 'ראש חודש';

  @override
  String get remindRoshHodeshSettingsAt => 'הזכר לי יום לפני ראש חודש בשעה';

  @override
  String get roshHodeshReminderWillBeAdvanced =>
      'תזכורת זו תוקדם לימי חול עד השעה שתיים בצהריים בשישי';

  @override
  String get sfiratOmer => 'ספירת העומר';

  @override
  String get remindSfiratOmerSettingsAt => 'הזכר לי לספור בעומר בשעה';

  @override
  String get updateRemindersTitle => 'עדכן תזכורות';

  @override
  String get all => 'הכל';

  @override
  String get my => 'שלי';

  @override
  String get noChroesMessage =>
      'אין מטלות אותן ביקשת שנזכיר לך, ניתן לשנות זאת בעמוד קביעת תזכורות.';

  @override
  String get compass => 'מצפן';

  @override
  String get darkMode => 'מצב לילה';

  @override
  String get lightMode => 'מצב יום';

  @override
  String get systemMode => 'לפי המערכת';

  @override
  String get birkatHamazonMenu => 'ברכת המזון';

  @override
  String get kriyatShemaAlHamitaMenu => 'קריאת שמע על המיטה';

  @override
  String get addCustomTask => 'הוסף מטלה';

  @override
  String get taskName => 'שם המטלה';

  @override
  String get add => 'הוסף';

  @override
  String get cancel => 'ביטול';

  @override
  String get delete => 'מחק';

  @override
  String get customTasksSection => 'המטלות שלי';

  @override
  String get deleteTaskTitle => 'למחוק את המטלה?';

  @override
  String get useMyLocation => 'השתמש במיקום שלי';

  @override
  String get locationNotAvailable =>
      'לא ניתן לזהות מיקום. אנא בדוק את הרשאות המיקום.';

  @override
  String get detectingLocation => 'מזהה מיקום...';

  @override
  String get dafYomiMenu => 'דף יומי';

  @override
  String get holidayCalendarMenu => 'לוח חגים יהודי';

  @override
  String get todaysDaf => 'הדף היומי';

  @override
  String get noHolidaysFound => 'לא נמצאו חגים.';

  @override
  String get compassNotSupported => 'המצפן אינו נתמך במכשיר זה';

  @override
  String get enableCompass => 'הפעל מצפן';

  @override
  String get search => 'חיפוש...';

  @override
  String get noSearchResults => 'לא נמצאו תוצאות';

  @override
  String get selectDateRange => 'בחר טווח תאריכים';

  @override
  String get dateRangeFrom => 'מ-';

  @override
  String get dateRangeTo => 'עד';

  @override
  String get listView => 'רשימה';

  @override
  String get monthlyView => 'לוח חודשי';

  @override
  String get torahReading => 'קריאת התורה';

  @override
  String get haftarah => 'הפטרה';

  @override
  String get mevarchimShabat => 'שבת מברכים';

  @override
  String blessingMonth(String months) => 'מברכים: $months';

  @override
  String get molad => 'מולד הלבנה';
}
