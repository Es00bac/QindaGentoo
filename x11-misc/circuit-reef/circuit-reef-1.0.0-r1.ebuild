# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Pinned commit of the local checkout (~/work_space/Screensaver/circuit-reef),
# like the other unpublished first-party packages.
inherit cmake xdg git-r3

DESCRIPTION="Circuit Reef - procedural cyberpunk aquarium screensaver for the QindaQt desktop"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/circuit-reef.git
	file:///home/cabewse/work_SPaC3/Screensaver/circuit-reef
	file:///home/cabewse/work_space/Screensaver/circuit-reef"
EGIT_COMMIT="22a3a0118849ae930d43185d50eb540e66fb049e"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=media-libs/libsdl2-2.0.18[wayland]
	x11-libs/cairo
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		# Same as qinda-patrol: reef-core is private, has no install rule, and
		# cmake.eclass's global BUILD_SHARED_LIBS=ON turned it into an
		# uninstalled libreef-core.so the executable could not load.
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_TESTING=OFF
		-DREEF_BUILD_QT=OFF
	)
	cmake_src_configure
}
