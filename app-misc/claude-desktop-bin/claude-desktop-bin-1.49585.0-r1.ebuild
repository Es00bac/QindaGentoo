# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop linux-info xdg

MY_PN="claude-desktop"

DESCRIPTION="Claude desktop application by Anthropic: Chat, Cowork and Claude Code (vendor binary)"
HOMEPAGE="https://claude.com/download https://code.claude.com/docs/en/desktop-linux"
# Same .deb Anthropic serves from its signed apt repository; the Manifest pins it.
SRC_URI="https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/${MY_PN}/${MY_PN}_${PV}_amd64.deb -> ${P}_amd64.deb"
S="${WORKDIR}"

# Application is proprietary; Electron/Chromium and bundled virtiofsd carry open licences.
LICENSE="all-rights-reserved MIT BSD Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cowork qindaqt"
RESTRICT="bindist mirror strip"
QA_PREBUILT="opt/${MY_PN}/*"

BDEPEND="app-arch/libarchive"

# Mapped from the .deb Depends/Recommends fields.
# AGENT-CONTRACT: native Desktop-r2 supplies portal and Secret Service; retain
# vendor-supported trash-cli and libsecret, with all stock choices outside qindaqt.
RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	sys-apps/xdg-desktop-portal
	sys-libs/glibc
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
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
	qindaqt? (
		>=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r2
		app-misc/trash-cli
	)
	!qindaqt? (
		|| ( kde-plasma/xdg-desktop-portal-kde sys-apps/xdg-desktop-portal-gtk sys-apps/xdg-desktop-portal-gnome )
		|| ( kde-plasma/kde-cli-tools app-misc/trash-cli gnome-base/gvfs )
		|| ( gnome-base/gnome-keyring kde-frameworks/kwallet )
	)
	cowork? (
		app-emulation/qemu[qemu_softmmu_targets_x86_64]
		app-emulation/virtiofsd
		|| ( sys-firmware/edk2-bin sys-firmware/edk2 )
	)
"

pkg_pretend() {
	[[ ${CHOST} == x86_64*-linux-gnu ]] || die "Vendor binary requires x86_64 glibc"
}

pkg_setup() {
	# Chromium's sandbox uses user namespaces; the setuid helper is the fallback.
	local CONFIG_CHECK="~USER_NS"
	use cowork && CONFIG_CHECK+=" ~KVM ~VHOST_VSOCK"
	linux-info_pkg_setup
}

src_unpack() {
	bsdtar -xf "${DISTDIR}/${A}" data.tar.xz || die
	bsdtar -xf data.tar.xz || die
	rm -f data.tar.xz || die
}

src_prepare() {
	default
	grep -aqE "\"version\": ?\"${PV}\"" usr/lib/${MY_PN}/resources/app.asar || die "Unexpected upstream version"
	# GNOME Shell search provider files reference the Debian install prefix.
	sed -i "s:/usr/lib/${MY_PN}:/opt/${MY_PN}:g" \
		usr/lib/${MY_PN}/resources/gnome-search-provider/com.anthropic.Claude.SearchProvider.service || die
}

src_install() {
	dodir /opt/${MY_PN}
	cp -a usr/lib/${MY_PN}/. "${ED}/opt/${MY_PN}/" || die
	# Same mode Debian ships: only used when user namespaces are unavailable.
	fperms 4755 /opt/${MY_PN}/chrome-sandbox

	newbin "${FILESDIR}"/claude-desktop.sh claude-desktop
	domenu usr/share/applications/com.anthropic.Claude.desktop

	local size
	for size in 16 32 48 128 256; do
		newicon -s ${size} usr/share/icons/hicolor/${size}x${size}/apps/${MY_PN}.png ${MY_PN}.png
	done

	insinto /usr/share/gnome-shell/search-providers
	doins usr/lib/${MY_PN}/resources/gnome-search-provider/com.anthropic.Claude.search-provider.ini
	insinto /usr/share/dbus-1/services
	doins usr/lib/${MY_PN}/resources/gnome-search-provider/com.anthropic.Claude.SearchProvider.service

	if use cowork; then
		# The app probes Debian's ovmf paths; Gentoo's edk2 packages install under /usr/share/edk2/OvmfX64.
		dosym -r /usr/share/edk2/OvmfX64/OVMF_CODE.fd /usr/share/OVMF/OVMF_CODE.fd
		dosym -r /usr/share/edk2/OvmfX64/OVMF_VARS.fd /usr/share/OVMF/OVMF_VARS.fd
	fi

	dodoc usr/share/doc/${MY_PN}/copyright
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Launch 'claude-desktop' or the Claude menu entry and sign in with a claude.ai account."
	elog "Configuration is shared with dev-util/claude-code (~/.claude.json, ~/.claude/settings.json)."
	elog "Updates do not self-install; bump this ebuild for new upstream versions."
	if use cowork; then
		elog
		elog "Cowork runs tasks in a KVM guest. Each user needs membership in the 'kvm' group"
		elog "(re-login afterwards) and the vhost_vsock module loaded:"
		elog "  usermod -aG kvm <user>; echo vhost_vsock > /etc/modules-load.d/vhost_vsock.conf"
	fi
}
