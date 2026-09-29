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
# place of Qt Widgets + qtermwidget6, then restores global menu export
# (a from-scratch QmlMenuSource) and per-window transparency.
EGIT_COMMIT="4df7a231e6f29f7ae3f0e696c6f6b08767e5631f"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# gui-wm/qindaqt-desktop publishes the QindaQt.Tokens QML module the
# QindaQtTheme bridge imports (theme following) and the global-menu
# protocol/exporter/dbusmenu static archives (menu export, via a from-scratch
# QmlMenuSource -- this app never links the Qt Widgets adapter, since the
# menu bar is QindaTK QML, not QMenuBar). dev-qt/qtdeclarative also carries
# the QtQuickTemplates2 private headers QmlMenuSource walks the menu tree
# through. kwindowsystem is blur-behind for translucent profiles.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-libs/qindatk-0.1.0-r12
	>=dev-qt/qtbase-6.11:6=[dbus,gui,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	>=kde-frameworks/kwindowsystem-6.0:6=
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
