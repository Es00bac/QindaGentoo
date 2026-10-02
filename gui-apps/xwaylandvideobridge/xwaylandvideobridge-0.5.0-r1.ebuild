# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
KFMIN=6.22.0
QTMIN=6.10.1
KDE_ORG_CATEGORY="system"
inherit ecm kde.org xdg

DESCRIPTION="Screenshare Wayland windows to XWayland apps (private KPipeWire)"
HOMEPAGE="https://invent.kde.org/system/xwaylandvideobridge"
KPIPEWIRE_PV="6.6.6.1"
SRC_URI="mirror://kde/stable/${PN}/src/${P}.tar.xz
 mirror://kde/stable/plasma/6.6.6/kpipewire-${KPIPEWIRE_PV}.tar.xz"
KEYWORDS="~amd64"
LICENSE="GPL-2+ LGPL-2.1+ BSD-3-Clause"
SLOT="0"

# KPipeWire remains exact upstream source inside this helper, not a global
# provider. Retain its codec/Qt/graphics requirements and all bridge behavior.
DEPEND="
 >=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets,X,opengl]
 >=dev-qt/qtdeclarative-${QTMIN}:6
 >=kde-frameworks/kcoreaddons-${KFMIN}:6
 >=kde-frameworks/kcrash-${KFMIN}:6
 >=kde-frameworks/ki18n-${KFMIN}:6
 >=kde-frameworks/kstatusnotifieritem-${KFMIN}:6
 >=kde-frameworks/kwindowsystem-${KFMIN}:6[X]
 media-libs/freetype
 x11-libs/libxcb:=
 x11-libs/libXfixes
 x11-libs/xcb-util
 media-libs/libepoxy
 media-libs/libglvnd
 media-libs/libva:=
 media-libs/mesa[opengl]
 >=media-video/ffmpeg-6.1:=
 >=media-video/pipewire-0.3:=
 x11-libs/libdrm
"
RDEPEND="${DEPEND}
 >=kde-frameworks/kirigami-${KFMIN}:6"
BDEPEND="virtual/pkgconfig"
PATCHES=( "${FILESDIR}/${PN}-0.5.0-private-kpipewire.patch" )

private_prefix() { printf '%s' "${EPREFIX}/usr/$(get_libdir)/xwaylandvideobridge"; }

src_prepare() {
 mkdir -p "${S}/qinda-private" || die
 mv "${WORKDIR}/kpipewire-${KPIPEWIRE_PV}" "${S}/qinda-private/kpipewire" || die
 cmake_src_prepare
}

src_configure() {
 local S="${S}/qinda-private/kpipewire"
 local BUILD_DIR="${WORKDIR}/kpipewire-build"
 local mycmakeargs=(
  -DBUILD_TESTING=OFF
  -DCMAKE_INSTALL_PREFIX="$(private_prefix)"
  -DKDE_INSTALL_LIBDIR=lib
  -DKDE_INSTALL_INCLUDEDIR=include
  -DKDE_INSTALL_QMLDIR=qml
  -DKDE_INSTALL_CMAKEPACKAGEDIR=lib/cmake
  -DCMAKE_INSTALL_RPATH="$(private_prefix)/lib"
 )
 cmake_src_configure
}

src_compile() {
 # Stage only inside WORKDIR for the public bridge's normal find_package API.
 # The NO_DEFAULT_PATH patch makes absent staging a hard error, not stock fallback.
 local bridge_source="${S}" bridge_build="${BUILD_DIR}"
 local S="${bridge_source}/qinda-private/kpipewire"
 local BUILD_DIR="${WORKDIR}/kpipewire-build"
 cmake_src_compile
 DESTDIR="${WORKDIR}/private-stage" cmake --install "${BUILD_DIR}" || die
 S="${bridge_source}"
 BUILD_DIR="${bridge_build}"
 local mycmakeargs=(
  -DQINDAQT_PRIVATE_KPIPEWIRE_DIR="${WORKDIR}/private-stage$(private_prefix)/lib/cmake/KPipeWire"
  -DQINDAQT_PRIVATE_PIPEWIRE_PREFIX="$(private_prefix)"
  -DCMAKE_INSTALL_RPATH="$(private_prefix)/lib"
 )
 cmake_src_configure
 cmake_src_compile
}

src_install() {
 cmake_src_install
 local stage="${WORKDIR}/private-stage$(private_prefix)"
 # Only this package's private subtree is copied. No global KPipeWire development
 # exports or module paths survive into the image; bridge public paths are stock.
 insinto "$(private_prefix)"
 doins -r "${stage}/."
 rm -rf "${ED}/usr/$(get_libdir)/xwaylandvideobridge/include" \
  "${ED}/usr/$(get_libdir)/xwaylandvideobridge/lib/cmake" || die
 docinto kpipewire
 dodoc -r "${S}/qinda-private/kpipewire/LICENSES"
 docinto xwaylandvideobridge
 dodoc -r "${S}/LICENSES"
}
