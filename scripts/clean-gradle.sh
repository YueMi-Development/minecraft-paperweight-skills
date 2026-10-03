#!/usr/bin/env bash
# Clean a corrupt/stale Gradle state and re-apply patches.
#
# Use when applyAllPatches or a build fails with errors about "broken objects",
# a "corrupt ancestor", or a corrupt Gradle cache.
#
# Usage:
#   scripts/clean-gradle.sh          # stop daemon + remove .gradle (then re-apply manually)
#   scripts/clean-gradle.sh --apply  # stop daemon + remove .gradle + ./gradlew applyAllPatches
set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> Stopping Gradle daemon..."
./gradlew --stop || true

echo "==> Removing .gradle folder..."
rm -rf .gradle

case "${1:-}" in
    --apply|-a)
        echo "==> Re-applying all patches..."
        ./gradlew applyAllPatches
        ;;
    *)
        echo "==> Clean. Re-apply patches with: ./gradlew applyAllPatches"
        ;;
esac
