# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Qt SDR Rx/Tx application and framework for various software defined radios"
HOMEPAGE="https://github.com/f4exb/sdrangel"
SRC_URI="https://github.com/f4exb/sdrangel/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"
IUSE="airspy bladerf funcube hackrf limesuite plutosdr +rtlsdr sdrplay server soapysdr uhd webengine"

# 1. PacketDemodFramer::PACKETDEMOD_CHASE_MAX is odr-used by std::min() but never
#    defined, so libdemodpacket.so fails to load with an undefined symbol and the
#    Packet demodulator silently disappears from the channel list.
# 2. Loading a configuration twice in quick succession runs two LoadConfigurationFSMs
#    concurrently; the second tears down what the first is still using and SDRangel
#    segfaults. The Configurations dialog shown on first run makes this easy to hit.
PATCHES=(
	"${FILESDIR}/${PF}-packetdemod-odr.patch"
	"${FILESDIR}/${PF}-serialize-configuration-load.patch"
)

# Qt6 components required by the GUI build: Core Widgets WebSockets Multimedia
# MultimediaWidgets Positioning Charts SerialPort OpenGL OpenGLWidgets Quick
# QuickWidgets Svg SvgWidgets StateMachine, plus optional TextToSpeech,
# Location and WebEngine.
RDEPEND="
	dev-libs/boost:=
	dev-libs/hidapi:=
	dev-libs/libusb:1
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,gui,network,opengl,widgets]
	dev-qt/qtcharts:6
	dev-qt/qtdeclarative:6
	dev-qt/qtlocation:6
	dev-qt/qtmultimedia:6
	dev-qt/qtpositioning:6
	dev-qt/qtscxml:6
	dev-qt/qtserialport:6
	dev-qt/qtspeech:6
	dev-qt/qtsvg:6
	dev-qt/qtwebsockets:6
	media-libs/codec2:=
	media-libs/faad2
	media-libs/flac:=
	media-libs/opencv:=
	media-libs/rnnoise
	media-video/ffmpeg:=
	net-wireless/aptdec
	net-wireless/cm256cc
	net-wireless/cspice
	net-wireless/dab-cmdline
	net-wireless/dsdcc
	net-wireless/ggmorse
	net-wireless/inmarsatc
	net-wireless/libsigmf
	net-wireless/mbelib
	net-wireless/serialdv
	net-wireless/sgp4
	sci-libs/fftw:3.0=
	sys-libs/libunwind:=
	sys-libs/zlib:=
	airspy? ( net-wireless/airspy )
	bladerf? ( net-wireless/bladerf:= )
	hackrf? ( net-wireless/hackrf-tools )
	limesuite? ( net-wireless/limesuite:= )
	plutosdr? ( net-libs/libiio:= )
	rtlsdr? ( net-wireless/rtl-sdr )
	sdrplay? ( net-wireless/sdrplay )
	soapysdr? ( net-wireless/soapysdr:= )
	uhd? ( net-wireless/uhd:= )
	webengine? ( dev-qt/qtwebengine:6[widgets] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

src_configure() {
	# ENABLE_EXTERNAL_LIBRARIES must stay OFF: its AUTO/ON modes git-clone a
	# dozen third-party projects during the build, which cannot work inside
	# Portage's network sandbox. Every one of them is a real dependency above.
	#
	# ARCH_OPT defaults to "native" and would append -march=native, overriding
	# the CFLAGS chosen for this system. An empty value leaves them alone.
	# SDRangel composes its library path as lib${LIB_SUFFIX}, so it wants the
	# bare suffix ("64"), not the full libdir name.
	local libsuffix=$(get_libdir)
	libsuffix=${libsuffix#lib}

	local mycmakeargs=(
		-DENABLE_QT6=ON
		-DENABLE_EXTERNAL_LIBRARIES=OFF
		-DARCH_OPT=""
		-DLIB_SUFFIX="${libsuffix}"
		-DBUILD_GUI=ON
		-DBUILD_BENCH=OFF
		-DBUILD_SERVER=$(usex server ON OFF)
		-DENABLE_AIRSPY=$(usex airspy ON OFF)
		-DENABLE_BLADERF=$(usex bladerf ON OFF)
		-DENABLE_FUNCUBE=$(usex funcube ON OFF)
		-DENABLE_HACKRF=$(usex hackrf ON OFF)
		-DENABLE_IIO=$(usex plutosdr ON OFF)
		-DENABLE_LIMESUITE=$(usex limesuite ON OFF)
		-DENABLE_RTLSDR=$(usex rtlsdr ON OFF)
		-DENABLE_SDRPLAY=$(usex sdrplay ON OFF)
		-DENABLE_SOAPYSDR=$(usex soapysdr ON OFF)
		-DENABLE_USRP=$(usex uhd ON OFF)
		-DENABLE_AIRSPYHF=OFF
		-DENABLE_FOBOS=OFF
		-DENABLE_MIRISDR=OFF
		-DENABLE_PERSEUS=OFF
		-DENABLE_XTRX=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	if use rtlsdr; then
		elog "RTL2832-based dongles are claimed by the kernel DVB-T driver by"
		elog "default. /etc/modprobe.d/blacklist-rtl-sdr.conf prevents this."
		elog "Device access requires membership of the plugdev group."
	fi
	if ! use webengine; then
		elog "The Map feature needs Qt WebEngine; rebuild with USE=webengine"
		elog "to enable it."
	fi
}
