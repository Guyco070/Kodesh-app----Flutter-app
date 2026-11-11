#!/usr/bin/env bash
# Full local check for Kodesh: l10n, format, analyze, tests, web build.
# Usage: tool/verify.sh            (from the repo root)
set -u
cd "$(dirname "$0")/.."

fail=0
step() {
  local name="$1"; shift
  echo "==> $name"
  if "$@"; then
    echo "    ok"
  else
    echo "    FAILED: $name"
    fail=1
  fi
}

analyze() {
  local out
  out=$(flutter analyze 2>&1)
  echo "$out" | grep -E "^\s*(error|warning) •" && return 1
  echo "$out" | tail -1
  return 0
}

step "pub get"      flutter pub get
step "gen-l10n"     flutter gen-l10n
step "format"       dart format lib/ test/
step "analyze"      analyze
step "unit tests"   flutter test test/unit/
step "web build"    flutter build web --release --base-href /

if [ -n "$(git status --porcelain lib test)" ]; then
  echo "Note: gen-l10n/format changed files. Review and commit them:"
  git status --short lib test
fi

exit $fail
