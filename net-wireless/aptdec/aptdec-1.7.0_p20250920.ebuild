# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="d037f77cfaff946318e39293ae97fc2e68595f0f"
ARGPARSE_COMMIT="c612dc03958cdbd538ca306d61853b643a435933"

DESCRIPTION="NOAA APT weather satellite image decoder library (SDRangel libaptdec fork)"
HOMEPAGE="https://github.com/srcejon/aptdec"
SRC_URI="
	https://github.com/srcejon/aptdec/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/cofyc/argparse/archive/${ARGPARSE_COMMIT}.tar.gz -> ${PN}-argparse-${ARGPARSE_COMMIT:0:8}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	media-libs/libpng:=
	media-libs/libsndfile
"
DEPEND="${RDEPEND}"

src_prepare() {
	# src/argparse is a git submodule, absent from the release tarball.
	rmdir src/argparse 2>/dev/null
	mv "${WORKDIR}/argparse-${ARGPARSE_COMMIT}" src/argparse || die

	# Upstream hardcodes the library destination as "lib", which is wrong on
	# a multilib Gentoo where shared libraries belong in /usr/lib64.
	sed -i -e 's|LIBRARY DESTINATION lib|LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}|' \
		CMakeLists.txt || die
	cmake_src_prepare
}
