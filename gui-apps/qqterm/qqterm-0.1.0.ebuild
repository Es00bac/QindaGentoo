# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# git-r3 pulls the pinned release commit from the local development checkout.
# AGENT-NOTE: once the repository is hosted, replace this with a standard
# SRC_URI tarball (the CMake layout stays identical); bump the version and
# commit together and regenerate the Manifest.
inherit cmake xdg git-r3

DESCRIPTION="QQ_Term - modern Qt6 terminal for the QindaQt desktop, one session per window"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/work_SPaC3/QindaQt_Apps"
# v0.1.0
EGIT_COMMIT="78fa9c017ab6a707ff8dc95f2f785ba22cc4fa7a"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# gui-wm/qindaqt-desktop owns the QindaQt global-menu and settings-client
# static archives and headers this app links (no CMake package configs are
# installed for them, hence the find_library use in CMakeLists.txt).
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-qt/qtbase-6.11:6=[dbus,gui,wayland,widgets]
	>=kde-frameworks/kwindowsystem-6.0:6=
	=x11-libs/qtermwidget-2.4*:0=
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
	)
	cmake_src_configure
}
