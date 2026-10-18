# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2026 QindaQt contributors
EAPI=8

inherit cmake xdg

DESCRIPTION="Native QindaTK anime.nexus browser, local library and mpv player"
HOMEPAGE="https://anime.nexus"
QINDAANIME_COMMIT="5c80bcdd89ec6277d56a67cf808664ae2ea86c5c"
SRC_URI="${PF}.tar.gz"
S="${WORKDIR}/QindaAnime-${QINDAANIME_COMMIT}"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="fetch !test? ( test )"
RDEPEND="
	app-misc/ca-certificates
	dev-libs/openssl:0=
	>=dev-libs/qindatk-0.1.0-r12
	>=dev-qt/qtbase-6.8:6=[gui,network,opengl,sql,sqlite,ssl]
	>=dev-qt/qtdeclarative-6.8:6=
	>=dev-qt/qtwebengine-6.8:6=[qml,opengl]
	media-video/mpv:=[libmpv,egl]
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.85
"
BDEPEND="virtual/pkgconfig"
DOCS=( README.md docs/api.md )

src_configure() {
	local mycmakeargs=( -DBUILD_TESTING=$(usex test) )
	cmake_src_configure
}

src_test() {
	QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software cmake_src_test
}

pkg_nofetch() {
	einfo "Supply the immutable source archive from QindaAnime commit ${QINDAANIME_COMMIT}."
	einfo "From a synchronized QindaAnime checkout:"
	einfo "git -c tar.umask=022 archive --format=tar --prefix=QindaAnime-${QINDAANIME_COMMIT}/ ${QINDAANIME_COMMIT} | gzip -n > ${PF}.tar.gz"
	einfo "Place ${PF}.tar.gz in Portage's configured distfiles directory."
}
