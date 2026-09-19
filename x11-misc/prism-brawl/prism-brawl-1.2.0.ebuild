# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake xdg git-r3
DESCRIPTION="Qinda Prism Brawl with seven arenas and expressive full-body combat"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/screensaver-suite.git"
EGIT_COMMIT="0ced5ea7f5f4b85db60358f829c6c4d7dcc9293e"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"
S="${EGIT_CHECKOUT_DIR}/prism-brawl"
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
