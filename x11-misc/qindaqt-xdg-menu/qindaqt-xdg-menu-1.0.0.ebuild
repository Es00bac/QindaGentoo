# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="XDG application menu required by QindaQt KWin service authorization"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}"

src_install() {
    insinto /etc/xdg/menus
    newins "${FILESDIR}/applications.menu" applications.menu
}
