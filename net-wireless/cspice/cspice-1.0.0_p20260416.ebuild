# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="507caedbf6bf2768e6a3ff0b0db75a7074d5eb54"

DESCRIPTION="NASA/NAIF CSPICE observation geometry toolkit (CMake packaging fork)"
HOMEPAGE="https://github.com/srcejon/cspice-cmake"
SRC_URI="https://github.com/srcejon/cspice-cmake/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cspice-cmake-${COMMIT}"

# The upstream fork ships no licence file; CSPICE is distributed under the
# Caltech/NAIF disclaimer reproduced verbatim in every source file header.
LICENSE="CSPICE"
SLOT="0"
KEYWORDS="amd64"

src_prepare() {
	# The library target hardcodes "lib" for LIBRARY/ARCHIVE, ignoring the
	# INSTALL_LIB_DIR cache variable that every other install rule honours.
	# On multilib Gentoo that drops libcspice.so into /usr/lib and trips the
	# multilib-strict QA check.
	sed -i \
		-e 's|^\( *\)LIBRARY DESTINATION lib$|\1LIBRARY DESTINATION ${INSTALL_LIB_DIR}|' \
		-e 's|^\( *\)ARCHIVE DESTINATION lib$|\1ARCHIVE DESTINATION ${INSTALL_LIB_DIR}|' \
		CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	# Upstream hardcodes lib/ and an unusual data/ prefix. Point every
	# install directory at the Gentoo layout so multilib-strict is satisfied
	# and SPICE kernels land under /usr/share rather than /usr/data.
	local mycmakeargs=(
		-DCSPICE_BUILD_STATIC_LIBRARY=OFF
		-DINSTALL_LIB_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DINSTALL_BIN_DIR="${EPREFIX}/usr/bin"
		-DINSTALL_INCLUDE_DIR="${EPREFIX}/usr/include"
		-DINSTALL_DATA_DIR="${EPREFIX}/usr/share"
		-DINSTALL_MAN_DIR="${EPREFIX}/usr/share/man"
		-DINSTALL_CMAKE_DIR="${EPREFIX}/usr/$(get_libdir)/cmake/cspice"
	)
	cmake_src_configure
}
