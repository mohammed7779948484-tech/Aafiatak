#!/usr/bin/env bash
set -euo pipefail

flutter --version
flutter pub get
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
