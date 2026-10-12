# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-single-r1

# AGENT-NOTE: the QindaQt boot menu and splash (source: QindaBoot) for both
# hosts. The ESP is not Portage's to own: qinda-boot-sync deploys rEFInd, the
# theme and the generated entries to $ESP/EFI/qinda, from pkg_config the first
# time and from pkg_postinst and kernel-install after that. systemd-boot stays
# installed as the firmware fallback and the menu's "Advanced" row.

DESCRIPTION="QindaQt graphical boot menu (themed rEFInd) and Plymouth boot splash"
HOMEPAGE="https://github.com/Es00bac/QindaBoot"
# AGENT-CONTRACT: this license-only source successor retains runtime bytes.
QINDA_BOOT_COMMIT="f778750ea9e9622b76b2abd84f0710486757997f"
SRC_URI="https://github.com/Es00bac/QindaBoot/archive/${QINDA_BOOT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaBoot-${QINDA_BOOT_COMMIT}"

# Original code is GPL-3+; README preserves reused artwork/font terms.
LICENSE="GPL-3+ all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="fetch bindist mirror"

RDEPEND="
	${PYTHON_DEPS}
	sys-apps/systemd[boot(-),kernel-install(-)]
	sys-boot/efibootmgr
	sys-boot/plymouth[pango]
	sys-boot/refind
	sys-kernel/installkernel[systemd]
"

pkg_nofetch() {
	einfo "Original code is GPL-3+; reused artwork retains separate terms."
	einfo "If authorized, download https://github.com/Es00bac/QindaBoot/archive/${QINDA_BOOT_COMMIT}.tar.gz"
	einfo "and save it as ${PF}.tar.gz in DISTDIR. The Manifest pins those exact bytes."
}

src_compile() {
	:
}

src_test() {
	emake test
}

src_install() {
	emake DESTDIR="${D}" install
	python_fix_shebang "${ED}"/usr/sbin/qinda-boot-sync
	einstalldocs
	dodoc LICENSE
}

pkg_postinst() {
	[[ -n ${ROOT} ]] && return
	local esp
	esp=$(bootctl --print-esp-path 2>/dev/null) || return
	if [[ -d ${esp}/EFI/qinda ]]; then
		qinda-boot-sync --quiet || ewarn "qinda-boot-sync failed; run it by hand"
	else
		elog "Deploy the boot menu and splash once, as root:"
		elog "  emerge --config ${CATEGORY}/${PN}"
	fi
}

pkg_config() {
	[[ -n ${ROOT} ]] && die "run on the machine itself"
	einfo "Selecting the qindaqt Plymouth theme"
	plymouth-set-default-theme qindaqt || die
	einfo "Deploying the boot menu and registering it with the firmware"
	qinda-boot-sync --install-nvram || die
	elog "Rebuild the initramfs so the splash is in it, e.g.:"
	elog "  emerge --config sys-kernel/gentoo-kernel-bin"
}
