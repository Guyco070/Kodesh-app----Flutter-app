---
name: widget-reuse
description: Before creating any new widget, helper or screen in Kodesh, search the existing catalog and code for something that already does the job and reuse or extend it instead of duplicating. Use whenever about to write a new Widget class, a date/format helper, a list/card/section layout, a search bar, a scaffold or an info page.
---

# Reuse before you write

Duplicated widgets drift apart: one copy gets the accessibility or RTL fix and the
other doesn't. Before writing a new class, do these steps.

## 1. Look it up

1. Read [CATALOG.md](CATALOG.md) — every shared widget, animation and helper with
   what it's for.
2. Search the code for what you're about to build, by purpose and by Flutter building
   block:

   ```bash
   grep -rn "class .* extends \(StatelessWidget\|StatefulWidget\)" lib/ | grep -i "<word>"
   grep -rln "<FlutterWidgetYouWouldUse>" lib/widgets lib/screens   # e.g. SearchBar, ExpansionTile, Card
   grep -rn "DateFormat\|Duration(days" lib/helpers
   ```

3. Look at a screen that already does something similar and copy its pattern, not
   its code: info pages use `InfoPageBody`, filtered lists use `SearchFilterBar`,
   every screen uses `CustomAppBar` (main screen `DefaultScaffold`).

## 2. Decide

| Found | Do |
|---|---|
| A widget that does exactly this | Use it. |
| One that does almost this | Add an optional parameter with a default that keeps current behaviour. Update its doc comment. Check all call sites still look the same. |
| The same UI written inline in 2+ places (yours would be the 3rd) | Extract it into `lib/widgets/` first, switch the existing places to it, then use it. |
| Nothing | Write a new widget following the `code-standards` skill. |

Don't add a parameter that turns a widget into two widgets behind a flag (`isCompact`,
`mode`) when the two cases share little. Write a second widget then, and say in both doc
comments when to use which.

## 3. Keep the catalog true

When you add, rename, move or delete a shared widget or helper, update `CATALOG.md` in
the same commit: one line with path, name and when to use it. Give every shared widget a
`///` doc comment on the class saying what it's for and when not to use it.
Sub-widgets that live in a parent's folder (`lib/widgets/<parent>/...`) are private to
that parent. List them under the parent, and don't import them from elsewhere; promote
them to `lib/widgets/` first if they're needed elsewhere.

## Known duplicates to consolidate when touched

- `AnimatedEventsListView`, `AnimatedOnlyShabatListView` and `AnimatedZmanimList` are
  three versions of "list whose items slide in". `AnimatedZmanimList` (keyed, no
  re-animation on filter) is the one to converge on.
- `DateWithTimeLeft` and `TimeLeft` both show time remaining. Use `DateWithTimeLeft`
  unless you need only the countdown.
- `ViewTypeTab` and the nusach buttons in `Tfilot.getNosahim` are the same segmented
  "pick one" control. A shared `SegmentedChoice` would replace both.
- `CuperinoTextCheckSwitch` (sic) and `SettingsFilterChip` are both on/off toggles with
  a label: chip for display filters, switch for settings.
