# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Native Fresh Start Command Center client with forms and electronic signatures"
HOMEPAGE="https://thefreshstartcenterco.org"
SRC_URI="${PF}.tar.xz"

# Private, immutable source snapshot of the validated 0.2.0 working tree.
# No source or credential is fetched from the Command Center server.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="fetch !test? ( test )"

RDEPEND="
	>=dev-libs/qindatk-0.1.0-r19:0=
	>=dev-qt/qtbase-6.8:6=[dbus,gui,network,ssl,widgets]
	>=dev-qt/qtdeclarative-6.8:6=[widgets]
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( README.md SECURITY.md docs/NATIVE-FORMS.md )

pkg_nofetch() {
	einfo "Obtain the immutable ${PF}.tar.xz archive from qinda with qinda-sync."
}

src_configure() {
	local mycmakeargs=(
		-DFSCC_NATIVE_BUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software cmake_src_test
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Launch FSCC Desktop from the application menu or run /usr/bin/fscc-native."
	elog "This experimental client is for synthetic data only."
}
