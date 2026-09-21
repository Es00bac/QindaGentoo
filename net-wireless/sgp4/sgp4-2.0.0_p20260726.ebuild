# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="661e057a5d369d5ee424676cf1d69cbead95ff2c"

DESCRIPTION="SGP4/SDP4 satellite orbit propagation library, used by the SDRangel Satellite Tracker"
HOMEPAGE="https://github.com/dnwrnr/sgp4"
SRC_URI="https://github.com/dnwrnr/sgp4/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

src_prepare() {
	# The top-level CMakeLists unconditionally FetchContent's googletest from
	# GitHub, which cannot work inside Portage's network sandbox. Tests are
	# disabled below, so drop the fetch entirely.
	sed -i -e '/^include(FetchContent)/,/^include(GoogleTest)/d' CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTS=OFF
	)
	cmake_src_configure
}
