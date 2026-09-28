# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Seven QindaQt themes with paired decorations and KDE color schemes"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# AGENT-CONTRACT: both hosts track this exact source commit in clean theme
# checkouts and the qinda Git hub; never package an uncommitted working tree.
EGIT_REPO_URI="file:///home/cabewse/git/QindaThemes.git"
EGIT_COMMIT="7387de435541c29db07a455fb045ab1c8946a953"

# The source pack has no license grant. Do not assign one on the artist's behalf.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=gui-wm/qindaqt-desktop-0.1.0_pre20260921
	x11-themes/qinda-icons"

# AGENT-GUARD: x11-themes/qinda-icons owns the icon families; installing them
# here too makes the two packages collide.
src_configure() {
	local mycmakeargs=(
		-DQINDA_THEMES_INSTALL_APPEARANCES=ON
		-DQINDA_THEMES_INSTALL_ICONS=OFF
	)
	cmake_src_configure
}
