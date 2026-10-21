# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
PYTHON_COMPAT=( python3_{13..15} )
inherit desktop python-single-r1 wrapper xdg
DESCRIPTION="Native QindaTK MOSS image studio with remote Vulkan generation"
HOMEPAGE="https://github.com/Es00bac"
SRC_URI="${PF}.tar.xz"
# Application source f0817f9, published through qinda's QindaMOSS Git hub.
S="${WORKDIR}/QindaMOSS"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="fetch !test? ( test )"
RDEPEND="${PYTHON_DEPS}
	>=dev-libs/qindatk-0.1.0-r19:0=
	net-misc/openssh
	$(python_gen_cond_dep 'dev-python/pyqt6[gui,network,qml,quick,${PYTHON_USEDEP}]')"
BDEPEND="${RDEPEND}"
pkg_nofetch() {
	einfo "Fetch the immutable QindaMOSS source archive from qinda using qinda-sync."
}
src_compile() { :; }
src_test() {
	QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software "${EPYTHON}" -m unittest discover -s tests -v || die
	QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software "${EPYTHON}" -m qindamoss --check || die
}
src_install() {
	python_domodule qindamoss
	make_wrapper qindamoss "${EPYTHON} -m qindamoss"
	make_wrapper qindamoss-worker "${EPYTHON} -m qindamoss.worker"
	domenu "${S}/packaging/org.qinda.MOSS.desktop"
	insinto /usr/share/icons/hicolor/scalable/apps
	doins "${S}/packaging/org.qinda.MOSS.svg"
	dodoc README.md docs/capabilities.md
}
pkg_postinst() {
	xdg_pkg_postinst
	elog "Launch QindaMOSS from the Graphics menu or run qindamoss."
	elog "The default SSH host is qinda. On the generation host install:"
	elog "sci-ml/stable-diffusion-cpp sci-ml/moss-image-models."
}
