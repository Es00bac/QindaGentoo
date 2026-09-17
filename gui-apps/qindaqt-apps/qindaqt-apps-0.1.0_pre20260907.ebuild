# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="QindaQt File Manager, Text Editor and Terminal"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
QINDAQT_COMMIT="3ec80588bb3a1505c52ef528c84dad6cebfbe67a"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=[widgets]
	>=dev-qt/qtsvg-6.11:6=
	=kde-frameworks/syntax-highlighting-6*:6=
	=x11-libs/qtermwidget-2.4*:0=
	media-libs/fontconfig
	app-shells/bash
	x11-misc/xdg-utils
"
# The current top-level configure also resolves desktop service providers,
# though this package builds and installs only the three application targets.
DEPEND="${RDEPEND}
	>=media-video/wireplumber-0.5
	>=net-misc/networkmanager-1.44
	dev-libs/wayland
"
BDEPEND="
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
	cmake_build qindaqt-file-manager qindaqt-editor qindaqt-terminal \
		qindaqt_app_shellplugin qindaqt_controls_qmlplugin qindaqt_tokens_qmlplugin
}

src_install() {
	local component
	for component in FileManager TextEditor Terminal; do
		DESTDIR="${D}" cmake --install "${BUILD_DIR}" --component "${component}" \
			|| die "Could not stage ${component}"
	done
	dodoc README.md
}
