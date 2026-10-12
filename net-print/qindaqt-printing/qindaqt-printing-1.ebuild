# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="QindaQt desktop printing defaults, discovery and printer setup"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-admin/system-config-printer[policykit]
	net-dns/avahi[dbus,systemd]
	>=net-print/cups-2.4.11[dbus,systemd,usb,zeroconf]
	>=net-print/cups-browsed-2.1.1-r1[zeroconf]
	>=net-print/cups-filters-2.0.1-r1
	net-print/gutenprint[cups]
	>=net-print/ipp-usb-0.9.34
	net-print/libcupsfilters[poppler,postscript]
	>=net-print/splix-2.0.2
	sys-apps/systemd
"

src_install() {
	systemd_dounit "${FILESDIR}/qindaqt-printing.target"
	insinto "$(systemd_get_systempresetdir)"
	doins "${FILESDIR}/50-qindaqt-printing.preset"
}

pkg_postinst() {
	# AGENT-GUARD: Reapplying presets on upgrade would undo an administrator's
	# disabled target. Member unit masks and all CUPS configuration remain owned
	# by the administrator; this package only presets its own new target.
	if [[ -n ${REPLACING_VERSIONS} ]]; then
		return
	fi

	if ! systemctl --root="${ROOT}" --preset-mode=enable-only preset qindaqt-printing.target; then
		ewarn "Printing defaults were not enabled; check local systemd preset policy."
		return
	fi

	# An image/chroot installation gets boot policy, never a host service action.
	if [[ ${ROOT} == / ]] && systemd_is_booted &&
		systemctl --quiet is-enabled qindaqt-printing.target; then
		systemctl daemon-reload || die "Could not reload printing units"
		systemctl start qindaqt-printing.target ||
			ewarn "Printing could not start; inspect qindaqt-printing.target and its member units."
	fi

	elog "Manage printers and print jobs in Settings > Printers & scanners."
	elog "Reconnect an already attached USB printer for automatic setup."
	elog "If CUPS was running before filters were installed, let its jobs finish,"
	elog "then run systemctl restart cups.service once to load the new filters."
	elog "To opt out of automatic startup: systemctl disable qindaqt-printing.target"
	elog "To prohibit an individual provider, mask that provider's systemd unit."
}
