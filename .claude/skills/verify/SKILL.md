---
name: verify
description: Run the full local check (gen-l10n, format, analyze, unit tests, web build) before committing, pushing, merging or deploying Kodesh. Use whenever code changed and before /deploy-dev.
---

# Verify Kodesh before it leaves your machine

CI only formats and analyzes on `master`, and the Pages deploy only builds. Branches
have reached `dev-deployed` with compile errors because nothing ran on them. Run this
before every push, merge or deploy.

## Steps

Run from the repo root, in order. Stop at the first failure, fix it, and start again.

```bash
flutter pub get
flutter gen-l10n                      # regenerates lib/api/l10n/app_localizations*.dart from the ARB files
dart format lib/ test/                # writes changes; commit them
flutter analyze --fatal-warnings      # infos are tolerated, warnings and errors are not
flutter test test/unit/
flutter build web --release --base-href /   # catches web-only compile errors (dart:io, js interop)
```

Or run everything with one script:

```bash
tool/verify.sh
```

## Reading the results

- **analyze**: `flutter analyze` exits non-zero even for `info` lines. Only `error •` and
  `warning •` lines block. Don't "fix" infos as part of unrelated work.
- **gen-l10n changed files**: commit the regenerated `app_localizations*.dart` together
  with the ARB change, never separately.
- **build web fails but analyze passes**: usually a name clash or a native-only import.
  Known one: `package:intl/intl.dart` exports its own `TextDirection`. Import it as
  `import 'package:intl/intl.dart' show DateFormat;` in widget files.
- **Android/iOS**: this does not build the native apps. Before a store release also run
  `flutter build appbundle` and `flutter build ipa` (see the `release-check` skill).

## When done

Report: pass/fail per step, and for failures the exact error lines with file:line.
Never claim something passed without having run it.
