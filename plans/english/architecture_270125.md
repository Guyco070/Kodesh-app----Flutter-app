# Kodesh App - Architecture Guide
**Date:** December 27, 2025

## Introduction

This document explains the architecture of the Kodesh app in a way that will help developers new to the codebase understand how the application is structured and how different components work together.

## High-Level Architecture

Kodesh follows a **layered architecture** pattern with clear separation of concerns:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│    (Screens, Widgets, Animations)       │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│       State Management Layer            │
│         (Provider Pattern)              │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│          Business Logic                 │
│      (Models, Helpers, APIs)            │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│       External Services                 │
│  (Hebcal API, Local Notifications,      │
│   SharedPreferences, Device Sensors)    │
└─────────────────────────────────────────┘
```

## Architecture Pattern: Provider State Management

The app uses the **Provider** pattern for state management, which is one of Flutter's recommended approaches for managing application state.

### How Provider Works in Kodesh

The app wraps the entire widget tree with `MultiProvider` in [main.dart:53-59](lib/main.dart#L53-L59):

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

This makes four main providers available throughout the app:
1. **Events** - Manages Shabbat, holidays, and daily times (Zmanim)
2. **Reminders** - Manages notification settings and scheduling
3. **LanguageChangeProvider** - Handles app localization
4. **Tfilot** - Manages prayer-related data

### Key Provider Classes

#### 1. Events Provider ([lib/providers/events.dart](lib/providers/events.dart))

This is the heart of the application. It manages:

- **Event Data**: List of Jewish events (Shabbat, holidays, Rosh Chodesh, Sfirat Omer)
- **Zmanim Data**: Daily halachic times (sunrise, sunset, prayer times)
- **User Preferences**: Selected city, date filters, display preferences
- **API Communication**: Fetches data from Hebcal APIs
- **Hebrew Date Conversion**: Converts Gregorian to Hebrew dates

**Key Methods:**
- `fetchAndSetProducts()` - Fetches events from Hebcal Shabbat Times API
- `fetchAndSetZmanimProducts()` - Fetches daily times from Hebcal Zmanim API
- `fetchAndSetHebrewDatesProducts()` - Converts dates to Hebrew calendar
- `setCity()` - Updates location and refetches data
- `eventsFactoryMethod()` - Factory pattern for creating event widgets

**Data Flow:**
```
User selects city → setCity() called
    ↓
Update SharedPreferences
    ↓
fetchAndSetProducts() → API call to Hebcal
    ↓
Parse JSON response → Create Event objects
    ↓
notifyListeners() → UI rebuilds
```

#### 2. Reminders Provider ([lib/providers/reminders.dart](lib/providers/reminders.dart))

Manages all notification scheduling and preferences:

- Tracks which reminders are enabled
- Stores custom reminder times
- Schedules notifications via NotificationApi
- Persists settings to SharedPreferences

**Reminder Types:**
- Shabbat preparation (connect appliances)
- Candle lighting
- Havdalah
- Tefillin (daily phylacteries)
- Rosh Chodesh
- Hanukkah candles
- Counting of the Omer

#### 3. Language Provider ([lib/providers/language_change_provider.dart](lib/providers/language_change_provider.dart))

Handles app localization:
- Switches between English and Hebrew
- Persists language preference
- Triggers UI rebuild on language change

## Data Models

The app uses an object-oriented approach with inheritance for different event types.

### Event Hierarchy

```
Event (abstract base class)
├── Shabat
├── Holiday
├── RoshChodesh
└── SfiratOmer
```

**Event Base Class** ([lib/models/event.dart](lib/models/event.dart)):
- Defines common properties: title, entryDate, releaseDate, parasha
- Defines abstract methods for reminder generation
- Each subclass implements specific reminder logic

**Zman Model** ([lib/models/zman.dart](lib/models/zman.dart)):
- Represents a single halachic time (e.g., sunrise, sunset)
- Contains a name and DateTime

## API Integration

### Hebcal API Communication

The app communicates with three Hebcal REST APIs:

#### 1. Shabbat Times API
**URL Pattern:** `https://www.hebcal.com/shabbat?cfg=json&o=on&...`

**Purpose:** Fetches weekly events (Shabbat, holidays, Torah portions)

**Implementation:** [lib/providers/events.dart:167-184](lib/providers/events.dart#L167-L184) (`tryFetch()` method)

**Data Processing:**
- Response is parsed in `getEventsItemsFromMap()` [lib/providers/events.dart:215-315](lib/providers/events.dart#L215-L315)
- Creates appropriate Event subclass objects
- Matches candle lighting with havdalah times
- Handles edge cases (multiple events on same day)

#### 2. Zmanim API
**URL Pattern:** `https://www.hebcal.com/zmanim?cfg=json&...`

**Purpose:** Fetches daily halachic times

**Implementation:** [lib/providers/events.dart:317-334](lib/providers/events.dart#L317-L334) (`tryFetchZmanim()` method)

#### 3. Hebrew Date Converter API
**URL Pattern:** `https://www.hebcal.com/converter?cfg=json&...`

**Purpose:** Converts date ranges to Hebrew calendar

**Implementation:** [lib/providers/events.dart:362-372](lib/providers/events.dart#L362-L372) (`tryFetchHebrewDates()` method)

### Error Handling Strategy

The app uses a fallback approach for location queries [lib/providers/events.dart:174-182](lib/providers/events.dart#L174-L182):

1. First tries with ZIP code from city data
2. If error returned, falls back to city name
3. This handles cases where ZIP codes might not work for all locations

## Notification System

### NotificationApi Wrapper

The app wraps Flutter's local notifications plugin in a custom API class: [lib/api/notification_api.dart](lib/api/notification_api.dart)

**Key Features:**
- **Scheduled Notifications**: One-time notifications at specific dates
- **Recurring Notifications**: Daily and weekly repeating reminders
- **Timezone Handling**: Properly handles device timezone
- **Notification Tapping**: Routes users to relevant screens when tapping notifications

**Notification Types:**
```dart
// One-time scheduled
showSchedualedNotification(date: DateTime)

// Daily recurring (e.g., tefillin reminder)
showSchedualeDailyNotification(time: Time)

// Weekly recurring (e.g., Shabbat preparation)
showSchedualedWeeklyNotification(weekday: int)
```

**Notification Flow:**
```
User enables reminder in settings
    ↓
Reminders provider schedules notification
    ↓
NotificationApi.showSchedualedNotification()
    ↓
Flutter Local Notifications Plugin
    ↓
Native OS notification system
```

### Notification Payload for Navigation

When a notification is tapped, it includes a payload (route name) that navigates the user to the relevant screen [lib/screens/event_screen.dart:64-78](lib/screens/event_screen.dart#L64-L78).

## Screen Architecture

### Main Screen: EventScreen

The home screen [lib/screens/event_screen.dart](lib/screens/event_screen.dart) is the central hub that displays:

**Two View States:**
1. **Events View**: Shows upcoming Shabbat and holidays
2. **Zmanim View**: Shows today's halachic times

**State Management:**
```dart
ViewState _viewState = ViewState.events;  // Toggle between views
bool _isLoading = false;                  // Loading state for events
bool _isLoadingZmanim = true;             // Loading state for zmanim
bool _isOnlyShabat = false;               // Filter: show only Shabbat
bool _isTodayTimesFromNow = false;        // Filter: show only upcoming times
```

**Initialization Flow:**
1. `initState()`: Initialize notifications
2. `didChangeDependencies()`: Load data on first build
3. `getAllData()`: Fetch events and zmanim from APIs
4. `listenNotifictions()`: Set up notification tap handling

### Widget Composition

The app follows Flutter's composition pattern with reusable widgets:

#### Event Widgets ([lib/widgets/events_widgets/](lib/widgets/events_widgets/))
- `ShabatWidget` - Displays Shabbat information
- `HolidayWidget` - Displays holiday information
- `RoshChodeshWidget` - Displays Rosh Chodesh
- `SfiratOmerWidget` - Displays Omer count

**Factory Pattern Usage:**
The `Events.eventsFactoryMethod()` [lib/providers/events.dart:450-455](lib/providers/events.dart#L450-L455) returns the appropriate widget based on event type:

```dart
static Widget? eventsFactoryMethod(Event event) {
  if (event is Shabat) return ShabatWidget(data: event);
  if (event is Holiday) return HolidayWidget(data: event);
  if (event is RoshChodesh) return RoshChodeshWidget(data: event);
  if (event is SfiratOmer) return SfiratOmerWidget(data: event);
}
```

#### Animated Widgets ([lib/animations/](lib/animations/))
- `AnimatedEventsListView` - Animates event list changes
- `AnimatedTimesListView` - Animates zmanim list changes
- `SlideInAnimation` - Provides slide-in effects
- `HeroDialogRoute` - Custom dialog transitions

#### Switch Widgets ([lib/widgets/swiches/](lib/widgets/swiches/))
Custom toggle switches for various settings (only Shabbat, from now on, Hebrew dates, etc.)

## Data Persistence

### SharedPreferences Usage

The app stores user preferences locally using `SharedPreferences`:

**Stored Data:**
- `city` - Selected city string (format: "CountryCode-CityName|ZipCode")
- `language` - Current app language
- `isOnlyShabat` - Filter preference
- `isHebrewDate` - Date display preference
- `isTodayTimesFromNow` - Time filter preference
- All reminder settings and times

**Pattern:**
Every provider implements a `getData()` method that loads preferences on startup:

```dart
getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> prefsKeys = prefs.getKeys();

  if (prefsKeys.contains('city')) {
    city = prefs.getString('city')!;
  }
  // ... load other preferences
  notifyListeners();
}
```

## Localization System

### Multi-Language Support

The app uses Flutter's built-in localization system with `.arb` files.

**Structure:**
```
lib/api/l10n/
├── app_en.arb          # English translations
├── app_he.arb          # Hebrew translations
└── l10n.dart           # Locale configuration
```

**Implementation:**
1. [main.dart:67-72](lib/main.dart#L67-L72) configures localization delegates
2. `LanguageChangeProvider` manages current locale
3. UI components use `AppLocalizations.of(context)` to access translations

**Usage in Widgets:**
```dart
Text(AppLocalizations.of(context)!.shabbat)
```

## Navigation & Routing

### Named Routes Pattern

The app uses Flutter's named routes for navigation [main.dart:75-87](lib/main.dart#L75-L87):

```dart
routes: {
  SchedualNotficationsScreen.routeName: (_) => const SchedualNotficationsScreen(),
  SederAnahatTefilin.routeName: (_) => SederAnahatTefilin(),
  // ... other routes
}
```

**Route Names:**
Each screen defines a static `routeName` constant:
```dart
class SederAnahatTefilin extends StatelessWidget {
  static const String routeName = '/seder-anahat-tefilin';
  // ...
}
```

### Navigation Drawer

The main navigation is through a drawer menu (accessed via hamburger icon) that provides access to:
- Main event screen
- Notification settings
- Prayer guides (Shabbat candles, Havdalah, Tefillin, etc.)
- Compass
- Checklist
- About screen

## Special Features

### 1. Prayer Direction Compass

**Implementation:** [lib/screens/compass_screen.dart](lib/screens/compass_screen.dart)

Uses device magnetometer via `flutter_compass` package to show prayer direction toward Jerusalem.

**How it Works:**
- Reads compass sensor data stream
- Calculates direction to Jerusalem based on device location
- Updates compass UI in real-time

### 2. Tefillin Reminder Logic

The app has special logic for tefillin reminders that skips certain days:

- Not reminded on Shabbat (day of rest)
- Not reminded on certain holidays
- Special handling for Chol HaMoed (intermediate festival days)

This logic is implemented in the Reminders provider with checks against the Events data.

### 3. Hebrew Date Display

The app can toggle between Gregorian and Hebrew dates:

**Implementation:**
1. Fetches Hebrew date conversions from Hebcal API
2. Stores mapping in `_hebrewDates` map
3. UI switches between date formats based on `isHebrewDate` flag
4. Event objects store both Gregorian and Hebrew dates

## Data Flow Examples

### Example 1: User Changes City

```
User selects new city in dropdown
    ↓
EventScreen calls Provider.of<Events>.setCity()
    ↓
Events provider:
  - Updates city variable
  - Saves to SharedPreferences
  - Calls fetchAndSetProducts()
  - Calls fetchAndSetZmanimProducts()
    ↓
API calls to Hebcal with new city parameter
    ↓
Parse JSON responses into Event/Zman objects
    ↓
notifyListeners() called
    ↓
Consumer widgets rebuild with new data
    ↓
UI displays events for new city
```

### Example 2: Scheduling a Shabbat Candle Lighting Reminder

```
User enables "Shabbat Candles" reminder
    ↓
User sets time (e.g., 15 minutes before)
    ↓
SchedualNotficationsScreen updates Reminders provider
    ↓
Reminders provider:
  - Saves preference to SharedPreferences
  - Loops through upcoming Shabbat events
  - For each Shabbat:
      - Gets candle lighting time
      - Subtracts 15 minutes
      - Calls NotificationApi.showSchedualedNotification()
    ↓
NotificationApi schedules with Flutter Local Notifications
    ↓
Notification stored in OS notification system
    ↓
At scheduled time, notification appears
    ↓
User taps notification
    ↓
App opens and navigates to candle lighting guide
```

### Example 3: Loading the App

```
main() called
    ↓
MyApp widget builds
    ↓
Create provider instances (Events, Reminders, LanguageChangeProvider, Tfilot)
    ↓
Providers call getData() to load SharedPreferences
    ↓
MultiProvider wraps MaterialApp
    ↓
MaterialApp routes to EventScreen
    ↓
EventScreen.initState():
  - Initialize NotificationApi
  - Set up notification listeners
    ↓
EventScreen.didChangeDependencies():
  - Call getAllData()
    ↓
getAllData():
  - Get current language from LanguageChangeProvider
  - Call Events.fetchAndSetProducts()
  - Call Events.fetchAndSetZmanimProducts()
    ↓
API calls fetch data, parse, and notify listeners
    ↓
UI rebuilds with fetched data
    ↓
User sees current Shabbat/holiday times
```

## Key Design Patterns Used

1. **Provider Pattern** - State management across the app
2. **Factory Pattern** - `eventsFactoryMethod()` creates appropriate widgets
3. **Repository Pattern** - Events provider acts as data repository
4. **Singleton** - NotificationApi uses static methods
5. **Observer Pattern** - ChangeNotifier/Consumer for reactive updates
6. **Strategy Pattern** - Different Event subclasses implement different reminder strategies

## File Organization Summary

```
lib/
├── main.dart                      # App entry, routing, provider setup
├── api/
│   ├── notification_api.dart      # Notification wrapper
│   └── l10n/                      # Localization files
├── models/                        # Data models
│   ├── event.dart                 # Base Event class
│   ├── shabat.dart                # Shabbat model
│   ├── holiday.dart               # Holiday model
│   └── zman.dart                  # Time model
├── providers/                     # State management
│   ├── events.dart                # Main data provider
│   ├── reminders.dart             # Notifications provider
│   └── language_change_provider.dart
├── screens/                       # Full-page screens
│   ├── event_screen.dart          # Home screen
│   ├── schedual_notifications.dart # Reminder settings
│   └── tefilot/                   # Prayer guide screens
├── widgets/                       # Reusable components
│   ├── events_widgets/            # Event display widgets
│   ├── swiches/                   # Toggle switches
│   └── zman_widget.dart           # Time display
├── animations/                    # Animation widgets
├── helpers/                       # Utility functions
└── data/                         # Static data (cities)
```

## Common Developer Tasks

### Adding a New Event Type

1. Create a new class extending `Event` in `lib/models/`
2. Implement required abstract methods for reminders
3. Add parsing logic in `Events.getEventsItemsFromMap()`
4. Create a widget in `lib/widgets/events_widgets/`
5. Add case to `Events.eventsFactoryMethod()`

### Adding a New Reminder Type

1. Add toggle state variable to Reminders provider
2. Add time picker state variables
3. Add SharedPreferences save/load logic
4. Add notification scheduling logic
5. Add UI in `schedual_notifications.dart`

### Adding a New Screen

1. Create screen file in `lib/screens/`
2. Define `static const routeName`
3. Add route to `main.dart` routes map
4. Add navigation call from drawer or other screen

### Changing the API Endpoint

1. Locate the relevant method in `Events` provider
2. Update URL in `tryFetch()`, `tryFetchZmanim()`, or `tryFetchHebrewDates()`
3. Update JSON parsing logic if response structure changed

## Summary

The Kodesh app follows a clean, layered architecture with:
- **Provider** for state management
- **Clear separation** between UI, business logic, and data
- **Reusable components** for consistent UI
- **Robust API integration** with fallback strategies
- **Persistent user preferences** via SharedPreferences
- **Flexible notification system** for various reminder types
- **Multi-language support** through Flutter's localization system

For new developers, start by:
1. Understanding the Provider pattern and how data flows
2. Exploring the Events provider to see how API data is fetched and managed
3. Looking at EventScreen to see how UI consumes provider data
4. Examining the Event model hierarchy to understand data structures
5. Reviewing NotificationApi to understand reminder scheduling
