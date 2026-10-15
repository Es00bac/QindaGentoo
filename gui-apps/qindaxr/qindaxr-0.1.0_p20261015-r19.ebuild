# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit cmake python-single-r1 xdg git-r3

DESCRIPTION="QindaTK workspace for VR headsets, with AI agent avatars"
HOMEPAGE="https://github.com/Es00bac"
# Read the published hub, or its refreshed laptop bare mirror. Never install
# source from a working checkout.
EGIT_REPO_URI="file:///home/cabewse/git/Oculus.git"
# r19: crashes leave a backtrace in the log and a core file (debugging the
# headset segfault after a dictation).
EGIT_COMMIT="5aa70ac7487b56fcecb1a0454fdd0ead2c196910"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gamepad +voice +wivrn +x11"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# Private Qt Quick 3D, Qt Quick and QtWaylandCompositor headers are used, so Qt
# updates must rebuild the app (slot operators). Qt Quick 3D must carry the
# qindaqt overlay's openxr flag for the QtQuick3D.Xr module.
RDEPEND="
	${PYTHON_DEPS}
	>=dev-libs/qindatk-0.1.0-r18:0/18
	>=dev-qt/qtbase-6.11:6=[dbus,gui,opengl,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	>=dev-qt/qtquick3d-6.11.1-r1:6=[openxr(-)]
	>=dev-qt/qtwayland-6.11.1-r4:6=[qml]
	dev-libs/wayland
	gui-apps/waypipe
	gui-wm/qindaqt-kwin
	net-misc/openssh
	x11-libs/libxkbcommon
	gamepad? (
		media-libs/libsdl3
		games-util/game-device-udev-rules
	)
	voice? (
		media-video/pipewire
		app-accessibility/faster-whisper-models
		dev-python/faster-whisper[${PYTHON_SINGLE_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/numpy[${PYTHON_USEDEP}]
		')
	)
	wivrn? ( media-libs/wivrn )
	x11? (
		gui-apps/xwayland-satellite
		x11-base/xwayland
	)
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare
	if ! use gamepad; then
		sed -i -e 's/^find_package(SDL3 CONFIG)/# gamepad disabled/' CMakeLists.txt || die
	fi
}

src_install() {
	cmake_src_install
	python_fix_shebang "${ED}"/usr/libexec/qindaxr "${ED}"/usr/bin/qindaxr-print-markers
	use voice || rm "${ED}"/usr/libexec/qindaxr/qindaxr-voice || die
	dodoc README.md
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Headset setup (once per user):"
	elog "  install -Dm644 /usr/share/qindaxr/wivrn/config.json ~/.config/wivrn/config.json"
	elog "  systemctl --user enable --now wivrn"
	elog "Then start WiVRn on the Quest and connect; QindaXR starts automatically."
	elog "Trouble in the headset? Run qindaxr-doctor on this machine."
	elog "Desktop preview: qindaxr --preview (see /usr/share/doc/${PF}/README.md*)."
}
