# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# The 55 language packs in the release's locales/ directory.
CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"
inherit chromium-2

DESCRIPTION="Electron runtime for desktop applications (official prebuilt release)"
HOMEPAGE="https://www.electronjs.org https://github.com/electron/electron"
SRC_URI="https://github.com/electron/electron/releases/download/v${PV}/electron-v${PV}-linux-x64.zip"
S="${WORKDIR}"

# Electron is MIT; the Chromium it embeds bundles the rest (LICENSES.chromium.html
# in the installed tree lists every component). libffmpeg.so carries the
# proprietary H.264, HEVC and AAC decoders, so the build is not redistributable.
LICENSE="MIT BSD BSD-2 Apache-2.0 Boost-1.0 CC0-1.0 FTL GPL-2 IJG ISC LGPL-2.1+
	libpng MPL-1.1 MPL-2.0 OFL-1.1 Unicode-3.0 ZLIB"
# One slot per Electron major: applications pin the major they were built for
# (dev-util/electron-bin:44 provides /usr/bin/electron-44) and majors co-install.
SLOT="${PV%%.*}"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

# NEEDED libraries of the electron binary, plus what Chromium opens at run time:
# libdbusmenu-glib.so.4 (X11 global menu; only the glib library is used, which
# dev-libs/libdbusmenu always builds), libnotify (desktop notifications),
# libsecret (safeStorage), libva (hardware video decoding), libpulse (audio
# through PulseAudio or PipeWire), libEGL and libGLESv2 (GPU rendering).
RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libdbusmenu
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/libglvnd
	media-libs/libpulse
	media-libs/libva
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	virtual/libudev
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[X]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
"
BDEPEND="app-arch/unzip"

QA_PREBUILT="opt/${PN}-${SLOT}/*"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default

	# The Manifest pins the archive; this also catches a mislabelled release.
	[[ $(<version) == "${PV}" ]] || die "unexpected upstream version: $(<version)"

	pushd locales >/dev/null || die
	chromium_remove_language_paks
	popd >/dev/null || die
}

src_install() {
	local dest=/opt/${PN}-${SLOT}

	# Keep the upstream layout: Electron finds its resources, libffmpeg.so and
	# chrome-sandbox next to the executable.
	insinto "${dest}"
	doins -r .
	fperms 0755 "${dest}"/{electron,chrome_crashpad_handler,libffmpeg.so,libvk_swiftshader.so,libvulkan.so.1}

	# Chromium's setuid sandbox helper. Renderers use it when unprivileged user
	# namespaces are unavailable (distribution policy, hardened kernels);
	# where they work, Chromium prefers the namespace sandbox.
	fowners root:root "${dest}/chrome-sandbox"
	fperms 4755 "${dest}/chrome-sandbox"

	newbin - "electron-${SLOT}" <<-EOF
		#!/bin/sh
		exec "${EPREFIX}${dest}/electron" "\$@"
	EOF
}

pkg_postinst() {
	elog "Electron ${PV} is installed as electron-${SLOT}: run an application with"
	elog "    electron-${SLOT} /path/to/application"
	elog "Other majors install beside it (dev-util/electron-bin:<major>)."
	elog "${EPREFIX}/opt/${PN}-${SLOT}/chrome-sandbox is setuid root so renderers keep the"
	elog "Chromium sandbox on systems without unprivileged user namespaces."
}
