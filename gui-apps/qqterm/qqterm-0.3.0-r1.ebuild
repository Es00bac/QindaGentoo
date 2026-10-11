# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg git-r3

DESCRIPTION="QQ_Term - QindaTK terminal for the QindaQt desktop, one session per window"
HOMEPAGE="https://github.com/Es00bac/QindaQt_Apps"
# Read the published hub, or its refreshed laptop bare mirror. Never install
# source from a working checkout.
EGIT_REPO_URI="file:///home/cabewse/git/QindaQt_Apps.git"
# 0.3.0: exact cell rendering and styled history, selection/search/export,
# negotiated terminal input, IME, profile validation and PTY/window cleanup.
EGIT_COMMIT="0c879058ac3abb97096559be0872db7853ca0b4c"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# The desktop owns the QindaQt.Tokens QML module and global-menu archives.
# Qt private headers require slot operators so Qt updates rebuild the app.
# A compact CJK font provides fallback for double-width terminal glyphs.
# Bind future toolkit ABI changes to a Portage rebuild. Source is unchanged.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-libs/qindatk-0.1.0-r18:0=
	>=dev-qt/qtbase-6.11:6=[dbus,gui,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	>=kde-frameworks/kwindowsystem-6.0:6=
	media-fonts/wqy-microhei
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	test? (
		>=dev-lang/python-3.11
		dev-libs/glib:2
		sys-apps/dbus
	)
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software cmake_src_test
}
