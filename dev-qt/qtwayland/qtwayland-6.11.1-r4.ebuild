# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qt6-build

DESCRIPTION="Toolbox for making Qt based Wayland compositors"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
fi

IUSE="gnome qml"

RDEPEND="
	dev-libs/wayland
	~dev-qt/qtbase-${PV}:6[gui,opengl,wayland]
	media-libs/libglvnd
	x11-libs/libdrm
	x11-libs/libxkbcommon
	qml? ( ~dev-qt/qtdeclarative-${PV}:6 )
	gnome? (
		~dev-qt/qtbase-${PV}:6[dbus]
		~dev-qt/qtsvg-${PV}:6
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

PATCHES=(
	# Multiple keyboard listeners on one Firefox/GTK client must all receive state.
	"${FILESDIR}/6.11.1-compositor-keyboard-resources-v2.patch"
	# Build the linux-dmabuf client-buffer plugin, with dma-buf feedback so Mesa 25+
	# clients (no wl_drm) render on the GPU; used by QindaXR.
	"${FILESDIR}/6.11.1-compositor-dmabuf-feedback.patch"
	# A window maximized before its item has an output (inside Qt Quick 3D) crashed.
	"${FILESDIR}/6.11.1-xdgshell-maximize-without-output.patch"
	# xwayland-satellite (X11 apps in QindaXR) needs xdg_wm_base 2 and named outputs.
	"${FILESDIR}/6.11.1-xdgshell-wm-base-v2.patch"
	"${FILESDIR}/6.11.1-output-v4-name.patch"
)

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package qml Qt6Quick)
		$(qt_feature gnome wayland_decoration_adwaita)
	)

	qt6-build_src_configure
}
