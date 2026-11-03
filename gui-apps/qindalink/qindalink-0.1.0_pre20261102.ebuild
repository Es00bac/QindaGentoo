# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="QindaLink: phone companion for the QindaQt desktop (messages, notifications, apps, input)"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# QindaLink is a separate package with its own version line (0.1.0_preYYYYMMDD, -rN for ebuild-only
# changes); it does not follow the desktop's revision numbers. It installs as an add-on over the installed
# desktop (>= r47) and builds only the Link programs. @@QINDAQT_COMMIT@@ is replaced by the cut script.
# AGENT-GUARD: archive prefix and S are the fixed name QindaQt, never contain the commit; a stable
# path keeps ccache hits across snapshots (ccache section of gentoo-desktop.md).
QINDAQT_COMMIT="8d6b1f21a01ca40a793299fba840ee7f441cd27d"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaQt"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
# The public remote carries no snapshot tarballs; the cut script writes the archive to DISTDIR.
RESTRICT="fetch"

# gui-wm/qindaqt-desktop (>= r47) provides what qindaqt-link borrows at run time: libqindaqt_app_shell.so in
# the QML tree (qindaqt-link's RUNPATH points at it; proven against the installed r47 library), the
# session bus, the notification host and XDG autostart. A newer desktop adds the panel chip, phone input
# and vault typing (Session1 and the focus relay); on r47 those report unverified. media-video/ffmpeg[vaapi] is the mirror decoder (ADR-0435);
# dev-util/android-tools is /usr/bin/adb for the USB tunnel; OpenSSL libcrypto backs the pinned-TLS
# transport (ADR-0434). net-dns/avahi joins only when LAN discovery lands (D-Bus only).
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r47
	>=dev-libs/qindatk-0.1.0-r18
	>=media-video/ffmpeg-6:=[vaapi]
	dev-util/android-tools
	>=dev-libs/openssl-3.2:=
	>=dev-qt/qtbase-6.11:6=[concurrent,dbus,gui,network,wayland,widgets]
	>=dev-qt/qtdeclarative-6.11:6=[widgets]
	>=dev-qt/qtsvg-6.11:6=
	media-libs/fontconfig
	sys-apps/dbus
	sys-apps/systemd
"
# The shared project configuration also resolves these providers even with the shell off.
DEPEND="${RDEPEND}
	>=media-video/wireplumber-0.5
	>=net-misc/networkmanager-1.44
	>=kde-frameworks/syntax-highlighting-6.0:6=
	=x11-libs/qtermwidget-2.4*:0=
	dev-libs/wayland
	dev-libs/wayland-protocols
"
BDEPEND="
	dev-util/wayland-scanner
	>=kde-frameworks/extra-cmake-modules-6.0:0
	virtual/pkgconfig
"

pkg_nofetch() {
	eerror "Create ${PF}.tar.gz from Git commit ${QINDAQT_COMMIT} using git archive"
	eerror "with prefix QindaQt/, then place it in DISTDIR."
}

src_configure() {
	local mycmakeargs=(
		# AGENT-GUARD: BUILD_TESTING=OFF also keeps QINDAQT_LINK_TEST_HOOKS (its default) out of the
		# service. Never turn it on for an installed build.
		-DBUILD_TESTING=OFF
		-DQINDAQT_BUILD_KWIN_PLUGIN=OFF
		-DQINDAQT_BUILD_SHELL=OFF
		-DQINDAQT_BUILD_PRODUCTION_SHELL=OFF
		-DQINDAQT_BUILD_VIEWER=OFF
		-DQINDAQT_BUILD_SYSTEM_MONITOR=OFF
		-DQINDAQT_BUILD_REMOVABLE_MEDIA=OFF
		-DQINDAQT_BUILD_OBS_BRIDGE=OFF
		-DQINDAQT_BUILD_WINDOWS_RUNNER=OFF
		-DQINDAQT_BUILD_ANDROID_MANAGER=OFF
		-DQINDAQT_BUILD_ANDROID_NATIVE_COLLECTOR=OFF
		-DQINDAQT_BUILD_LINK_SERVICE=ON
		-DQINDAQT_BUILD_LINK_APP=ON
		-DQINDAQT_BUILD_LINK_MIRROR=ON
		-DKDE_INSTALL_LIBEXECDIR=libexec
		-DQINDAQT_ENABLE_HOST_UINPUT_TESTS=OFF
		-DQINDAQT_ENABLE_STRICT_WARNINGS=OFF
	)
	cmake_src_configure
}

src_compile() {
	cmake_build qindaqt-link-service qindaqt-link qindaqt-link-mirror
}

src_install() {
	local component
	for component in QindaQtLink QindaLinkApp LinkMirror; do
		DESTDIR="${D}" cmake --install "${BUILD_DIR}" --component "${component}" \
			|| die "Could not stage ${component}"
	done
	# Build-time static libraries and headers belong to no run-time consumer.
	rm -r "${ED}"/usr/include/qindaqt/services/link_* "${ED}"/usr/lib64/libqindaqt_link_*.a || die
	rmdir --ignore-fail-on-non-empty -p "${ED}"/usr/include/qindaqt/services 2>/dev/null
	dodoc docs/wiki/apps/qindalink.md
}
