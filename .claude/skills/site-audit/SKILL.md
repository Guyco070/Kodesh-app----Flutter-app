---
name: site-audit
description: Audit the Kodesh website page by page in a real browser - screenshots on phone/desktop/200% zoom, accessibility (axe-core, IS 5568 / WCAG AA), console and network errors, keyboard order. Use before deploying to the site, after UI changes, or when asked whether the site is ready.
---

# Site audit

`tool/site_audit/audit.mjs` builds nothing itself: it opens an already-built web app
with Playwright and records what a visitor and a screen reader get. It found the
Hebcal `zip` 404s and a site screen readers couldn't see, so run it before every deploy.

## Run it

**On GitHub (works from anywhere, real network):**

```bash
# Either push the commit to an audit/* branch (works on any branch, any time):
git push -f origin HEAD:audit/$(git branch --show-current | tr / -)
# ...or, once site-audit.yml is on the default branch:
gh workflow run site-audit.yml --ref <branch>

gh run watch $(gh run list --workflow site-audit.yml -L1 --json databaseId -q '.[0].databaseId')
git fetch origin audit-results && git archive origin/audit-results ci-audit-out | tar -x -C /tmp/kodesh-audit
```

**Locally (needs network access to hebcal.com and gstatic.com):**

```bash
flutter build web --release --base-href /
(cd build/web && python3 -m http.server 8080 &)
cd tool/site_audit && npm install && npx playwright install chromium && node audit.mjs
```

## Read the results

Start with `summary.json`. For each run (`<route>__<lang>__<viewport>`):

| Field | Problem when |
|---|---|
| `error` | present: the page didn't load (often a failed web build — check `build.txt`) |
| `failedRequests` | not empty: API calls failing (wrong Hebcal params, CORS) |
| `console` | `error:` / `pageerror:` lines |
| `semanticsNodesBefore` | `0`: screen readers see nothing until they find the hidden "Enable accessibility" button |
| `axe` | any entry. `aria-command-name` = button without label → add `tooltip`/`Semantics(label:)`. `role-img-alt` = image without label → `excludeFromSemantics: true` if decorative, `semanticLabel` if meaningful. |
| `tabOrder` | entries with an empty `label=` are unlabeled controls |
| `html.lang` | must be a plain tag (`he`, `en`) |

Then **look at the screenshots** (Read the PNGs) — at least `home`, `home__zmanim`,
`home__drawer`, every changed screen, and the `zoom200` runs. Check for text clipped or
cut off, rows overflowing the screen edge on `mobile` (390px), unreadable grey-on-grey
text, and mixed-direction text breaking (e.g. "ירושלים-IL").

## Known, accepted findings

- `scrollable-region-focusable` on long text pages and the holiday calendar: Flutter's
  scroll container. Those views use `primary: true` so arrow keys/Page Down scroll them.
  Listed as a known limitation in the accessibility statement.

## Adding screens

New named route → add it to `routes` in `tool/site_audit/audit.mjs`.

## Report

List problems by severity with route, language and viewport, plus the screenshot path.
Don't call the site ready while `error`, `failedRequests` or any non-accepted `axe`
finding remains.
