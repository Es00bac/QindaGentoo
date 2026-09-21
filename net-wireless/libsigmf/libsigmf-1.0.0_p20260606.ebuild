# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="877b069e5abdd0c12fdc9e192a47e9026628c14b"

DESCRIPTION="Header library for the SigMF signal recording format (SDRangel fork)"
HOMEPAGE="https://github.com/f4exb/libsigmf"
SRC_URI="https://github.com/f4exb/libsigmf/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/flatbuffers:=
"
DEPEND="${RDEPEND}"

src_configure() {
	# json and flatbuffers are git submodules upstream; use the packaged
	# copies instead so nothing is fetched during src_compile.
	local mycmakeargs=(
		-DENABLE_EXAMPLES=OFF
		-DUSE_SYSTEM_JSON=ON
		-DUSE_SYSTEM_FLATBUFFERS=ON
	)
	cmake_src_configure
}
