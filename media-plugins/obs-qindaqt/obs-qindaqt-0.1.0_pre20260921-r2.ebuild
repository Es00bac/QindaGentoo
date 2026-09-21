# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="QindaQt console buses and strips as OBS Studio audio sources"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# Set to the exact QindaQt commit at the package cut; the Manifest is
# generated then (`ebuild ... manifest`), like the desktop package.
QINDAQT_COMMIT="4f2eec0f2ba07a52f00dc359728d843761780db3"
RESTRICT="fetch"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"
# The module is one directory of the QindaQt tree and configures alone.
CMAKE_USE_DIR="${S}/src/obs"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# libobs, obs-frontend-api and the obs-websocket API header come from
# obs-studio; the bridge talks to Audio1 over the session bus and draws its
# dock with the same Qt the OBS frontend uses.
RDEPEND="
	>=media-video/obs-studio-32.0:=[websocket]
	>=dev-qt/qtbase-6.11:6=[dbus,gui,widgets]
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260916
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-build/cmake-3.25"

src_configure() {
	local mycmakeargs=(
		-DQINDAQT_ENABLE_STRICT_WARNINGS=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	elog "OBS loads obs-qindaqt from ${EPREFIX}/usr/$(get_libdir)/obs-plugins on its next start."
	elog "Every QindaQt console bus and strip then appears as an OBS audio source,"
	elog "the 'QindaQt Console' dock lists them with meters, and obs-websocket"
	elog "clients can request the vendor call qindaqt.GetConsoleMapping."
}
