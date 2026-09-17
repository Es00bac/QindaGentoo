# Copyright 2026 QindaStudio contributors
# Distributed under the terms of the GNU General Public License v3+
# Local overlay ebuild for the QindaStudio port of Sloom Studio.
# Refresh the source tarball after new commits with:
#   git -C ~/work_SPaC3/QindaStudio archive --format tar \
#     --prefix qindastudio-0.1.0/ HEAD | xz -c \
#     > /var/cache/distfiles/qindastudio-0.1.0.tar.xz

EAPI=8

DESCRIPTION="Qt6/QML creative suite for the QindaQt desktop: Flow, Paper, Image, Video and Sloom Link"
HOMEPAGE="https://qindaqt.invalid/qindastudio"
SRC_URI="${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network]
	dev-qt/qtdeclarative:6
	kde-frameworks/karchive:6
	media-libs/fontconfig
	media-libs/lcms:2
	gui-wm/qindaqt-desktop
"
RDEPEND="${DEPEND}"

inherit cmake

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
	)
	cmake_src_configure
}
