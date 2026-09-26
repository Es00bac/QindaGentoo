# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="QindaQt Wayland desktop, services and bundled applications"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
QINDAQT_COMMIT="257fa5882296f037fd62afa6c73593d7ad3ca161"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaQt-${QINDAQT_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# r2 (QindaQt 257fa588) adds QindaLutris store accounts: sign in to Epic,
# GOG and Amazon on the store's own page (embedded through QtWebEngine), see
# the games you own and install them with one button; they start through
# legendary / gogdl / nile with umu and the title's pinned Proton build. It
# also shows a compatibility verdict before installing, applies the
# database's one-time winetricks fixes at install, and adds "Check for
# newer" compatibility information from the QindaQt `compat-db` GitHub
# release. qtwebengine is a real dependency (not automagic): CMake links it
# whenever it is present.
#
# r1 makes QindaLutris the desktop's game installer (ADR-0275): every Windows
# title runs through umu on one exact, recorded Proton build (never floating);
# Get games installs Battle.net, EA app, Ubisoft Connect, Epic, GOG Galaxy and
# Amazon Games or any setup file, or adopts an existing prefix; the Proton page
# manages builds with the shipped compatibility database
# (/usr/share/qindalutris/compat-db-v1.json, 2249 games); games run in their
# own systemd scope with Force quit; "Run in its own screen" uses gamescope.
# It also fixes the tray: the item client now names
# org.freedesktop.DBus.Properties on GetAll, so Wine/Proton (Battle.net) and
# GDBus tray icons appear, and a header-less Properties.Set from any bus peer
# can no longer crash the shell. The tray fix takes effect after logging out
# and back in; QindaLutris changes take effect the next time it starts.
# 20260925 keeps Display1 available when KWin mirrors on hot-plug and lists every
# advertised resolution (ADR-0274): the compositor plugin now publishes modes and
# the mirror source, so the KWin plugin change takes effect only when KWin next
# loads it (log out and back in).
# r2 adds Ctrl+K search in Settings (ADR-0257, QindaTK CommandPalette), signal and charge
# meters and QindaTK empty states, Input shortcuts drawn as QindaTK key caps (KeyCap is only in
# QindaTK 0.1.0-r5, hence the raised floor), the Network panel applet (ADR-0258), and desktop
# icons laid out inside the panels' work area (ADR-0261).
# r1 adds the W6 integration: Settings → Screen saver → Preview runs the saver
# itself (same program and arguments as the idle launcher), never the
# kscreenlocker greeter, and holds an org.freedesktop.ScreenSaver inhibition
# so the idle lock cannot fire over a preview (ADR-0259).
# Pinned to the W0 integration: the network secret agent admits the IP-config
# and DNS wire forms NetworkManager sends with GetSecrets, scrubs every decoded
# copy, and stays resident after its last prompt, so new secured Wi-Fi
# networks reach the password prompt again. Everything in the 20260923-r4
# Settings checkpoint (per-app notification policy, ADR-0256 Audio1 refresh,
# ADR-0239..0243 shell fixes) is included unchanged.
# The shell can restart into this version, but the compositor plugin's new
# fullscreen publication takes effect only when KWin next loads the plugin.
# Generate this exact archive locally from QINDAQT_COMMIT.
RESTRICT="fetch"

# This package installs the complete tree, including the bundled apps. Keep
# ownership unambiguous for users who previously selected the apps-only package.
#
# x11-libs/libxcb serves the XEmbed tray proxy (ADR-0229), which is what gives
# Wine, Proton and Steam tray icons a selection owner to dock with. It resolves
# xcb, xcb-composite, xcb-damage, xcb-shape, xcb-xtest and xcb-xfixes through
# pkg-config with REQUIRED, and all six ship in libxcb. Undeclared, this built
# here only because KWin had already pulled the development files in; a clean
# machine would have failed at configure.
#
# AGENT-GUARD: never put a '#' comment inside RDEPEND/DEPEND. The whole string
# is parsed as atoms, so `ebuild manifest` fails with "Invalid atom (#)" and
# the package cut aborts before it builds anything.
RDEPEND="
	>=media-plugins/swh-plugins-0.4.17
	>=media-libs/noise-suppression-for-voice-1.10
	>=media-libs/libsndfile-1.2
	!gui-apps/qindaqt-apps
	>=dev-qt/qtbase-6.11:6=[concurrent,dbus,gui,network,sql,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=[widgets]
	>=dev-qt/qtsvg-6.11:6=
	>=dev-qt/qtimageformats-6.11:6=
	>=dev-qt/qtwebsockets-6.11:6=
	>=dev-qt/qtwebengine-6.11:6=[qml]
	>=dev-libs/qindatk-0.1.0-r5
	>=app-text/poppler-26.05:=[qt6]
	>=kde-frameworks/kcalendarcore-6.0:6=
	=kde-plasma/kwin-6.6.6*:6=[lock,shortcuts]
	=kde-plasma/kdecoration-6.6.6*:6=
	=kde-plasma/kscreenlocker-6.6.6*:6=
	=kde-plasma/layer-shell-qt-6.6.6*:6=
	=kde-plasma/kwayland-6.6.6*:6=
	=kde-plasma/polkit-kde-agent-6.6.6*:6=
	=kde-plasma/plasma-activities-6.6.6*:6=
	~kde-plasma/powerdevil-6.6.6
	~kde-plasma/knighttime-6.6.6
	=kde-plasma/spectacle-6.6.6*:6=
	=kde-plasma/xdg-desktop-portal-kde-6.6.6*:6=
	>=kde-frameworks/kconfig-6.0:6=
	>=kde-frameworks/kcoreaddons-6.0:6=
	>=kde-frameworks/kglobalaccel-6.0:6=
	>=kde-frameworks/kidletime-6.0:6=
	>=kde-frameworks/kio-6.0:6=
	>=kde-frameworks/karchive-6.0:6=
	>=kde-frameworks/kservice-6.0:6=
	>=kde-frameworks/syntax-highlighting-6.0:6=
	kde-misc/kio-fuse
	=x11-libs/qtermwidget-2.4*:0=
	x11-libs/libxcb
	>=media-video/wireplumber-0.5
	>=net-misc/networkmanager-1.44
	app-crypt/gcr:4
	gnome-base/gnome-keyring
	media-libs/fontconfig
	net-wireless/bluez
	sys-apps/dbus
	sys-apps/systemd
	sys-apps/xdg-desktop-portal
	|| (
		sys-apps/tuned[ppd]
		sys-power/power-profiles-daemon
	)
	sys-power/upower
	x11-base/xwayland
	x11-misc/xdg-utils
	x11-misc/xkeyboard-config
"
# QindaMPV and QQ_Term build against the installed AppShell, global-menu and
# settings-client libraries from this package, so both are post-dependencies:
# an RDEPEND here would be a build cycle. QQ_Term is the desktop's terminal
# (ADR-0222) — this package no longer builds one — so a desktop install always
# has one, and the Terminal=true launch policy (`qqterm -e`) always resolves.
PDEPEND=">=media-video/qqmpv-0.1.0_p20260919
	>=gui-apps/qqterm-0.1.0_p20260920"

DEPEND="${RDEPEND}
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
"
BDEPEND="
	>=kde-frameworks/extra-cmake-modules-6.0:0
	virtual/pkgconfig
"

pkg_nofetch() {
	eerror "Create ${PF}.tar.gz from Git commit ${QINDAQT_COMMIT} using git archive"
	eerror "with prefix QindaQt-${QINDAQT_COMMIT}/, then place it in DISTDIR."
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DQINDAQT_BUILD_KWIN_PLUGIN=ON
		-DQINDAQT_BUILD_SHELL=ON
		-DQINDAQT_BUILD_PRODUCTION_SHELL=ON
		-DQINDAQT_BUILD_VIEWER=ON
		# gui-apps/qindaqt-system-monitor owns qindaqt-system-monitor, its
		# desktop entry and its icon. The System Monitor landed on main after
		# the pre20260919-r9 pin, so this option's ON default silently made
		# the desktop package install all three and collide with that package
		# at merge time. The shell's own dock dashboard applet is separate and
		# unaffected.
		-DQINDAQT_BUILD_SYSTEM_MONITOR=OFF
		# media-plugins/obs-qindaqt owns the libobs module. Without this the
		# bridge was gated only on libobs being findable, so this package
		# installed obs-plugins/obs-qindaqt.so when built on a host with OBS
		# and omitted it otherwise - a non-deterministic file list, and a
		# collision with the media-plugins package. Streaming stays available;
		# it just comes from the package that declares the OBS dependency.
		-DQINDAQT_BUILD_OBS_BRIDGE=OFF
		-DQINDAQT_ENABLE_HOST_UINPUT_TESTS=OFF
		-DQINDAQT_ENABLE_STRICT_WARNINGS=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc README.md
}
