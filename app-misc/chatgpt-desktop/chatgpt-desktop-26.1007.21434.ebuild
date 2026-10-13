# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="OpenAI ChatGPT desktop application (official Linux release)"
HOMEPAGE="https://learn.chatgpt.com/docs/linux/linux-app"
# Use the versioned RPM from OpenAI's repository, not the mutable latest endpoint.
# The Manifest pins the exact upstream bytes; src_prepare checks the payload version.
SRC_URI="https://persistent.oaistatic.com/codex-app-prod/linux/rpm/x86_64/chatgpt-${PV}-1.x86_64.rpm -> ${P}.x86_64.rpm"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+abi_x86_64"
REQUIRED_USE="elibc_glibc abi_x86_64"
RESTRICT="bindist mirror strip"
QA_PREBUILT="opt/chatgpt/*"

BDEPEND="app-arch/libarchive"
RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/tpm2-tss
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libusb:1
	dev-libs/nspr
	dev-libs/nss
	dev-libs/openssl:0/3
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	virtual/udev
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[X]
	x11-libs/libdrm
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
	dev-qt/qtbase:6[gui,widgets]
	dev-libs/wayland
"

src_unpack() {
	bsdtar -xf "${DISTDIR}/${A}" || die
}

src_prepare() {
	default
	grep -q '"version": "'"${PV}"'"' \
		usr/lib/chatgpt/resources/linux-package-metadata.json || die "Unexpected upstream version"
}

src_install() {
	dodir /opt/chatgpt
	cp -a usr/lib/chatgpt/. "${ED}/opt/chatgpt/" || die
	dobin "${FILESDIR}/chatgpt"
	domenu usr/share/applications/chatgpt.desktop
	newicon -s 512 usr/lib/chatgpt/resources/icon-chatgpt.png chatgpt.png
}
