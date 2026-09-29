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

DESCRIPTION="QQ_Term - QindaTK terminal for the QindaQt desktop, one session per window"
HOMEPAGE="https://github.com/Es00bac/QindaQt_Apps"
EGIT_REPO_URI="file:///home/cabewse/git/QindaQt_Apps.git"
# 0.2.0 rebuilds the UI on QindaTK (Tk.AppWindow/MenuBar/TerminalView) in
# place of Qt Widgets + qtermwidget6.
EGIT_COMMIT="ac45ccf25dcb309f9df4092822b7731bea8c6dd4"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# gui-wm/qindaqt-desktop publishes the QindaQt.Tokens QML module that
# QindaTK's QindaQtTheme bridge imports (src/bridge/QindaQtTheme.qml on
# dev-libs/qindatk) to follow the desktop's theme; without it that import
# fails outright, so it stays a hard runtime dependency even though nothing
# here links against it anymore (no more global-menu/settings-client static
# archives: the whole UI is QindaTK QML, not Qt Widgets).
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-libs/qindatk-0.1.0-r12
	>=dev-qt/qtbase-6.11:6=[dbus,gui,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
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
