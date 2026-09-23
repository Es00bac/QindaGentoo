# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Seven QindaQt themes with paired decorations and KDE color schemes"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# AGENT-CONTRACT: both hosts have this exact source commit in their local Git
# hub. The laptop's original working directory was not a Git repository.
EGIT_REPO_URI="file:///home/cabewse/git/QindaThemes.git"
EGIT_COMMIT="3c05226b25b4d25d03e892eacaff1e8592c185e0"

# The source pack has no license grant. Do not assign one on the artist's behalf.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=gui-wm/qindaqt-desktop-0.1.0_pre20260921"
