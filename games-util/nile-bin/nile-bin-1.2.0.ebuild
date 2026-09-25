# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Amazon Games client helper used by QindaLutris's built-in Amazon sign-in"
HOMEPAGE="https://github.com/imLinguin/nile"
SRC_URI="https://github.com/imLinguin/nile/releases/download/v${PV}/nile_linux_x86_64 -> ${P}-x86_64"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip test"

QA_PREBUILT="usr/bin/nile"

src_unpack() { :; }

src_install() {
	# AGENT-NOTE: upstream ships a self-contained PyInstaller binary, the same
	# artifact Heroic bundles. QindaLutris runs /usr/bin/nile as a helper
	# process (ADR-0275); it is never bundled into the app.
	newbin "${DISTDIR}/${P}-x86_64" nile
}
