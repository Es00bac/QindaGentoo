# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..15} )
inherit python-single-r1 systemd

DESCRIPTION="Verified daily Codex and Claude Code release updates for the Qinda overlay"
HOMEPAGE="https://github.com/Es00bac/QindaGentoo"
S="${WORKDIR}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="
	${PYTHON_DEPS}
	dev-vcs/git
	net-misc/curl
	net-misc/openssh
	sys-apps/portage
	dev-util/pkgcheck
"
BDEPEND="${PYTHON_DEPS}"

src_compile() { :; }

src_install() {
	python_newscript "${FILESDIR}/qinda-ai-cli-update.py" qinda-ai-cli-update
	systemd_douserunit "${FILESDIR}/qinda-ai-cli-update.service"
	systemd_douserunit "${FILESDIR}/qinda-ai-cli-update.timer"
	insinto /etc
	doins "${FILESDIR}/qinda-ai-cli-updater.conf"
}

pkg_postinst() {
	elog "On qinda, as the ordinary overlay owner:"
	elog "  systemctl --user daemon-reload"
	elog "  systemctl --user enable --now qinda-ai-cli-update.timer"
	elog "Check now: qinda-ai-cli-update --check"
	elog "The timer publishes verified recipes; it does not install CLI updates."
}
