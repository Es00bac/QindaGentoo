# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils xdg

DESCRIPTION="Firefox adapted for QindaQt, prebuilt with one page per native window"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
SRC_URI="https://qindaqt.invalid/distfiles/${P}-amd64.tar.xz"
S="${WORKDIR}/${P}"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1 GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="fetch mirror strip"
QA_PREBUILT="opt/qindafox/* usr/libexec/qindafox/qindafox-launcher"

RDEPEND="
	>=dev-qt/qtbase-6.11:6=[gui,wayland,widgets]
	|| (
		media-libs/libpulse
		media-sound/apulse
	)
	>=app-accessibility/at-spi2-core-2.46.0:2
	>=dev-libs/glib-2.26:2
	media-libs/alsa-lib
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	media-video/ffmpeg
	sys-apps/dbus
	sys-process/psmisc
	virtual/freedesktop-icon-theme
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.11:3[X,wayland]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb
	>=x11-libs/pango-1.22.0
"

pkg_nofetch() {
	eerror "Create ${P}-amd64.tar.xz with tools/package-gentoo-bin"
	eerror "and place it in DISTDIR before emerging ${CATEGORY}/${PF}."
}

src_install() {
	dodir /opt/qindafox
	cp -a "${S}"/runtime/. "${ED}"/opt/qindafox/ || die

	pax-mark m \
		"${ED}"/opt/qindafox/firefox \
		"${ED}"/opt/qindafox/firefox-bin \
		"${ED}"/opt/qindafox/plugin-container

	echo "This installation is managed by Gentoo Portage." \
		> "${ED}"/opt/qindafox/is-packaged-app || die

	exeinto /usr/libexec/qindafox
	newexe "${S}"/qindafox-launcher qindafox-launcher
	newexe "${FILESDIR}"/qindafox qindafox-profile-launcher
	dosym ../libexec/qindafox/qindafox-profile-launcher /usr/bin/qindafox

	newmenu "${S}"/org.qindaqt.QindaFox.desktop org.qindaqt.QindaFox.desktop

	local icon size
	for icon in "${S}"/icons/hicolor/*/apps/qindafox.png ; do
		size=${icon%/apps/qindafox.png}
		size=${size##*/}
		newicon -s "${size%x*}" "${icon}" qindafox.png
	done

	dodoc "${S}"/README.md
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "QindaFox can reuse a Firefox profile through ~/.config/qindafox/profile."
	elog "The launcher creates a one-time profile backup before first use."
	elog "Close Firefox before starting QindaFox with the same profile."
}
