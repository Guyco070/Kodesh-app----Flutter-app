---
name: release-check
description: Check whether Kodesh is ready to submit to Google Play / the App Store or to publish the website on its own domain, and list exactly what blocks it. Use before any release, version bump or store upload, or when asked "are we ready to release".
---

# Release readiness check

Go through every item, check it in the code (don't assume), and report a table:
item / status (✅ ok, ❌ blocker, ⚠️ should fix) / evidence (file:line or command output).

## 1. Identity and versioning

- [ ] **App ID** is `com.pressondev.kodesh` everywhere and not `com.example.*`:
  `grep -rn "com.example" android ios macos linux --include=*.gradle --include=*.kts --include=*.xml --include=*.pbxproj --include=*.xcconfig --include=CMakeLists.txt`.
  It is final after the first upload — never change it afterwards.
  (Set on branch `release/app-id`; check it has been merged.)
- [ ] **Version** in `pubspec.yaml` bumped: name for users (`1.2.0`), build number
  strictly higher than the last uploaded one (`+3`).
- [ ] `CHANGELOG.md` has an entry for this version.

## 2. Android (Google Play)

- [ ] **Release signing**: `android/app/build.gradle` must not use
  `signingConfigs.debug` for `release`. It should read `android/key.properties`, and
  `key.properties` plus the `.jks` must be in `.gitignore`.
- [ ] **targetSdk / compileSdk** meet Google Play's current requirement (API 36 for new
  apps and updates from Aug 31 2026 — check the current rule online).
- [ ] **Gradle layout**: the declarative `plugins {}` block, not
  `apply from: ".../flutter.gradle"` (removed in current Flutter).
- [ ] **Manifest permissions** for reminders: `POST_NOTIFICATIONS`,
  `SCHEDULE_EXACT_ALARM` (or `USE_EXACT_ALARM` with justification),
  `RECEIVE_BOOT_COMPLETED`, plus the `flutter_local_notifications` receivers
  (`ScheduledNotificationReceiver`, `ScheduledNotificationBootReceiver`). Without them
  reminders silently disappear on Android 13+ and after a reboot.
- [ ] `flutter build appbundle --release` succeeds.

## 3. iOS (App Store)

- [ ] Bundle ID set and a Development Team selected in `ios/Runner.xcodeproj`.
- [ ] `ios/Runner/PrivacyInfo.xcprivacy` exists (required; declare UserDefaults use).
- [ ] `AppDelegate.swift` sets `UNUserNotificationCenter.current().delegate` so
  notifications show while the app is open.
- [ ] Location usage strings in `Info.plist` are present and accurate.
- [ ] Display name (`CFBundleDisplayName`) is final.
- [ ] `flutter build ipa --release` succeeds.

## 4. Content and legal (both stores and the website)

- [ ] **Privacy policy** reachable at a public URL (the site's `#/privacy` page) and
  linked in the store listings.
- [ ] **Accessibility statement** (`#/accessibility`) has real contact details:
  `lib/config/site_contact.dart` must not have empty `email` /
  `accessibilityCoordinatorName`.
- [ ] **Attribution** to Hebcal (CC BY 4.0) and Sefaria on the About page.
- [ ] Store assets: 512×512 icon (not the low-res `assets/logo.jpg`), feature graphic
  1024×500 (Play), screenshots for phone sizes, short and full description in he/en.

## 5. Website on its own domain

- [ ] Repository variable `BASE_HREF` set to `/` (Settings → Variables → Actions).
- [ ] `web/CNAME` contains the domain; DNS records point to GitHub Pages; HTTPS enforced.
- [ ] `index.html` title/description/OG tags are final.
- [ ] Run the `site-audit` skill on the release branch: no load errors, no failed
  requests, no non-accepted axe findings.

## 6. Quality gate

- [ ] `tool/verify.sh` passes on the release branch.
- [ ] Tested on a real device or emulator: reminders fire (use "Send test
  notification"), survive a reboot, location picks the right city, language switching.

## Report

Give the blockers first, each with the concrete fix. Don't mark an item ✅ without
evidence you just collected.
