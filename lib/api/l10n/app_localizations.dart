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
  /// **'Ashkenaz Version'**
  String get ashkenazVirsion;

  /// mizrahVirsion
  ///
  /// In en, this message translates to:
  /// **'Mizrah Version'**
  String get mizrahVirsion;

  /// sfaradVirsion
  ///
  /// In en, this message translates to:
  /// **'Sfarad Version'**
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
  /// **'View Hebrew dates'**
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

  /// Label for the time a fast begins
  ///
  /// In en, this message translates to:
  /// **'Fast begins'**
  String get fastBegins;

  /// Label for the time a fast ends
  ///
  /// In en, this message translates to:
  /// **'Fast ends'**
  String get fastEnds;

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
  /// **'City'**
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
  /// **'This reminder will be advanced to weekdays until two o\'clock in the afternoon.'**
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

  /// systemMode
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemMode;

  /// birkatHamazonMenu
  ///
  /// In en, this message translates to:
  /// **'Birkat Hamazon'**
  String get birkatHamazonMenu;

  /// kriyatShemaAlHamitaMenu
  ///
  /// In en, this message translates to:
  /// **'Bedtime Shema'**
  String get kriyatShemaAlHamitaMenu;

  /// addCustomTask
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addCustomTask;

  /// taskName
  ///
  /// In en, this message translates to:
  /// **'Task name'**
  String get taskName;

  /// add
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// delete
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// customTasksSection
  ///
  /// In en, this message translates to:
  /// **'My custom tasks'**
  String get customTasksSection;

  /// deleteTaskTitle
  ///
  /// In en, this message translates to:
  /// **'Delete task?'**
  String get deleteTaskTitle;

  /// Tooltip for the GPS location detection button
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// Shown when location detection fails
  ///
  /// In en, this message translates to:
  /// **'Could not detect location. Please check location permissions.'**
  String get locationNotAvailable;

  /// Shown while GPS location is being detected
  ///
  /// In en, this message translates to:
  /// **'Detecting location...'**
  String get detectingLocation;

  /// dafYomiMenu
  ///
  /// In en, this message translates to:
  /// **'Daf Yomi'**
  String get dafYomiMenu;

  /// holidayCalendarMenu
  ///
  /// In en, this message translates to:
  /// **'Jewish Holiday Calendar'**
  String get holidayCalendarMenu;

  /// todaysDaf
  ///
  /// In en, this message translates to:
  /// **'Today\'s Daf'**
  String get todaysDaf;

  /// noHolidaysFound
  ///
  /// In en, this message translates to:
  /// **'No holidays found.'**
  String get noHolidaysFound;

  /// shown when device has no compass sensor
  ///
  /// In en, this message translates to:
  /// **'Compass is not supported on this device'**
  String get compassNotSupported;

  /// button to request compass/orientation permission
  ///
  /// In en, this message translates to:
  /// **'Enable Compass'**
  String get enableCompass;

  /// Search field hint text
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

  /// Shown when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noSearchResults;

  /// Tooltip for the zmanim display-mode picker button
  ///
  /// In en, this message translates to:
  /// **'Display options'**
  String get zmanimDisplayModeTooltip;

  /// Zmanim display mode: all collapsed, tap to expand, multiple can stay open
  ///
  /// In en, this message translates to:
  /// **'Collapsed (expand several)'**
  String get zmanimDisplayMultiExpand;

  /// Zmanim display mode: all collapsed, tap to expand only one at a time
  ///
  /// In en, this message translates to:
  /// **'Collapsed (one at a time)'**
  String get zmanimDisplaySingleExpand;

  /// Zmanim display mode: all descriptions expanded by default
  ///
  /// In en, this message translates to:
  /// **'Expanded'**
  String get zmanimDisplayExpandedByDefault;

  /// Date range picker title
  ///
  /// In en, this message translates to:
  /// **'Select date range'**
  String get selectDateRange;

  /// Start of date range label
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get dateRangeFrom;

  /// End of date range label
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get dateRangeTo;

  /// List view toggle label
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listView;

  /// Monthly view toggle label
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyView;

  /// Torah reading section label
  ///
  /// In en, this message translates to:
  /// **'Torah Reading'**
  String get torahReading;

  /// Haftarah section label
  ///
  /// In en, this message translates to:
  /// **'Haftarah'**
  String get haftarah;

  /// Shabbat Mevarchim label
  ///
  /// In en, this message translates to:
  /// **'Shabbat Mevarchim'**
  String get mevarchimShabat;

  /// Month blessing label
  ///
  /// In en, this message translates to:
  /// **'Blessing: {months}'**
  String blessingMonth(String months);

  /// Molad label
  ///
  /// In en, this message translates to:
  /// **'New Moon (Molad)'**
  String get molad;

  /// Button label to fire a test notification immediately
  ///
  /// In en, this message translates to:
  /// **'Send test notification'**
  String get sendTestNotification;

  /// Title of the test notification
  ///
  /// In en, this message translates to:
  /// **'Test notification'**
  String get testNotificationTitle;

  /// Body of the test notification
  ///
  /// In en, this message translates to:
  /// **'Notifications are working correctly!'**
  String get testNotificationBody;

  /// Snackbar message after sending a test notification
  ///
  /// In en, this message translates to:
  /// **'Test notification sent'**
  String get testNotificationSent;

  /// Banner shown on the reminders screen when running on the web, where local notifications are not supported
  ///
  /// In en, this message translates to:
  /// **'Reminders aren\'t available in the browser. Open the app on your phone to receive notifications.'**
  String get notificationsNotAvailableOnWeb;

  /// Bottom navigation tab: main screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom navigation tab: halachic times of the day
  ///
  /// In en, this message translates to:
  /// **'Times'**
  String get navTimes;

  /// Bottom navigation tab: prayers and aids
  ///
  /// In en, this message translates to:
  /// **'Prayers'**
  String get navPrayers;

  /// Bottom navigation tab: reminder settings
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get navReminders;

  /// Screen-reader label of the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Main navigation'**
  String get mainNavigation;

  /// Home card: countdown label before candle lighting
  ///
  /// In en, this message translates to:
  /// **'Candle lighting in'**
  String get candleLightingIn;

  /// Home card: countdown label while Shabbat is in progress
  ///
  /// In en, this message translates to:
  /// **'Shabbat ends in'**
  String get shabbatEndsIn;

  /// Home card: candle lighting time label
  ///
  /// In en, this message translates to:
  /// **'Shabbat begins'**
  String get shabbatBegins;

  /// Home card: havdalah time label
  ///
  /// In en, this message translates to:
  /// **'Shabbat ends'**
  String get shabbatEnds;

  /// Home card: unit caption under the hh:mm countdown
  ///
  /// In en, this message translates to:
  /// **'hours : minutes'**
  String get hoursColonMinutes;

  /// Home screen greeting
  ///
  /// In en, this message translates to:
  /// **'Shabbat Shalom'**
  String get shabbatShalom;

  /// Prayers screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Prayer book'**
  String get prayerBook;

  /// Screen-reader label of the nusach (prayer version) selector
  ///
  /// In en, this message translates to:
  /// **'Prayer version'**
  String get prayerVersion;

  /// Screen-reader text of the home countdown ring
  ///
  /// In en, this message translates to:
  /// **'{label} {hours} hours and {minutes} minutes'**
  String countdownSemantics(String label, int hours, int minutes);

  /// Tooltip of the button that moves the selected start date one day back
  ///
  /// In en, this message translates to:
  /// **'Previous day'**
  String get previousDay;

  /// Tooltip of the button that moves the selected start date one day forward
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get nextDay;

  /// Screen-reader label of the start date button on the main screen
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get chooseDate;

  /// Screen-reader label of the city button on the main screen
  ///
  /// In en, this message translates to:
  /// **'Choose city'**
  String get chooseCity;

  /// Tooltip of the button that resets the start date to today
  ///
  /// In en, this message translates to:
  /// **'Back to today'**
  String get backToToday;

  /// Tooltip of the button that enlarges prayer text
  ///
  /// In en, this message translates to:
  /// **'Larger text'**
  String get increaseTextSize;

  /// Tooltip of the button that shrinks prayer text
  ///
  /// In en, this message translates to:
  /// **'Smaller text'**
  String get decreaseTextSize;

  /// Tooltip of the button that resets prayer text size
  ///
  /// In en, this message translates to:
  /// **'Default text size'**
  String get resetTextSize;

  /// Brand tagline under the KODESH wordmark; kept in Latin letters in every language
  ///
  /// In en, this message translates to:
  /// **'SHABBAT · ZMANIM · TEFILOT'**
  String get splashTagline;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading Shabbat times'**
  String get splashLoading;

  /// No description provided for @kodeshEmblemLabel.
  ///
  /// In en, this message translates to:
  /// **'Kodesh logo'**
  String get kodeshEmblemLabel;

  /// No description provided for @prayersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer book'**
  String get prayersSubtitle;

  /// No description provided for @remindersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Local notifications'**
  String get remindersSubtitle;

  /// Home screen title on Friday and Shabbat
  ///
  /// In en, this message translates to:
  /// **'Shabbat Shalom'**
  String get greetingShabbat;

  /// Home screen title Sunday to Thursday
  ///
  /// In en, this message translates to:
  /// **'Shavua Tov'**
  String get greetingWeek;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// No description provided for @sunsetToday.
  ///
  /// In en, this message translates to:
  /// **'Sunset today'**
  String get sunsetToday;

  /// No description provided for @nextRoshChodesh.
  ///
  /// In en, this message translates to:
  /// **'Rosh Chodesh'**
  String get nextRoshChodesh;

  /// No description provided for @todayWord.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayWord;

  /// No description provided for @tomorrowWord.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrowWord;

  /// How many days until an event
  ///
  /// In en, this message translates to:
  /// **'In {count} days'**
  String inDaysCount(int count);

  /// No description provided for @openReminders.
  ///
  /// In en, this message translates to:
  /// **'Open reminders'**
  String get openReminders;

  /// No description provided for @remindersActive.
  ///
  /// In en, this message translates to:
  /// **'Active reminders'**
  String get remindersActive;

  /// No description provided for @remindersActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} on'**
  String remindersActiveCount(int count, int total);

  /// No description provided for @omerTonight.
  ///
  /// In en, this message translates to:
  /// **'Tonight we count'**
  String get omerTonight;

  /// No description provided for @omerDaysOfCounting.
  ///
  /// In en, this message translates to:
  /// **'49 days of counting'**
  String get omerDaysOfCounting;

  /// No description provided for @omerNotNow.
  ///
  /// In en, this message translates to:
  /// **'The Omer is counted between Passover and Shavuot.'**
  String get omerNotNow;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @compassNorth.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get compassNorth;

  /// No description provided for @compassSouth.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get compassSouth;

  /// No description provided for @compassEast.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get compassEast;

  /// No description provided for @compassWest.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get compassWest;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Reminder subtitle; time is hours:minutes
  ///
  /// In en, this message translates to:
  /// **'{time} before it begins'**
  String reminderBeforeEntry(String time);

  /// No description provided for @reminderAtTime.
  ///
  /// In en, this message translates to:
  /// **'At {time}'**
  String reminderAtTime(String time);

  /// Settings switch: reminders play a sound
  ///
  /// In en, this message translates to:
  /// **'Notification sound'**
  String get notificationSound;

  /// Subtitle of the notification sound switch
  ///
  /// In en, this message translates to:
  /// **'Play a sound with reminders'**
  String get notificationSoundSubtitle;

  /// Settings section title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// deleteTask
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get deleteTask;

  /// clearSearch
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// accessibilityMenu
  ///
  /// In en, this message translates to:
  /// **'Accessibility statement'**
  String get accessibilityMenu;

  /// privacyMenu
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyMenu;

  /// compassMobileOnly
  ///
  /// In en, this message translates to:
  /// **'The compass needs a phone or tablet with a direction sensor.'**
  String get compassMobileOnly;

  /// openInSefaria
  ///
  /// In en, this message translates to:
  /// **'Learn on Sefaria'**
  String get openInSefaria;

  /// Browser tab title on web
  ///
  /// In en, this message translates to:
  /// **'Kodesh – Shabbat, holiday and daily times'**
  String get siteTitle;
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
