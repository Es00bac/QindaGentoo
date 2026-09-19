# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="QindaMPV media player with QindaTK UI and QindaQt global menus"
HOMEPAGE="https://github.com/Es00bac/QindaMPV"
QINDAMPV_COMMIT="6bfde6644d927989fcd157471873543c75b5b05b"
# AGENT-CONTRACT: This local checkpoint is supplied as an exact git archive,
# independent of either developer's checkout path or unpublished remote refs.
SRC_URI="${P}.tar.gz"
S="${WORKDIR}/QindaMPV-${QINDAMPV_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"

# The desktop owns AppShell's headers and libraries. Its dependency on this
# player is PDEPEND so Portage can install the desktop before building QQMpv.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-qt/qtbase-6.11:6=[dbus,gui,opengl,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=
	>=dev-libs/qindatk-0.1.0
	media-video/mpv[libmpv]
"
DEPEND="${RDEPEND}"

pkg_nofetch() {
	eerror "Create ${P}.tar.gz from QindaMPV commit ${QINDAMPV_COMMIT} using git archive"
	eerror "with prefix QindaMPV-${QINDAMPV_COMMIT}/ and gzip -n; place it in DISTDIR."
}

src_configure() {
	local mycmakeargs=( -DBUILD_TESTING=OFF )
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc README.md
}
