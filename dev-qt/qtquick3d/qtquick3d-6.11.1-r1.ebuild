# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QT6_HAS_STATIC_LIBS=1
inherit qt6-build

DESCRIPTION="Qt module and API for defining 3D content in Qt QuickTools"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="amd64 arm arm64 ~loong ppc64 ~riscv x86"
elif [[ ${QT6_BUILD_TYPE} == live ]]; then
	EGIT_SUBMODULES=() # skip qtquick3d-assimp
fi

# qindaqt: ::gentoo builds this with Qt Quick 3D XR switched off. QindaXR
# (the Quest workspace) needs the QtQuick3D.Xr module, so this revision adds
# an openxr flag that builds it against the system OpenXR loader (::guru).
IUSE="openxr opengl vulkan"

RDEPEND="
	~dev-qt/qtbase-${PV}:6[concurrent,gui,opengl=,vulkan=,widgets]
	~dev-qt/qtdeclarative-${PV}:6
	~dev-qt/qtquicktimeline-${PV}:6
	~dev-qt/qtshadertools-${PV}:6
	media-libs/assimp:=
	virtual/zlib:=
	openxr? ( media-libs/openxr-loader )
"
DEPEND="
	${RDEPEND}
	test? ( ~dev-qt/qtbase-${PV}:6[network] )
	vulkan? ( dev-util/vulkan-headers )
"
BDEPEND="
	~dev-qt/qtshadertools-${PV}:6
"

CMAKE_SKIP_TESTS=(
	# needs off-by-default assimp[collada] that is masked on some profiles,
	# not worth the extra trouble
	tst_qquick3dassetimport
)

PATCHES=(
	"${FILESDIR}"/${PN}-6.6.2-gcc14.patch
	"${FILESDIR}"/${PN}-6.6.2-x32abi.patch
)

src_configure() {
	local mycmakeargs=(
		$(qt_feature openxr quick3dxr_openxr)
	)
	use openxr && mycmakeargs+=(
		-DINPUT_openxr=system
		-DQT_FEATURE_system_openxr=ON
	)

	qt6-build_src_configure
}
