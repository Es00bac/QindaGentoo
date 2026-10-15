# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Khronos KTX texture tools (ktx, toktx) and libktx"
HOMEPAGE="https://github.com/KhronosGroup/KTX-Software"
SRC_URI="https://github.com/KhronosGroup/KTX-Software/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/KTX-Software-${PV}"

# libktx, the tools, basisu and astc-encoder are Apache-2.0; bundled fmt,
# cxxopts and helpers are MIT/BSD/zlib/Boost. The ETC unpacker (Ericsson's
# non-free licence) is left out below.
LICENSE="Apache-2.0 BSD BSD-2 Boost-1.0 MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# Wanted by the WiVRn headset client build, whose assets are KTX2 files made
# with `ktx create`. Upstream vendors its libraries.
src_configure() {
	local mycmakeargs=(
		# Tarballs carry no git tags.
		-DKTX_GIT_VERSION_FULL="v${PV}"
		-DKTX_FEATURE_TOOLS=ON
		-DKTX_FEATURE_TOOLS_CTS=OFF
		-DKTX_FEATURE_TESTS=OFF
		-DKTX_FEATURE_DOC=OFF
		-DKTX_FEATURE_LOADTEST_APPS=OFF
		-DKTX_FEATURE_JNI=OFF
		-DKTX_FEATURE_PY=OFF
		-DKTX_FEATURE_GL_UPLOAD=OFF
		-DKTX_FEATURE_VK_UPLOAD=OFF
		-DKTX_FEATURE_ETC_UNPACK=OFF
	)
	cmake_src_configure
}
