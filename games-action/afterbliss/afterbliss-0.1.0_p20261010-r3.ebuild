EAPI=8

inherit cmake xdg

DESCRIPTION="CyberPengu, Ducké and the rescue crew in a native 72-stage platform adventure"
HOMEPAGE=""
SRC_URI="${PF}.tar.xz"
S="${WORKDIR}/${PF}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="fetch !test? ( test )"

RDEPEND="
    >=media-libs/libsdl2-2.24.0[opengl,sound,video]
    media-libs/libpng:0=
    media-libs/freetype:2
    media-libs/fontconfig:1.0
    media-fonts/dejavu
"
DEPEND="${RDEPEND} dev-cpp/nlohmann_json"
BDEPEND="virtual/pkgconfig"

pkg_nofetch() {
    einfo "Create the reviewed first-party source archive with tools/make-dist.sh."
    einfo "Publish its matching Manifest and archive through qinda-sync."
}

src_configure() {
    local mycmakeargs=( -DBUILD_TESTING=$(usex test) )
    cmake_src_configure
}

src_test() {
    cmake_src_test
}
