# Changelog

All notable changes to this project are documented here.

## [1.1.0] - 2026-06-02

### Added
- **Offline caching** — last-fetched events are stored in `SharedPreferences` and shown when the network is unavailable
- **Retry button** on the error state of the main events screen
- **Pull-to-refresh** on the main events screen
- **City search picker** — replaced a 1 200-item dropdown with a lazy `SearchDelegate` backed by `ListView.builder`
- **GitHub Actions CI** — `flutter analyze`, `dart format` check, and `flutter test` run on every push/PR to `master`; coverage uploaded to Codecov on `master` pushes
- **Spanish and Russian UI translations** — all previously missing strings added; both locales enabled in the language picker
- **Hanukkah candle notification text** for Spanish and Russian (`RemindersTranslates`)
- **Background notification tap routing** — taps on notifications received while the app is in the background now navigate to the correct screen

### Changed
- Providers (`Events`, `Reminders`, `LanguageChangeProvider`, `Tfilot`) are now created in `main()` rather than inside `MyApp.build()`
- `Reminders` no longer takes a `BuildContext` constructor argument
- Hours-before picker capped at 23 (was incorrectly allowing 24)
- Version bumped to `1.1.0+2`
- App description updated in `pubspec.yaml`
- Notification API methods renamed to correct English spelling (`showScheduledNotification`, `scheduleDaily`, etc.)
- Screen and widget class names corrected (`ScheduleNotificationsScreen`, route `/schedule-notifications`)

### Fixed
- Rosh Chodesh reminder incorrectly moved Friday-before-14:00 reminders to Thursday
- Hebrew date converter URL used wrong date range (missed future weeks) and had a double-`&&` typo
- Background notification taps were silently dropped

### Removed
- Commented-out debug/test data from `Reminders` provider
- Commented-out dead code in `l10n.dart`, `app_drawer.dart`, `default_scaffold.dart`, `dates.dart`

---

## [1.0.0] - 2023

### Added
- Initial release
- Shabbat and holiday entry/exit times via Hebcal API
- Daily zmanim (halachic times)
- Local push notifications: Shabbat/holiday preparation, Hanukkah candles, tefillin, Rosh Chodesh, Sefirat HaOmer
- Prayer texts (Ashkenaz, Sfarad, Mizrachi nusachim)
- Qibla compass
- English and Hebrew UI
