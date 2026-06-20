# Zmanim Display Mode + Search Fix — Design

Date: 2026-06-20

## Problem

The zmanim ("times of day") view on `EventScreen` has three issues:

1. **No control over description display.** Each zman's description is collapsed by
   default and only expands on tap. Users want to choose how descriptions are shown.
2. **Search filtering is broken.** After a recent fix that removed
   `ValueKey(query)` from the animated list, typing in the search box no longer
   filters the list. Root cause: `AnimatedTimesListView` snapshots `widget.widgets`
   into an internal `_list` once in `initState` and never reacts to changes
   (no `didUpdateWidget`). The old `ValueKey` "worked" only by destroying and
   rebuilding the whole list on every keystroke — which is exactly what caused the
   entry animations to replay.
3. **Collapsed descriptions cut at a fixed 30 characters** mid-text instead of
   showing a full single line.

## Goals

- Add a control next to the zmanim search field to pick a description display mode.
- Fix search so it filters the list without replaying the entry animation.
- When collapsed, show one full line (ellipsis only if it overflows), not a fixed cut.

## Non-Goals

- No changes to the events view or its animation widgets.
- No change to the zmanim data fetching / parsing.

## Display Modes

New enum `ZmanimDisplayMode`:

| Mode | Behavior |
|---|---|
| `multiExpand` (default) | All collapsed; tapping a row toggles it; multiple can stay open. Matches current de-facto behavior. |
| `singleExpand` | All collapsed; tapping a row expands it and collapses any previously expanded row (only one open at a time). |
| `expandedByDefault` | All rows expanded on load; tapping a row collapses it. |

Default on first run: `multiExpand`.

## Architecture

### 1. Persisted setting — `Events` provider

`Events` already manages display toggles (`isHebrewDate`, `isOnlyShabat`,
`isTodayTimesFromNow`) persisted via `SharedPreferences`. Add the mode there:

- Field `ZmanimDisplayMode _zmanimDisplayMode` + getter `zmanimDisplayMode`.
- `updateZmanimDisplayMode(ZmanimDisplayMode mode)` — sets, persists, `notifyListeners()`.
- Load/save in `getData()` and the save path, stored as the enum index (int).

The enum lives in its own file `lib/models/zmanim_display_mode.dart`.

### 2. Expansion state — `EventScreen` (transient, not persisted)

Which rows are currently expanded is transient UI state, kept in `_EventScreenState`:

- Unique key per zman: `'${z.title}_${z.date.toIso8601String()}'` (the same title
  recurs for yesterday/today/tomorrow, so title alone is not unique).
- A `Set<String> _expandedKeys` holds explicitly-expanded keys.
- `isExpanded(key)` is derived from the mode:
  - `multiExpand` / `singleExpand`: expanded iff key ∈ `_expandedKeys`.
  - `expandedByDefault`: expanded iff key ∉ `_expandedKeys` (the set tracks
    explicit collapses).
- Tap handler `_toggleZman(key)`:
  - `singleExpand`: clears the set, then adds the key if it was not the only member.
  - `multiExpand` / `expandedByDefault`: toggles key membership.
- When the mode changes, `_expandedKeys` is cleared so the new mode starts from its
  natural default.

### 3. Mode picker UI

The search field row becomes a `Row`: the existing `TextField` (Expanded) plus a
trailing `PopupMenuButton<ZmanimDisplayMode>` (icon button) listing the three modes
with a check mark on the active one. Selecting an item calls
`updateZmanimDisplayMode` and clears expansion state.

### 4. Animated list rewrite — `AnimatedZmanimList`

Replace the two identical, snapshot-based widgets
(`AnimatedTimesListView`, `AnimatedFromNowOnTimesListView`, used only in
`EventScreen`) with a single `lib/animations/animated_zmanim_list.dart`:

- Renders a `Column` of children (keeps `shrinkWrap` behavior inside the existing
  `SingleChildScrollView`).
- Each child is wrapped in a small private `_SlideInItem` `StatefulWidget` that runs
  the slide-in animation **once in its own `initState`**, staggered by index.
- Each `_SlideInItem` carries the zman's unique `Key`.
- Because items are keyed, when the parent rebuilds with a filtered list, Flutter
  preserves already-shown items (they do **not** re-animate); only newly-matching
  items run their entry animation. Filtered-out items are removed (no exit
  animation — acceptable for search).

The two old animation files are deleted after the switch.

### 5. Collapsed = one full line — `AnimatedLongText`

`AnimatedLongText` becomes controlled (receives `expanded` instead of managing its
own `_charToView`):

- Collapsed: `Text(text, maxLines: 1, overflow: TextOverflow.ellipsis)`.
- Expanded: `Text(text)` (all lines).
- Wrapped in `AnimatedSize` for a smooth height transition.

This replaces the previous char-by-char "typing" animation with a clean
expand/collapse (the typing effect is incompatible with width-based one-line fit;
approved by the user).

### 6. `ZmanWidget`

- Accepts `bool isExpanded` and `VoidCallback onToggle`.
- The whole `ListTile` is tappable (`onTap: onToggle`) rather than only the subtitle.
- Passes `isExpanded` down to `AnimatedLongText`.

## Localization

Add ARB keys to `app_en.arb` and `app_he.arb` (and run `flutter gen-l10n`):

- `zmanimDisplayModeTooltip` — icon button tooltip.
- `zmanimDisplayMultiExpand`, `zmanimDisplaySingleExpand`,
  `zmanimDisplayExpandedByDefault` — menu item labels.

## Data Flow

1. User picks a mode → `Events.updateZmanimDisplayMode` persists + notifies.
2. `EventScreen.build` reads `events.zmanimDisplayMode`, clears `_expandedKeys` on
   change, builds keyed `ZmanWidget`s with derived `isExpanded` + `onToggle`.
3. Typing in search → `setState(_zmanimSearchQuery)` → filtered widget list →
   `AnimatedZmanimList` rebuilds; kept items don't re-animate, new ones slide in.
4. Tapping a row → `_toggleZman` → `setState` → only that row's `AnimatedLongText`
   animates its size.

## Testing

- Manual: verify each mode's tap behavior, search filtering across modes, collapsed
  one-line rendering, persistence across app restart, RTL (Hebrew) layout.
- `flutter analyze` clean for touched files.
