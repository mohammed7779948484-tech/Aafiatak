#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
./scripts/refresh_tsconfig.py >/dev/null
mkdir -p dist
tsc -p tsconfig.json
echo "Build OK"
