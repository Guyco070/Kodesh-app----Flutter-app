# Kodesh App - Project Summary
**Date:** December 27, 2025

## Overview

**Kodesh** is a comprehensive Jewish lifestyle mobile application built with Flutter/Dart that helps users track important Jewish religious times, events, and observances. The app provides daily schedules for Shabbat (Sabbath) entry/exit times, holiday dates, prayer times, and sends reminders for various Jewish religious practices.

## Purpose and Target Audience

The application serves Jewish users who need to:
- Track Shabbat (Sabbath) entry and exit times based on their location
- Monitor Jewish holidays and their specific observance times
- Receive notifications for religious reminders (tefillin, candle lighting, etc.)
- Access Jewish prayer guides and step-by-step instructions
- Find the direction of prayer (Mizrah/towards Jerusalem) using a compass feature
- View all information in multiple languages (primarily English and Hebrew)

## Technology Stack

### Core Framework
- **Flutter/Dart** - Cross-platform mobile development framework for iOS and Android

### Key Dependencies
- **State Management:** `provider` (v6.0.4)
- **Networking:** `http` (v0.13.5)
- **Notifications:** `flutter_local_notifications` (v12.0.3)
- **Localization:** `intl` (v0.17.0)
- **Data Persistence:** `shared_preferences` (v2.0.15)
- **Time Management:** `timezone` (v0.9.0)
- **Hardware Integration:** `flutter_compass` (v0.7.0)
- **Network Detection:** `internet_connection_checker` (v1.0.0)
- **Reactive Programming:** `rxdart` (v0.27.7)
- **UI Components:** `numberpicker` (v2.1.1), `dropdown_button2` (v1.9.2)

### Development Tools
- `flutter_launcher_icons` - App icon generation
- `flutter_native_splash` - Splash screen generation

## Core Features

### 1. Shabbat & Holiday Times
- Fetches Shabbat entry (candle lighting) and exit (Havdalah) times via Hebcal APIs
- Displays Jewish holiday dates and times with Hebrew date conversion
- Shows weekly Torah portion (parashat hashavua)
- Location-aware: supports 250+ cities worldwide

### 2. Daily Times (Zmanim)
- Sunrise and sunset times
- Prayer times (Shacharit, Mincha, Maariv)
- Halachic times specific to Jewish law
- Automatically updates based on user location

### 3. Smart Reminders System
- **Shabbat reminders:** Prepare appliances, candle lighting time, Havdalah
- **Hanukkah:** Candle lighting reminders
- **Tefillin:** Daily phylacteries reminders
- **Rosh Chodesh:** First day of the month notifications
- **Counting of the Omer:** 49-day count between Passover and Shavuot
- Fully customizable timing and notification content

### 4. Prayer Resources & Guides
- Shabbat candle lighting instructions and blessings
- Hanukkah candle lighting ceremony guide
- Tefillin (phylacteries) donning procedure with visual step-by-step guides
- Havdalah (Sabbath ending) ceremony instructions
- Counting of the Omer daily guide

### 5. Prayer Direction Compass
- Uses device magnetometer to determine prayer direction
- Helps users orient towards Jerusalem for prayer
- Real-time compass display

### 6. Multi-Language Support
- **Active Languages:** English, Hebrew
- **Available (commented out):** Spanish, Russian, Polish, Finnish, Hungarian, Romanian, Ukrainian
- Full app localization including UI and notification content

### 7. Shabbat & Holiday Preparation Checklist
- Interactive checklist for pre-Shabbat/holiday preparations
- Items include: hot plate (blech), samovar, Shabbat clock, candles, air conditioning, phone settings

## External APIs

The app integrates with Hebcal (Hebrew Calendar) REST APIs:

1. **Hebcal Shabbat Times API** - Shabbat candle lighting and Havdalah times
2. **Hebcal Zmanim API** - Daily halachic times (sunrise, sunset, prayer times)
3. **Hebcal Hebrew Date Converter API** - Gregorian to Hebrew calendar conversion

## Data Storage & Persistence

Uses `SharedPreferences` to locally store:
- Selected city and geographic coordinates
- Language preference
- All reminder settings and custom times
- Display preferences (Gregorian vs Hebrew calendar)
- Filter preferences (show only Shabbat, upcoming events only, etc.)
- User's personal checklist state

## Design & User Experience

- **Design System:** Material Design (Flutter Material components)
- **Primary Color:** Dark blue (#0047AE)
- **Animations:** Custom slide-in animations and expanding sections
- **Navigation:** Drawer-based navigation with custom app bar
- **Loading States:** Progress indicators during API data fetching
- **Responsive:** Adapts to different screen sizes and orientations
- **Offline Support:** Internet connection checking with graceful degradation

## Project Structure

```
lib/
├── main.dart                    # App entry point, routing, theme
├── animations/                  # UI animations
├── api/                        # External API integration & notifications
│   ├── notification_api.dart
│   └── l10n/                   # Localization files
├── data/                       # Static data (cities database)
├── helpers/                    # Utility functions
├── models/                     # Data models (Event, Shabat, Holiday, etc.)
├── providers/                  # State management (Provider pattern)
├── screens/                    # Main UI screens
│   └── tefilot/               # Prayer guide screens
└── widgets/                    # Reusable UI components
```

## Recent Development Activity

Based on recent commits (as of January 2025):
- Active maintenance and bug fixes throughout 2023-2025
- Recent focus on holiday widget improvements
- Tefillin reminder handling for special days (Chol HaMoed)
- Version: 1.0.0+1

## Supported Platforms

- **Android:** Full support
- **iOS:** Full support
- Cross-platform codebase with platform-specific notification handling

## Distribution

- Private package (not published to pub.dev)
- Designed for distribution through Google Play Store and Apple App Store

## Summary

Kodesh is a well-architected, feature-rich Jewish calendar and reminder application that successfully combines multiple external APIs, local notification systems, and multi-language support to provide a comprehensive religious observance tracking tool for Jewish users worldwide. The app demonstrates good separation of concerns with its Provider-based state management, clean model layer, and modular screen components.
