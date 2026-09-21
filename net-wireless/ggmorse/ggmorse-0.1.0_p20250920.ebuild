# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="25f98e2636a8f4a4481a891384c6dd4ca7aa6b3a"

DESCRIPTION="Morse code decoding library used by the SDRangel Morse demodulator"
HOMEPAGE="https://github.com/srcejon/ggmorse"
SRC_URI="https://github.com/srcejon/ggmorse/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

src_configure() {
	# Examples pull in the imgui submodule, which is not in the tarball and is
	# not needed for the library SDRangel links against.
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DGGMORSE_BUILD_EXAMPLES=OFF
		-DGGMORSE_BUILD_TESTS=OFF
		-DGGMORSE_SUPPORT_SDL2=OFF
	)
	cmake_src_configure
}
