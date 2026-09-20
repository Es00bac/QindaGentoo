# Copyright 2026 QindaStudio contributors
# Distributed under the terms of the GNU General Public License v3+
#
# media-gfx, not gui-wm: gui-wm is for window managers and compositors
# (sway, labwc, wayfire, gamescope). gui-wm/qindaqt-desktop belongs there
# because it IS a desktop; QindaStudio is an application that runs on it,
# and it sits beside gimp, krita and inkscape.
#
# Refresh the source tarball after new commits with:
#   packaging/portage/refresh-tarball.sh

EAPI=8

inherit cmake

DESCRIPTION="Qt6/QML creative suite for the QindaQt desktop: Flow, Paper, Image, Video and Sloom Link"
HOMEPAGE="https://qindaqt.invalid/qindastudio"
SRC_URI="${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
# exr and avif gate optional high-bit import/export; the engine reports the
# format unavailable rather than silently converting when they are off.
IUSE="+exr +avif test"
RESTRICT="!test? ( test )"

# QindaTK supplies the QML module every toolkit surface binds to. Without it
# the build still succeeds and the interface comes up missing its controls,
# which is why it is a hard dependency here rather than an optional one.
#
# The version floor is not housekeeping. The workspace switcher binds to
# Tk.PillSwitcher, which no QindaTK before r4 contains; built against an
# older one this package installs cleanly and then fails to start, because
# the QML root cannot resolve the type. `tests/toolkit_components_check.py`
# is the same guard at build time.
COMMON_DEPEND="
	>=dev-libs/qindatk-0.1.0-r4
	dev-qt/qtbase:6[concurrent,dbus,gui,network,ssl]
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	dev-qt/qtsvg:6
	dev-libs/openssl:=
	kde-frameworks/karchive:6
	media-libs/fontconfig
	media-libs/lcms:2
	exr? ( media-libs/openexr:= )
	avif? ( media-libs/libavif:= )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	gui-wm/qindaqt-desktop
	media-video/ffmpeg
"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		# Portage builds as the portage user in a sandbox where a developer's
		# ~/work_SPaC3/QindaTK does not exist. Without this the build finds no
		# toolkit, SUCCEEDS, and ships an interface with every toolkit surface
		# missing.
		-DQINDASTUDIO_PREFER_INSTALLED_QINDATK=ON
		-DBUILD_TESTING=$(usex test ON OFF)
	)
	cmake_src_configure
}

src_test() {
	# The desktop probes need a display and a private session bus.
	local -x QT_QPA_PLATFORM=offscreen
	cmake_src_test
}
