---
name: pr-review
description: Review a Kodesh pull request or branch before it is merged - correctness, project standards, localization, accessibility, web vs. native, duplicated widgets, tests and build. Use when asked to review a PR, a branch, a diff or "my changes", or before merging into dev-deployed or master.
---

# Review a Kodesh PR

The goal is to catch what would break the app, the website or a store submission before
it's merged. Base every finding on code you actually read and checks you actually ran.

## 1. Get the change

```bash
# A GitHub PR
gh pr view <number> --json title,body,baseRefName,headRefName,files
gh pr diff <number>
gh pr checkout <number>

# A branch (no PR): compare with what it will merge into, usually dev-deployed
git fetch origin
git diff --stat origin/dev-deployed...<branch>
git diff origin/dev-deployed...<branch>
git log --oneline origin/dev-deployed..<branch>
```

Read the PR description and the commit messages to understand what the change should do.
Then read every changed file **in full**, not just the hunks: most bugs here came from
context the diff doesn't show (a nullable return, an import clash, a parent `ListTile`).

## 2. Run the checks

- `tool/verify.sh` on the PR head (see the `verify` skill). A failure is a blocker.
- Merge conflicts: `git merge-tree $(git merge-base origin/dev-deployed HEAD) origin/dev-deployed HEAD | grep -c '<<<<<<<'`.
- UI changes reach the website: run the `site-audit` skill and look at the screenshots of
  the changed screens in Hebrew and English, on mobile.
- Native-only changes (notifications, permissions, Gradle, iOS): run the `run-emulator`
  skill if a device is available. If none is, say it wasn't run.

## 3. Review against this checklist

**Correctness**
- Logic does what the PR says, including edge cases: two-day Rosh Chodesh, Yom Tov
  starting at 00:00, Chol HaMoed, fasts that start the evening before, date crossing
  midnight, DST changes, empty or failed Hebcal responses.
- Nulls: no `!` on data from the network or `SharedPreferences` without a check; explicit
  return types.
- Async: `mounted` checked after every `await` before `setState`/`context`; no
  fire-and-forget futures that can throw unhandled.
- Hebcal and other APIs: correct parameters (`geonameid`, not `zip`; `lg` set to the UI
  language), errors caught and shown with retry.
- Notifications: IDs don't collide, past dates skipped, nothing scheduled on web.

**Project standards** — follow the `code-standards` skill: one widget per file,
sub-widgets in the parent's folder, no `_buildX()` methods, theme colours,
`WidgetState*`, directional insets, `logger` instead of `print`, English comments.

**Duplication** — follow the `widget-reuse` skill: is there already a widget or helper in
`.claude/skills/widget-reuse/CATALOG.md` that does this? If the PR adds or moves a
shared widget, did it update `CATALOG.md`?

**Text and language**
- New text is in all four ARB files (`en`, `he`, `es`, `ru`) and the generated
  `app_localizations*.dart` were regenerated in the same PR.
- Real translations, natural Hebrew; no hardcoded strings in widgets.
- Dates/times formatted with `DateFormat` and the locale; no Latin code glued to Hebrew.

**Accessibility (IS 5568 / WCAG AA)** — every icon button has a `tooltip`, custom
tappables have `Semantics`, decorative images are excluded, selected ≠ disabled, contrast
at least 4.5:1, nothing clipped at 390px or 200% zoom.

**Web vs. native** — native-only APIs guarded with `kIsWeb` and an honest web message;
no `dart:io` in code that compiles for web.

**Tests** — new logic in `lib/helpers` / `lib/providers` / `lib/models` has unit tests in
`test/unit/`; changed behaviour has its tests updated, not deleted.

**Release impact** — changes to `pubspec.yaml`, `android/`, `ios/`, `web/index.html`,
`.github/workflows/`: new permissions declared and justified, app ID untouched, no secrets
or keystores committed, deploy workflow still builds with the right `--base-href`.

**Scope** — one logical change per commit; no unrelated reformatting, debug leftovers,
commented-out code or local files (`.claude/settings.local.json`, `*.command`).

## 4. Report

Start with a one-line verdict: **Approve**, **Approve with nits**, or **Changes requested**.

Then the findings, most severe first, each with:
- severity: **Blocker** (breaks build, app, site, data or a store requirement) /
  **Should fix** (bug risk, standards, accessibility, missing test) / **Nit**
- `file:line`
- what's wrong, and a concrete fix (a short code snippet when it helps)

Then what you ran and the results (verify, audit, emulator, or "not run because …").
Mention what's good only where it matters for the decision.

Don't invent problems to fill the list. If there are no findings, say so.

## 5. Posting to GitHub (only when asked)

```bash
gh pr review <number> --comment --body-file review.md          # general review
gh pr review <number> --request-changes --body-file review.md  # when there are blockers
```

Never approve or merge on the user's behalf unless they ask.
