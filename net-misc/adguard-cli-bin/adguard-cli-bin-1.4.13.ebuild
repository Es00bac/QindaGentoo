# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="AdGuard system-wide filtering CLI"
HOMEPAGE="https://adguard.com/en/adguard-linux/overview.html"
SRC_URI="https://github.com/AdguardTeam/AdGuardCLI/releases/download/v${PV}-release/adguard-cli-${PV}-linux-x86_64.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/adguard-cli-${PV}-linux-x86_64"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist strip"

RDEPEND="sys-libs/glibc"
QA_PREBUILT="opt/adguard-cli/*"

src_install() {
	exeinto /opt/adguard-cli
	doexe adguard-cli adguard_root_helper adguard_cli_nm certutil install_cert.sh

	insinto /opt/adguard-cli
	doins adguard-cli.sig adguard_root_helper.sig adguard_cli_nm.sig certutil.sig defaults.zip

	newbashcomp bash-completion.sh adguard-cli
	dosym ../../opt/adguard-cli/adguard-cli /usr/bin/adguard-cli
}
