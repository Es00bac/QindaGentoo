# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit python-single-r1

DESCRIPTION="Optional host control tool and protocol reference for QindaDeck hardware"
HOMEPAGE="https://github.com/Es00bac/QindaDeck"
QINDADECK_COMMIT="2edcd922508b78314fec07b7077dcaf05679e75b"
SRC_URI="https://github.com/Es00bac/QindaDeck/archive/${QINDADECK_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaDeck-${QINDADECK_COMMIT}"

# No project license grant accompanies this commit. Public source access
# does not authorize redistribution or imply an open-source license.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test zeroconf"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="fetch mirror bindist !test? ( test )"
RDEPEND="
	${PYTHON_DEPS}
	zeroconf? ( $(python_gen_cond_dep 'dev-python/zeroconf[${PYTHON_USEDEP}]') )
"
BDEPEND="${PYTHON_DEPS}"

pkg_nofetch() {
	einfo "This source has no project-wide license grant. If authorized to use it,"
	einfo "download https://github.com/Es00bac/QindaDeck/archive/${QINDADECK_COMMIT}.tar.gz"
	einfo "and save it as ${PF}.tar.gz in DISTDIR. The Manifest pins those exact bytes."
}

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
	dodoc README.md docs/*.md
	newdoc "${FILESDIR}/README.gentoo.md" README.gentoo.md
}
