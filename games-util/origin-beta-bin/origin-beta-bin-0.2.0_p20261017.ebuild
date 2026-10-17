# Copyright 2026 Sloom Software LLC
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Qind Qompany: Origin of Species private beta launcher"
HOMEPAGE="https://sloom.studio/origin"
# Unmodified generic Linux kit from the validated beta-20261017.1 freeze.
# Private access links are per-user configuration, never package contents.
SRC_URI="${PF}.tar.gz"
S="${WORKDIR}/Origin-Beta-Linux"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="fetch mirror strip"
QA_PREBUILT="opt/origin-beta/*"

RDEPEND="
	>=sys-libs/glibc-2.31
	>=sys-devel/gcc-10[cxx]
	app-misc/ca-certificates
	media-libs/libglvnd
	media-libs/mesa
	media-libs/vulkan-loader
	x11-libs/libdrm
	virtual/libudev
"

pkg_nofetch() {
	einfo "Publish the validated generic Linux beta kit through qinda-sync:"
	einfo "  origin-beta-bin-0.2.0_p20261017.tar.gz"
	einfo "The archive must not contain a private channel.txt."
}

src_compile() { :; }

src_install() {
	dodir /opt/origin-beta
	cp -a launcher/. "${ED}/opt/origin-beta/" || die
	dobin "${FILESDIR}/origin-beta"
	domenu "${FILESDIR}/origin-of-species.desktop"
	dodoc START-HERE.html Report-Helper.html
}

pkg_postinst() {
	xdg_pkg_postinst
	einfo "Open Origin Beta from Games. The launcher installs signed beta builds"
	einfo "in your user data and updates them automatically, outside game sessions."
	einfo "The private channel is supplied through per-user launcher Settings."
}
