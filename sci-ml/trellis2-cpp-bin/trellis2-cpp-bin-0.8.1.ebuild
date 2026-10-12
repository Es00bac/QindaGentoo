# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Native TRELLIS.2 image-to-3D generator with Vulkan acceleration"
HOMEPAGE="https://github.com/pwilkin/trellis.cpp"
SRC_URI="https://github.com/pwilkin/trellis.cpp/releases/download/v${PV}/trellis-vulkan-linux-x64.tar.gz -> ${P}-vulkan-linux-x64.tar.gz"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist strip"
RDEPEND="
	media-libs/vulkan-loader
	sci-ml/trellis2-q4-models
"
QA_PREBUILT="opt/trellis2-cpp/*"

src_install() {
	dodir /opt/trellis2-cpp
	cp -a -- "${S}/trellis-cli" "${S}/trellis-server" "${S}"/libggml*.so* \
		"${ED}/opt/trellis2-cpp/" || die
	dosym ../../opt/trellis2-cpp/trellis-cli /usr/bin/trellis-cli
	dosym ../../opt/trellis2-cpp/trellis-server /usr/bin/trellis-server
	newbin "${FILESDIR}/trellis2" trellis2
}

pkg_postinst() {
	elog "Run: trellis2 input.png output.glb"
	elog "The wrapper uses the Q4 weights and 512-resolution Vulkan generation."
}
