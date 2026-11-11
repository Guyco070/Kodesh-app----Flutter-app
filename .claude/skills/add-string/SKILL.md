---
name: add-string
description: Add or change a user-facing UI string in Kodesh in all four languages (en, he, es, ru) and regenerate localizations. Use for any new text in a widget, tooltip, snackbar or dialog.
---

# Add a UI string in every language

Kodesh ships English, Hebrew, Spanish and Russian. A key missing from one ARB file
breaks the build, and Spanish and Russian have been forgotten twice. Never inline text
in a widget; never add a key to only some files.

## Where strings go

| Kind of text | Where |
|---|---|
| UI text (labels, tooltips, messages, page titles) | `lib/api/l10n/app_{en,he,es,ru}.arb` |
| Notification text (scheduled in the background, no `BuildContext`) | `lib/api/l10n/reminders_translates.dart`, all four language keys |
| Long page content (About, Accessibility, Privacy) | `lib/data/site_pages_content.dart` |

## Steps

1. **Check it doesn't exist already**: `grep -n '"<key>"\|<the English text>' lib/api/l10n/app_en.arb`.
   Reuse an existing key when the meaning is the same. For generic actions (back, close,
   delete, open menu) use `MaterialLocalizations.of(context)` instead of adding a key.
2. **Add the key to all four ARB files**, at the end, before the closing `}`:
   - `app_en.arb` is the template: add the value **and** an `@key` entry with a
     `description` that says where the text appears.
   - `app_he.arb`, `app_es.arb`, `app_ru.arb`: value only. Write real translations;
     Hebrew must be natural, not a word-for-word copy.
   - Keys are lowerCamelCase and describe meaning, not position (`deleteTask`, not `button3`).
3. **Validate JSON** of all four files (a trailing comma breaks gen-l10n):
   `for f in lib/api/l10n/app_*.arb; do python3 -m json.tool "$f" >/dev/null || echo "BAD $f"; done`
4. **Regenerate**: `flutter gen-l10n`.
5. **Use it**: `AppLocalizations.of(context)!.yourKey`. With placeholders, declare them
   in the `@key` entry (`"placeholders": {"count": {"type": "int"}}`).
6. Commit the four ARB files and the regenerated `app_localizations*.dart` together.

## Rules for the text itself

- Write the label from the user's side: "Previous day", not "Decrement date".
- Every `IconButton` needs a `tooltip` — that is also its screen-reader label.
- Dates and times are never built with string concatenation; use `DateFormat` with the
  locale: `DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toLanguageTag())`.
