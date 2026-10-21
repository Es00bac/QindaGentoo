# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake
SD_COMMIT="0518b34374761cb82aeda5ad3c2f0686fdad2cec"
GGML_COMMIT="dc998771e700d49bbdf9a39cede22bb5b3311767"
DESCRIPTION="Native diffusion inference with Vulkan and complete MOSS layer skipping controls"
HOMEPAGE="https://github.com/leejet/stable-diffusion.cpp"
SRC_URI="${PF}-source.tar.xz"
S="${WORKDIR}/stable-diffusion.cpp-${SD_COMMIT}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+vulkan"
RESTRICT="fetch"
DEPEND="vulkan? ( media-libs/vulkan-loader dev-util/vulkan-headers )"
RDEPEND="${DEPEND}"
BDEPEND="vulkan? ( dev-util/glslang )"
PATCHES=( "${FILESDIR}/moss-layer-controls.patch" )
src_prepare() {
	cmake_src_prepare
	# The native SSH application owns transport; no embedded browser server.
	sed -i '/add_subdirectory(server)/d' examples/CMakeLists.txt || die
}
pkg_nofetch() {
	einfo "Pinned source-only archive from QindaMOSS tools/make-runtime-dist.py; fetch through qinda-sync."
}
src_configure() {
	local mycmakeargs=( -DSD_VULKAN=$(usex vulkan ON OFF)
	-DSD_WEBP=OFF -DSD_WEBM=OFF -DSD_BUILD_SHARED_LIBS=OFF
	-DSD_BUILD_SHARED_GGML_LIB=OFF -DGGML_NATIVE=OFF -DGGML_OPENMP=ON )
	cmake_src_configure
}
src_compile() { cmake_build sd-cli; }
src_install() {
	dobin "${BUILD_DIR}/bin/sd-cli"
	dodoc README.md docs/moss_image.md
}
