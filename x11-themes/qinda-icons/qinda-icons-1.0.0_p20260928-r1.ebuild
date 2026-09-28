# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake xdg git-r3
DESCRIPTION="Seven Qinda icon families, including the true-color Qinda Native, for apps, places, file types and actions"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
EGIT_REPO_URI="file:///home/cabewse/git/QindaThemes.git"
EGIT_COMMIT="7387de435541c29db07a455fb045ab1c8946a953"
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
