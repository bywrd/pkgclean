Name:           pkgclean
Version:        2.1.0
Release:        1%{?dist}
Summary:        Interactive terminal uninstaller and system cleaner

License:        MIT
URL:            https://github.com/bywrd/pkgclean
Source0:        %{url}/archive/refs/tags/v%{version}.tar.gz#/%{name}-%{version}.tar.gz
BuildArch:      noarch

Requires:       bash
Requires:       fzf
Requires:       sudo
Suggests:       flatpak

%description
Pick an app from a list (no need to remember package names) and remove it
with or without its leftovers. Also cleans unused dependencies and caches.
Supports pacman, apt and dnf.

%prep
%autosetup

%build
# nothing to build

%install
install -Dm755 pkgclean %{buildroot}%{_bindir}/pkgclean

%files
%license LICENSE
%doc README.md README.ru.md
%{_bindir}/pkgclean

%changelog
* Sun Nov 01 2026 Ars <draganarseniy039@gmail.com> - 2.1.0-1
- Add Flatpak, Snap, pipx, pip, npm, cargo and AppImage support
- Add big files finder, folder browser, container cleanup, old kernels and logs

* Sun Nov 01 2026 Ars <draganarseniy039@gmail.com> - 2.0.1-1
- Initial package
