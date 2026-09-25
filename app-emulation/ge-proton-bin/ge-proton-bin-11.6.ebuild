# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# GE-Proton release tags spell the version with a dash: 11.6 -> GE-Proton11-6.
MY_P="GE-Proton${PV/./-}"
MY_TOOL="${MY_P}-x86_64"

DESCRIPTION="GloriousEggroll's Proton build, installed as a pinned system compatibility tool"
HOMEPAGE="https://github.com/GloriousEggroll/proton-ge-custom"
SRC_URI="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${MY_P}/${MY_TOOL}.tar.gz"
S="${WORKDIR}/${MY_TOOL}"

LICENSE="BSD LGPL-2.1+ MIT ZLIB OFL-1.1 GPL-2"
# One slot per release so a tested build stays installed while a newer one is
# evaluated beside it. Games pin a build by path; nothing floats to "newest".
SLOT="${PV}"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip test"

RDEPEND="games-util/umu-launcher"

QA_PREBUILT="*"

src_install() {
	# AGENT-CONTRACT: QindaLutris and umu address this build by the absolute
	# path below (PROTONPATH), and Steam lists every tool in this directory.
	# The directory name is the release's own tool name; never rename it, or
	# every prefix recorded against it stops resolving.
	# AGENT-NOTE: the tree is root-owned and read-only at run time. That is
	# safe because the release ships files/share/default_pfx and no dist/ or
	# steampipe_fixups.json, the only cases in which the proton script writes
	# into its own directory (checked against GE-Proton11-6's script).
	local dest=/usr/share/steam/compatibilitytools.d
	dodir "${dest}"
	cp -a "${S}" "${ED}${dest}/${MY_TOOL}" || die
	rm -rf "${ED}${dest}/${MY_TOOL}/__pycache__" || die
}

pkg_postinst() {
	elog "${MY_P} is installed at /usr/share/steam/compatibilitytools.d/${MY_TOOL}."
	elog "QindaLutris offers it by name; Steam lists it under Compatibility."
	elog "Newer GE-Proton releases arrive only as new, separately tested slots."
}
