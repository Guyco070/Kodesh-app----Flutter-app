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

Generated localization files (`lib/api/l10n/app_localizations*.dart`) are committed and must be regenerated with `flutter gen-l10n` after editing any `.arb` file in `lib/api/l10n/`.

Full pre-push check (gen-l10n, format, analyze, tests, web build): `tool/verify.sh`.
Run in debug on an emulator: `tool/run_debug_emulator.sh [android|ios]`.

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

1. **ARB / `flutter_gen`** — UI strings. ARB files are at `lib/api/l10n/app_[en|he|es|ru].arb`. Config is in `l10n.yaml`. All four locales are enabled in `L10n.all`; every key must exist in all four ARB files. Locales are language-only (`Locale('he')`) because on web they become `<html lang>`. A first-time visitor gets the device/browser language (`L10n.initialLanguageCode()`).

2. **`RemindersTranslates`** (`lib/api/l10n/reminders_translates.dart`) — Notification text. Static maps keyed by language code (`en`, `he`, `es`, `ru`). Some values are closures (e.g., `body` takes `DateTime` args). This is separate from ARB because notifications are scheduled in the background and cannot use `BuildContext`.

There is also a module-level `Locale currentLocal` variable in `lib/api/l10n/l10n.dart` used by `Reminders` provider to check language without context.

RTL layout is handled via `LanguageChangeProvider.isDirectionRTL()`.

### Notifications

`NotificationApi` (`lib/api/notification_api.dart`) wraps `flutter_local_notifications`. It uses `timezone` + `flutter_timezone` for accurate scheduling. On web it is a no-op (browsers can't schedule local notifications); the reminders screen says so. Notification tap payloads are route names (e.g., `/adlakat_nerot`); `EventScreen` listens on `NotificationApi.onNotifications` stream and navigates accordingly.

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

## Known Code Quirks

Older patterns still in the codebase — do not replicate them in new code:

- **Three slide-in list animations** (`AnimatedEventsListView`, `AnimatedOnlyShabatListView`, `AnimatedZmanimList`). Use `AnimatedZmanimList` for new lists.
- **Deprecated `MaterialState*`** is still used in older widgets; new code uses `WidgetState*`.
- **Hardcoded colours** (`Colors.blue`, `Colors.grey[600]`) in older widgets; new code uses `Theme.of(context).colorScheme`.
- **`static` mutable state** in `LanguageChangeProvider` and `NotificationApi` (read without context from background code).
- The folder `lib/widgets/swiches/` and the class `CuperinoTextCheckSwitch` are misspelled; keep the names, don't add new ones like them.

## Skills

Project skills live in `.claude/skills/`. Use them:

| Skill | When |
|---|---|
| `code-standards` | Before writing or reviewing any Dart code |
| `widget-reuse` | Before creating any widget or helper (with `CATALOG.md`) |
| `add-string` | Any new user-facing text |
| `verify` | Before every push, merge or deploy |
| `pr-review` | Reviewing a PR or branch before merging |
| `run-emulator` | Run/debug the app on a device |
| `site-audit` | Before deploying the website, after UI changes |
| `release-check` | Before a store release or moving the site to its domain |
| `branch-status` | What's merged, deployed or pending |

## Branches and deployment

- `dev-deployed` is what the website shows: every push runs `.github/workflows/deploy.yml` (GitHub Pages). A failed build leaves the previous version live.
- Work on a branch opened from `dev-deployed` (`fix/*`, `feature/*`), verify it, then merge with `/deploy-dev`.
- `master` is the stable line; CI (`ci.yml`) runs format, analyze and tests on it.

## Common Developer Tasks

### Adding a New Event Type
1. Create a class extending `Event` in `lib/models/`
2. Implement all abstract reminder methods, delegating to a new static map in `RemindersTranslates`
3. Add parsing logic in `Events.getEventsItemsFromMap()`
4. Create a display widget in `lib/widgets/events_widgets/`
5. Add a case to `Events.eventsFactoryMethod()`

### Adding a New Reminder Type
1. Add a boolean toggle and optional time string to `Reminders` provider
2. Add `SharedPreferences` load/save in `getData()` and `updateAll()`
3. Add scheduling logic inside `Reminders.setReminders()`
4. Add the UI controls in `lib/screens/schedule_notifications.dart`
5. Add any new notification text to `RemindersTranslates` (all four language keys: `en`, `he`, `es`, `ru`)

### Adding a New Screen
1. Create the screen file in `lib/screens/` using `snake_case`
2. Define `static const String routeName = '/your-route'`
3. Register the route in `main.dart`
4. Add navigation to it from `lib/widgets/app_drawer.dart` or via a notification payload
5. Add the route to `routes` in `tool/site_audit/audit.mjs` so the site audit covers it

## Coding Conventions (for all new code)

### File & Widget Structure
- One widget per file. Every new widget gets its own `.dart` file in the appropriate directory.
- Sub-widgets used exclusively by one parent widget go in a subdirectory named after that parent (e.g., `lib/widgets/compass/compass_button.dart` for a sub-widget of `CompassWidget`). Do not dump them in the global `lib/widgets/` folder.
- Extract sub-widgets into separate `StatelessWidget`/`StatefulWidget` classes. Do not build them via private builder methods like `Widget _buildSection()` — that pattern is only acceptable for very small, highly repetitive elements within the same file.

### UI Text
All hardcoded UI strings must go in ARB files (`lib/api/l10n/app_en.arb`, `app_he.arb`), not inlined in widgets. Run `flutter gen-l10n` after editing and access via `AppLocalizations.of(context)!.yourKey`. Notification strings go in `RemindersTranslates` instead (see Localization section above).

### Logging
Do not use `print()`. Use the global `logger` instance from `lib/helpers/app_logger.dart`:

```dart
import 'package:kodesh_app/helpers/app_logger.dart';

logger.d('debug message');
logger.i('info message');
logger.w('warning message');
logger.e('error message', error: e, stackTrace: st);
```

### Comments
All code comments must be written in English.

### Git Commits
Commit one logical unit at a time — one feature, one bug fix, or one refactor per commit. Do not bundle unrelated changes. Keep messages short and imperative (e.g., `Fix tefillin reminder on Chol HaMoed`).

### Context Window
When context usage reaches ~50%, or after completing a distinct task, remind the developer to run `/compact` to prevent context rot and save tokens.

## Architecture Documentation

Detailed architecture documents (data flow diagrams, recommended refactors, sprint plans) are in `plans/` on the `last_150526` branch:

- `plans/english/architecture_270125.md` — full layered architecture walkthrough
- `plans/english/architecture_fixes_271225.md` — recommended improvements with code examples
- `plans/english/project_summary_271225.md` — feature and technology overview
- `plans/tasks/` — CSV sprint task files for planned development work
