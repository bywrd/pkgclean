# Maintainer: Ars <draganarseniy039@gmail.com>
pkgname=pkgclean
pkgver=2.0.1
pkgrel=1
pkgdesc='Interactive terminal tool to uninstall apps and clean leftovers (pacman, apt, dnf)'
arch=('any')
url='https://github.com/bywrd/pkgclean'
license=('MIT')
depends=('bash' 'pacman' 'sudo' 'fzf')
optdepends=(
  'pacman-contrib: paccache for pacman cache cleaning'
  'flatpak: cleaning unused Flatpak runtimes'
)
source=("$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP') # replace with: updpkgsums

package() {
  cd "$pkgname-$pkgver"
  install -Dm755 pkgclean "$pkgdir/usr/bin/pkgclean"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
  install -Dm644 README.ru.md "$pkgdir/usr/share/doc/$pkgname/README.ru.md"
}
