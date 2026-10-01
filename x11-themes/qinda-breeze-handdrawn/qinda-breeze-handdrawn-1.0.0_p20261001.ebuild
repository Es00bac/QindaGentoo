# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..15} )
inherit python-any-r1 xdg

QINDA_ICON_ART_COMMIT="6cdcfeccf22411534f2b0fb07579c7c53c5e73b6"
DESCRIPTION="Colorful hand-rendered colored-pencil and pastel Breeze raster icon family"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
SRC_URI="${PF}.tar.xz"
S="${WORKDIR}/QindaIconArt-${QINDA_ICON_ART_COMMIT}"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"

# AGENT-GUARD: an optional inherited fallback must never add a Plasma dependency.
RDEPEND="x11-themes/hicolor-icon-theme"
BDEPEND="${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/pillow[${PYTHON_USEDEP}]')"

python_check_deps() {
	python_has_version "dev-python/pillow[${PYTHON_USEDEP}]"
}

pkg_nofetch() {
	eerror "Obtain the exact reviewed ${A} from the qinda distfile hub."
	eerror "Source is pinned to QindaIconArt ${QINDA_ICON_ART_COMMIT}."
	eerror "The archive retains original references, complete generation provenance"
	eerror "and source notices; do not substitute a partial gallery checkpoint."
}

src_prepare() {
	default
	"${PYTHON}" tools/handdrawn_atlas.py verify || die "Artwork provenance verification failed"
	"${PYTHON}" tools/handdrawn_release.py || die "Source-bound release metadata verification failed"
	"${PYTHON}" "${FILESDIR}/verify-release.py" "${S}" || die "Incomplete XDG artwork release"
}

src_install() {
	# AGENT-CONTRACT: install immutable raster bytes; theme selection remains a
	# Settings preference and must not be changed by any package hook.
	insinto /usr/share/icons/QindaQt-Handdrawn
	doins data/icons/QindaQt-Handdrawn/index.theme
	doins -r data/icons/QindaQt-Handdrawn/128x128
	doins sources/COPYING-ICONS sources/HANDDRAWN-MODIFICATIONS.txt

	dodoc README.md
	docinto source
	dodoc -r sources
	docinto provenance
	dodoc provenance/README.md provenance/source-contract.json provenance/inventory-check.json \
		provenance/release-manifest.csv provenance/release-summary.json
	# Exact complete raw/reference/prompt provenance remains in the pinned source
	# archive on qinda, without duplicating every working atlas in the runtime image.
	docompress -x /usr/share/doc/${PF}
}
