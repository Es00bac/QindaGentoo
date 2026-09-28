# Copyright 2026 Sloom Software LLC
# Proprietary: Sloom Software LLC — Confidential and Proprietary.

EAPI=8

inherit xdg

DESCRIPTION="QindaHane - physical-media painting on the Tiltmark brush engine (binary build)"
HOMEPAGE="https://sloom.studio"
# AGENT-NOTE: the archive is cut from the qinda build by QindaHane's
# tools/package-gentoo-bin <PVR>; named after ${PF} so a same-day re-cut is a
# new revision with its own Manifest line (overlay convention).
SRC_URI="${PF}.tar.xz"
S="${WORKDIR}/${PF}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
# Closed-source Tiltmark engine: never mirrored or redistributed.
RESTRICT="bindist fetch mirror strip"

# The binary links the QindaQt AppShell/global-menu archives (qindaqt-desktop)
# and loads QindaTK's QML module and library at run time.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260927-r7
	>=dev-libs/qindatk-0.1.0-r12
	>=dev-qt/qtbase-6.11:6=[dbus,gui,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
"

QA_PREBUILT="usr/bin/qindahane"

pkg_nofetch() {
	einfo "Cut the archive from the qinda build and place it in DISTDIR:"
	einfo "  cd ~/work_space/QindaHane && tools/package-gentoo-bin ${PVR} \$(portageq distdir)"
}

src_install() {
	cp -a usr "${ED}/" || die
}
