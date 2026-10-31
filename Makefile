VERSION := $(shell sed -n 's/^VERSION="\(.*\)"$$/\1/p' pkgclean)
PREFIX  ?= /usr/local
DESTDIR ?=

.PHONY: install uninstall deb check clean

install:
	install -Dm755 pkgclean $(DESTDIR)$(PREFIX)/bin/pkgclean
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/pkgclean/LICENSE

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/pkgclean
	rm -rf $(DESTDIR)$(PREFIX)/share/licenses/pkgclean

# Syntax check (and shellcheck if installed)
check:
	bash -n pkgclean
	@command -v shellcheck >/dev/null && shellcheck -S warning pkgclean || echo "shellcheck not installed, skipped"

# Build a .deb:  make deb   (needs dpkg-deb)
deb: check
	rm -rf build/deb
	install -Dm755 pkgclean build/deb/usr/bin/pkgclean
	install -Dm644 LICENSE build/deb/usr/share/doc/pkgclean/copyright
	install -Dm644 README.md build/deb/usr/share/doc/pkgclean/README.md
	mkdir -p build/deb/DEBIAN
	sed "s/@VERSION@/$(VERSION)/" packaging/deb-control.in > build/deb/DEBIAN/control
	dpkg-deb --build --root-owner-group build/deb build/pkgclean_$(VERSION)_all.deb
	@echo "Built: build/pkgclean_$(VERSION)_all.deb"

clean:
	rm -rf build
