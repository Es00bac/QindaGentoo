# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="a04f705582d7e2bf041a322522fa3c0529c4e832"

DESCRIPTION="DAB/DAB+ decoding library (dab_lib) used by the SDRangel DAB demodulator"
HOMEPAGE="https://github.com/srcejon/dab-cmdline"
SRC_URI="https://github.com/srcejon/dab-cmdline/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	media-libs/faad2
	sci-libs/fftw:3.0=
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}"

# Only the library/ subdirectory is wanted; the repository root builds the
# command line example programs instead.
CMAKE_USE_DIR="${S}/library"

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
	)
	cmake_src_configure
}
