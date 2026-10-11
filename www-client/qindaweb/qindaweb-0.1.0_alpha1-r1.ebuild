# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake git-r3 xdg

DESCRIPTION="Experimental native QindaTK browser with Gecko content and global menus"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/QindaWeb.git"
EGIT_BRANCH="feature/native-browser"
EGIT_COMMIT="3f440915750ddafe1703ce60538150e2c9a428ed"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# This installed preview uses ordinary windows. The strict native candidate
# stays .ebuild.in until the desktop's package-owned placement SDK is released.
# No development/staged SDK is linked or installed by this recipe.
# Pin this candidate to the qualified ABI even during package-only builds
# while r17 remains installed. A later ABI requires a revised recipe/rebuild.
RDEPEND="
	>=dev-libs/qindatk-0.1.0-r18:0/18[qindaqt]
	dev-libs/wayland
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,opengl,ssl,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	=dev-qt/qtwayland-6.11.1-r2:6=[qml]
	>=dev-qt/qtwebsockets-6.11:6=
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260927-r7
	kde-plasma/kwayland:6
	sys-apps/dbus
	|| (
		>=www-client/qindafox-bin-155
		>=www-client/firefox-155[wayland]
		>=www-client/firefox-bin-155
	)
"
DEPEND="${RDEPEND}"
BDEPEND="app-alternatives/ninja virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DQINDAWEB_REQUIRE_DESKTOP_SDK=OFF
		-DCMAKE_DISABLE_FIND_PACKAGE_QindaQtApplicationWindowManagement=ON
	)
	cmake_src_configure
}

src_test() {
	# Wayland test sockets include QTemporaryDir's path and must fit sun_path.
	# Portage's T can exceed that limit on an archive-backed build volume.
	local test_tmp
	test_tmp=$(mktemp -d /tmp/qindaweb-test.XXXXXX) || die
	addwrite "${test_tmp}"
	TMPDIR="${test_tmp}" XDG_RUNTIME_DIR="${test_tmp}" \
		QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software cmake_src_test
	rm -rf "${test_tmp}" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Launch QindaWeb from the application menu or run qindaweb."
	elog "Ctrl+Shift+H hides all controls; Ctrl+L temporarily reveals the address field."
	elog "This experimental preview opens ordinary windows."
	elog "Automatic container tabs/splits await the desktop's released placement SDK."
}
