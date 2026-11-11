---
name: code-standards
description: Coding standards for writing or reviewing Flutter/Dart code in Kodesh - structure, localization, RTL, accessibility, theming, web/native differences, state and async. Use before writing any new widget, screen, provider or helper, and when reviewing a change.
---

# Kodesh code standards

These come from bugs this codebase actually had. Follow them for new code; fix old code
only when you are already changing it for another reason.

Before creating any widget, run the `widget-reuse` skill first.

## Structure

- **One public widget per file**, `snake_case.dart`. A sub-widget used only by one
  parent goes in a folder named after the parent:
  `lib/widgets/settings_bar/settings_filter_chip.dart` for `SettingsBar`.
- **Extract sub-widgets as classes**, not `Widget _buildX()` methods. Classes get their
  own `build`, can be `const`, and don't rebuild with the parent.
- Where things live: screens `lib/screens/`, reusable widgets `lib/widgets/`,
  animations `lib/animations/`, models `lib/models/`, state `lib/providers/`, pure
  helpers `lib/helpers/`, platform services `lib/services/`, static content `lib/data/`,
  constants/config `lib/config/`.
- Keep `build()` free of side effects: no fetching, no provider creation, no
  `SharedPreferences` writes. Start loads in `initState` (with
  `addPostFrameCallback` if you call `setState`) or in the provider.
- Explicit return types on every function and method, including `static` ones.
  `dynamic` return types hid a null bug that broke the web build.

## Text, language and direction

- No hardcoded UI text. Use the `add-string` skill: key in all four ARB files.
- Format dates and times with the locale, never by hand:
  `DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toLanguageTag())`.
  Don't print ISO strings (`2026-10-25`) to users.
- In widget files import intl as `import 'package:intl/intl.dart' show DateFormat;`.
  A plain import brings in intl's `TextDirection` and breaks `TextDirection.rtl`.
- Locales are language-only (`Locale('he')`). A country part ends up in
  `<html lang>` on the web and breaks screen readers.
- Use directional APIs so RTL works without branching: `EdgeInsetsDirectional`,
  `AlignmentDirectional`, `BorderRadiusDirectional`, `PositionedDirectional`.
  Don't branch on `isDirectionRTL` to swap left/right.
- Don't glue a Latin code to Hebrew text ("IL-ירושלים"). Bidi reordering mangles it;
  see `cityDisplayName()` in `lib/helpers/city_display.dart`.
- Hebcal requests pass the UI language (`lg`). Data fetched in the wrong language
  shows English in a Hebrew UI.

## Accessibility (required: IS 5568 / WCAG 2.0 AA)

- Every `IconButton`, `FloatingActionButton` and icon-only control has a `tooltip`
  (it's also the screen-reader label). Generic actions use `MaterialLocalizations`
  (`backButtonTooltip`, `openAppDrawerTooltip`, `deleteButtonTooltip`).
- Custom tappables (`GestureDetector`, painted widgets) get
  `Semantics(button: true, label: ..., onTap: ...)`.
- Decorative images: `Image.asset(..., excludeFromSemantics: true)`. Meaningful
  images: `semanticLabel:`.
- A selected option is **not** a disabled button. Keep `onPressed` and wrap it in
  `Semantics(selected: true, inMutuallyExclusiveGroup: true)`.
  See `ViewTypeTab`.
- On/off options are `FilterChip`/`Switch`/`Checkbox`, never coloured text. Text
  contrast must be at least 4.5:1. Grey (`Colors.grey`) on light grey fails.
- Page titles: wrap in `Semantics(header: true)`. Don't put several interactive
  widgets inside one `ListTile`: it merges them into one node. That's why
  `CustomAppBar` uses `NavigationToolbar`.
- Scroll views that hold only text get `primary: true`, so the keyboard can scroll them.
- Touch targets are at least 48×48 (don't use `MaterialTapTargetSize.shrinkWrap`
  on lone buttons).

## Theme and layout

- Colours come from `Theme.of(context).colorScheme` (`primary`, `onSurfaceVariant`,
  `secondaryContainer`…), not `Colors.blue`/`Colors.grey[600]`, so dark mode and
  contrast work.
- Use `WidgetStatePropertyAll`/`WidgetStateProperty`, not the deprecated
  `MaterialState*`.
- Widths: never `MediaQuery.size.width / n` alone. Clamp it
  (`.clamp(min, max)`), or use `Expanded`/`Flexible`/`Wrap`, and cap reading width
  on desktop (`ConstrainedBox(maxWidth: 720–760)`). Test at 390px wide.
- Avoid fixed heights around text: it gets clipped at larger font sizes and 200% zoom.

## Web vs. native

- Anything native-only (local notifications, compass sensor, `dart:io`) is guarded
  with `kIsWeb` and gets an honest message on the web instead of a control that does
  nothing.
- Conditional imports for platform code: `foo_stub.dart` / `foo_web.dart` /
  `foo_native.dart` (see `lib/services/compass_service*.dart`).
- External links: `url_launcher` `launchUrl(uri, mode: LaunchMode.externalApplication)`.
  Android needs the `https` `<queries>` entry in the manifest (already there).

## State, async and errors

- State lives in the `Provider` `ChangeNotifier`s created in `main()`. Read with
  `context.read<T>()` in callbacks and `context.watch<T>()`/`Provider.of<T>(context)`
  in `build`.
- After every `await` in a widget, check `if (!mounted) return;` before `setState` or
  using `context`.
- Network calls: catch errors, log with `logger.e(..., error: e, stackTrace: st)`, show
  a localized message with a retry. Never `print()`.
- Don't retry deterministic failures (bad arguments, `PlatformException`), only
  transient ones.
- Notification IDs: scheduled reminders use sequential IDs from 0; one-off
  notifications use reserved constants (`NotificationApi.testNotificationId`).

## Done means

- `verify` skill passes (gen-l10n, format, analyze, tests, web build).
- New logic in `lib/helpers` or `lib/providers` has a unit test in `test/unit/`.
- UI changes: run the app (`run-emulator`) and for web changes the `site-audit` skill,
  and look at the result before saying it works.
- Commits: one logical change each, short imperative message, English comments only.
