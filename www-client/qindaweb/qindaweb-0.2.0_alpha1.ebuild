# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2026 QindaQt contributors
EAPI=8
inherit cmake git-r3 xdg

DESCRIPTION="Native QindaTK Gecko browser with tablet controls and Qinda integration"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/QindaWeb.git"
EGIT_BRANCH="feature/browser-experience"
EGIT_COMMIT="7ffc3cc69275a2b5faee96bbf04f0e9aa9c4bf4a"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# Consume only package-owned public SDKs. QtWayland r7 preserves the earlier
# keyboard/XR fixes and supplies the qualified touch and clipboard repairs.
RDEPEND="
	>=dev-libs/qindatk-0.1.0-r18:0/18[qindaqt]
	dev-libs/wayland
	x11-libs/libxkbcommon
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,opengl,ssl,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	=dev-qt/qtwayland-6.11.1-r7:6=[qml]
	>=dev-qt/qtwebsockets-6.11:6=
	>=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r13
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
		-DQINDAWEB_REQUIRE_DESKTOP_SDK=ON
	)
	cmake_src_configure
}

src_test() {
	local test_tmp
	test_tmp=$(mktemp -d /tmp/qindaweb-test.XXXXXX) || die
	addwrite "${test_tmp}"
	TMPDIR="${test_tmp}" XDG_RUNTIME_DIR="${test_tmp}" \
		QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software cmake_src_test
	rm -rf "${test_tmp}" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Reopen QindaWeb to use the new browser shell."
	elog "Ctrl+D saves a page; Ctrl+H opens history; Ctrl+Shift+T reopens a page."
	elog "View has touch/tablet controls; Qinda grants per-view agent access."
	elog "Container tabs and splits use the installed public QindaQt SDK."
	elog "Physical pen/touch, IME and other production qualification remain open."
}
