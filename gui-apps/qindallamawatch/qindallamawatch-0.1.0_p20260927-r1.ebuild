# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg git-r3

DESCRIPTION="QindaLlamaWatch - live QindaTK monitor for a remote llama.cpp server"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# The hub on qinda is read first; the laptop keeps a bare mirror at the same
# path, fast-forwarded from qinda before an emerge.
EGIT_REPO_URI="file:///home/cabewse/git/QindaLlamaWatch.git
	file:///home/cabewse/work_SPaC3/QindaLlamaWatch
	file:///home/cabewse/work_space/QindaLlamaWatch"
# AGENT-NOTE: pin the reviewed commit here and bump the revision with it;
# an unpinned git-r3 ebuild builds whatever the hub holds.
# cbacd612: first release; verified built, 16 unit tests passing, and run
# live against qinda's qinda-llm.service (router, ornith).
# r1 (e39db7c): Recent requests reads request timings from the whole boot,
# so they no longer scroll out of the backlog during long prompt reads.
EGIT_COMMIT="e39db7c6b9bac13ca19632682990a2b3c141f731"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# gui-wm/qindaqt-desktop owns the AppShell and global-menu archives and
# headers this app links (no CMake package configs, hence find_library in
# CMakeLists.txt). dev-libs/qindatk is a runtime QML import only.
# net-misc/openssh: host telemetry and the journal are read over `ssh`.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	>=dev-libs/qindatk-0.1.0-r12
	net-misc/openssh
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
