# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
PYTHON_COMPAT=( python3_{11..14} )
KFMIN=6.22.0
QTMIN=6.10.1
inherit ecm fcaps python-any-r1 toolchain-funcs xdg

DESCRIPTION="QindaQt's compositor: a KWin 6.6 fork that installs beside stock KWin"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# Hub: qinda:~/git/qindaqt-kwin.git. The tarball is `git archive` of this commit.
# Native shortcut release and standard introspection; plugin ABI serial remains unchanged.
QINDAQT_KWIN_COMMIT="dd74a6c1cc3fb79d8d33dc7bc48aa2e94a396698"
SRC_URI="${PF}.tar.gz"
S="${WORKDIR}/${PF}"

LICENSE="GPL-2+"
# Plugins built against one fork release never load in another (the plugin
# interface id and the CMake package carry the exact version), so consumers
# rebuild through the := subslot.
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="accessibility gamepad +screencast selinux +systemd"
RESTRICT="fetch test"

# Native session lock, native shortcuts and Schedule1 nightlight are required.
# kdecoration is vendored; KAuth is gone (native terminate-process helper).
COMMON_DEPEND="
	>=dev-libs/libei-1.4
	>=dev-libs/libinput-1.28:=
	>=dev-libs/wayland-1.24.0
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=dev-qt/qtbase-${QTMIN}:6=[accessibility=,gui,libinput,opengl,wayland,widgets,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-qt/qttools-${QTMIN}:6[widgets]
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6[qml]
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6[wayland]
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kidletime-${KFMIN}:6=[wayland]
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/ksvg-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6=[wayland]
	>=kde-plasma/kwayland-6.6.6:6
	media-libs/lcms:2
	media-libs/libcanberra
	>=media-libs/libdisplay-info-0.2.0:=
	media-libs/libepoxy
	media-libs/libglvnd
	>=media-libs/mesa-24.1.0_rc1[opengl,wayland]
	virtual/libudev:=
	>=x11-libs/libdrm-2.4.127
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXres
	>=x11-libs/libxcvt-0.1.1
	>=x11-libs/libxcb-1.10:=
	>=x11-libs/libxkbcommon-1.5.0
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	accessibility? ( media-libs/libqaccessibilityclient:6 )
	gamepad? ( dev-libs/libevdev )
	screencast? ( >=media-video/pipewire-1.2.0:= )
	systemd? ( sys-apps/systemd:= )
"
# polkit provides pkexec for the terminate-process helper. Breeze and Aurorae
# are not needed: the fork loads only its own decoration namespace.
RDEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6
	sys-apps/hwdata
	sys-auth/polkit
	>=x11-base/xwayland-23.1.0[libei]
	selinux? ( sec-policy/selinux-wm )
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/plasma-wayland-protocols-1.20.0
	>=dev-libs/wayland-protocols-1.47
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
	x11-base/xorg-proto
"
BDEPEND="${PYTHON_DEPS}
	>=dev-qt/qtbase-${QTMIN}:6[wayland]
	dev-util/wayland-scanner
"

# https://bugs.gentoo.org/941628
# -m 0755 to avoid suid with USE="-filecaps"
FILECAPS=( -m 0755 cap_sys_nice=ep usr/bin/qindaqt-kwin )

pkg_nofetch() {
	eerror "Create ${A} from the qindaqt-kwin hub:"
	eerror "  git -C ~/git/qindaqt-kwin.git archive --format=tar.gz \\"
	eerror "      --prefix=${PF}/ ${QINDAQT_KWIN_COMMIT} > ${A}"
	eerror "then place it in DISTDIR."
}

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-min_ver gcc 14
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-min_ver gcc 14
	python-any-r1_pkg_setup
}

src_prepare() {
	ecm_src_prepare

	# The fork serial in CMakeLists.txt is the _p part of this version.
	local serial
	serial=$(sed -n 's/^set(QINDAQT_KWIN_SERIAL \([0-9]\+\))$/\1/p' CMakeLists.txt) || die
	[[ ${serial} == "${PV##*_p}" ]] || die "fork serial '${serial}' does not match ${PV}"

	if ! use gamepad; then
		sed -e "s/^pkg_check_modules.*libevdev/#&/" -i CMakeLists.txt || die
	fi
	if ! use screencast; then
		sed -e "s/^pkg_check_modules.*PipeWire/#&/" -i CMakeLists.txt || die
	fi
	if ! use systemd; then
		sed -e "s/^pkg_check_modules.*libsystemd/#&/" -i CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package accessibility QAccessibilityClient6)
		-DKWIN_BUILD_KCMS=OFF
		-DKWIN_BUILD_RUNNERS=OFF
		-DKWIN_BUILD_SCREENLOCKER=ON
		-DKWIN_BUILD_GLOBALSHORTCUTS=ON
		-DKWIN_NATIVE_SHORTCUTS=ON
		-DKWIN_BUILD_ACTIVITIES=OFF
		-DQINDAQT_KWIN_BUILD_TESTS=OFF
		-DKWIN_BUILD_X11=ON # bug #965053
	)

	ecm_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	fcaps_pkg_postinst
}
