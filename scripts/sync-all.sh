#!/bin/bash
# Sync all submodules to latest from their respective remotes
# Usage: ./scripts/sync-all.sh [module-name]
#   No args   = sync all modules
#   With arg  = sync specific module (aem-marketing, aem-advise, aem-lifeportal)

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

MODULES=("aem-marketing" "aem-advise" "aem-lifeportal")

sync_module() {
    local module="$1"
    echo "--- Syncing $module ---"
    cd "$REPO_ROOT/$module"
    git fetch origin
    git checkout master
    git pull origin master
    cd "$REPO_ROOT"
    git add "$module"
    echo "    $module synced to $(cd $module && git rev-parse --short HEAD)"
}

if [ -n "$1" ]; then
    sync_module "$1"
else
    for mod in "${MODULES[@]}"; do
        sync_module "$mod"
    done
fi

if ! git diff --cached --quiet; then
    echo ""
    echo "Changes detected. Committing..."
    git commit -m "sync: update submodule references"
    echo "Done. Run 'git push' to push to remote."
else
    echo ""
    echo "All submodules already up to date."
fi
