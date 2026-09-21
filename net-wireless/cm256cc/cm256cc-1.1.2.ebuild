# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="da87adbe3e583877870cb159d37e0456549b2c29"

DESCRIPTION="C++ library for Cauchy MDS block erasure codec, used by SDRangel remote devices"
HOMEPAGE="https://github.com/f4exb/cm256cc"
SRC_URI="https://github.com/f4exb/cm256cc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TOOLS=OFF
	)
	cmake_src_configure
}
