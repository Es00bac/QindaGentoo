# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake xdg
DESCRIPTION="QindaQt local Windows program setup and per-app Wine profiles"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
QINDAQT_COMMIT="99b731b27d08546156e4e498338e521655e168c2"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
RESTRICT="fetch"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"
CMAKE_USE_DIR="${S}/src/apps/windows_runner"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
    >=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r23
    >=dev-qt/qtbase-6.11:6=[concurrent,gui,widgets]
    app-emulation/wine-proton
    sys-apps/bubblewrap
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
pkg_nofetch() {
    eerror "Generate ${PF}.tar.gz with git archive --prefix=QindaQt-${QINDAQT_COMMIT}/ ${QINDAQT_COMMIT}"
}
src_configure() {
    local mycmakeargs=( -DBUILD_TESTING=OFF -DQINDAQT_ENABLE_STRICT_WARNINGS=ON )
    cmake_src_configure
}
src_compile() {
    cmake_build qindaqt-windows-runner
}
src_install() {
    DESTDIR="${D}" cmake --install "${CMAKE_USE_DIR}_build" --component WindowsRunner         || die "Could not stage Windows Program Runner"
    # A new CONFIG_PROTECT-owned file; never replace R23's /usr/share default
    # list, File Manager, shared library or existing user MIME preferences.
    insinto /etc/xdg
    doins "${FILESDIR}/qindaqt-mimeapps.list"
    dodoc "${S}/docs/wiki/apps/windows-program-runner.md"
}
