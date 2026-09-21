# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="f27b32d2df131ae3a376fe72d3fb880ae1f9ede1"

DESCRIPTION="Digital Speech Decoder library for DMR, dPMR, D-Star, YSF and P25 demodulation"
HOMEPAGE="https://github.com/f4exb/dsdcc"
SRC_URI="https://github.com/f4exb/dsdcc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	net-wireless/mbelib
	net-wireless/serialdv
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_MBELIB=ON
		-DBUILD_TOOL=OFF
	)
	cmake_src_configure
}
