import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_he.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('he'),
    Locale('ru'),
  ];

  /// English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// main
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// menu
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// prayersAndBlessings
  ///
  /// In en, this message translates to:
  /// **'Prayers and Blessings'**
  String get prayersAndBlessings;

  /// aids
  ///
  /// In en, this message translates to:
  /// **'Aids'**
  String get aids;

  /// settingRemindersMenu
  ///
  /// In en, this message translates to:
  /// **'Setting reminders'**
  String get settingRemindersMenu;

  /// candleLightingOrderMenu
  ///
  /// In en, this message translates to:
  /// **'Shabat candle lighting order'**
  String get candleLightingOrderMenu;

  /// hanukkahCandleLightingOrderMenu
  ///
  /// In en, this message translates to:
  /// **'Hanukkah candle lighting'**
  String get hanukkahCandleLightingOrderMenu;

  /// sederSfiratOmer
  ///
  /// In en, this message translates to:
  /// **'Counting of the Omer'**
  String get sederSfiratOmer;

  /// tefilinOrderMenu
  ///
  /// In en, this message translates to:
  /// **'Laying of phylacteries'**
  String get tefilinOrderMenu;

  /// noTefilin
  ///
  /// In en, this message translates to:
  /// **'Do not put on tefillin on this day'**
  String get noTefilin;

  /// aboutMenu
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutMenu;

  /// choresBeforeShabbatMenu
  ///
  /// In en, this message translates to:
  /// **'Chores before Shabbat'**
  String get choresBeforeShabbatMenu;

  /// havdalah
  ///
  /// In en, this message translates to:
  /// **'Havdalah'**
  String get havdalah;

  /// ashkenazVirsion
  ///
  /// In en, this message translates to:
  /// **'Ashkenaz Virsion'**
  String get ashkenazVirsion;

  /// mizrahVirsion
  ///
  /// In en, this message translates to:
  /// **'Mizrah Virsion'**
  String get mizrahVirsion;

  /// sfaradVirsion
  ///
  /// In en, this message translates to:
  /// **'Sfarad Virsion'**
  String get sfaradVirsion;

  /// nextWeekEvants
  ///
  /// In en, this message translates to:
  /// **'Next Week Evants'**
  String get nextWeekEvants;

  /// weekEvents
  ///
  /// In en, this message translates to:
  /// **'Week\'s events'**
  String get weekEvents;

  /// todayTimes
  ///
  /// In en, this message translates to:
  /// **'Today\'s times'**
  String get todayTimes;

  /// Shabat day
  ///
  /// In en, this message translates to:
  /// **'Shabat'**
  String get shabat;

  /// loading...
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// onlyShabat
  ///
  /// In en, this message translates to:
  /// **'View only shabat'**
  String get onlyShabat;

  /// viewAllEvents
  ///
  /// In en, this message translates to:
  /// **'View all events'**
  String get viewAllEvents;

  /// viewForeignDates
  ///
  /// In en, this message translates to:
  /// **'View foreign dates'**
  String get viewForeignDates;

  /// viewHebrewDates
  ///
  /// In en, this message translates to:
  /// **'View hebrew dates'**
  String get viewHebrewDates;

  /// noLaterTimesToShow
  ///
  /// In en, this message translates to:
  /// **'There are no later times to show for this date.'**
  String get noLaterTimesToShow;

  /// fromNowOn
  ///
  /// In en, this message translates to:
  /// **'From now on'**
  String get fromNowOn;

  /// currentDate
  ///
  /// In en, this message translates to:
  /// **'Current date'**
  String get currentDate;

  /// No description provided for @entryAndLightingCandles.
  ///
  /// In en, this message translates to:
  /// **'Entry and lighting candles'**
  String get entryAndLightingCandles;

  /// departureAndHavdalah
  ///
  /// In en, this message translates to:
  /// **'Departure and havdalah'**
  String get departureAndHavdalah;

  /// startDate
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// endDate
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get endDate;

  /// eventStartDate
  ///
  /// In en, this message translates to:
  /// **'Event start date'**
  String get eventStartDate;

  /// eventEndDate
  ///
  /// In en, this message translates to:
  /// **'Event end date'**
  String get eventEndDate;

  /// eventDay
  ///
  /// In en, this message translates to:
  /// **'Event day'**
  String get eventDay;

  /// parasha
  ///
  /// In en, this message translates to:
  /// **'Weekly Torah Portion'**
  String get parasha;

  /// monday
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// tuesday
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// wednesday
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// thursday
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// friday
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// saturday
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// sunday
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// yesterday
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// tomorrow
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// inXDays
  ///
  /// In en, this message translates to:
  /// **'In {days} days'**
  String inXDays(String days);

  /// inXDays
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String xDaysAgo(String days);

  /// noIntrnetMessage
  ///
  /// In en, this message translates to:
  /// **'Sorry, it appears that there is no internet connection, please connect to the internet and press the refresh button.'**
  String get noIntrnetMessage;

  /// apiErrorMessage
  ///
  /// In en, this message translates to:
  /// **'Sorry, something went wrong while loading data. Please try again.'**
  String get apiErrorMessage;

  /// retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// beforeShabatAndHolidaysSettengs
  ///
  /// In en, this message translates to:
  /// **'Before shabat and holidays'**
  String get beforeShabatAndHolidaysSettengs;

  /// city
  ///
  /// In en, this message translates to:
  /// **'city'**
  String get city;

  /// minutes
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// hours
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// inXDays
  ///
  /// In en, this message translates to:
  /// **'Remind me {hours} hours and {minutes} minutes before shabat or holiday'**
  String remindMeXhoursAndYMinutesBeforeShbatAndHolidays(
    String hours,
    String minutes,
  );

  /// inXDays
  ///
  /// In en, this message translates to:
  /// **'Remind me {hours} hours and {minutes} minutes before lighting Hanukkah candles'**
  String remindMeXhoursAndYMinutesBeforeNerotHanukkah(
    String hours,
    String minutes,
  );

  /// whatToRemindSettings
  ///
  /// In en, this message translates to:
  /// **'What would you like us to remind you ?'**
  String get whatToRemindSettings;

  /// plata
  ///
  /// In en, this message translates to:
  /// **'Shabbat blech'**
  String get plata;

  /// plataAction
  ///
  /// In en, this message translates to:
  /// **'Connect Shabbat blech'**
  String get plataAction;

  ///  miham
  ///
  /// In en, this message translates to:
  /// **'Samovar'**
  String get miham;

  ///  mihamAction
  ///
  /// In en, this message translates to:
  /// **'Connect samovar'**
  String get mihamAction;

  /// shabbatClock
  ///
  /// In en, this message translates to:
  /// **'Shabbat clock'**
  String get shabbatClock;

  ///  shabbatClockAction
  ///
  /// In en, this message translates to:
  /// **'Turn on Shabbat clock'**
  String get shabbatClockAction;

  /// candleLighting
  ///
  /// In en, this message translates to:
  /// **'Candle lighting'**
  String get candleLighting;

  /// hanukkahCandleLighting
  ///
  /// In en, this message translates to:
  /// **'Hanukkah candle lighting'**
  String get hanukkahCandleLighting;

  ///  candleLightingAction
  ///
  /// In en, this message translates to:
  /// **'light candles'**
  String get candleLightingAction;

  /// airConditioner
  ///
  /// In en, this message translates to:
  /// **'Air conditioner'**
  String get airConditioner;

  ///  airConditionerAction
  ///
  /// In en, this message translates to:
  /// **'Turn on the air conditioner'**
  String get airConditionerAction;

  /// phone
  ///
  /// In en, this message translates to:
  /// **'cell phone'**
  String get phone;

  /// phoneAction
  ///
  /// In en, this message translates to:
  /// **'Turn off the cell phone'**
  String get phoneAction;

  /// remindCandleLightningSeperateSettings
  ///
  /// In en, this message translates to:
  /// **'Remind me to light candles separately'**
  String get remindCandleLightningSeperateSettings;

  /// inXDays
  ///
  /// In en, this message translates to:
  /// **'Remind me to light candles {hours} hours and {minutes} minutes before shabat or holiday'**
  String remindMeXhoursAndYMinutesBeforeCandlesLighning(
    String hours,
    String minutes,
  );

  /// inXDays
  ///
  /// In en, this message translates to:
  /// **'Remind me to light candles {hours} hours and {minutes} minutes after shabat or holiday for Havdalh'**
  String remindMeXhoursAndYMinutesAfterShabatForHavdalah(
    String hours,
    String minutes,
  );

  /// tefillin
  ///
  /// In en, this message translates to:
  /// **'Tefillin'**
  String get tefillin;

  /// remindTeffilinSettingsAt
  ///
  /// In en, this message translates to:
  /// **'Remind me to ley on tefillin every day at'**
  String get remindTeffilinSettingsAt;

  /// roshHodesh
  ///
  /// In en, this message translates to:
  /// **'Rosh Hodesh'**
  String get roshHodesh;

  /// remindRoshHodeshSettingsAt
  ///
  /// In en, this message translates to:
  /// **'Remind me the day before Rosh Chodesh at'**
  String get remindRoshHodeshSettingsAt;

  /// roshHodeshReminderWillBeAdvanced
  ///
  /// In en, this message translates to:
  /// **'This reminder will be advanced to weekdays until two o\'clock in the afternoon'**
  String get roshHodeshReminderWillBeAdvanced;

  /// sfiratOmer
  ///
  /// In en, this message translates to:
  /// **'Counting of the Omer'**
  String get sfiratOmer;

  /// remindSfiratOmerSettingsAt
  ///
  /// In en, this message translates to:
  /// **'Remind counting of the Omer at'**
  String get remindSfiratOmerSettingsAt;

  /// updateRemindersTitle
  ///
  /// In en, this message translates to:
  /// **'Update reminders'**
  String get updateRemindersTitle;

  /// all
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// my
  ///
  /// In en, this message translates to:
  /// **'My'**
  String get my;

  /// noChroesMessage
  ///
  /// In en, this message translates to:
  /// **'There are no tasks that you asked us to remind you of, this can be changed on the setting reminders page.'**
  String get noChroesMessage;

  /// compass
  ///
  /// In en, this message translates to:
  /// **'Compass'**
  String get compass;

  /// darkMode
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// lightMode
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  String get systemMode;

  String get birkatHamazonMenu;
  String get kriyatShemaAlHamitaMenu;
  String get addCustomTask;
  String get taskName;
  String get add;
  String get cancel;
  String get delete;
  String get customTasksSection;
  String get deleteTaskTitle;

  /// useMyLocation
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// locationNotAvailable
  ///
  /// In en, this message translates to:
  /// **'Could not detect location. Please check location permissions.'**
  String get locationNotAvailable;

  /// detectingLocation
  ///
  /// In en, this message translates to:
  /// **'Detecting location...'**
  String get detectingLocation;

  String get dafYomiMenu;
  String get holidayCalendarMenu;
  String get todaysDaf;
  String get noHolidaysFound;

  String get torahReading;
  String get haftarah;
  String get mevarchimShabat;
  String blessingMonth(String months);
  String get molad;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'he', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'he':
      return AppLocalizationsHe();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
