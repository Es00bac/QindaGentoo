# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="Optional Neon Confluence native screensaver preview with live instruments"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
QINDAQT_COMMIT="a8f6b51473eb5f9708e7707da740a4def35552ce"
SRC_URI="https://github.com/Es00bac/QindaQt/archive/${QINDAQT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/NeonConfluence-${QINDAQT_COMMIT}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"
RDEPEND=">=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r33"
pkg_nofetch() {
 eerror "Create ${PF}.tar.gz from ${QINDAQT_COMMIT} with prefix NeonConfluence-${QINDAQT_COMMIT}/"
 eerror "and path data/screensavers/neon-confluence, then place it in DISTDIR."
}
src_install() {
 # The ordinary desktop owns the host; this optional preview owns only its
 # complete declarative package. Removing it cannot remove the host or settings.
 insinto /usr/share/qindaqt/screensavers
 doins -r data/screensavers/neon-confluence
}
