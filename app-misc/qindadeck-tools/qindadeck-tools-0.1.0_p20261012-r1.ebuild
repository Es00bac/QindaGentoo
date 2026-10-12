# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit python-single-r1

DESCRIPTION="Optional host control tool and protocol reference for QindaDeck hardware"
HOMEPAGE="https://github.com/Es00bac/QindaDeck"
QINDADECK_COMMIT="38f3731652058114288d96d592f3750a45774ff7"
SRC_URI="https://github.com/Es00bac/QindaDeck/archive/${QINDADECK_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaDeck-${QINDADECK_COMMIT}"

# Host CLI/schema/docs are original GPL-3+ code. Uninstalled firmware/Android
# third-party components retain the notices recorded in the source README.
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test zeroconf"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"
RDEPEND="
	${PYTHON_DEPS}
	zeroconf? ( $(python_gen_cond_dep 'dev-python/zeroconf[${PYTHON_USEDEP}]') )
"
BDEPEND="${PYTHON_DEPS}"

src_compile() { :; }

src_test() {
	# --help exits before discovery/network/device actions. Never probe a
	# deck, flash firmware or invoke Android/ESP-IDF tools during packaging.
	"${EPYTHON}" tools/deckctl.py --help > /dev/null || die
	"${EPYTHON}" -m json.tool protocol/qindadeck.schema.json > /dev/null || die
}

src_install() {
	python_newscript tools/deckctl.py deckctl
	insinto /usr/share/qindadeck
	doins protocol/qindadeck.schema.json
	dodoc README.md LICENSE docs/*.md
	newdoc "${FILESDIR}/README.gentoo-licensed.md" README.gentoo.md
}
