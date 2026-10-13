# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenAI Codex command-line coding agent (official standalone binary)"
HOMEPAGE="https://learn.chatgpt.com/docs/codex/cli https://github.com/openai/codex"
# Keep the official standalone installer's Linux musl bundle and resource layout.
# Portage owns the bundle rather than letting install.sh overwrite /opt/codex.
SRC_URI="https://releases.openai.com/codex/releases/${PV}/codex-package-x86_64-unknown-linux-musl.tar.gz -> ${P}-linux-musl.tar.gz"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"
QA_PREBUILT="opt/codex/*"

RDEPEND="
	app-misc/ca-certificates
	dev-vcs/git
	sys-apps/ripgrep
"

src_prepare() {
	default
	grep -q '"version": "'"${PV}"'"' codex-package.json || die "Unexpected upstream version"
}

src_install() {
	dodir /opt/codex
	cp -a bin codex-package.json codex-path codex-resources "${ED}/opt/codex/" || die
	dosym -r "${EPREFIX}/opt/codex/bin/codex" /usr/bin/codex
	dosym -r "${EPREFIX}/opt/codex/bin/codex-code-mode-host" \
		/usr/bin/codex-code-mode-host
}
