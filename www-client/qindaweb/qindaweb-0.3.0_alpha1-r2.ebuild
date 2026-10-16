# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2026 QindaQt contributors
EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit cmake git-r3 python-single-r1 xdg

DESCRIPTION="Native QindaTK Gecko browser with tablet controls and Qinda integration"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/QindaWeb.git"
EGIT_BRANCH="feature/browser-reliability"
EGIT_COMMIT="9c162efeb930eeeec7df01d191e188e4fc336745"

LICENSE="GPL-3+ LGPL-2+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

# Public native SDKs only. r8 preserves prior keyboard/touch/clipboard/XR
# fixes and adds opt-in complete pointer frames for precision scrolling.
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/adblock-0.6.0-r1[${PYTHON_USEDEP}]
	')
	>=dev-libs/qindatk-0.1.0-r18:0/18[qindaqt,widgets]
	dev-libs/wayland
	x11-libs/libxkbcommon
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,opengl,ssl,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=
	=dev-qt/qtwayland-6.11.1-r8:6=[qml]
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
BDEPEND="app-alternatives/ninja dev-util/wayland-scanner virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DQINDAWEB_PYTHON="${PYTHON}"
		-DPython3_EXECUTABLE="${PYTHON}"
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
	elog "The shield controls built-in ad/tracker blocking and site exceptions."
	elog "Ctrl+Shift+N opens a private window; Ctrl+O opens a file; F11 toggles fullscreen."
	elog "View has touch/tablet controls; Qinda grants per-view agent access."
	elog "Container tabs and splits use the installed public QindaQt SDK."
	elog "Physical pen/touch, IME and other production qualification remain open."
}
