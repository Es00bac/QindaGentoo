# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd udev

DESCRIPTION="Driverless IPP printing over USB with automatic device discovery"
HOMEPAGE="https://github.com/OpenPrinting/ipp-usb"
SRC_URI="https://github.com/OpenPrinting/ipp-usb/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

# The upstream archive vendors goipp under the same license.
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/lp
	>=net-dns/avahi-0.8[dbus]
	virtual/libusb:1
	virtual/udev
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	# Gentoo's merged-/usr system service must name the installed binary.
	sed -i -e 's|ExecStart=/sbin/ipp-usb |ExecStart=/usr/sbin/ipp-usb |' \
		systemd-udev/ipp-usb.service || die
}

src_compile() {
	# AGENT-GUARD: Stay offline under Portage's network sandbox and leave
	# stripping to Portage; upstream's install target recompiles and strips.
	ego build -mod=vendor -tags nethttpomithttp2 -o ipp-usb
}

src_test() {
	ego test -mod=vendor -tags nethttpomithttp2 ./...
}

src_install() {
	dosbin ipp-usb
	systemd_dounit systemd-udev/ipp-usb.service
	udev_dorules systemd-udev/71-ipp-usb.rules
	insinto /etc/ipp-usb
	doins ipp-usb.conf
	insinto /usr/share/ipp-usb/quirks
	doins ipp-usb-quirks/*.conf
	doman ipp-usb.8
	dodoc README.md LICENSE
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
