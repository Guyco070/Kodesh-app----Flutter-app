# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About the App

Kodesh is a Flutter app for iOS and Android that helps Jewish users track Shabbat/holiday entry and exit times, halachic times of day (zmanim), and set local push notifications for various Jewish observances (Shabbat, holidays, Hanukkah candles, tefillin, Rosh Chodesh, Sefirat HaOmer). It also includes prayer texts and a Qibla compass.

## Commands

```bash
flutter pub get          # Install dependencies
flutter run              # Run on connected device/emulator
flutter analyze          # Lint (uses flutter_lints)
flutter test             # Run all tests
flutter test test/widget_test.dart  # Run a single test file
flutter gen-l10n         # Regenerate localization files from ARB
flutter build apk        # Build Android APK
flutter build ios        # Build iOS
```

Generated localization files live in `.dart_tool/flutter_gen/gen_l10n/` and must be regenerated after editing any `.arb` file in `lib/api/l10n/`.

## Architecture

### State Management — Provider

Four `ChangeNotifier` providers are registered at the root (`main.dart`):

| Provider | Responsibility |
|---|---|
| `Events` | Fetches and stores weekly events and daily zmanim; manages city, start date, display toggles |
| `Reminders` | Reads user notification preferences and schedules all local notifications via `NotificationApi` |
| `LanguageChangeProvider` | Tracks current locale; persists to `SharedPreferences` |
| `Tfilot` | Tracks the user's prayer nusach (Mizrachi / Ashkenaz / Sfarad) |

All preferences are persisted through `SharedPreferences` and loaded on startup via each provider's `getData()` method.

### Data Model — Event Hierarchy

`Event` is the abstract base class (`lib/models/event.dart`). Concrete subclasses:

- `Shabat` — has `parasha`, `entryDate` (candle lighting), `releaseDate` (Havdalah)
- `Holiday` — adds `subcat` (e.g., `"major"`) and `titleOrig` for Chanukah detection
- `RoshChodesh` — can be merged across two-day Rosh Chodesh via `RoshChodesh.marge()`
- `SfiratOmer` — includes a `sefira` map with Hebrew/English counting text

`Zman` is a separate flat class (not an `Event`) representing a single named halachic time.

All `Event` subclasses implement `getReminderTitle/Body/CandlesTitle/CandlesBody/HavdalahTitle/HavdalahBody(String lang)`, which delegate to static translation maps in `RemindersTranslates`.

### External APIs (Hebcal)

All three APIs are called from `Events` provider (`lib/providers/events.dart`). City is passed as `"CC-CityName|geonamesId"` (e.g., `"IL-Jerusalem|281184"`). On error response, the provider retries using the city name segment instead of the numeric ID.

- **Shabbat/events**: `https://www.hebcal.com/shabbat?cfg=json&...`
- **Zmanim**: `https://www.hebcal.com/zmanim?cfg=json&...`
- **Hebrew date converter**: `https://www.hebcal.com/converter?cfg=json&...`

`Events.getEventsItemsFromMap()` is a static factory that parses the raw Hebcal `items` list into typed `Event` objects. It scans backwards for candle-lighting entries to associate with `parashat` items.

### Localization

Two parallel systems:

1. **ARB / `flutter_gen`** — UI strings. ARB files are at `lib/api/l10n/app_[en|he|es|ru].arb`. Config is in `l10n.yaml`. Only `en` and `he` are currently enabled in `L10n.all`; `es` and `ru` ARB files exist but the locales are commented out.

2. **`RemindersTranslates`** (`lib/api/l10n/reminders_translates.dart`) — Notification text. Static maps keyed by language code (`en`, `he`, `es`, `ru`). Some values are closures (e.g., `body` takes `DateTime` args). This is separate from ARB because notifications are scheduled in the background and cannot use `BuildContext`.

There is also a module-level `Locale currentLocal` variable in `lib/api/l10n/l10n.dart` used by `Reminders` provider to check language without context.

RTL layout is handled via `LanguageChangeProvider.isDirectionRTL()`.

### Notifications

`NotificationApi` (`lib/api/notification_api.dart`) wraps `flutter_local_notifications`. It uses `timezone` + `flutter_native_timezone` for accurate scheduling. Notification tap payloads are route names (e.g., `/adlakat_nerot`); `EventScreen` listens on `NotificationApi.onNotifications` stream and navigates accordingly.

`Reminders.setReminders()` is the single entry point that cancels all existing notifications and reschedules everything from scratch. It fetches today's events fresh to determine dates, then removes tefillin reminders that fall on holidays/Chol HaMoed.

### Prayer Text Rendering (`Tfilot`)

Prayer text is stored as `List<String>` where the first character of each string is a formatting code:

- `B` — bold first line of a blessing
- `T` — section title
- `S` — start of a sentence (rendered in blue)
- Lines ending with `.` or `:` get trailing newlines

`Tfilot.getSederWidgets()` converts these lists into `List<TextSpan>`. Prayer screens pass a `getBracha` map structured as `Map<String, Map<Nosah, List<String>>>` (language → nusach → text lines).

### Screens and Navigation

Named routes are registered in `main.dart`. Each prayer/checklist screen exposes a static `routeName` string used both for navigation and as the notification payload. The main screen is `EventScreen` (no named route).

### City Format

Cities are stored as `"CC-CityName|geonamesId"` strings. The `lib/data/cities.dart` file contains the full city list with translations per language. City display names are keyed by language code (`en`, `he`, `ru`, `es`).
