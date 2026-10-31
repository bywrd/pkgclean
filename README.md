# pkgclean

[Русская версия](README.ru.md)

Interactive terminal tool to uninstall apps and clean your system. Pick an app
from a list (no need to remember package names) and remove it the way you want:
just the package, with dependencies, or completely with all its leftovers.

Works on **Arch** (`pacman`), **Debian / Ubuntu / Mint** (`apt`) and
**Fedora / RHEL** (`dnf`). The package manager is detected automatically.

## Features

- Installed packages sorted by size (biggest first), with live preview
- Only what you installed yourself by default, `-a` shows everything
- Multi-select with `Tab`
- Removal modes: package only / with unused dependencies / with system configs
- **Full removal**: package + leftovers in `~/.config`, `~/.cache`,
  `~/.local/share`, `~/.local/state`, `~/.var/app`, `~/.name` (you review the list)
- Dry-run: see what would be removed without touching anything
- Unused dependencies (orphans) cleanup
- Cache cleanup: package manager cache, yay/paru, systemd journal, Flatpak

## Install

| Your system | Method | Status |
|---|---|---|
| Debian / Ubuntu / Mint | `.deb` from Releases | available |
| Any distro | `make install` from source | available |
| Arch Linux | `makepkg -si` from this repo | available |
| Any distro | single file download | available |
| Arch Linux | AUR (`yay -S pkgclean`) | **temporarily unavailable** |
| Fedora | COPR (`dnf copr enable`) | planned |

> **AUR status:** the AUR package is **temporarily unavailable**. Arch has
> closed registration of new AUR accounts for now, so the package cannot be
> published yet. It will appear in the AUR as soon as registration reopens.
> The methods marked "available" work the same way in the meantime.

### Debian / Ubuntu / Mint: `.deb`

Download the `.deb` from the [Releases](https://github.com/bywrd/pkgclean/releases)
page and install it (replace the version with the latest one):

```bash
wget https://github.com/bywrd/pkgclean/releases/download/v2.0.0/pkgclean_2.0.0_all.deb
sudo apt install ./pkgclean_2.0.0_all.deb
```

`apt` pulls in `fzf` and `sudo` automatically. Remove with `sudo apt remove pkgclean`.

### Any distro (including Fedora): from source

```bash
git clone https://github.com/bywrd/pkgclean
cd pkgclean
sudo make install        # installs to /usr/local/bin
```

Uninstall: `sudo make uninstall`. Install elsewhere: `make install PREFIX=~/.local`.
You also need `fzf` (`sudo dnf install fzf` on Fedora; the script offers to install it).

### Arch Linux: build a package from this repo

```bash
git clone https://github.com/bywrd/pkgclean
cd pkgclean
makepkg -si
```

### Single file

```bash
curl -LO https://raw.githubusercontent.com/bywrd/pkgclean/v2.0.0/pkgclean
sudo install -Dm755 pkgclean /usr/local/bin/pkgclean
```

### Coming later

```bash
yay -S pkgclean                      # AUR, when registration reopens
sudo dnf copr enable bywrd/pkgclean  # Fedora COPR
```

## Usage

```bash
pkgclean        # packages you installed yourself
pkgclean -a     # all packages, including dependencies
pkgclean -h     # help
```

Keys: arrows to move, type to search, `Tab` to select several, `Enter` to
confirm, `Esc` to go back. `fzf` is required (the script offers to install it).

## What each backend does

| Action | pacman | apt | dnf |
|---|---|---|---|
| Package only | `-R` | `remove` | `remove` (keeps unused deps) |
| With dependencies | `-Rs` | `remove --auto-remove` | `remove` (cleans unused deps) |
| With system configs | `-Rns` | `purge --auto-remove` | `remove` |
| Dry-run | `-Rnsp` | `-s purge` | `remove --assumeno` |
| Unused deps | `-Qdtq` + `-Rns` | `autoremove --purge` | `autoremove` |

Note: on apt, `--auto-remove` also removes *other* packages that are no longer
needed. Check the list apt shows before confirming.

## Warning

"Full removal" deletes files from your home directory. Leftovers are found by
package name, so for generic names the list may contain unrelated things.
The tool shows the list and asks for confirmation, but read it carefully.
Package removal is always done by your package manager, which asks too.

## Development

```bash
make check    # bash -n + shellcheck (if installed)
make deb      # build .deb into build/
```

Releases: push a tag like `v2.0.1` (after bumping `VERSION` in `pkgclean`).
GitHub Actions checks the script, builds the `.deb` and attaches it to the release.

## License

MIT
