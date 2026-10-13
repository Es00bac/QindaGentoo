# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit desktop python-single-r1 wrapper xdg

DESCRIPTION="Native TRELLIS.2 image-to-3D client with remote GPU controls and hardware warnings"
HOMEPAGE="https://github.com/pwilkin/trellis.cpp"
# QindaTrellis source 442bce8, shared through qinda's Git hub.
SRC_URI="${PF}.tar.xz"
S="${WORKDIR}/QindaTrellis"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui backend test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="fetch !test? ( test )"
RDEPEND="
	${PYTHON_DEPS}
	net-misc/openssh
	gui? ( $(python_gen_cond_dep '
		dev-python/pyqt6[gui,widgets,opengl,${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	') )
	backend? ( sci-ml/trellis2-cpp-bin )
"
BDEPEND="${PYTHON_DEPS}"

pkg_nofetch() {
	einfo "The immutable QindaTrellis archive is published with its Manifest on qinda."
	einfo "Fetch ${PF}.tar.xz through QindaGentoo's tools/qinda-sync."
}

src_compile() { :; }

src_test() {
	"${EPYTHON}" -m unittest discover -s tests -v || die
	if use gui; then
		QT_QPA_PLATFORM=offscreen XDG_CONFIG_HOME="${T}/ui-config" \
			"${EPYTHON}" tests/ui_check.py || die
	fi
}

src_install() {
	python_domodule qindatrellis
	make_wrapper qindatrellis "${EPYTHON} -m qindatrellis"
	if use gui; then
		make_desktop_entry qindatrellis "QindaTrellis" applications-graphics "Graphics;3DGraphics"
	fi
	dodoc README.md LICENSE
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Launch QindaTrellis from the applications menu or run qindatrellis."
	elog "Install this package on qinda too; select the existing SSH host qinda."
	elog "The backend USE flag adds the generator dependency on the desktop only."
}
