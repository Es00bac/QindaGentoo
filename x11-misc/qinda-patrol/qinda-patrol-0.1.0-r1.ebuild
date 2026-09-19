# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Pinned commit of the local checkout (~/work_space/Screensaver/qinda-patrol),
# like the other unpublished first-party packages.
inherit cmake xdg git-r3

DESCRIPTION="Qinda Patrol - autonomous cyberpunk platformer screensaver for the QindaQt desktop"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/qinda-patrol.git
	file:///home/cabewse/work_SPaC3/Screensaver/qinda-patrol
	file:///home/cabewse/work_space/Screensaver/qinda-patrol"
EGIT_COMMIT="c9f6d9bd44a0696ed77d560d6d774b0cbafa6f89"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# LayerShellQt places one overlay surface per output on Wayland, which is
# how every monitor gets its own scene under the QindaQt compositor.
RDEPEND="
	>=dev-qt/qtbase-6.11:6=[gui,wayland]
	=kde-plasma/layer-shell-qt-6.6.6*:6=
"
DEPEND="${RDEPEND}"
BDEPEND="app-alternatives/ninja"

src_configure() {
	local mycmakeargs=(
		# patrol_core is a private helper library with no install rule and no
		# SONAME discipline. cmake.eclass turns BUILD_SHARED_LIBS on for every
		# package, which built it as a libpatrol_core.so that nothing installs,
		# leaving both executables unable to start. Link it in instead.
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_TESTING=OFF
		-DPATROL_BUILD_DESKTOP=ON
		-DPATROL_BUILD_QUICK=OFF
		-DPATROL_LAYER_SHELL=ON
	)
	cmake_src_configure
}
