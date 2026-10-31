# pkgclean

Interactive terminal tool for Arch Linux: pick an app from a list (no need to
remember package names) and remove it the way you want.

## Features

- List of installed packages sorted by size, with live preview (fzf)
- Multi-select with Tab
- Removal modes: `-R`, `-Rs`, `-Rns`, or **full** (package + leftovers in
  `~/.config`, `~/.cache`, `~/.local/share`, ...)
- Dry-run: see what would be removed
- Orphan packages cleanup
- Cache cleanup: pacman, yay/paru, systemd journal, Flatpak

## Install

From the AUR:

```bash
yay -S pkgclean
```

Manually:

```bash
git clone https://github.com/bywrd/pkgclean
cd pkgclean
sudo install -Dm755 pkgclean /usr/local/bin/pkgclean
```

## Usage

```bash
pkgclean        # only packages you installed yourself
pkgclean -a     # all packages, including dependencies
```

Keys: arrows to move, type to search, `Tab` to select several, `Enter` to
confirm, `Esc` to go back.

## Warning

The "full removal" mode deletes files from your home directory. It shows the
list and asks for confirmation, but read it carefully: matching is done by
package name.

## License

MIT
