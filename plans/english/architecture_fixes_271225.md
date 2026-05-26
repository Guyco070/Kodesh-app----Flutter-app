# Kodesh App - Recommended Architecture Fixes
**Date:** December 27, 2025

## Overview

This document outlines recommended architectural improvements for the Kodesh app. These suggestions are aimed at improving code maintainability, scalability, testability, and following Flutter/Dart best practices.

## Priority Levels
- **Critical** - Should be addressed soon, impacts stability or security
- **High** - Significant improvement to code quality
- **Medium** - Nice to have, improves maintainability
- **Low** - Minor improvements, can be addressed over time

---

## 1. Separation of Concerns Issues

### 1.1 Provider Instantiation in build() Method
**Priority:** Critical
**Location:** [lib/main.dart:48-51](lib/main.dart#L48-L51)

**Issue:**
```dart
Widget build(BuildContext context) {
  Reminders reminders = Reminders(context);  // Created in build method
  Events events = Events();
  LanguageChangeProvider lang = LanguageChangeProvider();
  lang.getData();  // Side effect in build method
```

**Problem:**
- Provider instances are created in the `build()` method, which can be called multiple times
- `Reminders` constructor takes a `BuildContext` and calls `getData()`, causing side effects during widget construction
- `lang.getData()` is called during build, which is an anti-pattern

**Recommended Fix:**
- Move provider initialization outside of build method
- Use the `create` parameter properly without calling methods that have side effects
- Load initial data in `initState()` or using `FutureProvider`/`StreamProvider`

**Example:**
```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize data loading here if needed
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
        // Trigger initial data load after providers are available
        return FutureBuilder(
          future: _loadInitialData(context),
          builder: (context, snapshot) {
            // ... return MaterialApp
          }
        );
      }),
    );
  }
}
```

---

### 1.2 Reminders Constructor Takes BuildContext
**Priority:** High
**Location:** [lib/providers/reminders.dart:53-55](lib/providers/reminders.dart#L53-L55)

**Issue:**
```dart
Reminders(BuildContext context) {
  getData(context);
}
```

**Problem:**
- Providers should not depend on BuildContext in their constructors
- This creates tight coupling and makes the provider harder to test
- Violates the principle that providers should be independent of the widget tree

**Recommended Fix:**
- Remove BuildContext from constructor
- Call `getData()` separately after provider is created, or use lazy loading
- Use a separate initialization method

**Example:**
```dart
class Reminders with ChangeNotifier {
  Reminders();  // No BuildContext

  Future<void> initialize(BuildContext context) async {
    await getData(context);
  }
}
```

---

### 1.3 API Logic Mixed with State Management
**Priority:** High
**Location:** [lib/providers/events.dart](lib/providers/events.dart)

**Issue:**
The `Events` provider contains both state management AND API communication logic (300+ lines).

**Problem:**
- Single Responsibility Principle violation
- Hard to test business logic separately from API calls
- Difficult to mock API responses for testing
- Can't reuse API logic outside of this provider

**Recommended Fix:**
Create a separate service/repository layer:

```
lib/
├── providers/
│   └── events.dart          # State management only
├── repositories/
│   └── hebcal_repository.dart  # API calls
└── services/
    └── event_parser.dart    # JSON parsing logic
```

**Example:**
```dart
// hebcal_repository.dart
class HebcalRepository {
  Future<Map<String, dynamic>> fetchShabbatTimes({
    required String city,
    DateTime? date,
    String language = 'en',
  }) async {
    // API call logic here
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

## 2. Error Handling Issues

### 2.1 Silent Error Swallowing
**Priority:** Critical
**Location:** [lib/providers/events.dart:203-204](lib/providers/events.dart#L203-L204)

**Issue:**
```dart
} catch (error) {
  rethrow;  // Just rethrows without logging or user feedback
}
```

**Problem:**
- Errors are caught and rethrown without logging
- No user feedback when API calls fail
- Difficult to debug production issues

**Recommended Fix:**
- Add proper error logging
- Show user-friendly error messages
- Implement retry logic for network failures
- Add error state to provider

**Example:**
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
      _errorMessage = 'Failed to load events. Please try again.';
      _eventsItems = null;
      notifyListeners();

      // Log error for debugging
      debugPrint('Error fetching events: $error');

      return null;
    }
  }
}
```

---

### 2.2 No Offline Data Caching
**Priority:** High
**Location:** [lib/providers/events.dart:207-212](lib/providers/events.dart#L207-L212)

**Issue:**
```dart
} else {
  _eventsItems = null;
  _zmanimItems = null;
  _hebrewDates = null;
  notifyListeners();
  return _eventsItems;
}
```

**Problem:**
- When there's no internet, all data is set to null
- Users see empty screens instead of cached data
- No offline functionality

**Recommended Fix:**
- Cache API responses locally (using SharedPreferences, Hive, or SQLite)
- Show cached data when offline
- Indicate to users when they're viewing cached data

**Example:**
```dart
Future<List<Event>?> fetchAndSetProducts() async {
  if (await isThereInternetConnection()) {
    try {
      final extractData = await tryFetch();
      _eventsItems = getEventsItemsFromMap(extractData['items'] as List);

      // Cache the data
      await _cacheEvents(_eventsItems);

      notifyListeners();
      return _eventsItems;
    } catch (error) {
      // On error, try to load from cache
      _eventsItems = await _loadCachedEvents();
      notifyListeners();
      return _eventsItems;
    }
  } else {
    // Load from cache when offline
    _eventsItems = await _loadCachedEvents();
    notifyListeners();
    return _eventsItems;
  }
}
```

---

## 3. Code Duplication Issues

### 3.1 Repeated API URL Construction
**Priority:** Medium
**Location:** [lib/providers/events.dart:167-184](lib/providers/events.dart#L167-L184), [lib/providers/events.dart:317-334](lib/providers/events.dart#L317-L334)

**Issue:**
The same pattern of trying with ZIP code, then falling back to city name, is repeated multiple times.

**Recommended Fix:**
Create a reusable method for building Hebcal URLs:

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

### 3.2 Repeated Setter Pattern in Providers
**Priority:** Low
**Location:** [lib/providers/reminders.dart](lib/providers/reminders.dart)

**Issue:**
Many setter methods follow the same pattern:
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

**Recommended Fix:**
Create a generic toggle method:
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

## 4. Type Safety Issues

### 4.1 Static Map Parsing Methods
**Priority:** High
**Location:** [lib/providers/events.dart:215-315](lib/providers/events.dart#L215-L315)

**Issue:**
```dart
static getEventsItemsFromMap(List? items) {
  // No return type specified
  // Returns dynamic
}
```

**Problem:**
- Missing return type annotation
- Makes code less type-safe
- IDE can't help with autocomplete
- Harder to catch type errors

**Recommended Fix:**
Add explicit return types:
```dart
static List<Event> getEventsItemsFromMap(List<dynamic>? items) {
  if (items == null) return [];

  List<Event> tempItems = [];
  // ... rest of logic
  return tempItems;
}
```

---

### 4.2 Using Dynamic Types for JSON
**Priority:** Medium
**Location:** Throughout providers

**Issue:**
JSON data is accessed without type checking:
```dart
items[i]['category']  // No type safety
```

**Recommended Fix:**
Create model classes for API responses:

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

## 5. Testing and Maintainability

### 5.1 No Dependency Injection
**Priority:** High
**Location:** Throughout the app

**Issue:**
- Providers directly instantiate dependencies
- Hard to mock for testing
- Tight coupling between classes

**Recommended Fix:**
Implement dependency injection:

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

This allows easy mocking in tests:
```dart
test('fetchAndSetProducts returns cached data when offline', () async {
  final mockRepo = MockHebcalRepository();
  final mockConnectivity = MockConnectivityService();

  when(mockConnectivity.hasConnection).thenReturn(Future.value(false));

  final events = Events(
    repository: mockRepo,
    connectivityService: mockConnectivity,
  );

  // ... test logic
});
```

---

### 5.2 Large Static Methods
**Priority:** Medium
**Location:** [lib/providers/events.dart:215-315](lib/providers/events.dart#L215-L315)

**Issue:**
- `getEventsItemsFromMap()` is 100+ lines long
- Complex nested logic
- Hard to understand and maintain

**Recommended Fix:**
Break into smaller, focused methods:

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
  // Focused logic for creating Shabat event
}

static Event _createHolidayEvent(List items, int index) {
  // Focused logic for creating Holiday event
}
```

---

## 6. Hard-Coded Values

### 6.1 Magic Strings and Numbers
**Priority:** Medium
**Location:** Throughout the codebase

**Issue:**
- Route names as strings: `'/seder-anahat-tefilin'`
- Notification IDs as magic numbers
- API URLs as hard-coded strings

**Recommended Fix:**
Create constants file:

```dart
// lib/constants/routes.dart
class Routes {
  static const home = '/';
  static const notifications = '/notifications';
  static const tefilin = '/seder-anahat-tefilin';
  static const candles = '/adlakat-nerot';
  // ... etc
}

// lib/constants/notification_ids.dart
class NotificationIds {
  static const shabatCandles = 1000;
  static const havdalah = 1001;
  static const tefilin = 1002;
  // ... etc
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

### 6.2 Default City Hard-Coded
**Priority:** Low
**Location:** Multiple files

**Issue:**
```dart
String city = 'IL-Jerusalem|281184';  // Hard-coded default
```

**Recommended Fix:**
Create a configuration file:
```dart
// lib/config/defaults.dart
class AppDefaults {
  static const defaultCity = 'IL-Jerusalem|281184';
  static const defaultLanguage = 'en';
  static const defaultBeforeCandlesMinutes = 15;
  // ... etc
}
```

---

## 7. Performance Issues

### 7.1 Multiple API Calls for Same Data
**Priority:** High
**Location:** Events provider

**Issue:**
- Fetching events, zmanim, and Hebrew dates separately
- Multiple calls when changing city or date
- No request batching or caching

**Recommended Fix:**
- Batch related API calls
- Implement request caching with expiration
- Use debouncing for user input (city selection)

```dart
// Add caching with expiration
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

### 7.2 Rebuilding Entire Widget Tree on Language Change
**Priority:** Medium
**Location:** Language provider triggers full rebuild

**Issue:**
- Changing language rebuilds the entire app
- Inefficient for large widget trees

**Recommended Fix:**
- Use `Localizations.override()` for targeted rebuilds
- Implement more granular locale-specific providers
- Consider using `flutter_localizations` more efficiently

---

## 8. Security and Privacy

### 8.1 No API Rate Limiting
**Priority:** Medium
**Location:** API calls

**Issue:**
- No rate limiting on API calls
- Could cause issues with Hebcal API limits
- Potential for excessive requests on errors

**Recommended Fix:**
Implement rate limiting:

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

### 8.2 Print Statements in Production Code
**Priority:** Low
**Location:** [lib/providers/events.dart:180](lib/providers/events.dart#L180)

**Issue:**
```dart
print(url);  // Debug print in production code
```

**Recommended Fix:**
- Remove or replace with proper logging
- Use `debugPrint()` which is stripped in release builds
- Consider using a logging package like `logger`

```dart
import 'package:logger/logger.dart';

final logger = Logger();

// In code:
logger.d('Fetching data from: $url');  // Debug level
logger.e('Error occurred: $error');    // Error level
```

---

## 9. UI/UX Issues

### 9.1 No Loading States for Individual Components
**Priority:** Medium
**Location:** Event screen

**Issue:**
- Global loading states only
- Can't show partial loading (e.g., events loaded but zmanim still loading)

**Recommended Fix:**
Use more granular loading states:

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

### 9.2 No Empty State Handling
**Priority:** Low
**Location:** List views

**Issue:**
- When data is empty, showing nothing
- No helpful message to users

**Recommended Fix:**
Add empty state widgets:
```dart
if (events.isEmpty) {
  return EmptyStateWidget(
    icon: Icons.event,
    message: 'No upcoming events',
    action: TextButton(
      child: Text('Refresh'),
      onPressed: () => provider.fetchAndSetProducts(),
    ),
  );
}
```

---

## 10. Code Organization

### 10.1 Inconsistent File Naming
**Priority:** Low
**Location:** Throughout project

**Issue:**
- Mix of `snake_case` and `PascalCase` file names
- Example: `Shabat_and_holidays_check_list.dart` vs `event_screen.dart`

**Recommended Fix:**
Standardize to `snake_case` for all file names:
- `shabat_and_holidays_check_list.dart`
- `event_screen.dart`

---

### 10.2 Large Provider Files
**Priority:** Medium
**Location:** [lib/providers/events.dart](lib/providers/events.dart) (450+ lines)

**Issue:**
- Provider files are very large
- Multiple responsibilities in one file

**Recommended Fix:**
Split into multiple files using part/library or separate classes:

```
lib/providers/events/
├── events_provider.dart       # Main provider
├── events_state.dart          # State class
├── events_repository.dart     # API calls
└── events_parser.dart         # Data parsing
```

---

## Summary and Prioritized Action Plan

### Immediate Actions (Critical Priority)
1. Fix provider instantiation in build method
2. Implement proper error handling and logging
3. Add offline data caching

### Short-term Improvements (High Priority)
4. Separate API logic into repository layer
5. Remove BuildContext from Reminders constructor
6. Add dependency injection for testability
7. Implement rate limiting for API calls
8. Add type safety to JSON parsing

### Medium-term Refactoring (Medium Priority)
9. Break large methods into smaller functions
10. Create constants file for magic strings/numbers
11. Implement request caching
12. Add granular loading states
13. Improve code organization and file structure

### Long-term Enhancements (Low Priority)
14. Standardize file naming conventions
15. Add empty state handling
16. Replace print with proper logging
17. Create reusable URL builder utilities

## Testing Recommendations

To support these architectural improvements:

1. **Add unit tests** for providers and business logic
2. **Add widget tests** for key screens
3. **Add integration tests** for critical user flows
4. **Set up CI/CD** with automated testing
5. **Add test coverage** reporting (aim for >70%)

## Conclusion

These architectural improvements will make the Kodesh app more:
- **Maintainable** - Easier to understand and modify
- **Testable** - Can write automated tests
- **Scalable** - Can add features without breaking existing code
- **Robust** - Better error handling and offline support
- **Professional** - Follows Flutter/Dart best practices

It's recommended to tackle these issues incrementally, starting with the critical and high-priority items, rather than attempting a complete rewrite.
