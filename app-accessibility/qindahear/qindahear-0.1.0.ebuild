# Copyright 2026 QindaHear contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Native microphone sound amplifier with speech denoising and per-ear EQ"
HOMEPAGE="https://github.com/Es00bac/QindaGentoo"
# Immutable archive from QindaHear hub commit 2171bad475afd95779f0f0c6e35cdebcbab9d885.
SRC_URI="${PF}.tar.xz"
S="${WORKDIR}/QindaHear-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="fetch !test? ( test )"

RDEPEND="
	>=dev-qt/qtbase-6.5:6=[gui,widgets]
	media-libs/libpulse
	>=media-libs/rnnoise-0.4
	sci-libs/fftw:3.0=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_nofetch() {
	einfo "Create the immutable source archive from the QindaHear hub:"
	einfo "git -C ~/work_SPaC3/QindaHear archive --prefix=QindaHear-${PV}/ 2171bad | xz > ${PF}.tar.xz"
	einfo "Place that archive in your configured Portage DISTDIR."
}

src_configure() {
	local mycmakeargs=( -DBUILD_TESTING=$(usex test) )
	cmake_src_configure
}

src_test() {
	QT_QPA_PLATFORM=offscreen cmake_src_test
}
