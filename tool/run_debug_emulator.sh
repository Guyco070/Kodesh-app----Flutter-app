#!/usr/bin/env bash
# Runs Kodesh in debug on an Android emulator (default) or the iOS simulator.
# Usage: tool/run_debug_emulator.sh [android|ios]
set -u
cd "$(dirname "$0")/.."
target="${1:-android}"

echo "== Flutter: $(command -v flutter)"
flutter --version | head -1

if [ "$target" = "ios" ]; then
  open -a Simulator
  for _ in $(seq 1 60); do
    flutter devices 2>/dev/null | grep -qi "simulator" && break
    sleep 2
  done
  device=$(flutter devices --machine 2>/dev/null \
    | python3 -c 'import json,sys; d=[x for x in json.load(sys.stdin) if x.get("emulator") and x.get("targetPlatform","").startswith("ios")]; print(d[0]["id"] if d else "")')
else
  if ! flutter devices 2>/dev/null | grep -q "emulator-"; then
    emu_id=$(flutter emulators 2>/dev/null | grep -i "android" | head -1 | awk -F'•' '{gsub(/ /,"",$1); print $1}')
    if [ -z "$emu_id" ]; then
      echo "!! No Android emulator found. Create one in Android Studio > Device Manager."
      exit 1
    fi
    echo "== Launching emulator: $emu_id"
    flutter emulators --launch "$emu_id"
    echo "== Waiting for the emulator to boot..."
    for _ in $(seq 1 90); do
      flutter devices 2>/dev/null | grep -q "emulator-" && break
      sleep 2
    done
  fi
  device=$(flutter devices 2>/dev/null | grep -o "emulator-[0-9]*" | head -1)
fi

if [ -z "${device:-}" ]; then
  echo "!! No $target device came up."
  exit 1
fi

echo "== Running on $device"
flutter pub get
flutter run -d "$device"
