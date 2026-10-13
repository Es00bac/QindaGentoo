# Copyright 2026 QindaPaint contributors
# SPDX-License-Identifier: GPL-2.0-only
EAPI=8

inherit cmake xdg

DESCRIPTION="Native QindaTK painting app with a Rust brush engine"
HOMEPAGE="https://qindaqt.invalid/qindapaint"
SRC_URI="${PF}.tar.gz"
S="${WORKDIR}/${PF}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="fetch !test? ( test )"

RDEPEND="
	>=dev-libs/qindatk-0.1.0-r18
	>=dev-libs/qindatk-raster-0.1.0
	>=dev-qt/qtbase-6.8:6[gui]
	>=dev-qt/qtdeclarative-6.8:6
	virtual/zlib:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	|| ( >=dev-lang/rust-bin-1.85 >=dev-lang/rust-1.85 )
	app-alternatives/ninja
"

pkg_nofetch() {
	einfo "From the committed QindaPaint checkout, create the locked archive:"
	einfo "tools/make-dist.sh ${PVR} /var/cache/distfiles"
	einfo "The tarball must match this ebuild's Manifest."
}

src_configure() {
	local mycmakeargs=( -DBUILD_TESTING=$(usex test ON OFF) )
	cmake_src_configure
}

src_compile() {
	CARGO_NET_OFFLINE=true CARGO_HOME="${T}/cargo-home" cmake_src_compile
}

src_test() {
	CARGO_NET_OFFLINE=true CARGO_HOME="${T}/cargo-home" \
	    QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software cmake_src_test
}

src_install() {
	cmake_src_install
	dodoc README.md docs/brush-research.md docs/brush-creator.md docs/bristle-engine.md \
		docs/brush-colour.md docs/feature-parity.md docs/psd-interchange.md
}
