#!/usr/bin/env bash
set -euo pipefail

# Apply stow packages

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT="${SCRIPT_DIR%/scripts}"

echo "Stowing home → ~"
stow -v -t "$HOME" -d "$REPO_ROOT" home

echo "Stowing config → ~/.config"
mkdir -p "$HOME/.config"
stow -v -t "$HOME" -d "$REPO_ROOT" config

echo "Done."


