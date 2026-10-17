# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Battery-safe logind and sleep defaults for QindaQt laptops"
HOMEPAGE="https://github.com/Es00bac/QindaQt"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}"

RDEPEND=">=sys-apps/systemd-257"

src_install() {
	insinto /usr/lib/systemd/logind.conf.d
	doins "${FILESDIR}"/50-qindaqt-power.conf
	insinto /usr/lib/systemd/sleep.conf.d
	doins "${FILESDIR}"/50-qindaqt-sleep.conf
	local unit
	for unit in suspend hibernate hybrid-sleep suspend-then-hibernate; do
		insinto "$(systemd_get_systemunitdir)/systemd-${unit}.service.d"
		doins "${FILESDIR}"/50-qindaqt-no-freeze.conf
	done
}

pkg_postinst() {
	elog "To apply these defaults without a reboot, run:"
	elog "  systemctl daemon-reload && systemctl reload systemd-logind"
	elog "daemon-reload loads the no-freeze drop-ins into the sleep services;"
	elog "the sleep settings apply from the next suspend."
}
