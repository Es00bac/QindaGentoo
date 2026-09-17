# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="QindaQt native system monitor with detachable resource views"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# Immutable source reviewed and verified before packaging.
QINDAQT_COMMIT="67314971fd0ac0a764154341e9275b365afd5ba8"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# The existing desktop owns the common QindaQt runtime libraries. This component
# installs only System Monitor, never a second copy of those libraries.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-qt/qtbase-6.11:6=[concurrent,dbus,gui,network,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=[widgets]
	>=dev-qt/qtsvg-6.11:6=
	media-libs/fontconfig
"
# The shared project configuration also resolves these desktop/app providers.
DEPEND="${RDEPEND}
	>=media-video/wireplumber-0.5
	>=net-misc/networkmanager-1.44
	>=kde-frameworks/syntax-highlighting-6.0:6=
	=x11-libs/qtermwidget-2.4*:0=
	dev-libs/wayland
	dev-libs/wayland-protocols
"
BDEPEND="
	dev-util/wayland-scanner
	>=kde-frameworks/extra-cmake-modules-6.0:0
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DQINDAQT_BUILD_SHELL=OFF
		-DQINDAQT_BUILD_PRODUCTION_SHELL=OFF
		-DQINDAQT_BUILD_KWIN_PLUGIN=OFF
		-DQINDAQT_ENABLE_STRICT_WARNINGS=OFF
	)
	cmake_src_configure
}

src_compile() {
	cmake_build qindaqt-system-monitor
}

src_install() {
	DESTDIR="${D}" cmake --install "${BUILD_DIR}" --component SystemMonitor \
		|| die "Could not stage System Monitor"
	dodoc docs/wiki/apps/system-monitor.md
}
