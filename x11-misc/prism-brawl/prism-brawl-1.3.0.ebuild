# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake xdg git-r3
DESCRIPTION="Qinda Prism Brawl with the rigged Qind Qompany crew on seven arenas"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/screensaver-suite.git"
EGIT_BRANCH="rigged-crew-1.3.0"
EGIT_COMMIT="60c05cea6752e1908ff7caacd312e77eb6198956"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"
S="${EGIT_CHECKOUT_DIR}/prism-brawl"
# The rigged crew assets live in the checkout's sibling common/ directory.
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
