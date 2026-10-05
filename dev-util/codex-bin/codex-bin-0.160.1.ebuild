# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenAI Codex command-line coding agent (official standalone binary)"
HOMEPAGE="https://developers.openai.com/codex/cli https://github.com/openai/codex"
# The official x86_64 musl archive that install.sh
# (https://chatgpt.com/codex/install.sh) selects. Upstream also publishes a
# gnu build, but musl is the one they ship by default on Linux and the one
# both machines have been running, so the target stays put rather than
# chasing whichever glibc variant happens to be newest.
#
# The payload is a prebuilt musl bundle, not a buildable source tree: the
# binary is Rust and the archive ships its own rg, bwrap, zsh and (for the
# voice mode) gstreamer runtime, so there is nothing to compile and no
# USE-dependent rebuild. Portage owns the extracted files, which is the whole
# point of packaging this rather than running install.sh: upgrades become
# transactional and reversible instead of overwriting a root-owned /opt tree
# that nothing can account for.
SRC_URI="https://releases.openai.com/codex/releases/${PV}/codex-package-x86_64-unknown-linux-musl.tar.gz -> ${P}-linux-musl.tar.gz"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
# Prebuilt archive served from a vendor host, not a Gentoo mirror, and the
# checksums are per-release anyway.
RESTRICT="mirror strip"
QA_PREBUILT="opt/codex/*"

# git for the agent's repo operations, ripgrep for its file search, and TLS
# roots for the API endpoint. The musl build carries its own gstreamer and
# musl libc inside codex-resources/, so nothing else is pulled in.
RDEPEND="
	app-misc/ca-certificates
	dev-vcs/git
	sys-apps/ripgrep
"

src_install() {
	# ${ED}/opt rather than a bare /opt so the payload still goes through
	# DESTDIR. This system runs with an empty EPREFIX, so ${ED} == ${D} and
	# the files land on /opt/codex exactly where 0.155.1 put them -- which is
	# what makes this a clean in-place upgrade rather than a second copy
	# beside the old one. The agent resolves codex-path/ and codex-resources/
	# relative to its own executable, so the directory layout has to be
	# reproduced exactly; cp -a keeps the modes upstream shipped, which
	# matters for the executables bundled in codex-resources/.
	dodir /opt/codex
	cp -a bin codex-package.json codex-path codex-resources "${ED}/opt/codex/" || die

	# Absolute targets, same as the build that produced the installed
	# package, so portage records the same relativised symlink
	# (../../opt/codex/bin/codex) rather than a second entry to reconcile.
	dosym -r "${EPREFIX}/opt/codex/bin/codex" /usr/bin/codex
	dosym -r "${EPREFIX}/opt/codex/bin/codex-code-mode-host" \
		/usr/bin/codex-code-mode-host
}
