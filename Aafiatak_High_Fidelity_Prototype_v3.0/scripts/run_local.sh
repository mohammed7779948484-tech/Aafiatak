#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
./scripts/build.sh
PORT="${1:-4173}"
echo "Aafiatak High-Fidelity: http://127.0.0.1:${PORT}/?screen=PAT-01&state=patient-populated"
python3 -m http.server "$PORT" --bind 127.0.0.1
