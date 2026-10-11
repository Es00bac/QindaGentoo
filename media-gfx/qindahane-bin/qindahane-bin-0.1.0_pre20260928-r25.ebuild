# Copyright 2026 Sloom Software LLC
# Proprietary: Sloom Software LLC — Confidential and Proprietary.

EAPI=8

inherit xdg

DESCRIPTION="QindaHane - physical-media painting on the Tiltmark brush engine (binary build)"
HOMEPAGE="https://sloom.studio"
# ABI metadata checkpoint: retain the immutable r24 payload. Its six
# QindaTK imports concern StylusHandler/StylusSample, whose public header
# is byte-identical from r17 through reviewed r18 e6837dc5. Every imported
# symbol resolves in r18. The binary stays locked to this qualified ABI;
# merely re-running a binary ebuild cannot repair a later incompatible ABI.
QINDAHANE_PAYLOAD="qindahane-bin-0.1.0_pre20260928-r24"
SRC_URI="${QINDAHANE_PAYLOAD}.tar.xz"
S="${WORKDIR}/${QINDAHANE_PAYLOAD}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
# Closed-source Tiltmark engine: never mirrored or redistributed.
RESTRICT="bindist fetch mirror strip"

# The binary links the QindaQt AppShell/global-menu archives (qindaqt-desktop)
# and loads QindaTK's QML module and library at run time.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260927-r7
	>=dev-libs/qindatk-0.1.0-r18:0/18
	>=dev-qt/qtbase-6.11:6=[dbus,gui,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
"

QA_PREBUILT="usr/bin/qindahane"

pkg_nofetch() {
	einfo "Supply the existing, unchanged ${QINDAHANE_PAYLOAD}.tar.xz archive."
	einfo "This revision changes dependency metadata only; never recut the r24 payload."
}

src_install() {
	cp -a usr "${ED}/" || die
}
