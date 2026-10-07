# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pam

DESCRIPTION="Gentoo authentication policy for the native QindaQt session locker"
HOMEPAGE="https://github.com/Es00bac/QindaQt"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}"

RDEPEND="sys-auth/pambase
	sys-libs/pam"

src_install() {
	newpamd "${FILESDIR}/qindaqt-lock.pam" qindaqt-lock
}
