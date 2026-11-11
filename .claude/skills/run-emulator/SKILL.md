---
name: run-emulator
description: Run Kodesh in debug on an Android emulator (or iOS simulator), starting one if needed. Use when asked to run, launch, debug or try the app on a device.
---

# Run Kodesh in debug on an emulator

## Quick start

```bash
tool/run_debug_emulator.sh            # Android emulator (starts one if none is running)
tool/run_debug_emulator.sh ios        # iOS simulator (macOS only)
```

The script: finds a running emulator or launches the first Android AVD, waits for it to
boot, runs `flutter pub get`, then `flutter run` in debug. Keep the terminal open:
`r` = hot reload, `R` = hot restart, `q` = quit.

## Manual steps

```bash
flutter emulators                     # list AVDs
flutter emulators --launch <id>       # start one
flutter devices                       # wait until emulator-5554 (or similar) shows up
flutter run -d emulator-5554
```

## Things that commonly go wrong

- **After switching branches** run `flutter clean && flutter pub get`. Plugins changed
  between branches (geolocator, url_launcher) and stale builds fail with odd Gradle errors.
- **App ID changed** (`com.example.kodesh_app` → `com.pressondev.kodesh` on `release/app-id`):
  the old build stays installed as a separate app. Uninstall it from the emulator.
- **Notifications** need `POST_NOTIFICATIONS` (Android 13+) and exact alarms
  (Android 12+). Use the "Send test notification" button on the reminders screen to check.
- **Location**: set a location in the emulator's Extended Controls → Location, otherwise
  "Use my location" times out.
- **No emulator found**: create one in Android Studio → Device Manager (a Pixel with a
  recent API level).

## When asked to "show" the result

Take a screenshot with `adb exec-out screencap -p > /tmp/kodesh.png` (Android) or
`xcrun simctl io booted screenshot /tmp/kodesh.png` (iOS) and look at it before
describing what the app shows.
