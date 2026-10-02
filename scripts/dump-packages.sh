#!/usr/bin/env bash
# Regenerate packages/*.txt from what is installed on this machine.
# Review the diff before committing: lists are meant to be hand-editable.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$DOTFILES/packages"
OMARCHY_LISTS=(/usr/share/omarchy/install/*.packages)

# Hardware/boot specific or provided by Omarchy itself: never part of the lists
EXCLUDE_PACMAN=(linux linux-headers grub efibootmgr intel-ucode acpica omarchy omarchy-keyring omarchy-settings flatpak)
EXCLUDE_AUR=(yay-gzip-fix-debug)

mkdir -p "$OUT"

strip_comments() { sed -e 's/#.*//' -e 's/[[:space:]]*$//' -e '/^$/d' "$@"; }

comm -23 \
  <(pacman -Qqen | sort) \
  <({ strip_comments "${OMARCHY_LISTS[@]}"; printf '%s\n' "${EXCLUDE_PACMAN[@]}"; } | sort -u) \
  >"$OUT/pacman.txt"

comm -23 \
  <(pacman -Qqem | sort) \
  <(printf '%s\n' "${EXCLUDE_AUR[@]}" | sort -u) \
  >"$OUT/aur.txt"

if command -v pnpm >/dev/null; then
  pnpm ls -g --depth 0 --json | jq -r '.[0].dependencies // {} | keys[]' >"$OUT/pnpm-global.txt"
fi

wc -l "$OUT"/*.txt
