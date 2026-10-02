#!/usr/bin/env bash
# Set up a fresh Omarchy install: packages, dotfiles, mise tools, services.
# Idempotent: safe to re-run. Usage: ./install.sh [step...]
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG="$DOTFILES/packages"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

STEPS=(packages stow mise services)
# nvim-light is left out: it targets ~/.config/nvim like vim does
STOW_PACKAGES=(bash bin cursor mise tmux vim zellij)

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }

# Print the entries of a list file, without comments and blank lines
list() { [[ -f $1 ]] && sed -e 's/#.*//' -e 's/[[:space:]]*$//' -e '/^$/d' "$1" || true; }

check() {
  [[ $EUID -ne 0 ]] || { warn "Run as your user, not root."; exit 1; }
  # shellcheck disable=SC1091
  [[ "$(. /etc/os-release && echo "$ID")" == omarchy ]] || { warn "This script targets Omarchy only."; exit 1; }
}

step_packages() {
  local missing

  # pacman -T prints the packages that are not installed yet, so sudo is only asked when needed
  mapfile -t missing < <(list "$PKG/pacman.txt" | xargs -r pacman -T || true)
  if ((${#missing[@]})); then
    info "pacman: installing ${missing[*]}"
    sudo pacman -S --needed --noconfirm "${missing[@]}"
  else
    info "pacman: nothing to install"
  fi

  mapfile -t missing < <(list "$PKG/aur.txt" | xargs -r pacman -T || true)
  if ((${#missing[@]})); then
    info "aur: installing ${missing[*]}"
    yay -S --needed --noconfirm "${missing[@]}"
  else
    info "aur: nothing to install"
  fi

  local name url app origin
  while read -r name url; do
    flatpak remote-add --user --if-not-exists "$name" "$url"
  done < <(list "$PKG/flatpak-remotes.txt")

  while read -r app origin; do
    if flatpak info "$app" &>/dev/null; then continue; fi
    info "flatpak: installing $app"
    flatpak install --user -y --noninteractive "${origin:-flathub}" "$app"
  done < <(list "$PKG/flatpak.txt")
}

# Move out of the way any real file that stow would refuse to overwrite
backup_conflicts() {
  local pkg=$1 file target link
  while IFS= read -r -d '' file; do
    target="$HOME/${file#"$DOTFILES/$pkg/"}"
    [[ -e $target || -L $target ]] || continue
    # Already linked by stow, directly or through a folded parent directory.
    # Only the parent is resolved: repo files may themselves be symlinks pointing elsewhere.
    [[ "$(realpath "$(dirname "$target")")" == "$DOTFILES"/* ]] && continue
    if [[ -L $target ]]; then
      link="$(readlink "$target")"
      [[ $link == /* ]] || link="$(dirname "$target")/$link"
      [[ "$(realpath -ms "$link")" == "$DOTFILES"/* ]] && continue
    fi
    mkdir -p "$BACKUP/$(dirname "${target#"$HOME/"}")"
    mv "$target" "$BACKUP/${target#"$HOME/"}"
    warn "moved $target to $BACKUP"
  done < <(find "$DOTFILES/$pkg" \( -type f -o -type l \) -print0)
}

step_stow() {
  local pkg opts
  for pkg in "${STOW_PACKAGES[@]}"; do
    [[ -d "$DOTFILES/$pkg" ]] || continue
    opts=()
    if [[ $pkg == cursor ]]; then
      # Link only the versioned files, so Cursor's runtime state stays out of the repo
      if [[ -L "$HOME/.config/Cursor" ]]; then
        warn "cursor: ~/.config/Cursor is a symlink to the whole directory, left as is"
        continue
      fi
      opts+=(--no-folding)
    fi
    backup_conflicts "$pkg"
    stow --dir "$DOTFILES" --target "$HOME" --restow "${opts[@]}" "$pkg"
    info "stow: $pkg"
  done
}

step_mise() {
  info "mise: installing tools"
  mise install

  local pnpm_globals
  mapfile -t pnpm_globals < <(list "$PKG/pnpm-global.txt")
  if ((${#pnpm_globals[@]})); then
    info "pnpm: installing global packages"
    mise exec -- pnpm add -g "${pnpm_globals[@]}"
  fi
}

step_services() {
  local unit
  while read -r unit; do
    systemctl is-enabled --quiet "$unit" 2>/dev/null && continue
    info "systemd: enabling $unit"
    sudo systemctl enable --now "$unit"
  done < <(list "$PKG/services-system.txt")

  while read -r unit; do
    systemctl --user is-enabled --quiet "$unit" 2>/dev/null && continue
    info "systemd (user): enabling $unit"
    systemctl --user enable --now "$unit"
  done < <(list "$PKG/services-user.txt")

  if getent group docker >/dev/null && ! id -nG "$USER" | grep -qw docker; then
    info "adding $USER to the docker group (log out and back in to apply)"
    sudo usermod -aG docker "$USER"
  fi
}

main() {
  check
  (($#)) || set -- "${STEPS[@]}"

  local step failed=()
  for step in "$@"; do
    if ! declare -F "step_$step" >/dev/null; then
      warn "unknown step: $step (available: ${STEPS[*]})"
      exit 1
    fi
    info "[$step]"
    # Subshell keeps set -e active inside the step while letting the others run
    (set -e; "step_$step") || failed+=("$step")
  done

  echo
  if ((${#failed[@]})); then
    warn "failed steps: ${failed[*]}"
    exit 1
  fi
  info "done: $*"
  cat <<'EOF'

Still manual:
  - SSH key for GitHub, then: gh auth login
  - gcloud auth login
  - 1Password sign-in
  - personal scripts in ~/.local/bin that are not in this repo (corpvpn, ...)
EOF
}

main "$@"
