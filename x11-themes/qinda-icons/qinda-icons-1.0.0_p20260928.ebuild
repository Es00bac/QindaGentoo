# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake xdg git-r3
DESCRIPTION="Six complete Qinda icon families for applications, files and desktop actions"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/QindaThemes.git"
EGIT_COMMIT="e530b0328973c2ce75ab57d14fa28417e1e8a1df"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="x11-themes/hicolor-icon-theme"
src_configure() {
    local mycmakeargs=(
        -DQINDA_THEMES_INSTALL_APPEARANCES=OFF
        -DQINDA_THEMES_INSTALL_ICONS=ON
    )
    cmake_src_configure
}
