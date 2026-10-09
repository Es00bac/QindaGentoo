# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="QindaQt Wayland desktop, services and bundled applications"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# Combine secure Voice credentials, Files recovery/Trash and peripheral Power batteries.
# Adopt with Gabbee-r6 for VoiceConfiguration1; older Voice1 stays compatible.
# Preserve complete compact Audio, Viewer, core SDKs and Network fallback.
# Preserve the accepted r6 ABI and nonexclusive physical-session power policy.
QINDAQT_COMMIT="1a5359e4894700a00b545e80e624e3b3a12952be"
# Dependency-only checkpoint of the fully verified signed R23 image.
SRC_URI="qindaqt-desktop-0.1.0_pre20261002-r23-1.gpkg.tar"
S="${WORKDIR}"
# SDL3 controller input is an independent plugin over the installed compositor SDK.

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch strip"
QA_PREBUILT="*"

# Candidate native cutover: own fork/lock/nightlight/shortcuts, Power1,
# polkit agent, screenshot and portal helpers. The physical login keeps native
# power exclusivity off until its receipt barrier passes on the laptop.
RDEPEND="
	>=x11-themes/qinda-icons-1.0.0_p20260928-r2
	>=app-accessibility/gabbee-0.1.0_p20261002[qindaqt]
	>=media-plugins/swh-plugins-0.4.17
	>=media-libs/noise-suppression-for-voice-1.10
	>=media-libs/libsndfile-1.2
	>=media-libs/libsdl3-3.2:=
	!gui-apps/qindaqt-apps
	>=dev-qt/qtbase-6.11:6=[concurrent,cups,dbus,gui,network,sql,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=[widgets]
	>=dev-qt/qtsvg-6.11:6=
	>=dev-qt/qtimageformats-6.11:6=
	>=dev-qt/qtwebsockets-6.11:6=
	>=dev-qt/qtwebengine-6.11:6=[qml]
	>=dev-libs/qindatk-0.1.0-r12
	>=app-text/poppler-26.05:=[qt6]
	>=kde-frameworks/kcalendarcore-6.0:6=
	=gui-wm/qindaqt-kwin-6.6.6_p1-r6:=
	=kde-plasma/layer-shell-qt-6.6.6*:6=
	=kde-plasma/kwayland-6.6.6*:6=
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
	dev-libs/libei:=
	>=dev-libs/openssl-3.2:=
	media-libs/fontconfig
	net-wireless/bluez
	sys-apps/dbus
	sys-apps/systemd
	>=sys-apps/xdg-desktop-portal-1.20.4
	net-print/cups
	sys-auth/polkit
	>=sys-auth/qindaqt-lock-pam-1
	sys-libs/pam
	|| (
		sys-apps/tuned[ppd]
		sys-power/power-profiles-daemon
	)
	sys-power/upower
	x11-base/xwayland
	x11-misc/xdg-utils
	x11-misc/xkeyboard-config
"
PDEPEND=">=media-video/qqmpv-0.1.0_p20260919
	>=gui-apps/qqterm-0.1.0_p20260920
	=gui-apps/qindaqt-removable-media-0.1.0_p20260930-r3"

# The signed input already contains the compiled SDK/runtime; this recipe
# stages it through Portage and changes only the media post-dependency.
BDEPEND="sys-apps/portage app-crypt/gnupg"

pkg_nofetch() {
    eerror "Provide the reviewed signed R23 gpkg named in SRC_URI."
}
src_unpack() { :; }
src_prepare() { :; }
src_configure() { :; }
src_compile() { :; }
src_install() {
    python3 "${FILESDIR}/qindaqt-desktop-r23-repack.py" \
        "${DISTDIR}/qindaqt-desktop-0.1.0_pre20261002-r23-1.gpkg.tar" \
        "${FILESDIR}/qindaqt-desktop-r23-image-ledger.json" "${D}" \
        || die "Signed R23 image verification/staging failed"
}
