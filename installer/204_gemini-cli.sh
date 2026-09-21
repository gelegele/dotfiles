#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/sub_load_nvm.sh"

echo "Installing @google/gemini-cli..."
npm install -g @google/gemini-cli

echo "Done. gemini $(gemini --version)"
