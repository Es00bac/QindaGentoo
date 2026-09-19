# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake xdg git-r3
DESCRIPTION="Qinda prism-circuit refined native screensaver"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/screensaver-suite.git"
EGIT_COMMIT="9076c73a76ddf1689cd1c613e8a7aac57b846a2b"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"
S="${EGIT_CHECKOUT_DIR}/prism-circuit"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	>=dev-qt/qtbase-6.4:6=[gui,wayland]
	kde-plasma/layer-shell-qt:6=
	>=media-libs/libsdl2-2.0.18[wayland]
	x11-libs/cairo
	virtual/opengl
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
# Portage's configured MAKEOPTS is inherited unchanged.
src_configure() {
 local mycmakeargs=(
  -DBUILD_SHARED_LIBS=OFF
  -DBUILD_TESTING=OFF
 )
 cmake_src_configure
}
