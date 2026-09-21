#!/usr/bin/env bash
set -euo pipefail

# for GAS development
. "$(dirname "$0")/sub_load_nvm.sh"

echo "Installing @google/clasp..."
npm install -g @google/clasp

echo "Done. clasp $(clasp --version)"
