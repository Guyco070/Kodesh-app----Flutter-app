# אפליקציית קודש - מדריך ארכיטקטורה
**תאריך:** 27 בדצמבר 2025

## מבוא

מסמך זה מסביר את הארכיטקטורה של אפליקציית קודש באופן שיעזור למפתחים חדשים בבסיס הקוד להבין כיצד האפליקציה מובנית וכיצד רכיבים שונים עובדים יחד.

## ארכיטקטורה ברמה גבוהה

קודש עוקבת אחר תבנית **ארכיטקטורת שכבות** עם הפרדת דאגות ברורה:

```
┌─────────────────────────────────────────┐
│         שכבת מצגת                       │
│    (מסכים, Widgets, אנימציות)          │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│       שכבת ניהול מצב                    │
│         (תבנית Provider)                │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│          לוגיקה עסקית                   │
│      (Models, Helpers, APIs)            │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│       שירותים חיצוניים                  │
│  (Hebcal API, התראות מקומיות,           │
│   SharedPreferences, חיישני מכשיר)      │
└─────────────────────────────────────────┘
```

## תבנית ארכיטקטורה: ניהול מצב Provider

האפליקציה משתמשת בתבנית **Provider** לניהול מצב, שהיא אחת מהגישות המומלצות של Flutter לניהול מצב אפליקציה.

### איך Provider עובד בקודש

האפליקציה עוטפת את כל עץ ה-widgets עם `MultiProvider` ב-[main.dart:53-59](lib/main.dart#L53-L59):

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => events),
    ChangeNotifierProvider(create: (context) => reminders),
    ChangeNotifierProvider(create: (context) => lang),
    ChangeNotifierProvider(create: (context) => Tfilot()),
  ],
  child: MaterialApp(...)
)
```

זה הופך ארבעה providers עיקריים לזמינים בכל האפליקציה:
1. **Events** - מנהל שבתות, חגים וזמנים יומיים (זמנים)
2. **Reminders** - מנהל הגדרות התראות ותזמון
3. **LanguageChangeProvider** - מטפל בלוקליזציה של האפליקציה
4. **Tfilot** - מנהל נתונים הקשורים לתפילה

### מחלקות Provider מרכזיות

#### 1. Events Provider ([lib/providers/events.dart](lib/providers/events.dart))

זהו הלב של האפליקציה. הוא מנהל:

- **נתוני אירועים**: רשימת אירועים יהודיים (שבת, חגים, ראש חודש, ספירת העומר)
- **נתוני זמנים**: זמנים הלכתיים יומיים (זריחה, שקיעה, זמני תפילה)
- **העדפות משתמש**: עיר נבחרת, מסנני תאריך, העדפות תצוגה
- **תקשורת API**: שולף נתונים מ-APIs של Hebcal
- **המרת תאריך עברי**: ממיר מתאריך גרגוריאני לעברי

**מתודות מפתח:**
- `fetchAndSetProducts()` - שולף אירועים מ-Hebcal Shabbat Times API
- `fetchAndSetZmanimProducts()` - שולף זמנים יומיים מ-Hebcal Zmanim API
- `fetchAndSetHebrewDatesProducts()` - ממיר תאריכים ללוח עברי
- `setCity()` - מעדכן מיקום ושולף מחדש נתונים
- `eventsFactoryMethod()` - תבנית Factory ליצירת widgets של אירועים

**זרימת נתונים:**
```
משתמש בוחר עיר → setCity() נקרא
    ↓
עדכן SharedPreferences
    ↓
fetchAndSetProducts() → קריאת API ל-Hebcal
    ↓
ניתוח תגובת JSON → יצירת אובייקטי Event
    ↓
notifyListeners() → UI נבנה מחדש
```
1111111331      

מנהל את כל תזמון ההתראות וההעדפות:

- עוקב אחר תזכורות שמופעלות
- שומר זמני תזכורת מותאמים אישית
- מתזמן התראות דרך NotificationApi
- שומר הגדרות ל-SharedPreferences

**סוגי תזכורות:**
- הכנות לשבת (חיבור מכשירים)
- הדלקת נרות
- הבדלה
- תפילין (תפילין יומיים)
- ראש חודש
- נרות חנוכה
- ספירת העומר

#### 3. Language Provider ([lib/providers/language_change_provider.dart](lib/providers/language_change_provider.dart))

מטפל בלוקליזציה של האפליקציה:
- מחליף בין אנגלית לעברית
- שומר העדפת שפה
- מפעיל בנייה מחדש של UI עם שינוי שפה

## מודלי נתונים

האפליקציה משתמשת בגישה מונחית עצמים עם ירושה לסוגי אירועים שונים.

### היררכיית Event

```
Event (מחלקת בסיס מופשטת)
├── Shabat
├── Holiday
├── RoshChodesh
└── SfiratOmer
```

**מחלקת Event בסיס** ([lib/models/event.dart](lib/models/event.dart)):
- מגדירה מאפיינים משותפים: title, entryDate, releaseDate, parasha
- מגדירה מתודות מופשטות ליצירת תזכורות
- כל תת-מחלקה מממשת לוגיקת תזכורת ספציפית

**מודל Zman** ([lib/models/zman.dart](lib/models/zman.dart)):
- מייצג זמן הלכתי יחיד (לדוגמה, זריחה, שקיעה)
- מכיל שם ו-DateTime

## אינטגרציית API

### תקשורת Hebcal API

האפליקציה מתקשרת עם שלושה REST APIs של Hebcal:

#### 1. Shabbat Times API
**תבנית URL:** `https://www.hebcal.com/shabbat?cfg=json&o=on&...`

**מטרה:** שליפת אירועי שבוע (שבת, חגים, פרשת שבוע)

**יישום:** [lib/providers/events.dart:167-184](lib/providers/events.dart#L167-L184) (מתודה `tryFetch()`)

**עיבוד נתונים:**
- התגובה מנותחת ב-`getEventsItemsFromMap()` [lib/providers/events.dart:215-315](lib/providers/events.dart#L215-L315)
- יוצר אובייקטי תת-מחלקת Event מתאימים
- מתאים הדלקת נרות עם זמני הבדלה
- מטפל במקרי קצה (אירועים מרובים באותו יום)

#### 2. Zmanim API
**תבנית URL:** `https://www.hebcal.com/zmanim?cfg=json&...`

**מטרה:** שליפת זמנים הלכתיים יומיים

**יישום:** [lib/providers/events.dart:317-334](lib/providers/events.dart#L317-L334) (מתודה `tryFetchZmanim()`)

#### 3. Hebrew Date Converter API
**תבנית URL:** `https://www.hebcal.com/converter?cfg=json&...`

**מטרה:** ממיר טווחי תאריכים ללוח עברי

**יישום:** [lib/providers/events.dart:362-372](lib/providers/events.dart#L362-L372) (מתודה `tryFetchHebrewDates()`)

### אסטרטגיית טיפול בשגיאות

האפליקציה משתמשת בגישת fallback לשאילתות מיקום [lib/providers/events.dart:174-182](lib/providers/events.dart#L174-L182):

1. ראשית מנסה עם מיקוד מנתוני העיר
2. אם חוזרת שגיאה, חוזר לשם העיר
3. זה מטפל במקרים שבהם מיקודים עשויים שלא לעבוד לכל המיקומים

## מערכת התראות

### עטיפת NotificationApi

האפליקציה עוטפת את ה-plugin של התראות מקומיות של Flutter במחלקת API מותאמת אישית: [lib/api/notification_api.dart](lib/api/notification_api.dart)

**תכונות מרכזיות:**
- **התראות מתוזמנות**: התראות חד-פעמיות בתאריכים ספציפיים
- **התראות חוזרות**: תזכורות חוזרות יומיות ושבועיות
- **טיפול באזור זמן**: מטפל כראוי באזור הזמן של המכשיר
- **הקשה על התראה**: מנתב משתמשים למסכים רלוונטיים בעת הקשה על התראות

**סוגי התראות:**
```dart
// מתוזמן חד-פעמי
showSchedualedNotification(date: DateTime)

// חוזר יומי (לדוגמה, תזכורת תפילין)
showSchedualeDailyNotification(time: Time)

// חוזר שבועי (לדוגמה, הכנות לשבת)
showSchedualedWeeklyNotification(weekday: int)
```

**זרימת התראה:**
```
משתמש מפעיל תזכורת בהגדרות
    ↓
ספק Reminders מתזמן התראה
    ↓
NotificationApi.showSchedualedNotification()
    ↓
Flutter Local Notifications Plugin
    ↓
מערכת התראות מקומית של OS
```

### Payload של התראה לניווט

כאשר לוחצים על התראה, היא כוללת payload (שם מסלול) שמנווט את המשתמש למסך הרלוונטי [lib/screens/event_screen.dart:64-78](lib/screens/event_screen.dart#L64-L78).

## ארכיטקטורת מסכים

### מסך ראשי: EventScreen

מסך הבית [lib/screens/event_screen.dart](lib/screens/event_screen.dart) הוא המוקד המרכזי שמציג:

**שני מצבי תצוגה:**
1. **תצוגת אירועים**: מציג שבתות וחגים קרובים
2. **תצוגת זמנים**: מציג זמנים הלכתיים של היום

**ניהול מצב:**
```dart
ViewState _viewState = ViewState.events;  // מתג בין תצוגות
bool _isLoading = false;                  // מצב טעינה לאירועים
bool _isLoadingZmanim = true;             // מצב טעינה לזמנים
bool _isOnlyShabat = false;               // מסנן: הצג רק שבת
bool _isTodayTimesFromNow = false;        // מסנן: הצג רק זמנים קרובים
```

**זרימת אתחול:**
1. `initState()`: אתחל התראות
2. `didChangeDependencies()`: טען נתונים בבנייה ראשונה
3. `getAllData()`: שלוף אירועים וזמנים מ-APIs
4. `listenNotifictions()`: הגדר טיפול בהקשה על התראה

### קומפוזיציית Widget

האפליקציה עוקבת אחר תבנית הקומפוזיציה של Flutter עם widgets לשימוש חוזר:

#### Widgets של אירועים ([lib/widgets/events_widgets/](lib/widgets/events_widgets/))
- `ShabatWidget` - מציג מידע על שבת
- `HolidayWidget` - מציג מידע על חג
- `RoshChodeshWidget` - מציג ראש חודש
- `SfiratOmerWidget` - מציג ספירת העומר

**שימוש בתבנית Factory:**
ה-`Events.eventsFactoryMethod()` [lib/providers/events.dart:450-455](lib/providers/events.dart#L450-L455) מחזיר את ה-widget המתאים על פי סוג האירוע:

```dart
static Widget? eventsFactoryMethod(Event event) {
  if (event is Shabat) return ShabatWidget(data: event);
  if (event is Holiday) return HolidayWidget(data: event);
  if (event is RoshChodesh) return RoshChodeshWidget(data: event);
  if (event is SfiratOmer) return SfiratOmerWidget(data: event);
}
```

#### Widgets מונפשים ([lib/animations/](lib/animations/))
- `AnimatedEventsListView` - מנפש שינויי רשימת אירועים
- `AnimatedTimesListView` - מנפש שינויי רשימת זמנים
- `SlideInAnimation` - מספק אפקטי החלקה
- `HeroDialogRoute` - מעברי דיאלוג מותאמים אישית

#### Widgets של מתגים ([lib/widgets/swiches/](lib/widgets/swiches/))
מתגי toggle מותאמים אישית להגדרות שונות (רק שבת, מעכשיו, תאריכים עבריים וכו')

## שימור נתונים

### שימוש ב-SharedPreferences

האפליקציה שומרת העדפות משתמש מקומיות באמצעות `SharedPreferences`:

**נתונים שמורים:**
- `city` - מחרוזת עיר נבחרת (פורמט: "CountryCode-CityName|ZipCode")
- `language` - שפת אפליקציה נוכחית
- `isOnlyShabat` - העדפת מסנן
- `isHebrewDate` - העדפת תצוגת תאריך
- `isTodayTimesFromNow` - העדפת מסנן זמן
- כל הגדרות התזכורות והזמנים

**תבנית:**
כל provider מממש מתודה `getData()` שטוענת העדפות בהפעלה:

```dart
getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> prefsKeys = prefs.getKeys();

  if (prefsKeys.contains('city')) {
    city = prefs.getString('city')!;
  }
  // ... טען העדפות אחרות
  notifyListeners();
}
```

## מערכת לוקליזציה

### תמיכה רב-לשונית

האפליקציה משתמשת במערכת הלוקליזציה המובנית של Flutter עם קבצי `.arb`.

**מבנה:**
```
lib/api/l10n/
├── app_en.arb          # תרגומים לאנגלית
├── app_he.arb          # תרגומים לעברית
└── l10n.dart           # תצורת Locale
```

**יישום:**
1. [main.dart:67-72](lib/main.dart#L67-L72) מגדיר delegates לוקליזציה
2. `LanguageChangeProvider` מנהל locale נוכחי
3. רכיבי UI משתמשים ב-`AppLocalizations.of(context)` לגשת לתרגומים

**שימוש ב-Widgets:**
```dart
Text(AppLocalizations.of(context)!.shabbat)
```

## ניווט וניתוב

### תבנית Named Routes

האפליקציה משתמשת ב-named routes של Flutter לניווט [main.dart:75-87](lib/main.dart#L75-L87):

```dart
routes: {
  SchedualNotficationsScreen.routeName: (_) => const SchedualNotficationsScreen(),
  SederAnahatTefilin.routeName: (_) => SederAnahatTefilin(),
  // ... מסלולים אחרים
}
```

**שמות מסלולים:**
כל מסך מגדיר קבוע `routeName` סטטי:
```dart
class SederAnahatTefilin extends StatelessWidget {
  static const String routeName = '/seder-anahat-tefilin';
  // ...
}
```

### מגירת ניווט

הניווט העיקרי הוא דרך תפריט מגירה (נגיש דרך אייקון המבורגר) שמספק גישה ל:
- מסך אירועים ראשי
- הגדרות התראות
- מדריכי תפילה (נרות שבת, הבדלה, תפילין וכו')
- מצפן
- רשימת בדיקה
- מסך אודות

## תכונות מיוחדות

### 1. מצפן כיוון תפילה

**יישום:** [lib/screens/compass_screen.dart](lib/screens/compass_screen.dart)

משתמש במגנטומטר של המכשיר דרך חבילת `flutter_compass` להצגת כיוון תפילה לכיוון ירושלים.

**איך זה עובד:**
- קורא זרם נתוני חיישן מצפן
- מחשב כיוון לירושלים על פי מיקום המכשיר
- מעדכן UI של המצפן בזמן אמת

### 2. לוגיקת תזכורת תפילין

לאפליקציה יש לוגיקה מיוחדת לתזכורות תפילין שמדלגת על ימים מסוימים:

- לא מזכיר בשבת (יום מנוחה)
- לא מזכיר בחגים מסוימים
- טיפול מיוחד בחול המועד

לוגיקה זו מיושמת ב-provider של Reminders עם בדיקות מול נתוני Events.

### 3. תצוגת תאריך עברי

האפליקציה יכולה להחליף בין תאריכים גרגוריאניים לעבריים:

**יישום:**
1. שולף המרות תאריך עברי מ-API של Hebcal
2. שומר מיפוי במפת `_hebrewDates`
3. UI מחליף בין פורמטי תאריך על פי דגל `isHebrewDate`
4. אובייקטי Event שומרים גם תאריכים גרגוריאניים וגם עבריים

## דוגמאות לזרימת נתונים

### דוגמה 1: משתמש משנה עיר

```
משתמש בוחר עיר חדשה ב-dropdown
    ↓
EventScreen קורא ל-Provider.of<Events>.setCity()
    ↓
ספק Events:
  - מעדכן משתנה city
  - שומר ל-SharedPreferences
  - קורא ל-fetchAndSetProducts()
  - קורא ל-fetchAndSetZmanimProducts()
    ↓
קריאות API ל-Hebcal עם פרמטר עיר חדש
    ↓
ניתוח תגובות JSON לאובייקטי Event/Zman
    ↓
notifyListeners() נקרא
    ↓
Consumer widgets נבנים מחדש עם נתונים חדשים
    ↓
UI מציג אירועים לעיר החדשה
```

### דוגמה 2: תזמון תזכורת להדלקת נרות שבת

```
משתמש מפעיל תזכורת "נרות שבת"
    ↓
משתמש מגדיר זמן (לדוגמה, 15 דקות לפני)
    ↓
SchedualNotficationsScreen מעדכן ספק Reminders
    ↓
ספק Reminders:
  - שומר העדפה ל-SharedPreferences
  - עובר בלולאה על אירועי שבת קרובים
  - לכל שבת:
      - מקבל זמן הדלקת נרות
      - מחסיר 15 דקות
      - קורא ל-NotificationApi.showSchedualedNotification()
    ↓
NotificationApi מתזמן עם Flutter Local Notifications
    ↓
התראה נשמרת במערכת ההתראות של OS
    ↓
בזמן המתוזמן, ההתראה מופיעה
    ↓
משתמש מקיש על התראה
    ↓
האפליקציה נפתחת ומנווטת למדריך הדלקת נרות
```

### דוגמה 3: טעינת האפליקציה

```
main() נקרא
    ↓
widget MyApp נבנה
    ↓
יצירת מופעי provider (Events, Reminders, LanguageChangeProvider, Tfilot)
    ↓
Providers קוראים ל-getData() לטעינת SharedPreferences
    ↓
MultiProvider עוטף MaterialApp
    ↓
MaterialApp מנתב ל-EventScreen
    ↓
EventScreen.initState():
  - אתחל NotificationApi
  - הגדר מאזיני התראות
    ↓
EventScreen.didChangeDependencies():
  - קרא ל-getAllData()
    ↓
getAllData():
  - קבל שפה נוכחית מ-LanguageChangeProvider
  - קרא ל-Events.fetchAndSetProducts()
  - קרא ל-Events.fetchAndSetZmanimProducts()
    ↓
קריאות API שולפות נתונים, מנתחות ומודיעות למאזינים
    ↓
UI נבנה מחדש עם נתונים שנשלפו
    ↓
משתמש רואה זמני שבת/חג נוכחיים
```

## תבניות עיצוב מרכזיות בשימוש

1. **תבנית Provider** - ניהול מצב בכל האפליקציה
2. **תבנית Factory** - `eventsFactoryMethod()` יוצר widgets מתאימים
3. **תבנית Repository** - ספק Events משמש כמאגר נתונים
4. **Singleton** - NotificationApi משתמש במתודות סטטיות
5. **תבנית Observer** - ChangeNotifier/Consumer לעדכונים ריאקטיביים
6. **תבנית Strategy** - תת-מחלקות Event שונות מממשות אסטרטגיות תזכורת שונות

## סיכום ארגון קבצים

```
lib/
├── main.dart                      # כניסה לאפליקציה, ניתוב, הגדרת provider
├── api/
│   ├── notification_api.dart      # עטיפת התראות
│   └── l10n/                      # קבצי לוקליזציה
├── models/                        # מודלי נתונים
│   ├── event.dart                 # מחלקת Event בסיס
│   ├── shabat.dart                # מודל שבת
│   ├── holiday.dart               # מודל חג
│   └── zman.dart                  # מודל זמן
├── providers/                     # ניהול מצב
│   ├── events.dart                # ספק נתונים ראשי
│   ├── reminders.dart             # ספק התראות
│   └── language_change_provider.dart
├── screens/                       # מסכים בעמוד מלא
│   ├── event_screen.dart          # מסך בית
│   ├── schedual_notifications.dart # הגדרות תזכורת
│   └── tefilot/                   # מסכי מדריכי תפילה
├── widgets/                       # רכיבים לשימוש חוזר
│   ├── events_widgets/            # widgets תצוגת אירועים
│   ├── swiches/                   # מתגי toggle
│   └── zman_widget.dart           # תצוגת זמן
├── animations/                    # widgets אנימציה
├── helpers/                       # פונקציות עזר
└── data/                         # נתונים סטטיים (ערים)
```

## משימות מפתח נפוצות

### הוספת סוג אירוע חדש

1. צור מחלקה חדשה שמרחיבה את `Event` ב-`lib/models/`
2. מימוש מתודות מופשטות נדרשות לתזכורות
3. הוסף לוגיקת ניתוח ב-`Events.getEventsItemsFromMap()`
4. צור widget ב-`lib/widgets/events_widgets/`
5. הוסף case ל-`Events.eventsFactoryMethod()`

### הוספת סוג תזכורת חדש

1. הוסף משתנה מצב toggle לספק Reminders
2. הוסף משתני מצב בוחר זמן
3. הוסף לוגיקת שמירה/טעינה של SharedPreferences
4. הוסף לוגיקת תזמון התראה
5. הוסף UI ב-`schedual_notifications.dart`

### הוספת מסך חדש

1. צור קובץ מסך ב-`lib/screens/`
2. הגדר `static const routeName`
3. הוסף מסלול למפת routes ב-`main.dart`
4. הוסף קריאת ניווט ממגירה או מסך אחר

### שינוי נקודת קצה API

1. אתר את המתודה הרלוונטית בספק `Events`
2. עדכן URL ב-`tryFetch()`, `tryFetchZmanim()`, או `tryFetchHebrewDates()`
3. עדכן לוגיקת ניתוח JSON אם מבנה התגובה השתנה

## סיכום

אפליקציית קודש עוקבת אחר ארכיטקטורה נקייה ושכבתית עם:
- **Provider** לניהול מצב
- **הפרדה ברורה** בין UI, לוגיקה עסקית ונתונים
- **רכיבים לשימוש חוזר** ל-UI עקבי
- **אינטגרציית API חזקה** עם אסטרטגיות fallback
- **העדפות משתמש מתמידות** דרך SharedPreferences
- **מערכת התראות גמישה** לסוגי תזכורת שונים
- **תמיכה רב-לשונית** דרך מערכת הלוקליזציה של Flutter

למפתחים חדשים, התחילו על ידי:
1. הבנת תבנית Provider וכיצד נתונים זורמים
2. חקירת ספק Events לראות איך נתוני API נשלפים ומנוהלים
3. בחינת EventScreen לראות איך UI צורך נתוני provider
4. בחינת היררכיית מודל Event להבנת מבני נתונים
5. סקירת NotificationApi להבנת תזמון תזכורות
