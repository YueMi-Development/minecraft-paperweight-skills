#!/usr/bin/env bash
# Rebuild patch files from subproject commits.
#
# Fails fast if any subproject has uncommitted changes: patch generation only
# picks up committed edits, so uncommitted work would be silently dropped from
# the regenerated patches.
#
# Usage:
#   scripts/rebuild-patches.sh       # rebuild server patches
#   scripts/rebuild-patches.sh api   # rebuild api patches
set -euo pipefail

cd "$(dirname "$0")/.."

task="${1:-server}"
case "$task" in
    server) gradle_task="rebuildAllServerPatches" ;;
    api)    gradle_task="rebuildAllApiPatches" ;;
    *) echo "Unknown task '$task' (expected 'server' or 'api')" >&2; exit 1 ;;
esac

echo "==> Checking subprojects are committed..."
dirty=0
for repo in $(find . -type d -name .git -not -path './.git' 2>/dev/null | sort); do
    dir="$(dirname "$repo")"
    if [[ -n "$(git -C "$dir" status --porcelain)" ]]; then
        echo "!! uncommitted changes in $dir — commit them first" >&2
        dirty=1
    fi
done
if [[ "$dirty" -ne 0 ]]; then
    echo "Aborting: commit subproject changes before rebuilding patches." >&2
    exit 1
fi

echo "==> Running $gradle_task..."
./gradlew "$gradle_task"
