# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GOG download and launch helper used by QindaLutris's built-in GOG sign-in"
HOMEPAGE="https://github.com/Heroic-Games-Launcher/heroic-gogdl"
SRC_URI="https://github.com/Heroic-Games-Launcher/heroic-gogdl/releases/download/v${PV}/gogdl_linux_x86_64 -> ${P}-x86_64"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip test"

QA_PREBUILT="usr/bin/gogdl"

src_unpack() { :; }

src_install() {
	# AGENT-NOTE: upstream ships a self-contained PyInstaller binary, the same
	# artifact Heroic bundles. QindaLutris runs /usr/bin/gogdl as a helper
	# process (ADR-0275); it is never bundled into the app.
	newbin "${DISTDIR}/${P}-x86_64" gogdl
}
