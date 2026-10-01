# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..15} )
inherit python-any-r1 xdg

DESCRIPTION="Supplied source-guided gouache and ink Breeze icon family for QindaQt"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
SRC_URI="${PF}.tar.gz"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"

# AGENT-GUARD: Breeze is only an optional inherited fallback. Adding a Breeze
# package dependency would reintroduce Plasma into a data-only icon family.
RDEPEND="x11-themes/hicolor-icon-theme"
BDEPEND="${PYTHON_DEPS}"

pkg_nofetch() {
	eerror "Obtain the reviewed consolidated ${A} from the qinda distfile hub."
	eerror "The archive retains all eleven supplied ZIP inputs' SHA256 identities"
	eerror "in INPUT-SHA256SUMS and the original complete editable source companion."
	eerror "Do not run the supplied install.sh; this package owns installation."
}

src_prepare() {
	default
	cd theme || die
	"${PYTHON}" verify.py || die "Supplied artwork integrity verification failed"
	[[ $(find 128x128 -type f | wc -l) -eq 7172 ]] || die "Incomplete artwork inventory"
}

src_install() {
	# AGENT-CONTRACT: install the original XDG family identity and artwork bytes;
	# selecting appearance.iconTheme belongs to Settings, never package hooks.
	insinto /usr/share/icons/QindaQt-Breeze-Painted
	doins theme/index.theme
	doins -r theme/128x128

	dodoc PACKAGE-README.txt INPUT-SHA256SUMS
	docinto theme
	local item
	for item in theme/*; do
		[[ ${item} == theme/128x128 ]] && continue
		dodoc -r "${item}"
	done
	docinto .
	dodoc -r source
	# Keep original filenames and bytes, including source archives/manifests.
	# The installer is retained as documentation only and never executed.
	docompress -x /usr/share/doc/${PF}
}
