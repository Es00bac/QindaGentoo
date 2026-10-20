# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Android native development toolchain (official r29 Linux distribution)"
HOMEPAGE="https://developer.android.com/ndk"
SRC_URI="https://dl.google.com/android/repository/android-ndk-r29-linux.zip"
S="${WORKDIR}/android-ndk-r29"

LICENSE="Apache-2.0 BSD MIT NCSA android"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="strip mirror"
QA_PREBUILT="opt/android-ndk/*"
BDEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc sys-libs/zlib"

src_install() {
	local target="/opt/android-ndk"
	dodir "${target}"
	cp -a . "${ED}${target}/" || die
	newenvd - 80android-ndk <<-EOF
	ANDROID_NDK_HOME="${EPREFIX}${target}"
	EOF
}
