# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Desktop interface for local TRELLIS.2 image-to-3D generation"
HOMEPAGE="https://github.com/pwilkin/trellis.cpp"
SRC_URI="https://github.com/pwilkin/trellis.cpp/releases/download/v${PV}/trellis-studio-linux-x86_64-portable.tar.gz -> ${P}-linux-x86_64.tar.gz"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist strip"
RDEPEND="
	net-libs/webkit-gtk:4.1
	sci-ml/trellis2-cpp-bin
"
QA_PREBUILT="usr/bin/trellis-studio"

src_install() {
	dobin trellis-studio
	make_desktop_entry trellis-studio "Trellis Studio" applications-graphics Graphics
}
