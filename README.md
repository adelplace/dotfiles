# dotfiles

Setup for a fresh [Omarchy](https://omarchy.org) install: packages, configs (stow), mise tools, services.

## Bootstrap

```bash
git clone git@github.com:adelplace/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

The script is idempotent. Run a single step with `./install.sh packages|stow|mise|services`.

Files that would be overwritten by a symlink are moved to `~/.dotfiles-backup/<date>/`.

## Packages

Lists live in `packages/`, one entry per line, `#` comments allowed:

| File | Installed with |
| --- | --- |
| `pacman.txt` | `pacman` (only what Omarchy does not already ship) |
| `aur.txt` | `yay` |
| `flatpak-remotes.txt` / `flatpak.txt` | `flatpak` (`application origin`) |
| `pnpm-global.txt` | `pnpm add -g` |
| `services-system.txt` / `services-user.txt` | `systemctl enable --now` |

Add a line by hand, or regenerate everything from the current machine and review the diff:

```bash
./scripts/dump-packages.sh && git diff packages/
```

Tool versions managed by mise are in `mise/.config/mise/config.toml`.
