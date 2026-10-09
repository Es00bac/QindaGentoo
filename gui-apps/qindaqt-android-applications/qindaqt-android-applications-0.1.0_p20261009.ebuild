# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake xdg

DESCRIPTION="QindaQt Android Applications setup and private collector"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
QINDAQT_COMMIT="fcea859abfd4f53ed5cef9ec851123798dda4129"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
RESTRICT="fetch"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"
CMAKE_USE_DIR="${S}/src/apps/android_manager/component"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    >=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r24
    >=app-portage/qindaportage-0.1.0_p20260928-r4
    >=dev-libs/qindatk-0.1.0-r15
    >=dev-qt/qtbase-6.11:6=[dbus,gui,widgets]
    >=dev-qt/qtdeclarative-6.11:6=[widgets]
"
DEPEND="
    >=dev-libs/qindatk-0.1.0-r15
    >=dev-qt/qtbase-6.11:6=[dbus,gui,widgets]
    >=dev-qt/qtdeclarative-6.11:6=[widgets]
"
BDEPEND="virtual/pkgconfig"

pkg_nofetch() {
    eerror "Create ${PF}.tar.gz from Git commit ${QINDAQT_COMMIT} with prefix QindaQt-${QINDAQT_COMMIT}/, then place it in DISTDIR."
}
src_configure() {
    local mycmakeargs=(
        -DBUILD_TESTING=OFF
        -DQINDAQT_ANDROID_SETUP_MENU_ENABLED=ON
        -DQINDAQT_ENABLE_STRICT_WARNINGS=ON
    )
    cmake_src_configure
}
src_compile() {
    cmake_build qindaqt-android-applications qindaqt-android-collector
}
src_install() {
    DESTDIR="${D}" cmake --install "${CMAKE_USE_DIR}_build" --component AndroidApplications \
        || die "Could not stage Android Applications component"
    dodoc "${S}/docs/wiki/apps/android-applications.md"
}
