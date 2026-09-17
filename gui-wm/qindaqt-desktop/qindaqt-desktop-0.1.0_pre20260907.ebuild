# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="QindaQt Wayland desktop, services and bundled applications"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
QINDAQT_COMMIT="d1232e75996fde216ed232622a5b20198dadb2e7"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# This package installs the complete tree, including the three bundled apps.
# Keep ownership unambiguous for users who previously selected the apps-only
# package.
RDEPEND="
	!gui-apps/qindaqt-apps
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=[widgets]
	>=dev-qt/qtsvg-6.11:6=
	=kde-plasma/kwin-6.6.6*:6=[lock,shortcuts]
	=kde-plasma/kdecoration-6.6.6*:6=
	=kde-plasma/kscreenlocker-6.6.6*:6=
	=kde-plasma/layer-shell-qt-6.6.6*:6=
	=kde-plasma/kwayland-6.6.6*:6=
	=kde-plasma/polkit-kde-agent-6.6.6*:6=
	=kde-plasma/plasma-activities-6.6.6*:6=
	~kde-plasma/powerdevil-6.6.6
	=kde-plasma/spectacle-6.6.6*:6=
	=kde-plasma/xdg-desktop-portal-kde-6.6.6*:6=
	>=kde-frameworks/kconfig-6.0:6=
	>=kde-frameworks/kcoreaddons-6.0:6=
	>=kde-frameworks/kglobalaccel-6.0:6=
	>=kde-frameworks/kidletime-6.0:6=
	>=kde-frameworks/kio-6.0:6=
	>=kde-frameworks/kservice-6.0:6=
	>=kde-frameworks/syntax-highlighting-6.0:6=
	=x11-libs/qtermwidget-2.4*:0=
	>=media-video/wireplumber-0.5
	>=net-misc/networkmanager-1.44
	media-libs/fontconfig
	net-wireless/bluez
	sys-apps/dbus
	sys-apps/systemd
	sys-apps/xdg-desktop-portal
	|| (
		sys-apps/tuned[ppd]
		sys-power/power-profiles-daemon
	)
	sys-power/upower
	x11-base/xwayland
	x11-misc/xdg-utils
"
DEPEND="${RDEPEND}
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
"
BDEPEND="
	>=kde-frameworks/extra-cmake-modules-6.0:0
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DQINDAQT_BUILD_KWIN_PLUGIN=ON
		-DQINDAQT_BUILD_SHELL=ON
		-DQINDAQT_BUILD_PRODUCTION_SHELL=ON
		-DQINDAQT_ENABLE_HOST_UINPUT_TESTS=OFF
		-DQINDAQT_ENABLE_STRICT_WARNINGS=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc README.md
}
