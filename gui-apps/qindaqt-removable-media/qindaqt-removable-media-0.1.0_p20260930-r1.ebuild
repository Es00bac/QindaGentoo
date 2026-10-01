# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

DESCRIPTION="QindaQt graphical removable-media prompts, mounting and safe removal"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
QINDAQT_COMMIT="5bff539edd232b3b23c62b0301aaab2f1c25ff21"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
RESTRICT="fetch"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260928-r3
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=[widgets]
	sys-fs/udisks
	sys-fs/dosfstools
	sys-fs/exfatprogs
	sys-fs/e2fsprogs
"
DEPEND="${RDEPEND}
	>=media-video/wireplumber-0.5
	>=net-misc/networkmanager-1.44
	>=kde-frameworks/kcalendarcore-6.0:6=
	>=kde-frameworks/kio-6.0:6=
	>=kde-frameworks/karchive-6.0:6=
	>=kde-frameworks/syntax-highlighting-6.0:6=
	dev-libs/wayland
	dev-libs/wayland-protocols
"
BDEPEND="dev-util/wayland-scanner
	>=kde-frameworks/extra-cmake-modules-6.0:0
	virtual/pkgconfig"

pkg_nofetch() {
	eerror "Generate ${PF}.tar.gz with git archive --prefix=QindaQt-${QINDAQT_COMMIT}/ ${QINDAQT_COMMIT}"
}
src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DQINDAQT_BUILD_KWIN_PLUGIN=OFF
		-DQINDAQT_BUILD_SHELL=OFF
		-DQINDAQT_BUILD_PRODUCTION_SHELL=OFF
		-DQINDAQT_BUILD_VIEWER=OFF
		-DQINDAQT_BUILD_SYSTEM_MONITOR=OFF
		-DQINDAQT_BUILD_QINDALUTRIS=OFF
		-DQINDAQT_BUILD_OBS_BRIDGE=OFF
		-DQINDAQT_BUILD_REMOVABLE_MEDIA=ON
		-DQINDAQT_ENABLE_STRICT_WARNINGS=ON
	)
	cmake_src_configure
}
src_compile() {
	cmake_build qindaqt-removable-media
}
src_install() {
	DESTDIR="${D}" cmake --install "${BUILD_DIR}" --component RemovableMedia \
		|| die "Could not stage removable media"
	# Compatibility for installed sessions predating the supervisor child.
	# The session-bus singleton makes a second --watch invocation inert.
	insinto /etc/xdg/autostart
	doins "${FILESDIR}/qindaqt-removable-media.desktop"
	dodoc docs/wiki/apps/removable-media.md
}
