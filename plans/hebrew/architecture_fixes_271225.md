# אפליקציית קודש - תיקוני ארכיטקטורה מומלצים
**תאריך:** 27 בדצמבר 2025

## סקירה כללית

מסמך זה מתאר שיפורי ארכיטקטורה מומלצים לאפליקציית קודש. הצעות אלה מכוונות לשיפור תחזוקת הקוד, יכולת הרחבה, יכולת בדיקה, ועקיבה אחר שיטות עבודה מומלצות של Flutter/Dart.

## רמות עדיפות
- **קריטי** - יש לטפל בקרוב, משפיע על יציבות או אבטחה
- **גבוה** - שיפור משמעותי באיכות הקוד
- **בינוני** - נחמד שיהיה, משפר תחזוקה
- **נמוך** - שיפורים קלים, ניתן לטפל לאורך זמן

---

## 1. בעיות הפרדת דאגות

### 1.1 יצירת Provider במתודת build()
**עדיפות:** קריטי
**מיקום:** [lib/main.dart:48-51](lib/main.dart#L48-L51)

**בעיה:**
```dart
Widget build(BuildContext context) {
  Reminders reminders = Reminders(context);  // נוצר במתודת build
  Events events = Events();
  LanguageChangeProvider lang = LanguageChangeProvider();
  lang.getData();  // תופעת לוואי במתודת build
```

**בעיה:**
- מופעי Provider נוצרים במתודה `build()`, שיכולה להיקרא מספר פעמים
- בנאי `Reminders` מקבל `BuildContext` וקורא ל-`getData()`, גורם לתופעות לוואי במהלך בניית widget
- `lang.getData()` נקרא במהלך build, שזה אנטי-תבנית

**תיקון מומלץ:**
- העבר אתחול provider מחוץ למתודת build
- השתמש בפרמטר `create` כראוי מבלי לקרוא מתודות שיש להן תופעות לוואי
- טען נתונים ראשוניים ב-`initState()` או באמצעות `FutureProvider`/`StreamProvider`

**דוגמה:**
```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // אתחל טעינת נתונים כאן אם נדרש
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Events()),
        ChangeNotifierProvider(create: (_) => Reminders()),
        ChangeNotifierProvider(create: (_) => LanguageChangeProvider()),
        ChangeNotifierProvider(create: (_) => Tfilot()),
      ],
      child: Builder(builder: (context) {
        // הפעל טעינת נתונים ראשונית לאחר שה-providers זמינים
        return FutureBuilder(
          future: _loadInitialData(context),
          builder: (context, snapshot) {
            // ... החזר MaterialApp
          }
        );
      }),
    );
  }
}
```

---

### 1.2 בנאי Reminders מקבל BuildContext
**עדיפות:** גבוה
**מיקום:** [lib/providers/reminders.dart:53-55](lib/providers/reminders.dart#L53-L55)

**בעיה:**
```dart
Reminders(BuildContext context) {
  getData(context);
}
```

**בעיה:**
- Providers לא צריכים להיות תלויים ב-BuildContext בבנאים שלהם
- זה יוצר coupling הדוק ומקשה על בדיקת ה-provider
- מפר את העיקרון ש-providers צריכים להיות עצמאיים מעץ ה-widgets

**תיקון מומלץ:**
- הסר BuildContext מהבנאי
- קרא ל-`getData()` בנפרד לאחר יצירת ה-provider, או השתמש בטעינה עצלה
- השתמש במתודת אתחול נפרדת

**דוגמה:**
```dart
class Reminders with ChangeNotifier {
  Reminders();  // ללא BuildContext

  Future<void> initialize(BuildContext context) async {
    await getData(context);
  }
}
```

---

### 1.3 לוגיקת API מעורבבת עם ניהול מצב
**עדיפות:** גבוה
**מיקום:** [lib/providers/events.dart](lib/providers/events.dart)

**בעיה:**
ספק `Events` מכיל גם ניהול מצב וגם לוגיקת תקשורת API (300+ שורות).

**בעיה:**
- הפרת עיקרון האחריות היחידה
- קשה לבדוק לוגיקה עסקית בנפרד מקריאות API
- קשה לחקות תגובות API לבדיקות
- לא ניתן לעשות שימוש חוזר בלוגיקת API מחוץ ל-provider זה

**תיקון מומלץ:**
צור שכבת שירות/repository נפרדת:

```
lib/
├── providers/
│   └── events.dart          # ניהול מצב בלבד
├── repositories/
│   └── hebcal_repository.dart  # קריאות API
└── services/
    └── event_parser.dart    # לוגיקת ניתוח JSON
```

**דוגמה:**
```dart
// hebcal_repository.dart
class HebcalRepository {
  Future<Map<String, dynamic>> fetchShabbatTimes({
    required String city,
    DateTime? date,
    String language = 'en',
  }) async {
    // לוגיקת קריאת API כאן
  }
}

// events.dart
class Events with ChangeNotifier {
  final HebcalRepository _repository;

  Events({HebcalRepository? repository})
    : _repository = repository ?? HebcalRepository();

  Future<void> fetchAndSetProducts() async {
    final data = await _repository.fetchShabbatTimes(city: city);
    _eventsItems = EventParser.parse(data);
    notifyListeners();
  }
}
```

---

## 2. בעיות טיפול בשגיאות

### 2.1 בליעת שגיאות שקטה
**עדיפות:** קריטי
**מיקום:** [lib/providers/events.dart:203-204](lib/providers/events.dart#L203-L204)

**בעיה:**
```dart
} catch (error) {
  rethrow;  // רק זורק מחדש ללא logging או משוב למשתמש
}
```

**בעיה:**
- שגיאות נתפסות ונזרקות מחדש ללא logging
- אין משוב למשתמש כאשר קריאות API נכשלות
- קשה לבצע דיבוג בעיות ייצור

**תיקון מומלץ:**
- הוסף logging שגיאות נכון
- הצג הודעות שגיאה ידידותיות למשתמש
- מימוש לוגיקת retry לכשלי רשת
- הוסף מצב שגיאה ל-provider

**דוגמה:**
```dart
class Events with ChangeNotifier {
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<List<Event>?> fetchAndSetProducts() async {
    try {
      _errorMessage = null;
      final extractData = await tryFetch();
      _eventsItems = getEventsItemsFromMap(extractData['items'] as List);
      notifyListeners();
      return _eventsItems;
    } catch (error) {
      _errorMessage = 'נכשל בטעינת אירועים. אנא נסה שוב.';
      _eventsItems = null;
      notifyListeners();

      // רשום שגיאה לצורך דיבוג
      debugPrint('שגיאה בשליפת אירועים: $error');

      return null;
    }
  }
}
```

---

### 2.2 אין caching של נתונים אופליין
**עדיפות:** גבוה
**מיקום:** [lib/providers/events.dart:207-212](lib/providers/events.dart#L207-L212)

**בעיה:**
```dart
} else {
  _eventsItems = null;
  _zmanimItems = null;
  _hebrewDates = null;
  notifyListeners();
  return _eventsItems;
}
```

**בעיה:**
- כאשר אין אינטרנט, כל הנתונים מוגדרים ל-null
- משתמשים רואים מסכים ריקים במקום נתונים שמורים במטמון
- אין פונקציונליות אופליין

**תיקון מומלץ:**
- שמור תגובות API מקומית (באמצעות SharedPreferences, Hive, או SQLite)
- הצג נתונים שמורים במטמון כאשר אופליין
- ציין למשתמשים כאשר הם צופים בנתונים שמורים במטמון

**דוגמה:**
```dart
Future<List<Event>?> fetchAndSetProducts() async {
  if (await isThereInternetConnection()) {
    try {
      final extractData = await tryFetch();
      _eventsItems = getEventsItemsFromMap(extractData['items'] as List);

      // שמור את הנתונים במטמון
      await _cacheEvents(_eventsItems);

      notifyListeners();
      return _eventsItems;
    } catch (error) {
      // בשגיאה, נסה לטעון מהמטמון
      _eventsItems = await _loadCachedEvents();
      notifyListeners();
      return _eventsItems;
    }
  } else {
    // טען מהמטמון כאשר אופליין
    _eventsItems = await _loadCachedEvents();
    notifyListeners();
    return _eventsItems;
  }
}
```

---

## 3. בעיות כפילות קוד

### 3.1 בניית URL של API חוזרת
**עדיפות:** בינוני
**מיקום:** [lib/providers/events.dart:167-184](lib/providers/events.dart#L167-L184), [lib/providers/events.dart:317-334](lib/providers/events.dart#L317-L334)

**בעיה:**
אותה תבנית של ניסיון עם מיקוד, ואז חזרה לשם העיר, חוזרת על עצמה מספר פעמים.

**תיקון מומלץ:**
צור מתודה לשימוש חוזר לבניית URLs של Hebcal:

```dart
class HebcalUrlBuilder {
  static const baseShabbatUrl = 'https://www.hebcal.com/shabbat';
  static const baseZmanimUrl = 'https://www.hebcal.com/zmanim';

  static Uri buildShabbatUrl({
    required String location,
    String language = 'en',
    DateTime? date,
    bool useZip = true,
  }) {
    final params = {
      'cfg': 'json',
      'o': 'on',
      'lg': language,
      useZip ? 'zip' : 'city': location,
    };

    if (date != null) {
      params.addAll({
        'gy': date.year.toString(),
        'gm': date.month.toString(),
        'gd': date.day.toString(),
      });
    }

    return Uri.parse(baseShabbatUrl).replace(queryParameters: params);
  }
}
```

---

### 3.2 תבנית Setter חוזרת ב-Providers
**עדיפות:** נמוך
**מיקום:** [lib/providers/reminders.dart](lib/providers/reminders.dart)

**בעיה:**
מתודות setter רבות עוקבות אחר אותה תבנית:
```dart
setShabatAndHolidays({bool? newShabatAndHolidays}) {
  if (newShabatAndHolidays != null) {
    shabatAndHolidays = newShabatAndHolidays;
  } else {
    shabatAndHolidays = !shabatAndHolidays;
  }
  notifyListeners();
}
```

**תיקון מומלץ:**
צור מתודת toggle גנרית:
```dart
void _toggleBool(bool Function() getter, void Function(bool) setter, {bool? newValue}) {
  setter(newValue ?? !getter());
  notifyListeners();
}

void setShabatAndHolidays({bool? newValue}) {
  _toggleBool(() => shabatAndHolidays, (v) => shabatAndHolidays = v, newValue: newValue);
}
```

---

## 4. בעיות Type Safety

### 4.1 מתודות ניתוח Map סטטיות
**עדיפות:** גבוה
**מיקום:** [lib/providers/events.dart:215-315](lib/providers/events.dart#L215-L315)

**בעיה:**
```dart
static getEventsItemsFromMap(List? items) {
  // לא צוין סוג החזרה
  // מחזיר dynamic
}
```

**בעיה:**
- חסרה הערת סוג החזרה
- הופך את הקוד לפחות type-safe
- IDE לא יכול לעזור עם השלמה אוטומטית
- קשה יותר לתפוס שגיאות סוג

**תיקון מומלץ:**
הוסף סוגי החזרה מפורשים:
```dart
static List<Event> getEventsItemsFromMap(List<dynamic>? items) {
  if (items == null) return [];

  List<Event> tempItems = [];
  // ... שאר הלוגיקה
  return tempItems;
}
```

---

### 4.2 שימוש בסוגי Dynamic ל-JSON
**עדיפות:** בינוני
**מיקום:** לאורך ה-providers

**בעיה:**
נתוני JSON נגשים ללא בדיקת סוג:
```dart
items[i]['category']  // אין type safety
```

**תיקון מומלץ:**
צור מחלקות מודל לתגובות API:

```dart
class HebcalEventResponse {
  final String category;
  final String title;
  final DateTime? date;

  HebcalEventResponse.fromJson(Map<String, dynamic> json)
    : category = json['category'] as String,
      title = json['title'] as String,
      date = json['date'] != null ? DateTime.parse(json['date']) : null;
}
```

---

## 5. בדיקות ותחזוקה

### 5.1 אין Dependency Injection
**עדיפות:** גבוה
**מיקום:** לאורך האפליקציה

**בעיה:**
- Providers יוצרים ישירות תלויות
- קשה לחקות לבדיקות
- coupling הדוק בין מחלקות

**תיקון מומלץ:**
מימוש dependency injection:

```dart
class Events with ChangeNotifier {
  final HebcalRepository repository;
  final CacheService cacheService;
  final ConnectivityService connectivityService;

  Events({
    HebcalRepository? repository,
    CacheService? cacheService,
    ConnectivityService? connectivityService,
  }) : repository = repository ?? HebcalRepository(),
       cacheService = cacheService ?? CacheService(),
       connectivityService = connectivityService ?? ConnectivityService();
}
```

זה מאפשר חיקוי קל בבדיקות:
```dart
test('fetchAndSetProducts מחזיר נתונים שמורים במטמון כאשר אופליין', () async {
  final mockRepo = MockHebcalRepository();
  final mockConnectivity = MockConnectivityService();

  when(mockConnectivity.hasConnection).thenReturn(Future.value(false));

  final events = Events(
    repository: mockRepo,
    connectivityService: mockConnectivity,
  );

  // ... לוגיקת בדיקה
});
```

---

### 5.2 מתודות סטטיות גדולות
**עדיפות:** בינוני
**מיקום:** [lib/providers/events.dart:215-315](lib/providers/events.dart#L215-L315)

**בעיה:**
- `getEventsItemsFromMap()` היא 100+ שורות ארוכה
- לוגיקה מקוננת מורכבת
- קשה להבין ולתחזק

**תיקון מומלץ:**
פרק למתודות קטנות יותר וממוקדות:

```dart
static List<Event> getEventsItemsFromMap(List<dynamic>? items) {
  if (items == null) return [];

  final events = <Event>[];

  for (int i = 0; i < items.length; i++) {
    final item = items[i];
    final category = item['category'] as String;

    switch (category) {
      case 'parashat':
        events.add(_createShabatEvent(items, i));
        break;
      case 'holiday':
        events.add(_createHolidayEvent(items, i));
        break;
      case 'roshchodesh':
        _handleRoshChodeshEvent(events, items, i);
        break;
      case 'omer':
        events.add(_createSfiratOmerEvent(items, i));
        break;
    }
  }

  return _removeDuplicates(events);
}

static Event _createShabatEvent(List items, int index) {
  // לוגיקה ממוקדת ליצירת אירוע שבת
}

static Event _createHolidayEvent(List items, int index) {
  // לוגיקה ממוקדת ליצירת אירוע חג
}
```

---

## 6. ערכים קשיחים (Hard-Coded)

### 6.1 מחרוזות ומספרים קסם
**עדיפות:** בינוני
**מיקום:** לאורך בסיס הקוד

**בעיה:**
- שמות מסלולים כמחרוזות: `'/seder-anahat-tefilin'`
- מזהי התראה כמספרים קסם
- כתובות URL של API כמחרוזות קשיחות

**תיקון מומלץ:**
צור קובץ קבועים:

```dart
// lib/constants/routes.dart
class Routes {
  static const home = '/';
  static const notifications = '/notifications';
  static const tefilin = '/seder-anahat-tefilin';
  static const candles = '/adlakat-nerot';
  // ... וכו'
}

// lib/constants/notification_ids.dart
class NotificationIds {
  static const shabatCandles = 1000;
  static const havdalah = 1001;
  static const tefilin = 1002;
  // ... וכו'
}

// lib/constants/api.dart
class ApiConstants {
  static const hebcalBaseUrl = 'https://www.hebcal.com';
  static const shabbatEndpoint = '/shabbat';
  static const zmanimEndpoint = '/zmanim';
  static const converterEndpoint = '/converter';
}
```

---

### 6.2 עיר ברירת מחדל קשיחה
**עדיפות:** נמוך
**מיקום:** קבצים מרובים

**בעיה:**
```dart
String city = 'IL-Jerusalem|281184';  // ברירת מחדל קשיחה
```

**תיקון מומלץ:**
צור קובץ תצורה:
```dart
// lib/config/defaults.dart
class AppDefaults {
  static const defaultCity = 'IL-Jerusalem|281184';
  static const defaultLanguage = 'en';
  static const defaultBeforeCandlesMinutes = 15;
  // ... וכו'
}
```

---

## 7. בעיות ביצועים

### 7.1 קריאות API מרובות לאותם נתונים
**עדיפות:** גבוה
**מיקום:** ספק Events

**בעיה:**
- שליפת אירועים, זמנים ותאריכים עבריים בנפרד
- קריאות מרובות בעת שינוי עיר או תאריך
- אין batching של בקשות או caching

**תיקון מומלץ:**
- אצוות קריאות API קשורות
- מימוש caching בקשות עם תפוגה
- השתמש ב-debouncing לקלט משתמש (בחירת עיר)

```dart
// הוסף caching עם תפוגה
class ApiCache<T> {
  T? _data;
  DateTime? _timestamp;
  final Duration expiration;

  ApiCache({this.expiration = const Duration(minutes: 5)});

  bool get isValid =>
    _data != null &&
    _timestamp != null &&
    DateTime.now().difference(_timestamp!) < expiration;

  T? get data => isValid ? _data : null;

  void set(T data) {
    _data = data;
    _timestamp = DateTime.now();
  }
}
```

---

### 7.2 בנייה מחדש של כל עץ ה-Widget בשינוי שפה
**עדיפות:** בינוני
**מיקום:** ספק Language מפעיל build מחדש מלא

**בעיה:**
- שינוי שפה בונה מחדש את כל האפליקציה
- לא יעיל לעצי widgets גדולים

**תיקון מומלץ:**
- השתמש ב-`Localizations.override()` לבניה מחדש ממוקדת
- מימוש providers ספציפיים ל-locale יותר גרנולריים
- שקול להשתמש ב-`flutter_localizations` בצורה יעילה יותר

---

## 8. אבטחה ופרטיות

### 8.1 אין הגבלת קצב API
**עדיפות:** בינוני
**מיקום:** קריאות API

**בעיה:**
- אין הגבלת קצב על קריאות API
- עלול לגרום לבעיות עם מגבלות API של Hebcal
- פוטנציאל לבקשות מופרזות בשגיאות

**תיקון מומלץ:**
מימוש הגבלת קצב:

```dart
class RateLimiter {
  final Duration minInterval;
  DateTime? _lastCall;

  RateLimiter({required this.minInterval});

  Future<T> execute<T>(Future<T> Function() fn) async {
    if (_lastCall != null) {
      final elapsed = DateTime.now().difference(_lastCall!);
      if (elapsed < minInterval) {
        await Future.delayed(minInterval - elapsed);
      }
    }

    _lastCall = DateTime.now();
    return fn();
  }
}
```

---

### 8.2 הצהרות Print בקוד ייצור
**עדיפות:** נמוך
**מיקום:** [lib/providers/events.dart:180](lib/providers/events.dart#L180)

**בעיה:**
```dart
print(url);  // הדפסת debug בקוד ייצור
```

**תיקון מומלץ:**
- הסר או החלף ב-logging נכון
- השתמש ב-`debugPrint()` שמוסר בבילדים של release
- שקול להשתמש בחבילת logging כמו `logger`

```dart
import 'package:logger/logger.dart';

final logger = Logger();

// בקוד:
logger.d('שולף נתונים מ: $url');  // רמת Debug
logger.e('אירעה שגיאה: $error');    // רמת Error
```

---

## 9. בעיות UI/UX

### 9.1 אין מצבי טעינה לרכיבים בודדים
**עדיפות:** בינוני
**מיקום:** מסך Event

**בעיה:**
- מצבי טעינה גלובליים בלבד
- לא ניתן להציג טעינה חלקית (לדוגמה, אירועים נטענו אבל זמנים עדיין נטענים)

**תיקון מומלץ:**
השתמש במצבי טעינה גרנולריים יותר:

```dart
class Events with ChangeNotifier {
  LoadingState _eventsLoadingState = LoadingState.idle;
  LoadingState _zmanimLoadingState = LoadingState.idle;

  LoadingState get eventsLoadingState => _eventsLoadingState;
  LoadingState get zmanimLoadingState => _zmanimLoadingState;
}

enum LoadingState {
  idle,
  loading,
  success,
  error,
}
```

---

### 9.2 אין טיפול במצב ריק
**עדיפות:** נמוך
**מיקום:** תצוגות רשימה

**בעיה:**
- כאשר הנתונים ריקים, לא מציגים כלום
- אין הודעה מועילה למשתמשים

**תיקון מומלץ:**
הוסף widgets למצב ריק:
```dart
if (events.isEmpty) {
  return EmptyStateWidget(
    icon: Icons.event,
    message: 'אין אירועים קרובים',
    action: TextButton(
      child: Text('רענן'),
      onPressed: () => provider.fetchAndSetProducts(),
    ),
  );
}
```

---

## 10. ארגון קוד

### 10.1 שמות קבצים לא עקביים
**עדיפות:** נמוך
**מיקום:** לאורך הפרויקט

**בעיה:**
- תערובת של שמות קבצים `snake_case` ו-`PascalCase`
- דוגמה: `Shabat_and_holidays_check_list.dart` מול `event_screen.dart`

**תיקון מומלץ:**
תקנן ל-`snake_case` לכל שמות הקבצים:
- `shabat_and_holidays_check_list.dart`
- `event_screen.dart`

---

### 10.2 קבצי Provider גדולים
**עדיפות:** בינוני
**מיקום:** [lib/providers/events.dart](lib/providers/events.dart) (450+ שורות)

**בעיה:**
- קבצי Provider גדולים מאוד
- אחריות מרובה בקובץ אחד

**תיקון מומלץ:**
פצל למספר קבצים באמצעות part/library או מחלקות נפרדות:

```
lib/providers/events/
├── events_provider.dart       # ספק ראשי
├── events_state.dart          # מחלקת State
├── events_repository.dart     # קריאות API
└── events_parser.dart         # ניתוח נתונים
```

---

## סיכום ותוכנית פעולה לפי עדיפויות

### פעולות מיידיות (עדיפות קריטית)
1. תקן יצירת provider במתודת build
2. מימוש טיפול בשגיאות ו-logging נכון
3. הוסף caching של נתונים אופליין

### שיפורים לטווח קצר (עדיפות גבוהה)
4. הפרד לוגיקת API לשכבת repository
5. הסר BuildContext מבנאי Reminders
6. הוסף dependency injection ליכולת בדיקה
7. מימוש הגבלת קצב לקריאות API
8. הוסף type safety לניתוח JSON

### רפקטורינג לטווח בינוני (עדיפות בינונית)
9. פרק מתודות גדולות לפונקציות קטנות יותר
10. צור קובץ קבועים למחרוזות/מספרים קסם
11. מימוש caching בקשות
12. הוסף מצבי טעינה גרנולריים
13. שפר ארגון קוד ומבנה קבצים

### שיפורים לטווח ארוך (עדיפות נמוכה)
14. תקנן מוסכמות שמות קבצים
15. הוסף טיפול במצב ריק
16. החלף print ב-logging נכון
17. צור כלי עזר לבניית URL לשימוש חוזר

## המלצות בדיקה

כדי לתמוך בשיפורי ארכיטקטורה אלה:

1. **הוסף בדיקות יחידה** ל-providers ולוגיקה עסקית
2. **הוסף בדיקות widget** למסכים מרכזיים
3. **הוסף בדיקות אינטגרציה** לזרימות משתמש קריטיות
4. **הגדר CI/CD** עם בדיקות אוטומטיות
5. **הוסף דיווח כיסוי בדיקות** (שאף ל->70%)

## סיכום

שיפורי ארכיטקטורה אלה יהפכו את אפליקציית קודש ליותר:
- **ניתנת לתחזוקה** - קל יותר להבין ולשנות
- **ניתנת לבדיקה** - יכול לכתוב בדיקות אוטומטיות
- **ניתנת להרחבה** - יכול להוסיף תכונות מבלי לשבור קוד קיים
- **חזקה** - טיפול בשגיאות טוב יותר ותמיכה אופליין
- **מקצועית** - עוקב אחר שיטות עבודה מומלצות של Flutter/Dart

מומלץ לטפל בבעיות אלה באופן מצטבר, החל מפריטי עדיפות קריטית וגבוהה, במקום לנסות שכתוב מלא.
