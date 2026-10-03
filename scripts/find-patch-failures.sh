#!/usr/bin/env bash
# After a failed ./gradlew applyAllPatches, pinpoint where it broke:
#   - rejected hunk files (*.rej) that need manual application
#   - files with unresolved conflict markers (<<<<<<<)
#   - subproject git repos with uncommitted/dirty state
#
# Run from the root project. Reports only; never modifies anything.
set -uo pipefail

cd "$(dirname "$0")/.."

echo "==> Rejected hunk files (*.rej):"
rej="$(find . -name '*.rej' -not -path './.git/*' 2>/dev/null)"
if [[ -n "$rej" ]]; then
    echo "$rej"
else
    echo "(none)"
fi

echo
echo "==> Unresolved conflict markers (<<<<<<<):"
markers="$(grep -rln '^<<<<<<<' \
    --include='*.java' --include='*.kt' --include='*.kts' --include='*.gradle' \
    --exclude-dir=.git . 2>/dev/null)"
if [[ -n "$markers" ]]; then
    echo "$markers"
else
    echo "(none)"
fi

echo
echo "==> Subproject git repos with uncommitted changes:"
found=0
for repo in $(find . -type d -name .git -not -path './.git' 2>/dev/null | sort); do
    dir="$(dirname "$repo")"
    dirty="$(git -C "$dir" status --porcelain)"
    if [[ -n "$dirty" ]]; then
        echo "--- $dir ---"
        echo "$dirty"
        found=1
    fi
done
if [[ "$found" -eq 0 ]]; then
    echo "(all clean)"
fi
