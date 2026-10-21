# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2026 QindaQt contributors
EAPI=8
PYTHON_COMPAT=( python3_{11..15} )
inherit cmake python-any-r1 xdg

DESCRIPTION="Native QindaTK anime posing, facial animation and layered drawing studio"
HOMEPAGE="https://github.com/Es00bac"
QINDAANIME_COMMIT="0084a972f1ec9b29d8573f57f36ae1e68e5dd87c"
SRC_URI="${PF}.tar.gz"
S="${WORKDIR}/QindaAnimeStudio-${QINDAANIME_COMMIT}"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+codex +video test"
REQUIRED_USE="test? ( video )"
RESTRICT="fetch !test? ( test )"

RDEPEND="
	>=dev-libs/qindatk-0.1.0-r19[quick3d]
	>=dev-qt/qtbase-6.8:6=[gui,network]
	>=dev-qt/qtdeclarative-6.8:6=
	>=dev-qt/qtquick3d-6.8:6=
	codex? ( >=dev-util/codex-bin-0.162.1 )
	video? ( media-video/ffmpeg:=[x264] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-alternatives/ninja
	>=dev-qt/qtshadertools-6.8:6
	virtual/pkgconfig
	test? ( ${PYTHON_DEPS} )
"

pkg_setup() {
	if use test; then
		python-any-r1_pkg_setup
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	QT_QPA_PLATFORM=offscreen QSG_RHI_BACKEND=opengl LIBGL_ALWAYS_SOFTWARE=1 cmake_src_test
}

src_install() {
	cmake_src_install
	dodoc README.md
	dodoc -r docs
}

pkg_nofetch() {
	einfo "Supply the immutable source archive from QindaAnimeStudio commit ${QINDAANIME_COMMIT}:"
	einfo "git -c tar.umask=022 archive --format=tar --prefix=QindaAnimeStudio-${QINDAANIME_COMMIT}/ ${QINDAANIME_COMMIT} | gzip -n > ${PF}.tar.gz"
}
