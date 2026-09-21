# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# git-r3 pulls the pinned release commit from the published bare repository,
# never from a working tree: a dirty checkout would make the build
# unreproducible.
# AGENT-NOTE: the repository is public at github.com/Es00bac/QindaQt_Apps, so
# this can become a standard SRC_URI tarball once releases are tagged there
# (the CMake layout stays identical); bump the version and commit together and
# regenerate the Manifest.
inherit cmake xdg git-r3

DESCRIPTION="QQ_Term - modern Qt6 terminal for the QindaQt desktop, one session per window"
HOMEPAGE="https://github.com/Es00bac/QindaQt_Apps"
EGIT_REPO_URI="file:///home/cabewse/git/QindaQt_Apps.git"
# 0.1.0 plus the XTerm-compatible `-e PROGRAM ARG...` form the desktop's
# Terminal=true launch policy needs (container-wm ADR-0222).
EGIT_COMMIT="b6df3d2b342b11ffd0b022e358830c99b4f4fb5a"

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
