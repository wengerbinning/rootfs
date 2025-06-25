pkgname='apps'

pkgdesc='These are app manager tools'

arch=('any')
pkgver='0.3'
pkgrel='1'

url='https://github.com/wengerbinning/wengerbinning.git'
license=('GPL')


source=(
	install.awk
	apps.sh
)
sha256sums=(
	'SKIP'
	'SKIP'
)

pkgver() { printf '%s' "${pkgver%.r*}"; }
build() { echo "build"; }
package() {
	test -d ${pkgdir}/usr/lib/apps || install -m 755 -d ${pkgdir}/usr/lib/apps
	install -m 644 ${srcdir}/install.awk ${pkgdir}/usr/lib/apps/install.awk
	#
	test -d ${pkgdir}/usr/bin || install -m 755 -d ${pkgdir}/usr/bin
	install -m 755 ${srcdir}/apps.sh ${pkgdir}/usr/bin/apps
	# install -d  ${pkgdir}/usr/share/bash-completion/completions
	# install -m 644 ${srcdir}/grandstream-bash-completion.sh ${pkgdir}/usr/share/bash-completion/completions/grandstream
}

install="apps.install"
